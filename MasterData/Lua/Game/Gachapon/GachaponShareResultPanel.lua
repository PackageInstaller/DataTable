-------------------------------------------------------------------------------
-- 抽卡结果分享内容页面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2022-06-06 19:11:35
-------------------------------------------------------------------------------

---@type SDKService
local SDKService    = import('Game.Entry.SDKService')
local QRCode        = CS.Engine.Tools.QRCode
local RawImage      = CS.UnityEngine.UI.RawImage
local I18NModule    = CS.Engine.I18N.I18NModule
local TextureLoader = CS.Engine.Modules.TextureLoader

--- from: Assets/BundleResources/Prefabs/Share/GachaponResultShareShowDialog.prefab > name: GachaponResultShareShowDialog
---@class GachaponShareResultPanel
---@field Env                           	GachaponShareResultPanel                
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field GameLogoImg                   	UnityEngine.RectTransform               @ 游戏logo图片
---@field ShareCodeImg                  	UnityEngine.RectTransform               @ 二维码图片
---@field ShareCodeNode                 	UnityEngine.RectTransform               @ 二维码节点
---@field PlayerNameTxt                 	UnityEngine.RectTransform               @ 玩家名文本
---@field PlayerUidTxt                  	UnityEngine.RectTransform               @ 玩家id文本
local GachaponShareResultPanel = Class('GachaponShareResultPanel')


function GachaponShareResultPanel:__init()
    ---@type UnityEngine.Texture2D
    self.qrcodeTexture_ = nil
end


function GachaponShareResultPanel:__delete()
    self.qrcodeTexture_ = nil
end


function GachaponShareResultPanel:Awake()
end


function GachaponShareResultPanel:OnInit(initArgs)
    local playerDojo = GameUtils.GetPlayerDojo() or {}
    CfUtils.FillText(self.PlayerNameTxt, tostring(playerDojo.playerName))
    CfUtils.FillText(self.PlayerUidTxt, tostring(playerDojo.playerId))
end


function GachaponShareResultPanel:Start()
    if isNotNull(self.ShareCodeNode) then
        -- local isOpenFtCommunity = SDKService:GetInstance():IsOfficialSDK()
        -- local isEnableCodeGroup = (isOpenFtCommunity or GameUtils.IsWindow()) and (not IS_REVIEW)  --win直接打开不分审核
        -- CfUtils.SetActive(self.ShareCodeNode, isEnableCodeGroup)
        
        ---@type GameChannelInfoVo
        local channelInfoVo = CfUtils.GetCfVo(AutoIds.IdSetting65, "GameChannelInfoVo", GameUtils.GetChannelId()) or {}
        if string.isEmpty(channelInfoVo.shareUrl) then
            CfUtils.SetActive(self.ShareCodeNode, false)

        else
            -- 生成二维码
            local imgSizeDelta  = self.ShareCodeImg.sizeDelta
            self.qrcodeTexture_ = QRCode.EncodeQRImage(channelInfoVo.shareUrl, imgSizeDelta.x, imgSizeDelta.y)

            ---@type UnityEngine.UI.RawImage
            local qrcodeImgComp   = self.ShareCodeImg.transform:GetComponent(typeof(RawImage))
            qrcodeImgComp.texture = self.qrcodeTexture_
            CfUtils.SetActive(self.ShareCodeNode, true)
        end
    end

    -- 游戏logo图片不能使用i18n空间方式加载，因为是异步加载，会出现还未加载完就截屏出中文的问题。所以这里手动实现成同步加载。
    if isNotNull(self.GameLogoImg) then
        local currentLang   = I18NModule.Lang
        if currentLang == 'en_UK' then
            currentLang = 'en_US'
        end
        local currentRegion = tostring(string.split2(currentLang, '_')[2])
        local imageName     = 'share_img_logo'
        local imagePathRoot = 'Arts/Textures/Localization'
        local localizePath  = string.fmt('%1/%2/%3_%4.png', imagePathRoot, currentLang, imageName, string.lower(currentRegion))
        if currentLang ~= 'zh_CN' then
            ---@type UnityEngine.UI.RawImage
            local gameLogoImgComp = self.GameLogoImg.transform:GetComponent(typeof(RawImage))
            local textureLoader   = TextureLoader.Load(localizePath, nil, CS.Engine.Modules.LoaderMode.Sync, true)
            if textureLoader.IsSuccess then
                textureLoader:Retain(gameLogoImgComp)
                gameLogoImgComp.texture = textureLoader.Asset
            end
            textureLoader:Release()
        end
    end
end


function GachaponShareResultPanel:OnDestroy()
    if not isNull(self.qrcodeTexture_) then
        CS.UnityEngine.GameObject.Destroy(self.qrcodeTexture_)
        self.qrcodeTexture_ = nil
    end
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


return GachaponShareResultPanel
