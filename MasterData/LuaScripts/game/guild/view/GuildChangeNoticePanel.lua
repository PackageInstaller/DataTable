module('guild.GuildChangeNoticePanel', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath('guild/GuildChangeNoticePanel.prefab')

destroyTime = -1 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗
isAdapta = 0--是否开启适配刘海 0 否 1 是

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(832, 353)
    self:setTxtTitle(_TT(94512))
end

function initData(self)
    self.m_input = nil
    self.mCurInputTxt = ""
end

function configUI(self)
    self.m_textTitle = self:getChildGO("TextTitle"):GetComponent(ty.Text)
    self.m_input = self:getChildGO("InputField"):GetComponent(ty.InputField)
    self.m_defaultText = self.m_input.placeholder:GetComponent(ty.Text)
    self.m_input.characterLimit = sysParam.SysParamManager:getValue(SysParamType.GUILD_NOTICE_LIMIT)
    self.m_btnCancel = self:getChildGO('BtnCancel')
    self.m_btnConfirm = self:getChildGO('BtnConfirm')
    self.mTxtTip = self:getChildGO("mTxtTip"):GetComponent(ty.Text)
end

function initViewText(self)
    self.m_textTitle.text = _TT(94513)--"请输入个性签名"
    self.m_defaultText.text = _TT(25181)--"请输入"
    self.mTxtTip.text = _TT(23223)--"弹窗提示"
    self:setBtnLabel(self.m_btnCancel, 2, "取消")
    self:setBtnLabel(self.m_btnConfirm, 1, "确定")
end

function addAllUIEvent(self)
    self:addUIEvent(self.m_btnCancel, self.__onClickCancelHandler)
    self:addUIEvent(self.m_btnConfirm, self.__onClickConfirmHandler)
end

function active(self)
    self.m_input.characterLimit = sysParam.SysParamManager:getValue(SysParamType.GUILD_NOTICE_LIMIT)
    self:__updateView()
    --self.m_input.text = ""
    self.mCurInputTxt = self.m_input.text
end

function deActive(self)
    self:removeOnClick(self.m_btnCancel)
    self:removeOnClick(self.m_btnConfirm)
end

function onClose(self)
    self:close()
end

function __updateView(self)
    self.m_input.text = guild.GuildManager:getGuildNotice()
end

function __onClickCancelHandler(self)
    self.m_input.text = ""
    self:onClose()
end

function __onClickConfirmHandler(self)
    if self.mCurInputTxt == self.m_input.text then
        self:onClose()
        return
    end
    self.mCurInputTxt = self.m_input.text
    local content = self.m_input.text
    --local limitLen = sysParam.SysParamManager:getValue(SysParamType.GUILD_NOTICE_LIMIT)
    -- if (string.getStringCharCount(content) > limitLen) then
    --     gs.Message.Show(_TT(25190))
    --     return
    -- end
    if FilterWordUtil:hasFilterWord(content) then
        gs.Message.Show(_TT(513))--"存在敏感字或非法符号"
        return
    end
    GameDispatcher:dispatchEvent(EventName.REQ_CHANGE_NOTICE, { notice = content })
    --self.m_input.text = ""
    --self:onClose()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]