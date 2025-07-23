--[[   
    系统设置
]]
module("role.OtherSettingTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("systemSetting/OtherSettingTab.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.mQuality = nil
end

function configUI(self)
    super.configUI(self)
    self.mTextTitleCamare = self:getChildGO("mTextTitleCamare"):GetComponent(ty.Text)
    self.mTextTitleCheckAsset = self:getChildGO("mTextTitleCheckAsset"):GetComponent(ty.Text)
    self.mTxtTitleLockTeam = self:getChildGO("mTxtTitleLockTeam"):GetComponent(ty.Text)
    self.mTextCheckAsset = self:getChildGO("mTextCheckAsset"):GetComponent(ty.Text)

    self.mToggleCamera = self:CreateToggle(self:getChildGO("mToggleCamera"))
    self.mToggleLockTeam = self:CreateToggle(self:getChildGO("mToggleLockTeam"))

    self.mBtnCheckAsset = self:getChildGO("mBtnCheckAsset")
end

function initViewText(self)
    self.mTextTitleCamare.text = _TT(62066)
    self.mTextTitleCheckAsset.text = _TT(62067)
    self.mTxtTitleLockTeam.text = _TT(62068)
    self.mTextCheckAsset.text = _TT(62069)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnCheckAsset, self.checkAsset)

    self.mToggleCamera.notifyEvent = function(value)
        systemSetting.SystemSettingManager:setSystemSettingValue(systemSetting.SystemSettingDefine.cameraLock, value)
    end

    self.mToggleLockTeam.notifyEvent = function(value)
        systemSetting.SystemSettingManager:setSystemSettingValue(systemSetting.SystemSettingDefine.lockTeamMember, value)
    end
end

function removeAllUIEvent(self)
    self.mToggleCamera:destroy()
    self.mToggleLockTeam:destroy()
end

function CreateToggle(self, go)

    local toggle = {}
    toggle.m_go = go
    toggle.m_childGos, toggle.m_childTrans = GoUtil.GetChildHash(toggle.m_go)

    toggle.value = 1
    local click = function()
        local val = toggle.value == 1 and 2 or 1
        toggle.setValueWithOutNotify(val)
    end
    self:addUIEvent(toggle.m_childGos["mClick"], click)

    toggle.setValueWithNoNotify = function(val)
        toggle.value = val
        toggle.show(val == 2)
    end

    toggle.setValueWithOutNotify = function(val)
        toggle.value = val
        toggle.show(val == 2)
        if toggle.notifyEvent then
            toggle.notifyEvent(toggle.value)
        end
    end

    toggle.show = function(val)
        toggle.m_childGos["mTxtClose"]:GetComponent(ty.Text).text = _TT(62064)
        toggle.m_childGos["mTxtOpen"]:GetComponent(ty.Text).text = _TT(62063)
        toggle.m_childGos["mOpen"]:SetActive(val)
        toggle.m_childGos["mClose"]:SetActive(not val)
    end

    toggle.destroy = function()

    end

    return toggle
end

function active(self)
    super.active(self)

    self.mToggleCamera.setValueWithNoNotify(systemSetting.SystemSettingManager:getSystemSettingValue(systemSetting.SystemSettingDefine.cameraLock))
    self.mToggleLockTeam.setValueWithNoNotify(systemSetting.SystemSettingManager:getSystemSettingValue(systemSetting.SystemSettingDefine.lockTeamMember))
end

function checkAsset(self)
    print("开始检测资源完整性 ... ")
end

function deActive(self)
    super.deActive(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]