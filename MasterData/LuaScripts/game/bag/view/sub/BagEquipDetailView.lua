module('bag.BagEquipDetailView', Class.impl("lib.component.BaseContainer"))
UIRes = UrlManager:getUIPrefabPath('bag/BagEquipDetailView.prefab')

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.m_propsVo = nil
end

function configUI(self)
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
end

function __reset(self)
    self:__recoverTxtGoDic()
end

function show(self)
    self.UIObject:SetActive(true)
end

function hide(self)
    self.UIObject:SetActive(false)
    self:__reset()
end

function __getGoUniqueName(self, goName)
    return self.__cname .. "_" .. goName
end

function __getTxtGo(self, goName)
    local uniqueName = self:__getGoUniqueName(goName)
    local go = gs.GOPoolMgr:GetOther(uniqueName)
    if (not go or gs.GoUtil.IsGoNull(go)) then
        if (self.m_childGos and self.m_childGos[goName]) then
            go = gs.GameObject.Instantiate(self.m_childGos[goName])
        end
    end
    self.m_txtGoDic[go:GetHashCode()] = { go = go, uniqueName = uniqueName }
    return go
end

function __recoverTxtGoDic(self)
    if (self.m_txtGoDic) then
        for hashCode, data in pairs(self.m_txtGoDic) do
            gs.GOPoolMgr:RecoverOther(data.uniqueName, data.go)
        end
    end
    self.m_txtGoDic = {}
end

function setData(self, cusPropsId)
    self.m_equipVo = bag.BagManager:getPropsVoById(cusPropsId)
    self:__updateView()
end

function __updateView(self)
    self.m_equipVo:removeEventListener(self.m_equipVo.UPDATE_EQUIP_DETAIL_DATA, self.__updateView, self)
    if (self.m_equipVo:getTotalAttr() == nil) then
        self.m_equipVo:addEventListener(self.m_equipVo.UPDATE_EQUIP_DETAIL_DATA, self.__updateView, self)
        return
    end

    self:__recoverTxtGoDic()
    self:__updateGrid()
    self:__updateAttr()
    self:__updateNuclearAttr()
    self:__updateSuit()
    self:__updateRemake()
end

function __updateGrid(self)
    local element_1 = self.m_childTrans["m_element_1"]
    if (not self.m_propsGrid) then
        self.m_propsGrid = PropsGrid:poolGet()
    end
    self.m_propsGrid:setData(self.m_equipVo, element_1)
    self.m_propsGrid:setIsShowName(false)
    self.m_propsGrid:setClickEnable(false)
    self.m_propsGrid:setPosition(gs.Vector3(-120, -70, 0))

    -- self.m_childTrans["mTxtName"]:GetComponent(ty.Text).text = HtmlUtil:color(self.m_equipVo:getName(), ColorUtil:getPropColor(self.m_equipVo.color))
    self.m_childTrans["mTxtName"]:GetComponent(ty.Text).text = self.m_equipVo:getName()
    self.m_childTrans["m_textLvl"]:GetComponent(ty.Text).text = "Lv." .. self.m_equipVo.strengthenLvl
end

-- 更新基础属性
function __updateAttr(self)
    local showAttrDic = {}
    showAttrDic[AttConst.ATTACK] = true
    showAttrDic[AttConst.DEFENSE] = true
    showAttrDic[AttConst.HP_MAX] = true
    local totalAttrList = self.m_equipVo:getTotalAttr()
    for i = 1, #totalAttrList do
        local attrVo = totalAttrList[i]
        if (showAttrDic[attrVo.key]) then
            local txtCloneGo = self:__getTxtGo("m_textAttr")
            txtCloneGo.transform:SetParent(self.m_childTrans["m_element_2"], false)
            txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(AttConst.getName(attrVo.key) .. ":" .. attrVo.value, ColorUtil.BLACK_NUM)
        end
    end
end

-- 更新核能属性
function __updateNuclearAttr(self)
    local nuclearAttrList, nuclearAttrDic = self.m_equipVo:getNuclearAttr()
    if (#nuclearAttrList > 0) then
        self.m_childGos["m_element_3"]:SetActive(true)

        local equipConfigVo = equip.EquipManager:getEquipConfigVo(self.m_equipVo.tid)
        for i = 1, #nuclearAttrList do
            local des = equipConfigVo:getNuclearAttrDes(nuclearAttrList[i])
            local txtCloneGo = self:__getTxtGo("m_textNuclearAttr")
            txtCloneGo.transform:SetParent(self.m_childTrans["m_element_3"], false)
            txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(des, ColorUtil.BLACK_NUM)
        end
    else
        self.m_childGos["m_element_3"]:SetActive(false)
    end

    local skillEffectList, skillEffectDic = self.m_equipVo:getSkillEffect()
    if (skillEffectList and #skillEffectList > 0) then
        self.m_childGos["m_element_3"]:SetActive(true)

        for i = 1, #skillEffectList do
            local des = equip.EquipSkillManager:getSkillDes(self.m_equipVo, skillEffectList[i])
            local txtCloneGo = self:__getTxtGo("m_textNuclearAttr")
            txtCloneGo.transform:SetParent(self.m_childTrans["m_element_3"], false)
            txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(des, ColorUtil.BLACK_NUM)
        end
    else
        if (#nuclearAttrList <= 0) then
            self.m_childGos["m_element_3"]:SetActive(false)
        end
    end
end

-- 更新套装属性
function __updateSuit(self)
    local equipConfigVo = equip.EquipManager:getEquipConfigVo(self.m_equipVo.tid)
    local suitId = equipConfigVo.suitId
    local suitConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(suitId)
    if (not suitConfigVo or (suitConfigVo.suitSkillId_2 <= 0 and suitConfigVo.suitSkillId_4 <= 0)) then
        self.m_childGos["m_element_4"]:SetActive(false)
    else
        self.m_childGos["m_element_4"]:SetActive(true)

        local count = 0
        local suitIdDic = equip.EquipManager:getEquipSuitIdDic()
        local equipTidDic = suitIdDic[suitId]
        local heroVo = hero.HeroManager:getHeroVo(self.m_equipVo.heroId)
        if (heroVo) then
            for i = 1, #heroVo.equipList do
                local propsVo = heroVo.equipList[i]
                if (equipTidDic[propsVo.tid]) then
                    count = count + 1
                    if (count >= 4) then
                        break
                    end
                end
            end
        end

        -- 2件套描述
        if (suitConfigVo.suitSkillId_2 > 0) then
            local colorStr
            if (count >= 2) then
                colorStr = ColorUtil.BLUE_NUM
            else
                colorStr = ColorUtil.BLACK_NUM
            end
            local txtCloneGo = self:__getTxtGo("m_textSuitDes")
            txtCloneGo.transform:SetParent(self.m_childTrans["m_element_4"], false)
            -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("套装" .. suitId .. "的2件套 [触发技能id:" .. suitConfigVo.suitSkillId_2 .. "]", colorStr)
            txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(suitConfigVo.name .. string.substitute(_TT(4013), 2), colorStr)

            txtCloneGo = self:__getTxtGo("m_textSuitDes")
            txtCloneGo.transform:SetParent(self.m_childTrans["m_element_4"], false)
            -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("技能id:" .. suitConfigVo.suitSkillId_2 .. "的描述", colorStr)
            local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_2)
            txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(skillVo:getDesc(), colorStr)
        end
        -- 4件套描述
        if (suitConfigVo.suitSkillId_4 > 0) then
            local colorStr
            if (count >= 4) then
                colorStr = ColorUtil.BLUE_NUM
            else
                colorStr = ColorUtil.BLACK_NUM
            end
            local txtCloneGo = self:__getTxtGo("m_textSuitDes")
            txtCloneGo.transform:SetParent(self.m_childTrans["m_element_4"], false)
            -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("套装" .. suitId .. "的4件套 [触发技能id:" .. suitConfigVo.suitSkillId_4 .. "]", colorStr)
            txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(suitConfigVo.name .. string.substitute(_TT(4013), 4), colorStr)

            txtCloneGo = self:__getTxtGo("m_textSuitDes")
            txtCloneGo.transform:SetParent(self.m_childTrans["m_element_4"], false)
            -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("技能id:" .. suitConfigVo.suitSkillId_4 .. "的描述", colorStr)
            local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_4)
            txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(skillVo:getDesc(), colorStr)
        end
    end
end

-- 更新改造属性
function __updateRemake(self)
    self.m_childGos["m_element_5"]:SetActive(false)
    local remakePosAttrList, remakePosAttrDic = self.m_equipVo:getRemakeAttr()
    for pos, attrData in pairs(remakePosAttrDic) do
        local key = attrData.key
        local value = attrData.value
        local maxValue = attrData.maxValue
        local colorStr = ""
        if (value >= maxValue) then
            colorStr = ColorUtil.RED_NUM
        else
            colorStr = ColorUtil.BLUE_NUM
        end

        local txtCloneGo = self:__getTxtGo("m_textRemakeDes")
        txtCloneGo.transform:SetParent(self.m_childTrans["m_element_5"], false)
        -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(AttConst.getName(key) .. "+" .. HtmlUtil:color(AttConst.getValueStr(key, value), colorStr) .. "(最大".. HtmlUtil:color(AttConst.getValueStr(key, maxValue), ColorUtil.RED_NUM) ..")", ColorUtil.BLACK_NUM)
        txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(AttConst.getName(key) .. "+" .. HtmlUtil:color(AttConst.getValueStr(key, value), colorStr) .. string.substitute(_TT(4014), HtmlUtil:color(AttConst.getValueStr(key, maxValue), ColorUtil.RED_NUM)), ColorUtil.BLACK_NUM)

        self.m_childGos["m_element_5"]:SetActive(true)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]