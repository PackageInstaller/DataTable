module('role.RoleModifyNamePanel', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath('role/RoleModifyNamePanel.prefab')

destroyTime = -1 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗
isAdapta = 0--是否开启适配刘海 0 否 1 是
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(832, 353)
    self:setTxtTitle(_TT(25214))
end

function initData(self)
end

function configUI(self)
    self.mInput = self:getChildGO("InputField"):GetComponent(ty.InputField)
    self.mTxtDefault = self.mInput.placeholder:GetComponent(ty.Text)
    self.mTxtTip = self:getChildGO("mTxtTip"):GetComponent(ty.Text)
    self.mBtnCancel = self:getChildGO('mBtnCancel')
    self.mBtnConfirm = self:getChildGO('mBtnConfirm')
end

function initViewText(self)
    self.mTxtDefault.text = _TT(517)--"请输入"
    self:setBtnLabel(self.mBtnCancel, 2, "取消")
    self:setBtnLabel(self.mBtnConfirm, 1, "确定")
    self.mTxtTip.text = _TT(25125)--"你的名字不包含特殊字符，且不超过6个字"
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnCancel, self.onClickCancelHandler)
    self:addUIEvent(self.mBtnConfirm, self.onClickConfirmHandler)
end

function active(self)
    self.mInput.characterLimit = sysParam.SysParamManager:getValue(SysParamType.PLAYER_NAME_INPUT_LIMIT)
    GameDispatcher:addEventListener(EventName.MODIFY_ROLE_NAME_SUCCESS, self.onChangePlayerNameHandler, self)
    self.mInput.text = role.RoleManager:getInputText()
    --local function inputChange(content)
    --    local str = string.gsub(content, "^[\\u4E00-\\u9FA5A-Za-z0-9]+$", "")
    --    self.mInput.text = str
    --end
    --self.mInput.onValueChanged:AddListener(inputChange)
end

function deActive(self)
    GameDispatcher:removeEventListener(EventName.MODIFY_ROLE_NAME_SUCCESS, self.onChangePlayerNameHandler, self)
end

-- 修改名称成功
function onChangePlayerNameHandler(self)
    self:close()
end

function onClickCancelHandler(self)
    if (role.RoleController.storyArgs) then
        gs.Message.Show(_TT(25115))--"请修改名称"
    else
        self.mInput.text = ""
        self:close()
    end
end

function onClickConfirmHandler(self)
    local newName = self.mInput.text
    if not newName or newName == "" then
        gs.Message.Show(_TT(25114)) --请输入名称
        return
    end

    local limitLen = sysParam.SysParamManager:getValue(SysParamType.PLAYER_NAME_LEN)
    if (string.getStringCharCount(newName) > limitLen) then
        gs.Message.Show(_TT(1211))
        return
    end


    if FilterWordUtil:HasReNameFilterWord(newName) then
        gs.Message.Show(_TT(513))--"存在敏感字或非法符号"
        return
    end
    GameDispatcher:dispatchEvent(EventName.REQ_MODIFY_ROLE_NAME, { name = newName })
    GameDispatcher:dispatchEvent(EventName.REQ_PLAYER_HOMEPAGE_INFO)
end

-- 玩家点击关闭
function onClickClose(self)
    if (role.RoleController.storyArgs) then
        gs.Message.Show(_TT(25115))--"请修改名称"
    else
        super.onClickClose(self)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]