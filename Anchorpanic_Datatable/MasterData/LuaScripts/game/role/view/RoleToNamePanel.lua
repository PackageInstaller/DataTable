module('role.RoleToNamePanel', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("role/Login2Name.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = -1 -- 窗口类型 1 全屏 2 弹窗
isBlur = 0
escapeClose = 0 -- 是否能通过esc关闭窗口

function setMask(self)
end

function configUI(self)
    self.m_textTitle = self:getChildGO("DescTxt"):GetComponent(ty.Text)
    self.m_btnPreClick = self:getChildGO("BtnPreClick")
    self.m_inputGo = self:getChildGO("InputField")
    self.m_input = self:getChildGO("InputField"):GetComponent(ty.InputField)
    self.m_defaultText = self.m_input.placeholder:GetComponent(ty.Text)
    -- self.m_input.characterLimit = sysParam.SysParamManager:getValue(SysParamType.PLAYER_NAME_LEN)
    self.m_btnConfirm = self:getChildGO('OKBtn')
end

function initViewText(self)
    self.m_textTitle.text = _TT(25125)--"请输入名称"
    self.m_defaultText.text = _TT(517)--"请输入"
    self:setBtnLabel(self.m_btnConfirm, 1, "确定")
end

function addAllUIEvent(self)
    self:addUIEvent(self.m_btnConfirm, self.__onClickConfirmHandler)
    self:addUIEvent(self.m_inputGo, self.__onClickInputField)
    self:addUIEvent(self.m_btnPreClick, self.__onClickImgPre)
end

function active(self)
    -- GameDispatcher:addEventListener(EventName.MODIFY_ROLE_NAME_SUCCESS, self.__onChangePlayerNameHandler, self)
    -- self.m_input.onValueChanged:AddListener(function()
    --     self:inputChange()
    -- end);
    self.m_input.characterLimit = sysParam.SysParamManager:getValue(SysParamType.PLAYER_NAME_INPUT_LIMIT)
end

function deActive(self)
    -- GameDispatcher:removeEventListener(EventName.MODIFY_ROLE_NAME_SUCCESS, self.__onChangePlayerNameHandler, self)
    -- self.m_input.onValueChanged:RemoveListener()
end

function __onClickInputField(self)
    self.m_defaultText.text = ""
end
function __onClickImgPre(self)
    if self.m_input.text == "" then
        self.m_defaultText.text = _TT(517)--"请输入"
    end
end

-- 修改名称成功
function __onChangePlayerNameHandler(self)
    self:close()
end

function __onClickConfirmHandler(self)
    local newName = self.m_input.text
    if not newName or newName == "" then
        gs.Message.Show(_TT(25114)) --请输入名称
        return
    end
    
    local limitLen = sysParam.SysParamManager:getValue(SysParamType.PLAYER_NAME_LEN)
    if(string.getStringCharCount(newName) > limitLen)then
        gs.Message.Show(_TT(1211))
        return
    end

    if FilterWordUtil:HasReNameFilterWord(newName) then
        gs.Message.Show(_TT(513))--"存在敏感字或非法符号"
        return
    end
    GameDispatcher:dispatchEvent(EventName.REQ_MODIFY_ROLE_NAME, { name = newName })
    GameDispatcher:dispatchEvent(EventName.REQ_GAME_REPORT, {key = stepReport.GAME_REPORT_STEP.FIRST_CHANGE_NAME, value = newName})
    self.m_input.text = ""
end

-- function inputChange(self)
--     local newName = self.m_input.text
--     -- newName = string.gsub(newName, "%s", "")
--     -- newName = string.gsub(newName, "%p", "")
--     self.m_input.text = newName
-- end

function __playOpenAction(self)

end

function __closeOpenAction(self)
    self:close()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
