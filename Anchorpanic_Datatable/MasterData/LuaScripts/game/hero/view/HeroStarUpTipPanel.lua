module('hero.HeroStarUpTipPanel', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath('hero/HeroStarUpTipPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    -- self:setSize(650, 470)
    -- self:setTxtTitle('')
end

function initData(self)
    self.mCallFun = nil
end

function configUI(self)
    self.m_textTitle = self:getChildGO("TextTitle"):GetComponent(ty.Text)
    self.m_textTip = self:getChildGO("TextTip"):GetComponent(ty.Text)
    self.m_input = self:getChildGO("InputField"):GetComponent(ty.InputField)
    self.m_defaultText = self.m_input.placeholder:GetComponent(ty.Text)
    self.m_input.characterLimit = sysParam.SysParamManager:getValue(SysParamType.PLAYER_NAME_LEN)
    self.m_btnCancel = self:getChildGO('BtnCancel')
    self.m_btnConfirm = self:getChildGO('BtnConfirm')
end

function initViewText(self)
    self.m_textTitle.text = _TT(1175)--"相同的战员可以用作技能升级消耗，任意SSR战员都可以用作升星材料，是否继续消耗？"
    self.m_defaultText.text = _TT(29533)--"请输入YES以确认操作"
    self.m_textTip.text = ""
    self:setBtnLabel(self.m_btnCancel, 2, "取消")
    self:setBtnLabel(self.m_btnConfirm, 1, "确定")
end

function addAllUIEvent(self)
    self:addUIEvent(self.m_btnCancel, self.__onClickCancelHandler)
    self:addUIEvent(self.m_btnConfirm, self.__onClickConfirmHandler)
end

function active(self, args)
    super.active(self, args)
    self.mCallFun = args.callFun
end

function deActive(self)
    super.deActive(self)
end

function __onClickCancelHandler(self)
    if(self.mCallFun)then
        self.mCallFun(false)
    end
    self:close()
end

function __onClickConfirmHandler(self)
    if string.lower(self.m_input.text) == "yes" then
        if(self.mCallFun)then
            self.mCallFun(true)
        end
        self:close()
    else
        gs.Message.Show(_TT(41026))
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
