-------------------------------------------------------------------------------
-- 通用 - 分享按钮
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-11-11 12:05:19
-------------------------------------------------------------------------------

local KTool        = CS.Engine.Lib.KTool
local CriWareUtils = GameUtils.GetCriWareUtils()

--- from: Assets/BundleResources/Prefabs/Share/BtnShare.prefab > name: BtnShare
---@class CommonBtnShareNode
---@field Env                           	CommonBtnShareNode                      
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field AnimRoot                      	UnityEngine.RectTransform               @ 动画根节点
---@field RewardNumTxt                  	UnityEngine.RectTransform               @ 奖励数量
---@field RewardIconImg                 	UnityEngine.RectTransform               @ 奖励图标
---@field RewardNode                    	UnityEngine.RectTransform               @ 奖励根节点
local CommonBtnShareNode = Class('CommonBtnShareNode')


function CommonBtnShareNode:__init()
end


function CommonBtnShareNode:__delete()
end


function CommonBtnShareNode:Awake()
    self.eventShareRewardCountChange_ = Events.AddListener(Constants.EventNames.SHARE_BUTTON_REFRESH, Bind(self, self.OnShareRewardCountChangeHandler_))
    SetButtonAction(self.controller, Bind(self, self.OnClickShareButtonHandler_))
    self:SetShareType(0)
end


function CommonBtnShareNode:Start()
end


function CommonBtnShareNode:OnDestroy()
    Events.RemoveListener(Constants.EventNames.SHARE_BUTTON_REFRESH, self.eventShareRewardCountChange_)
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@type Constants.ShareType
function CommonBtnShareNode:GetShareType()
    return checkInt(self.shareType_)
end
function CommonBtnShareNode:SetShareType(shareType)
    self.shareType_ = checkInt(shareType)
    self:UpdateShareButtonInfo_()
end


---@type string
function CommonBtnShareNode:GetPrefabPath()
    return tostring(self.prefabPath_)
end
function CommonBtnShareNode:SetPrefabPath(prefabPath)
    self.prefabPath_ = tostring(prefabPath)
end


---@type fun(shareParms:table, previewArgs:table):table
function CommonBtnShareNode:GetCreateShareParamsCb()
    return self.createShareParamsCb_
end
function CommonBtnShareNode:SetCreateShareParamsCb(callback)
    self.createShareParamsCb_ = callback
end

function CommonBtnShareNode:SetIsWaitComplete(isWaitCompleted)
    self.isWaitCompleted = isWaitCompleted
end

-------------------------------------------------
-- private

function CommonBtnShareNode:UpdateShareButtonInfo_()
    -- 功能开关 优先级最高
    local isVisible = Constants.MODULE_SWITCH.SHARE
    ---@type SDKService
    local SDKService = import('Game.Entry.SDKService'):GetInstance()
    -- PC客户端关闭分享，编辑器下调试方便开启
    if KTool.IsMobile() == false and CS.UnityEngine.Application.isEditor == false then
        isVisible = false
    end
    if isVisible and SDKService:IsChannelSdk() then
        isVisible = false
    end

    -- 绑定的分享类型，配表中是否打开
    if isVisible then

        ---@type ShareMessagesVo
        local shareMessagesVo = CfUtils.GetCfVo(AutoIds.IdSetting953, "ShareMessagesVo", self:GetShareType())
        if shareMessagesVo then

            isVisible = true

            -- update rewards visible
            local rewardLeftTimes = GameUtils.GetShareRewardLeftTimes(shareMessagesVo.rewardTypeId)
            CfUtils.SetActive(self.RewardNode, rewardLeftTimes > 0)
            
            -- update rewards info
            if rewardLeftTimes > 0 then
                ---@type ShareRewardsVo
                local shareRewardVo = CfUtils.GetCfVo(AutoIds.IdSetting951, "ShareRewardsVo", shareMessagesVo.rewardTypeId)
            
                -- update goods icon
                local goodsIconPath = GoodsConfMgr:GetInstance():GetPhotoPathById(shareRewardVo.goodsId)
                CfUtils.FillImage(self.RewardIconImg, goodsIconPath)
    
                -- update goods num
                CfUtils.FillText(self.RewardNumTxt, string.fmt('<size=26>x</size>%1', shareRewardVo.goodsNum))
            end

        else
            -- 分享内容表中关闭了
            isVisible = false
        end
    end

    -- update visible
    CfUtils.SetActive(self.controller, isVisible)
end


-------------------------------------------------
-- handler

function CommonBtnShareNode:OnClickShareButtonHandler_()
    CriWareUtils.PlaySeById(UISheets.UI_Menu.ui_button_share)

    print('[share screenShot]', self:GetShareType(), self:GetPrefabPath())

    local sharePreviewDialog = CfUtils.DialogGet(Constants.UITypeIds.CommonSharePreviewDialog)
    if not isNull(sharePreviewDialog) then
        return
    end

    local shareParms    = {}
    local previewArgs   = {}
    local createParmsCb = self:GetCreateShareParamsCb()
    local extraParams   = createParmsCb and createParmsCb(shareParms, previewArgs) or {}
    
    shareParms.prefabPath = self:GetPrefabPath()
    shareParms.finishCB   = function(filePath)
        local GachaponUtils   = import('Game.Gachapon.GachaponUtils')
        previewArgs.filePath  = filePath
        previewArgs.shareType = self:GetShareType()
        CoYield(GachaponUtils.OpenDialogAction(Constants.UITypeIds.CommonSharePreviewDialog, previewArgs))
    end
    shareParms.isWaitCompleted = self.isWaitCompleted
    GameUtils.ShareScreenShot(shareParms)
end


function CommonBtnShareNode:OnShareRewardCountChangeHandler_()
    self:UpdateShareButtonInfo_()
end


return CommonBtnShareNode
