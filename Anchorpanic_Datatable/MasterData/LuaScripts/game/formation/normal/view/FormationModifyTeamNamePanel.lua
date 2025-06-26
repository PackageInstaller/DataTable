module('formation.FormationModifyTeamNamePanel', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath('formation/FormationModifyTeamNamePanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗
isAdapta = 0--是否开启适配刘海 0 否 1 是
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(832, 353)
    self:setTxtTitle(_TT(25214))
end

function getManager(self)
    return self.mManager
end

function setManager(self, cusManager)
    self.mManager = cusManager
end

function initData(self)
    self.mTeamId = nil
end

function configUI(self)
    self.mInput = self:getChildGO("mTxtInput"):GetComponent(ty.InputField)
    self.mTxtTip = self:getChildGO("mTxtTip"):GetComponent(ty.Text)
    self.mDefaultText = self.mInput.placeholder:GetComponent(ty.Text)
    self.mBtnCancel = self:getChildGO('mBtnCancel')
    self.mBtnConfirm = self:getChildGO('mBtnConfirm')
end

function initViewText(self)
    self.mDefaultText.text = _TT(1236) --请输入队伍名称
    self.mTxtTip.text = _TT(1237)--"你的队名不包含特殊字符，且不超过4个字"
    self:setBtnLabel(self.mBtnCancel, 2, "取消")
    self:setBtnLabel(self.mBtnConfirm, 1, "确定")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnCancel, self.onClickCancelHandler)
    self:addUIEvent(self.mBtnConfirm, self.onClickConfirmHandler)
end

function active(self, args)
    super.active(self, args)
    self.mInput.text = role.RoleManager:getInputText()
    self:setManager(args.manager)
    self.mTeamId = args.data.teamId
end

function deActive(self)
    super.deActive(self)
end

function onClickCancelHandler(self)
    self.mInput.text = ""
    self:close()
end

function onClickConfirmHandler(self)
    local newName = self.mInput.text
    if not newName or newName == "" then
        gs.Message.Show(_TT(1236)) --请输入队伍名称
        return
    end

    local limitLen = sysParam.SysParamManager:getValue(SysParamType.FORMATION_TEAM_NAME_LEN)
    if (string.getStringCharCount(newName) > limitLen) then
        gs.Message.Show(_TT(1238)) --队名最长为4字
        return
    end

    if FilterWordUtil:HasReNameFilterWord(newName) then
        gs.Message.Show(_TT(513))--"存在敏感字或非法符号"
        return
    end

    self.mInput.text = ""
    self:getManager():dispatchEvent(self:getManager().REQ_MODIFY_TEAM_NAME, { teamId = self.mTeamId, name = newName })
    self:close()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]