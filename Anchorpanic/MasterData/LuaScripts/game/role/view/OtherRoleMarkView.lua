--[[ 
-----------------------------------------------------
@filename       : OtherRoleMarkView
@Description    : 玩家备注页面
@date           : 2020-08-24 10:40:27
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.role.view.OtherRoleMarkView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("role/OtherRoleMarkView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗
isAdapta = 0--是否开启适配刘海 0 否 1 是
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(832, 353)
    self:setTxtTitle(_TT(25215))
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mTxtTip = self:getChildGO("mTxtTip"):GetComponent(ty.Text)
    self.mTxtInput = self:getChildGO("mTxtInput"):GetComponent(ty.InputField);
    self.mTxtDefault = self.mTxtInput.placeholder:GetComponent(ty.Text)
    self.mBtnCancel = self:getChildGO("mBtnCancel")
    self.mBtnConfirm = self:getChildGO("mBtnConfirm")
end

function initViewText(self)
    self.mTxtDefault.text = _TT(25183) --"请输入"
    self:setBtnLabel(self.mBtnCancel, 2, "取消")
    self:setBtnLabel(self.mBtnConfirm, 1, "确定")
    self.mTxtTip.text = _TT(25189) --"你的名字不包含特殊字符，且不超过6个字"
end

--激活
function active(self, args)
    super.active(self, args)
    self.mTxtInput.text = role.RoleManager:getInputText()
    self.roleId = args
    self:updateMarkInfo()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mBtnCancel, self.onCancel)
    self:addUIEvent(self.mBtnConfirm, self.onConfirm)
end

function onCancel(self)
    self:close()
end

function onConfirm(self)
    local newMarks = self.mTxtInput.text
    if FilterWordUtil:hasFilterWord(newMarks) then
        gs.Message.Show(_TT(513))--"存在敏感字或非法符号"
        return
    elseif FilterWordUtil:HasReNameFilterWord(newMarks) then 
        gs.Message.Show(_TT(25217))--"存在敏感字或非法符号"
        return
    end
    if newMarks == "" then
        GameDispatcher:dispatchEvent(EventName.REQ_MASKSCLEAR, self.roleId)
    else
        GameDispatcher:dispatchEvent(EventName.REQ_FRIEND_RE_MARKS, { id = self.roleId, marks = newMarks })
    end
    self:close()
end

function updateMarkInfo(self)
    local marks = ""
    if not self.roleId then
        return
    end

    local friendVo = friend.FriendManager:getFriendVo(self.roleId)
    if friendVo then
        marks = friendVo.marks
    end

    self.mTxtInput.text = marks
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]