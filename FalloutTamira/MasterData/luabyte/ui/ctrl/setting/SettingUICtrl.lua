local SettingUICtrl = BaseClass("SettingUICtrl", BaseUICtrl)

local M = SettingUICtrl
local xiaoniuSDKChannelIds = { 681, 680, 151, 80 } -- 依次是 测试环境安卓、测试环境IOS、正式环境IOS、正式环境安卓
-- local Application = CS.UnityEngine.Application
-- local File = CS.System.IO.File
local Privacy = require "Config.Privacy"

function M:Init()
    self._allTabTypes = { SettingConst.SettingTabType.Voice, SettingConst.SettingTabType.Graphic, SettingConst
        .SettingTabType.Battle, SettingConst.SettingTabType.Dorm, SettingConst.SettingTabType.CV, SettingConst
        .SettingTabType.Account }

    self._setVoice = require("UI.Ctrl.Setting.SetVoiceUICtrl").New(self._view.SetVoice)
    self._setQuality = require("UI.Ctrl.Setting.SetQualityUICtrl").New(self._view.SetQuality)
    self._setFight = require("UI.Ctrl.Setting.SetFightUICtrl").New(self._view.SetFight)
    self._setRoom = require("UI.Ctrl.Setting.SetRoomUICtrl").New(self._view.SetRoom)
    self._setCV = require("UI.Ctrl.Setting.SetCVUICtrl").New(self._view.SetCV)
    self._setAccount = require("UI.Ctrl.Setting.SetAccountUICtrl").New(self._view.SetAccount)
    self._view.btn_Back:onClick(Bind(self, self.OnClickBackBtn))
    self._view.btn_exitGame:onClick(Bind(self, self.OnClickExitGameBtn))
    self._view.btn_Cdk:onClick(Bind(self, self.OnClickCdkBtn))
    self._view.btn_Revert:onClick(Bind(self, self.OnClickRevertDefaultSettingBtn))
    self._view.btn_logout:onClick(Bind(self, self.OnClickLogout))
    local macro = CS.GameX.GameHelper.GetUnityMacro()
    local packageName = CS.GameX.GameHelper.GetPackageName()
    if macro == "UNITY_ANDROID" then

    end
    self._view.leftTab:InitItems(0,
        { ConfigHelper.GetLocalString(395), ConfigHelper.GetLocalString(396), ConfigHelper.GetLocalString(397),
            ConfigHelper.GetLocalString(448), ConfigHelper.GetLocalString(5244), ConfigHelper.GetLocalString(30249) -- 账号
        }, Bind(self, self._OnClickTab))

    self._view.btn_Cdk:SetActive(true)
    -- self._view.btn1:onClick(Bind(self, self._onBtn1Click))
    -- self._view.btn2:onClick(Bind(self, self._onBtn2Click))
    -- self._view.btn1:SetActive(false)
    -- self._view.btn2:SetActive(false)
    self._view.customer:SetActive(false --[[ConfigHelper.ShowCustomerService()]])
    self._view.customer:onClick(Bind(self, self._onClickCustom))
    self._view.btn_rebate:onClick(Bind(self, self.OnClickRebate)) -- sdk超级商城
    self._view.btn_rebate:SetActive(false)                        -- 1是0否
    -- self:CheckSuperStore()
end

function M:_onClickCustom(go)
    CS.GameX.GameHelper.ChatToCustomer()
end

function M:OnAuthBindSuc(uid)
    if uid == nil then
        -- 绑定失败
        return
    end
end

function M:OnClickLogout(go)
    -- test
    GameHelper.Confirm(ConfigHelper.GetLocalString(405), function(ok)
        if ok then
            CS.GameX.GameHelper.SettingBackToLogin(true)
            IBuriedPointDataMgr:SubmitData(BuriedPointConst.Logout)
        end
    end)
end

function M:OnEnter(tabType)
    self._curTabType = 1
    if tabType ~= nil then
        self._curTabType = tabType
    end

    if self._curTabType == SettingConst.SettingTabType.Voice then
        self._setVoice:Open()
    elseif self._curTabType == SettingConst.SettingTabType.Graphic then
        self._setQuality:Open()
    elseif self._curTabType == SettingConst.SettingTabType.Battle then
        self._setFight:Open()
    elseif self._curTabType == SettingConst.SettingTabType.Dorm then
        self._setRoom:Open()
    elseif self._curTabType == SettingConst.SettingTabType.CV then
        self._setCV:Open()
    elseif self._curTabType == SettingConst.SettingTabType.Account then
        self._setAccount:Open()
    end
    GameHelper.DoPlayerAction(PlayerAction.OpenSetting)
end

function M:OnClickBackBtn()
    UIContextMgr:GetInstance():Close(UIDefine.UISetting)
end

function M:OnClickExitGameBtn()
    GameHelper.Confirm(ConfigHelper.GetLocalString(405), function(ok)
        if ok then
            CS.GameX.GameHelper.SettingBackToLogin(false)
            IBuriedPointDataMgr:SubmitData(BuriedPointConst.Logout)
        end
    end)
end

function M:_OnClickTab(tabType)
    self._curTabType = self._allTabTypes[tabType + 1]
    if self._curTabType == SettingConst.SettingTabType.Voice then
        self._setVoice:Open()
    elseif self._curTabType == SettingConst.SettingTabType.Graphic then
        self._setQuality:Open()
    elseif self._curTabType == SettingConst.SettingTabType.Battle then
        self._setFight:Open()
    elseif self._curTabType == SettingConst.SettingTabType.Dorm then
        self._setRoom:Open()
    elseif self._curTabType == SettingConst.SettingTabType.CV then
        self._setCV:Open()
    elseif self._curTabType == SettingConst.SettingTabType.Account then
        self._setAccount:Open()
    end
end

function M:OnClickCdkBtn()
    UIContextMgr:GetInstance():Show(UIDefine.UICdkRename)
end

function M:OnClickRebate()
    -- storeID: 商城类型，0：积分商城，1：超级商城
    GameHelper.ShowSuperStore(1)
end

function M:CheckSuperStore()
    local form = CS.UnityEngine.WWWForm()
    form:AddField("sid", "0");
    form:AddField("act_type_number", "3"); -- 3：超级商城
    GameHelper.HttpPost("http://smi.648sy.com/sdkh5activity/sdk_open_judge/ycdmlldyzaqlmzf", form, function(result, json)
        if result then
            local tbl = Json.decode(json)
            self._view.btn_rebate:SetActive(tbl.data.is_open == 1) -- 1是0否
        end
        Logger.Log(json)
    end)
end

function M:OnClickRevertDefaultSettingBtn()
    self._setVoice:RevertAll(self._curTabType == SettingConst.SettingTabType.Voice)
    self._setQuality:RevertAll(self._curTabType == SettingConst.SettingTabType.Graphic)
    self._setFight:RevertAll(self._curTabType == SettingConst.SettingTabType.Battle)
    self._setRoom:RevertAll(self._curTabType == SettingConst.SettingTabType.Dorm)
    self._setCV:RevertAll(self._curTabType == SettingConst.SettingTabType.CV)
end

-- 用户协议
function M:_onBtn1Click()
    -- local path = Application.streamingAssetsPath .. "/UserAgreement.txt"
    -- if File.Exists(path) then
    --     local context = File.ReadAllText(path)
    UIContextMgr:GetInstance():Show(UIDefine.UIAgeTips, "醒雾号服务协议", Privacy.UserAgreement)
    -- else
    --     Logger.LogError("未找到文件" .. path)
    -- end
end

-- 隐私协议
function M:_onBtn2Click()
    -- local path = Application.streamingAssetsPath .. "/PrivacyPolicy.txt"
    -- if File.Exists(path) then
    -- local context =
    UIContextMgr:GetInstance():Show(UIDefine.UIAgeTips, "醒雾号用户个人信息及隐私保护政策", Privacy.PrivacyPolicy)
    -- else
    --     Logger.LogError("未找到文件:" .. path)
    -- end
end

-- 设置退出时调用，返回TRUE则为拦截底层逻辑
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnVisible()
    GameHelper.DoPlayerAction(PlayerAction.OpenSetting)
end

function M:OnDispose()
    self._view.btn_Back:RemoveOnClick()
    self._view.btn_exitGame:RemoveOnClick()
    self._view.btn_Cdk:RemoveOnClick()
    self._view.btn_Revert:RemoveOnClick()

    self._setVoice:OnDispose()
    self._setVoice = nil

    self._setQuality:OnDispose()
    self._setQuality = nil

    self._setFight:OnDispose()
    self._setFight = nil

    self._setRoom:OnDispose()
    self._setRoom = nil

    self._setCV:OnDispose()
    self._setCV = nil

    M.super.OnDispose(self)
end

return SettingUICtrl
