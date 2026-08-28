
local RewardCellNodeLuaPath = 'Game.Activity.RotaryTable.ActivityRotaryTableExchangeCell'
local UIModule = CS.Engine.UI.UIModule
local KTool = CS.Engine.Lib.KTool 
---@type ActivityUtils
local ActivityUtils = import("Game.Activity.ActivityUtils")
local ActivityGachaponSkinNodePath =  "Game.Activity.GachaponSkin.ActivityGachaponSkinNode"
local ActivityGachaponSkinCellPath =  "Game.Activity.GachaponSkin.ActivityGachaponSkinCell"
local KCookie = CS.Engine.Lib.KCookie
local File = CS.System.IO.File
---@type ActivityGachaponSkinMgr
local ActivityGachaponSkinMgr = import('Game.Activity.GachaponSkin.ActivityGachaponSkinMgr'):GetInstance()
ActivityGachaponSkinMgr:Reset()
-- local anniversaryMgr = import('Game.Activity.RotaryTableAnniversaryMgr'):GetInstance()
--- from: Assets/BundleResources/Prefabs/GachaponSkin/GachaponSkinEntry.prefab > name: GachaponSkinEntry
---@class ActivityGachaponSkinDialog
---@field Env                           	ActivityGachaponSkinDialog              
---@field controller                    	Engine.UI.UILuaDialog                   
---@field GachaponSkinEntry             	UnityEngine.Canvas                      
---@field Container                     	UnityEngine.RectTransform               
---@field ScrollView                    	SuperScrollView.LoopListView2           
---@field Root                          	UnityEngine.RectTransform               
---@field AdmissionPanel                	UnityEngine.RectTransform               
---@field VideoPreviewMovie             	CriWare.CriManaMovieControllerForUI     
---@field VideoPreviewBg                	UnityEngine.RectTransform               
---@field VideoPreview                  	UnityEngine.RectTransform               
---@field LabelTrans                    	UnityEngine.CanvasGroup                 
---@field Content                       	UnityEngine.RectTransform               
---@field itemCell                      	UnityEngine.RectTransform               
local ActivityGachaponSkinDialog = Class('ActivityGachaponSkinDialog')
local PREFAB_SKIN_PATH = {
    --- 113001  活动类型
    ["113001"] ={
        --- prefabPath 资源路径
        prefabPath = "Prefabs/GachaponSkin/GachaponSkinDialog",
        --- lua 代码路径 路径
        scrPath = "Game.Activity.GachaponSkin.ActivityGachaponWithoutReplacement"
    },
    ["113002"] = {
        prefabPath = "Prefabs/GachaponSkin/GachaponSkinPropDialog",
        scrPath = "Game.Activity.GachaponSkin.GachaponSkinPropDialog"
    },
    ["120031"] = {
        prefabPath = "Prefabs/GachaponSkin/GachaponSkinBlendDialog",
        scrPath = "Game.Activity.GachaponSkin.GachaponSkinBlendDialog",
        isPanelDialog = true --- 是否挂载在panelDialog下面 默认挂载在self.Container下面
    },
    ["5011"] ={
        --- prefabPath 资源路径
        prefabPath = "Prefabs/GachaponSkin/GachaponSkinTreasureDialog",
        --- lua 代码路径 路径
        scrPath = "Game.Activity.GachaponSkin.GachaponSkinTreasureDialog"
    },
}
function ActivityGachaponSkinDialog:__init()
    self.skinHomeData = nil
    self.skinNode = {}
    self.noVideo = false
    self.selectIndex = KCookie.Get(Constants.UICacheDataKeys.UI_ACTIVITY_GACHAPON_SKIN_INDEX) or 1
    if checkInt(self.selectIndex) <= 0  then
        self.selectIndex = 1
    end
    self.Timer = nil
    self.ActivityCardSkinChangeEvent = Events.AddListener(Constants.EventNames.ActivityCardSkinChangeEvent, Bind(self, self.ChangeEvent))
    local CriWareUtils = import('Game.Entry.CriWareUtilsFix')
    CriWareUtils.StopLastBGMMusic()
end


function ActivityGachaponSkinDialog:__delete()
    self.skinHomeData = nil
    self.selectIndex = nil
    self.noVideo = nil
    if self.Timer then
        CS.Engine.Modules.CDTimerModule.GetInstance():RemoveCD(self.Timer)
        self.Timer = nil
    end
    if self.ActivityCardSkinChangeEvent then
        Events.RemoveListener(Constants.EventNames.ActivityCardSkinChangeEvent,self.ActivityCardSkinChangeEvent)
        self.ActivityCardSkinChangeEvent = nil
    end
end
function ActivityGachaponSkinDialog:OnFocus(focus)
    if focus then
       if self.skinHomeData then
            self:RefreshTop()
       end
    end
end
function ActivityGachaponSkinDialog:RefreshTop()
    if self.skinHomeData then
        local consumeId = self.skinHomeData[self.selectIndex].consumeId
        local t = {}
        ---@type ActivityMgr
        local ActivityMgr = import('Game.Activity.ActivityMgr'):GetInstance()
        local itemId , _ = ActivityMgr:GetGoodsPrice(consumeId)
        if checkInt(itemId) > 0 then
            table.insert(t, itemId) 
        end 
        table.insert(t, consumeId) 
        CfUtils.RefreshTopGoods(t)
   end
end
function ActivityGachaponSkinDialog:Awake()

end
function ActivityGachaponSkinDialog:OnInitialize()
    return CoWaitDo(function()
    end)
end
function ActivityGachaponSkinDialog:OnShow()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        self.requestFinish = false
        ActivityGachaponSkinMgr.Sever:RequestHome(function()
            ---@type ActivityCardSkinComponent
            local ActivityCardSkinComponent =  GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityCardSkinComponent)
            self.skinHomeData = ActivityCardSkinComponent:GetActivityData()
            local activitData = ActivityCardSkinComponent:GetActivityDataByIndex(self.selectIndex)
            self:RefreshScrollList()
            self:CreateActivityNode()
            -- CfUtils.RefreshTopGoods({activitData.consumeId})
            self:RefreshTop()
            self:ShowActivityNode(activitData.type)
            if self.Timer then
                CS.Engine.Modules.CDTimerModule.GetInstance():RemoveCD(self.Timer)
                self.Timer = nil
            end
            self:AddTimer()
            self:CheckVideo(activitData.video)
            if table.count(activitData.video) > 0 then
                self.VideoPreviewMovie.player:Loop(false)
                self:PoolVideosPlay(activitData.video,1)
            else
                CfUtils.SetActive(self.VideoPreview, false)
                self:FillImgBg(activitData)
                self.noVideo = true
            end
            CfUtils.SetActive(self.BgGroup, self.noVideo)
            self.requestFinish = true
        end, function(errCode)
            self.requestFinish = true
        end)
        
        while not self.requestFinish or self.VideoPreviewMovie.player.status ~= CS.CriWare.CriMana.Player.Status.Playing do
            if self.noVideo then
                break
            end
            CoYield()
        end
    end)
end

function ActivityGachaponSkinDialog:CheckVideo(videos)
    if videos and table.count(videos) > 0 then
        local count = table.count(videos)
        if count > 0 then
            for i = count , 1 , -1 do
                local videoName = videos[i]
                local poolVideoPath = GameUtils.GetManaPath(videoName)
                local isExists = File.Exists(poolVideoPath)
                if not isExists then
                    table.remove(videos, i)
                    local ThirdDownloadManager = import("Game.Entry.ThirdDownloadManager"):GetInstance()
                    local isSupport = ThirdDownloadManager:IsSupportThirdPackage()
                    if isSupport then
                        local PlayerPrefsUtility = CS.Engine.Tools.PlayerPrefsUtility
                        local ThirdPackageDownloaded = "ThirdPackageDownloaded"
                        local version =  PlayerPrefsUtility.GetEncryptedString(ThirdPackageDownloaded , "")
                        if string.len(version) < 3  then
                            if not isExists then
                                UIModule.OpenDialog({ id = Constants.UITypeIds.ThirdPackageDownloadDialog})
                                return
                            end
                        end
                    end
                end
            end
        end
    end
end
function ActivityGachaponSkinDialog:ChangeEvent()
    local cell = self.ScrollView:GetShownItemByItemIndex(self.selectIndex - 1)
    if isNotNull(cell) then
        ---@type ActivityGachaponSkinCell
        local src  = CfUtils.GetLuaScr(cell, ActivityGachaponSkinCellPath)
        src:Refresh(self:GetHomeData()[self.selectIndex] , self.selectIndex )
        src:SetIsSelect(true)
    end
end
---@return ActivityCardSkinComponent
function ActivityGachaponSkinDialog:GetComponent()
    local ActivityCardSkinComponent =  GameUtils.GetEntityCompByType(ECSComponentType.Constants.ActivityCardSkinComponent)
    return ActivityCardSkinComponent
end
function ActivityGachaponSkinDialog:GetHomeData()
    return self.skinHomeData
end

function ActivityGachaponSkinDialog:AddTimer()
    local countTime = 86400 * 30
    self.Timer = CS.Engine.Modules.CDTimerModule.GetInstance():AddCD(1, function(count, id)
        if self.ScrollView.IsListViewInit then
            for k, cell in pairs(self.ScrollView.ItemList) do
                ---@type ActivityGachaponSkinCell
                local src  = CfUtils.GetLuaScr(cell, ActivityGachaponSkinCellPath)
                if isNotNull(src) then
                    src:UpdateTimeText()
                end
            end 
        end
    end, countTime, false, true)
end

function ActivityGachaponSkinDialog:FillImgBg(data)
    local path = data.bgIcon
    if not string.isEmpty(path) then
        path = CS.ParseUtils.ParsePathNameByData(path)
        CfUtils.FillImage(self.BgGroup,path)
    end
end

function ActivityGachaponSkinDialog:SwitchActivityNodeByIndex(index)
    if self.selectIndex == index  then
        return 
    end
    local preSelect = self.selectIndex 
    self.selectIndex  = index 
    for k, v in pairs({self.selectIndex , preSelect}) do
        local cell = self.ScrollView:GetShownItemByItemIndex(v - 1)
        if isNotNull(cell) then
            ---@type ActivityGachaponSkinCell
            local src  = CfUtils.GetLuaScr(cell, ActivityGachaponSkinCellPath)
            src:Refresh(self:GetHomeData()[v] , v )
            src:SetIsSelect(self.selectIndex  == v )
        end
    end
    local oneActivityData = self:GetComponent():GetActivityDataByIndex(self.selectIndex)
    KCookie.Set(Constants.UICacheDataKeys.UI_ACTIVITY_GACHAPON_SKIN_INDEX,self.selectIndex)
    self:RefreshTop()
    self:CreateActivityNode()
    self.noVideo = table.count(oneActivityData.video) <= 0
    CfUtils.SetActive(self.BgGroup, self.noVideo)
    if self.noVideo then
        CfUtils.SetActive(self.VideoPreview, false)
        self:FillImgBg(oneActivityData)
    else
        self:PoolVideosPlay(oneActivityData.video,1)
    end
    
    self:ShowActivityNode(oneActivityData.type)
end
function ActivityGachaponSkinDialog:ShowActivityNode(activityType)
    activityType = tostring(activityType)
    for k, v in pairs(self.skinNode) do
        local oneType = tostring(k)
        local oneSkinNode = self.skinNode[oneType]
        local canvas =  KTool.GetComponent(oneSkinNode.controller.gameObject , typeof(CS.UnityEngine.Canvas))
        if activityType ~= oneType then
            if isNotNull(canvas) then
                canvas.enabled = false
            end
        else 
            canvas.enabled = true
        end
    end
end

function ActivityGachaponSkinDialog:CreateActivityNode()
    CfUtils.StartCoroutineWithBlocker(function()
        xTry(function()
            local oneSkinData = self:GetComponent():GetActivityDataByIndex(self.selectIndex)
            local config = PREFAB_SKIN_PATH[tostring(oneSkinData.type)]
            if isNull(config) then
                return
            end
            local prefabPath = config.prefabPath
            local isPanelDialog = config.isPanelDialog
            local scrPath = config.scrPath
            if not self.skinNode[tostring(oneSkinData.type)] then
                local path = string.format("%s.prefab",prefabPath)
                local root = isPanelDialog and self.PanelDialog or self.Container
                ---@type UnityEngine.GameObject
                local go = GameUtils.LoadBundleAsync(path, root.gameObject, false)
                go.transform.localPosition =  Vector3.New(0, 0,0)
                local scr = CfUtils.GetLuaScr(go, config.scrPath)
                self.skinNode[tostring(oneSkinData.type)] = scr
            end
            self.skinNode[tostring(oneSkinData.type)]:RefreshData(oneSkinData)
        end)
    end)
end

function ActivityGachaponSkinDialog:SetCanvasEnabled(isEnabled)
    self.GachaponSkinEntry.enabled = isEnabled
end

function ActivityGachaponSkinDialog:PoolVideosPlay(videos,index)
    CfUtils.SetActive(self.VideoPreview, true)
    self.VideoPreviewBg.anchoredPosition = Vector2.New(0, 0)
    self.videos = videos
    self.index = index
    local function GetVideoName()
        if self.index > #self.videos then
            self.index = 1
        end
        local name = self.videos[self.index]
        return name
    end

    if self.VideoPreviewMovie.player.statusChangeCallback == nil then
        self.VideoPreviewMovie.player.statusChangeCallback = function(status)
            --printError("MV callback: status = %s", status)
            if status == CS.CriWare.CriMana.Player.Status.Stop then
                self:PoolVideoPlay(GetVideoName())
            end
            if status == CS.CriWare.CriMana.Player.Status.PlayEnd then
                self.index = self.index + 1
                self:PoolVideoPlay(GetVideoName())
            end
        end
    end
    
    self:PoolVideoPlay(GetVideoName())
end

function ActivityGachaponSkinDialog:PoolVideoPlay(videoName)
    if isNull(videoName) then
        self.requestFinish = true
        self.noVideo = true
        return
    end
    -- 如果播放器 还未变到 停止状态：则先记录要播放的视频名，让播放器停止掉，等待播放器状态变为停止视，再播放才能正常。
    if isNotNull(self.VideoPreviewMovie.player)   then
        if  self.VideoPreviewMovie.player.status ~= CS.CriWare.CriMana.Player.Status.Stop then
            self.VideoPreviewMovie:Stop()  -- 当前帧不会立刻变为 stop 状态 
        else
            local poolVideoPath = GameUtils.GetManaPath(videoName)
            self.VideoPreviewMovie.player:SetFile(nil, poolVideoPath)
            self.VideoPreviewMovie:Play()  -- 当前帧不会立刻变为 play 状态    
        end
    end
end

function ActivityGachaponSkinDialog:RefreshScrollList()
    local cellCount = table.count(self:GetComponent():GetActivityData())
    if not self.ScrollView.IsListViewInit then
        self.ScrollView:InitListView(cellCount, Bind(self, self.RefreshCellItem))
    else
        GameUtils.ReloadData(self.ScrollView, cellCount)
    end
end

function ActivityGachaponSkinDialog:RefreshCellItem(view, index)
    ---@type ActivityDirectDrawMallProductDojo
    local cell = view:NewListViewItem("Cell")
    cell.name = "Cell" .. index + 1
    ---@type ActivityGachaponSkinCell
    local scr = CfUtils.GetLuaScr(cell, ActivityGachaponSkinCellPath)
    if scr then
        index = index + 1
        scr:Refresh(self.skinHomeData[index],index)
        scr:SetIsSelect(index == self.selectIndex)
    end
    return cell
end

function ActivityGachaponSkinDialog:PoolVideoStop_()
    CfUtils.SetActive(self.VideoPreview, false)
    CfUtils.SetActive(self.AdmissionPanel, true)
    self.VideoPreviewBg.anchoredPosition = Vector2.New(-999999, -999999)

    if self.VideoPreviewMovie.player then
        self.VideoPreviewMovie:Stop()  -- 当前帧不会立刻变为 stop 状态
        self.VideoPreviewMovie.player:StopForSeek()
        self.VideoPreviewMovie.player:SetSeekPosition(0)
    end
end


function ActivityGachaponSkinDialog:OnFinalize()
    return CoWaitDo(function()
        self:PoolVideoStop_()
        -- 退出抽卡界面检测红点逻辑
        self:GetComponent():SetCardSkinRedPoint()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end

return ActivityGachaponSkinDialog
