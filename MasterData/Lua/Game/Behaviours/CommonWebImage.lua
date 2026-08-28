
--region global define
local isNull    = isNull
local isNotNull = isNotNull
local CS = CS
--endregion

--region import

local Application    = CS.UnityEngine.Application
local PathUtility    = CS.Engine.Lib.PathUtility
local Downloader     = CS.Engine.Lib.Updater.Downloader
local Yielders       = CS.Engine.Lib.Yielders
---@type Engine.Lib.KTool
local KTool          = CS.Engine.Lib.KTool
local TextureUtility = CS.Engine.Lib.TextureUtility
local Object         = CS.UnityEngine.Object
local DOTween        = CS.DG.Tweening.DOTween
local cs_coroutine   = require "XLua.cs_coroutine"

--endregion

--region define

local DefaultSaveDir = PathUtility.Combine(Application.persistentDataPath, "External")
local yield_return   = cs_coroutine.yield_return
--endregion

--- from: Assets/BundleResources/Prefabs/Common/CommonWebImageGroup.prefab > name: CommonWebImageGroup
---@class CommonWebImage
---@field Env                           	CommonWebImage                          
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field RawImageCanvasGroup           	UnityEngine.RectTransform                 
---@field RawImage                      	UnityEngine.UI.RawImage                 
---@field ImgLoading                    	UnityEngine.RectTransform               
---@field AnimationNode                 	UnityEngine.Animation                   
local CommonWebImage = Class('CommonWebImage')

function CommonWebImage:__init()
    self._isStarted = false
    self._isLoading = false
end


function CommonWebImage:__delete()

end


function CommonWebImage:Awake()
    self:Init()

end


function CommonWebImage:Start()
    self._isStarted = true
    self:PlayLoadingAni()
end


function CommonWebImage:OnDestroy()
    self:Stop(true)
    
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 

function CommonWebImage:Init()
    --- 是否需要释放旧的texture
    -- self._releasePrev = isNotNull(self.RawImage.texture)
    self.RawImageCanvasGroup.alpha = 0
    self._defaultTexture = self.RawImage.texture
    local sequence = DOTween.Sequence()
    sequence:InsertCallback(0, function ()
        self._isLoading = false
        KTool.SetActive(self.ImgLoading, false)
        self.AnimationNode.enabled = false
    end)
    sequence:Append(self.RawImageCanvasGroup:DOFade(1, 0.2))
    sequence:OnComplete(function ()
        if not self._isLoading then
            return
        end
        KTool.SetActive(self.ImgLoading, false)
        self.RawImageCanvasGroup.alpha = 1
        self._isLoading = false
    end)
    -- sequence:Append(self.RawImageCanvasGroup:DOFade(1, 0.2))
    sequence:SetAutoKill(false)
    sequence:SetLink(self.controller.gameObject)
    sequence:Pause()
    self._showSequence = sequence


end

--endregion 


--region logic 

function CommonWebImage:LoadTexture(url, expireDays , isNative)
    if string.isEmpty(url) then return end
    if not self:CheckFileExtension(url) then 
        printError("invaild url extension")
        return 
    end

    self._showSequence:Complete()
    KTool.SetActive(self.ImgLoading, true)
    self.AnimationNode.enabled = true
    self._isLoading = true
    self:PlayLoadingAni()
    self.RawImageCanvasGroup.alpha = 0
    expireDays = expireDays or 20
    self:Stop()
    self:StartLoader(url, expireDays , isNative)
    
end

function CommonWebImage:Stop(isRelease)
    if isNotNull(self._co) then
        cs_coroutine.stop(self._co)
        self._co = nil
    end

    if isNotNull(self._downLoader) then
        if not self._downLoader.IsFinished then
            self._downLoader:Cancel()
            
        end
        if isRelease then
            self._downLoader:Dispose()    
        end
        
        self._downLoader = nil
    end
    
end


function CommonWebImage:StartLoader(url, expireDays, isNative)
    self._co = cs_coroutine.start(function ()
        local md5, fileName = self:GetMD5(url)
        local savePath = string.format("%s/%s", DefaultSaveDir, fileName)
        if self._pool ~= nil and self._pool[savePath] ~= nil then
            self:FillRawImage(savePath, true, isNative)
        else
            if self:StartDownload(url, md5, savePath, expireDays) then
                self:FillRawImage(savePath , false ,  isNative)
            end
        end
        self._co = nil
    end) 
end

function CommonWebImage:StartDownload(url, md5, savePath, expireDays)
    local downLoader = Downloader.Load(url, savePath, expireDays)
    downLoader.IsMultiThreading = false
    self._downLoader = downLoader
    downLoader.Md5 = md5
    downLoader:Start()
    while not downLoader.IsFinished do
        yield_return()
    end

    if downLoader.IsError then
        return false
    end
    
    local fileMd5 = KTool.MD5_File(savePath)
    fileMd5       = string.trim(string.lower(fileMd5))
    if fileMd5 ~= md5 then
        printError("md5 not equal");
        return false
    end
    
    return true
end

function CommonWebImage:FillRawImage(path, isInCache ,isNative)
    local texture  = isInCache and self._pool[path] or TextureUtility.LoadTexture(path)
    local RawImage = self.RawImage
    local preTexture = RawImage.texture
    if self._releasePrev and self._pool == nil and isNotNull(preTexture) then
        Object.Destroy(preTexture)
    end

    RawImage.texture = texture
    if isNative == true then
        RawImage:SetNativeSize()
        local Vector2 = CS.UnityEngine.Vector2
        local rect = RawImage.rectTransform
        rect.anchorMin = Vector2(0.5, 0.5)
        rect.anchorMax = Vector2(0.5, 0.5)
    end

    self._showSequence:Restart()
    self._releasePrev = true 
    if not isInCache and isNotNull(self._pool) then
        self._pool[path] = texture
    end

end

function CommonWebImage:PlayLoadingAni()
    if not self._isLoading or not self._isStarted then return end
    self.AnimationNode:Play("HotpointAssociatedNode_ImgLoading")

end

--endregion 

--region check 

function CommonWebImage:CheckFileExtension(url)
    local extension = self:GetFileExtension(url)
    return extension == "png" or extension == "jpg" or extension == "tga"
end

---endregion 

--region get/set 

function CommonWebImage:GetMD5(url)
    --- https://img.fantanggame.com/cat-activity/d8b6f82e47b5d7dd8b16e65ad1f67d92.png -> d8b6f82e47b5d7dd8b16e65ad1f67d92
    local fileName = string.stripFileName(url)
    local md5     = string.stripExtension(fileName)
    return md5, fileName
end

function CommonWebImage:GetFileExtension(url)
    return url:match("[^.]+$")
end

function CommonWebImage:SetPool(pool)
    self._pool = pool
end

---endregion 


--region handler 


---endregion 


return CommonWebImage
