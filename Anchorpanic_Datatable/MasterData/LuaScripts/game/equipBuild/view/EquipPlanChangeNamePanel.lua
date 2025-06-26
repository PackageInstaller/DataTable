--[[ 
-----------------------------------------------------
@filename       : EquipPlanChangeNamePanel
@Description    : 模组方案名修改界面
@date           : 2023-12-6 00:00:00
@Author         : Zzz
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('equipBuild.EquipPlanChangeNamePanel', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath('equipBuild/EquipPlanChangeNamePanel.prefab')

destroyTime = -1 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗
isAdapta = 0--是否开启适配刘海 0 否 1 是

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(832, 337)
    self:setTxtTitle(_TT(1415))--"方案保存"
end

function initData(self)
    super.initData(self)
    self.mInput = nil
    self.mCurInputTxt = ""
end

function configUI(self)
    self.mInput = self:getChildGO("InputField"):GetComponent(ty.InputField)
    self.mDefaultText = self.mInput.placeholder:GetComponent(ty.Text)
    self.mInput.characterLimit = sysParam.SysParamManager:getValue(SysParamType.PLAYER_AUTOGRAPH_LEN)
    self.mBtnCancel = self:getChildGO('BtnCancel')
    self.mBtnConfirm = self:getChildGO('BtnConfirm')
    self.mTxtTip = self:getChildGO("mTxtTip"):GetComponent(ty.Text)
end

function initViewText(self)
    self.mDefaultText.text = _TT(1416)--"输入1-5个字符方案名"
    self.mTxtTip.text = _TT(23223)--"弹窗提示"
    self:setBtnLabel(self.mBtnCancel, 2, "取消")
    self:setBtnLabel(self.mBtnConfirm, 1, "确定")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnCancel, self.__onClickCancelHandler)
    self:addUIEvent(self.mBtnConfirm, self.__onClickConfirmHandler)
end

function active(self, args)
    super.active(self, args)

    self.mIsAddNew = args.isAddNew
    self.mEquipPlanVo = args.equipPlanVo
    
    self.mInput.characterLimit = sysParam.SysParamManager:getValue(SysParamType.EQUIP_PLAN_NAME_MAX_COUNT)
    self:updateView()
end

function deActive(self)
    super.deActive(self)
end

function updateView(self)
    self.mInput.text = self.mEquipPlanVo.name
end

function __onClickCancelHandler(self)
    self.mInput.text = ""
    self:close()
end

function __onClickConfirmHandler(self)
    local content = self.mInput.text
    content = string.gsub(content, "\n", "")
    if(equipBuild.EquipPlanManager:getEmptyPlanVoDefaultName() == content or self.mEquipPlanVo.name == content)then
        gs.Message.Show(_TT(1417))--"请输入新方案名"
        return
    end
    local limitLen = sysParam.SysParamManager:getValue(SysParamType.EQUIP_PLAN_NAME_MAX_COUNT)
    if (string.getStringCharCount(content) > limitLen) then
        gs.Message.Show(_TT(1416))
        return
    end
    if FilterWordUtil:hasFilterWord(content) then
        gs.Message.Show(_TT(513))--"存在敏感字或非法符号"
        return
    end
    if(equipBuild.EquipPlanManager:getEmptyPlanVoDefaultName() == content or self.mEquipPlanVo.name == content)then
        gs.Message.Show(_TT(1417))--"请输入新方案名"
        return
    end
    if(self.mIsAddNew)then
        GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_PLANE_SAVE, { equipPlanVo = self.mEquipPlanVo, equipPlanName = content })
    else
        GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_PLANE_CHANGE_NAME, { equipPlanId = self.mEquipPlanVo.id, equipPlanName = content })
    end

    self.mInput.text = ""
    self:close()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]