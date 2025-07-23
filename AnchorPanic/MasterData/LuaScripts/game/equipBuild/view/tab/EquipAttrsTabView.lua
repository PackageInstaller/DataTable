

module("equipBuild.EquipAttrsTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("equipBuild/tab/EquipAttrsTab.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.mEquipVo = nil

    self.mTuPoAttrList = {}
    self.mRemakeItemList = {}
    self.mSuitItemList = {}
end

function configUI(self)
    self.mEquipNode = self:getChildTrans("mEquipNode")
    self.mTxtItemName = self:getChildGO("mTxtItemName"):GetComponent(ty.Text)
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.mTxtAttr = self:getChildGO("mTxtAttr"):GetComponent(ty.Text)
    self.mTxtAdditional = self:getChildGO("mTxtAdditional"):GetComponent(ty.Text)

    self.mTuPoScroll = self:getChildGO("mTuPoScrollView"):GetComponent(ty.ScrollRect)
    self.mRemakeScroll = self:getChildGO("mRemakeScrollView"):GetComponent(ty.ScrollRect)
    self.mSuitScroll = self:getChildGO("mSuitScrollView"):GetComponent(ty.ScrollRect)

    self.mTuPoAttrItem = self:getChildGO("mTuPoAttrItem")
    self.mRemakeItem = self:getChildGO("mRemakeItem")
    self.mSuitItem = self:getChildGO("mSuitItem")
    self.mTxtReform = self:getChildGO("mTxtReform"):GetComponent(ty.Text)
    self.mTxtSuit = self:getChildGO("mTxtSuit"):GetComponent(ty.Text)
    self.mImgBar = self:getChildGO("mImgBar"):GetComponent(ty.Image)
end

function initViewText(self)
    self.mTxtReform.text = _TT(4039)
    self.mTxtSuit.text = _TT(4225)
    self.mTxtAdditional.text = _TT(1332)
end

function active(self, args)
    self:updateView()
end

function deActive(self)
    if self.mEquipVo then
        self.mEquipVo:removeEventListener(equip.EquipVo.UPDATE_EQUIP_DETAIL_DATA,self.updateView,self)
        self.mEquipVo:removeEventListener(props.PropsVo.UPDATE,self.updateView,self)
    end

    self.mEquipVo = nil

    if self.mGrid then
        self.mGrid:poolRecover()
    end
    self.mGrid = nil

    self:clearTuPoItems()
    self:clearRemakeItems()
    self:clearSuitItems()
end

function updateView(self)
    if self.mEquipVo then
        self.mEquipVo:removeEventListener(equip.EquipVo.UPDATE_EQUIP_DETAIL_DATA,self.updateView,self)
        self.mEquipVo:removeEventListener(props.PropsVo.UPDATE,self.updateView,self)
    end

    self.mEquipVo = equipBuild.EquipStrengthenManager:getOpenEquipVo()
    self.mEquipVo:addEventListener(equip.EquipVo.UPDATE_EQUIP_DETAIL_DATA,self.updateView,self)
    self.mEquipVo:addEventListener(props.PropsVo.UPDATE,self.updateView,self)

    if self.mGrid then
        self.mGrid:poolRecover()
        self.mGrid = nil
    end

    self.mGrid = EquipGrid3:create(self.mEquipNode, self.mEquipVo, 1,false)
    self.mGrid:setClickEnable(false)
    self.mGrid:setShowEquipStrengthenLvl(false)
    self.mGrid:setIdxTap(false)
    -- self.mGrid:setPartScale(2*0.65)

    local color = ""
    if self.mEquipVo.color == 1 then 
        color = "45cea2ff"
    elseif self.mEquipVo.color == 2 then 
        color = "29acffff"
    elseif self.mEquipVo.color == 3 then 
        color = "ff72f1ff"
    else
        color = "ff9e35ff"
    end
    self.mImgBar.color = gs.ColorUtil.GetColor(color)
    --更新页面内属性
    self.mTxtItemName.text = self.mEquipVo.name
    self.mTxtLv.text = self.mEquipVo.strengthenLvl

    
    self:updateStrengthenAttr()
    self:updateTuPoAttr()    
    self:updateRemakeAttr()
    self:updateSuitAttr()
end

function updateStrengthenAttr(self)
    -- local mainAttrList,_ = self.mEquipVo:getMainAttr()

    -- if #mainAttrList > 0 then
    --     local preKey = mainAttrList[1].key
    --     local preValue = mainAttrList[1].value
    --     self.mTxtAttr.text = AttConst.getName(preKey).."  <color=#FFFFFF>+"..AttConst.getValueStr(preKey, preValue).."</color>"
    -- end
end

function updateTuPoAttr(self)
    self:clearTuPoItems()

    local attachAttrList, attachAttrDic = self.mEquipVo:getTuPoAttachAttr()
    if(attachAttrList and #attachAttrList > 0) then
        table.sort(attachAttrList, function(a, b)
            return a.breakUpRank < b.breakUpRank
        end)

        for i=1,#attachAttrList do
            local attachAttrVo = attachAttrList[i]
            local tupoAttrItem = SimpleInsItem:create(self.mTuPoAttrItem, self.mTuPoScroll.content, "EquipAttrsTabViewmTuPoAttrItem")

            local txtDes = tupoAttrItem:getChildGO("mTxtAttrDes"):GetComponent(ty.Text)
            -- local txtLock = tupoAttrItem:getChildGO("mTxtLockInfo"):GetComponent(ty.Text)

            txtDes.text = AttConst.getName(attachAttrVo.key) .. " " .. AttConst.getValueStr(attachAttrVo.key, attachAttrVo.value) 
            --已经激活
            local color = "ffffffff"
            if attachAttrVo.isActive then
                -- txtLock.text = _TT(1098)
            else
                color = "c6d4e1ff"
                -- txtLock.text = _TT(71403, attachAttrVo.breakUpRank - 1)
            end
            txtDes.color = gs.ColorUtil.GetColor(color)
            -- txtLock.color = gs.ColorUtil.GetColor(color)
            table.insert(self.mTuPoAttrList,tupoAttrItem)
        end
    end
end

function updateRemakeAttr(self)
    self:clearRemakeItems()

    local remakePosAttrList, remakePosAttrDic = self.mEquipVo:getRemakeAttr()
    if remakePosAttrDic == nil then
        return
    end

    for i= 1,2 do
        local remakeItem = SimpleInsItem:create(self.mRemakeItem, self.mRemakeScroll.content, "EquipAttrsTabViewmRemakeItem")
       
        local itemDes = remakeItem:getChildGO("mTxtAttrDes"):GetComponent(ty.Text)
        local itemValue = remakeItem:getChildGO("mTxtValue"):GetComponent(ty.Text)
        local color = "ffffffff"
        if remakePosAttrDic[i] ~= nil then
            local attrData = remakePosAttrDic[i]
            local key = attrData.key
            local value = attrData.value
            local maxValue = attrData.maxValue
            itemDes.text = AttConst.getName(key) 
            itemValue.text = string.format(_TT(71448), "<color=#44fd73>+"..AttConst.getValueStr(key, value).."</color>", AttConst.getValueStr(key, maxValue))
        else
            color = "c6d4e1ff"
            itemDes.text = _TT(71436)
            itemValue.text = ""
        end
        itemDes.color = gs.ColorUtil.GetColor(color)
        itemValue.color = gs.ColorUtil.GetColor(color)
        table.insert(self.mRemakeItemList,remakeItem)
    end
end

function updateSuitAttr(self)
    self:clearSuitItems()
    local equipConfigVo = equip.EquipManager:getEquipConfigVo(self.mEquipVo.tid)
    local suitId = equipConfigVo.suitId
    local suitConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(suitId)

    if (not suitConfigVo) then
        return
    end
  
    if suitConfigVo.suitSkillId_2 > 0 then
        local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_2)
        local suitItem = SimpleInsItem:create(self.mSuitItem, self.mSuitScroll.content, "EquipAttrsTabViewmSuitItem")
        suitItem:getChildGO("mTxtTitleSuit"):GetComponent(ty.Text).text = _TT(71404)
        suitItem:getChildGO("mTxtSuitDes"):GetComponent(ty.Text).text = skillVo:getDescTip()
        table.insert(self.mSuitItemList,suitItem)
    end

    if suitConfigVo.suitSkillId_4 > 0 then
        local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_4)
        local suitItem = SimpleInsItem:create(self.mSuitItem, self.mSuitScroll.content, "EquipAttrsTabViewmSuitItem")
        suitItem:getChildGO("mTxtTitleSuit"):GetComponent(ty.Text).text = _TT(71405)
        suitItem:getChildGO("mTxtSuitDes"):GetComponent(ty.Text).text =skillVo:getDescTip()
        table.insert(self.mSuitItemList,suitItem)
    end
end

function clearTuPoItems(self)
    for i = 1, #self.mTuPoAttrList do
        self.mTuPoAttrList[i]:poolRecover()
    end
    self.mTuPoAttrList = {}
end

function clearRemakeItems(self)
    for i = 1, #self.mRemakeItemList do
        self.mRemakeItemList[i]:poolRecover()
    end
    self.mRemakeItemList = {}
end

function clearSuitItems(self)
    for i = 1, #self.mSuitItemList do
        self.mSuitItemList[i]:poolRecover()
    end
    self.mSuitItemList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(71405):	"4件套"
	语言包: _TT(71404):	"2件套"
	语言包: _TT(71436):	"-未改造-"
]]
