module("equipBuild.EquipRestructureSucPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("equipBuild/success/EquipRestructureSucPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 520)
    self:setTxtTitle("")
end

-- 初始化数据
function initData(self)
    self.m_attrItemList = {}
    self.m_desItemList = {}
end

function configUI(self)
    super.configUI(self)
    self.m_textTitle = self:getChildGO("TextTitle"):GetComponent(ty.Text)

    self.m_textCancel = self:getChildGO("TextCancel"):GetComponent(ty.Text)
    self.m_textReplace = self:getChildGO("TextReplace"):GetComponent(ty.Text)
    self.m_btnCancel = self:getChildGO("BtnCancel")
    self.m_btnReplace = self:getChildGO("BtnReplace")

    self.m_textTitleOld = self:getChildGO("TextTitleOld"):GetComponent(ty.Text)
    self.m_textTitleCur = self:getChildGO("TextTitleCur"):GetComponent(ty.Text)

    self.m_groupContent = self:getChildTrans("Content")
    
    self.m_imgNuclearSkill = self:getChildTrans('ImgNuclearSkill'):GetComponent(ty.AutoRefImage)
    self.m_textOldNuclearSkillLvl = self:getChildTrans('TextOldNuclearSkillLvl'):GetComponent(ty.Text)
    self.m_textCurNuclearSkillLvl = self:getChildTrans('TextCurNuclearSkillLvl'):GetComponent(ty.Text)
    self.m_textNuclearSkillName = self:getChildTrans('TextNuclearSkillName'):GetComponent(ty.Text)
end

function active(self, args)
    super.active(self, args)
    self:setData(args.oldEquipVo, args.curEquipVo)
end

function deActive(self)
    super.deActive(self)
    self:__recyAllItem()
	self:__recoverAttrItem()
end

function initViewText(self)
    self.m_textCancel.text = _TT(2)
    self.m_textReplace.text = _TT(71443)
    self.m_textTitle.text = _TT(71444)
    self.m_textTitleOld.text = _TT(71401)
    self.m_textTitleCur.text = _TT(71402)
end

function addAllUIEvent(self)
    self:addUIEvent(self.m_btnCancel, self.__onCancelHandler)
    self:addUIEvent(self.m_btnReplace, self.__onReplaceHandler)
end

function __onCancelHandler(self)
    self:close()
end

function __onReplaceHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_CONFIRM_RESCTUCTURE, {})
    self:close()
end

function __recyAllItem(self)
    for i = 1, #self.m_attrItemList do
        local item = self.m_attrItemList[i]
        gs.GOPoolMgr:Recover(item, "HeroSucItem.prefab")
    end
    self.m_attrItemList = {}

    for i = 1, #self.m_desItemList do
        local item = self.m_desItemList[i]
        gs.GOPoolMgr:Recover(item, "EquipRestructureSucItem.prefab")
    end
    self.m_desItemList = {}
end

function setData(self, oldEquipVo, curEquipVo)
	self:__recoverAttrItem()

    -- 更新核能属性相关描述显示
    local oldNuclearAttrList, oldNuclearAttrDic = oldEquipVo:getNuclearAttr()
    local curNuclearAttrList, curNuclearAttrDic = curEquipVo:getNuclearAttr()
    if(curNuclearAttrList and #curNuclearAttrList > 0)then
        local equipConfigVo = equip.EquipManager:getEquipConfigVo(curEquipVo.tid)
        for i = 1, #curNuclearAttrList do
            local nuclearAttrVo = curNuclearAttrList[i]
            local item = self:__getAttrItemGo("ItemAttr")
            item.transform:SetParent(self.m_groupContent, false)
            item.transform:Find("TextAttrName"):GetComponent(ty.Text).text = AttConst.getName(nuclearAttrVo.key)
            item.transform:Find("TextOldAttrValue"):GetComponent(ty.Text).text = AttConst.getValueStr(nuclearAttrVo.key, oldNuclearAttrDic[nuclearAttrVo.key])
            item.transform:Find("TextCurAttrValue"):GetComponent(ty.Text).text = AttConst.getValueStr(nuclearAttrVo.key, nuclearAttrVo.value)
            local nuclearAttrData = equipConfigVo.nuclearAttrDic[nuclearAttrVo.key]
            item.transform:Find("TextRange"):GetComponent(ty.Text).text = "("..AttConst.getValueStr(nuclearAttrVo.key, nuclearAttrData.minValue).."~"..AttConst.getValueStr(nuclearAttrVo.key, nuclearAttrData.maxValue)..")"
        end
    end

    -- 更新核能技能相关描述显示
    local oldSkillEffectList, oldSkillEffectDic = oldEquipVo:getSkillEffect()
    local curSkillEffectList, curSkillEffectDic = curEquipVo:getSkillEffect()
    if(oldSkillEffectList and #oldSkillEffectList > 0)then
        for i = 1, #oldSkillEffectList do
            local nuclearSkillData = oldSkillEffectList[i]
            local skillVo = fight.SkillManager:getSkillRo(nuclearSkillData.skillId)
            self.m_imgNuclearSkill:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), true)
            self.m_textNuclearSkillName.text = skillVo:getName()
            self.m_textOldNuclearSkillLvl.text = equip.EquipSkillManager:getSkillLvl(nuclearSkillData)

            self.m_textCurNuclearSkillLvl.text = ""
            for i = 1, #curSkillEffectList do
                if(curSkillEffectList[i].skillId == nuclearSkillData.skillId)then
                    self.m_textCurNuclearSkillLvl.text = equip.EquipSkillManager:getSkillLvl(curSkillEffectList[i])
                    break
                end
            end
        end
    end
end

function __getGoUniqueName(self, goName)
    return self.__cname .. "_" .. goName
end

function __getAttrItemGo(self, goName)
    local uniqueName = self:__getGoUniqueName(goName)
    local go = gs.GOPoolMgr:GetOther(uniqueName)
	if (not go or gs.GoUtil.IsGoNull(go)) then
		go = gs.GameObject.Instantiate(self:getChildGO(goName))
    end
    go:SetActive(true)
    self.m_attrItemGoDic[go:GetHashCode()] = {go = go, uniqueName = uniqueName}
    return go
end

function __recoverAttrItem(self)
    if (self.m_attrItemGoDic) then
        for hashCode, data in pairs(self.m_attrItemGoDic) do
            gs.GOPoolMgr:RecoverOther(data.uniqueName, data.go)
        end
    end
    self.m_attrItemGoDic = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(71402):	"重构结果"
	语言包: _TT(71401):	"当前属性"
	语言包: _TT(71444):	"重构成功"
	语言包: _TT(71443):	"替换"
	语言包: _TT(2):	"取消"
]]
