module("equip.EquipRestructureDetailPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("equipBuild/EquipRestructureDetailPanel.prefab")
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle('')
end

-- 初始化数据
function initData(self)
end

function configUI(self)
	super.configUI(self)
    self.m_textTitle = self:getChildGO("TextTitle"):GetComponent(ty.Text)
    self.m_groupContent = self:getChildTrans('Content')
    
    self.m_imgNuclearSkill = self:getChildTrans('ImgNuclearSkill'):GetComponent(ty.AutoRefImage)
    self.m_textNuclearSkillLvl = self:getChildTrans('TextNuclearSkillLvl'):GetComponent(ty.Text)
    self.m_textNuclearSkillName = self:getChildTrans('TextNuclearSkillName'):GetComponent(ty.Text)
    self.m_textDes = self:getChildTrans('TextDes'):GetComponent(ty.Text)
end

function active(self, args)
    super.active(self, args)
    self:setData(args)
end

function deActive(self)
	super.deActive(self)
	self:__recoverAttrItem()
end

function initViewText(self)
	self.m_textTitle.text = _TT(71417)
end

function addAllUIEvent(self)
end

function setData(self, equipVo)
	self:__recoverAttrItem()

    -- 更新核能属性相关描述显示
    local nuclearAttrList, nuclearAttrDic = equipVo:getNuclearAttr()
    if(nuclearAttrList and #nuclearAttrList > 0)then
        local equipConfigVo = equip.EquipManager:getEquipConfigVo(equipVo.tid)
        for i = 1, #nuclearAttrList do
            local nuclearAttrVo = nuclearAttrList[i]
            local item = self:__getAttrItemGo("ItemAttr")
            item.transform:SetParent(self.m_groupContent, false)
            item.transform:Find("TextAttrName"):GetComponent(ty.Text).text = AttConst.getName(nuclearAttrVo.key)
            item.transform:Find("TextAttrValue"):GetComponent(ty.Text).text = AttConst.getValueStr(nuclearAttrVo.key, nuclearAttrVo.value)
            local nuclearAttrData = equipConfigVo.nuclearAttrDic[nuclearAttrVo.key]
            item.transform:Find("TextRange"):GetComponent(ty.Text).text = "("..AttConst.getValueStr(nuclearAttrVo.key, nuclearAttrData.minValue).."~"..AttConst.getValueStr(nuclearAttrVo.key, nuclearAttrData.maxValue)..")"
        end
    end

    -- 更新技能相关描述显示
    local skillEffectList, skillEffectDic = equipVo:getSkillEffect()
    if(skillEffectList and #skillEffectList > 0)then
        for i = 1, #skillEffectList do
            local nuclearSkillData = skillEffectList[i]
            local des = equip.EquipSkillManager:getSkillDes(equipVo, nuclearSkillData)
            local skillVo = fight.SkillManager:getSkillRo(nuclearSkillData.skillId)
            self.m_imgNuclearSkill:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), true)
            self.m_textNuclearSkillName.text = skillVo:getName()
            self.m_textNuclearSkillLvl.text = equip.EquipSkillManager:getSkillLvl(nuclearSkillData)
            self.m_textDes.text = des
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
	语言包: _TT(71417):	"核能属性"
]]
