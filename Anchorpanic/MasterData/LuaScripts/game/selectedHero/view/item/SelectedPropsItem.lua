module("selectedHero.SelectedPropsItem", Class.impl(BaseReuseItem))

UIRes = UrlManager:getUIPrefabPath("selectedHero/item/SelectedHeroItem.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
    self.isSelect = false
    self.mPropsGrid = nil
end

function configUI(self)
    self.mHeroGroup = self:getChildTrans("mHeroGroup")
    self:getChildGO("mHeroState"):SetActive(false)
    self.mTxtHeroState = self:getChildGO("mTxtHeroState"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.isSelectMask = self:getChildGO("IsSelect")
    self.btn = self:getChildGO("Btn")
    self.mBtnChack = self:getChildGO("mBtnChack")
end

function setData(self, cusParent, cusItemVo)
    self:setParentTrans(cusParent)
    self.vo = cusItemVo[1]
    self.id = cusItemVo[2]
    self.num = cusItemVo[3]
    self:updateView()

    self.btn:SetActive(cusItemVo[4])
    -- self.isSelectMask:SetActive(cusItemVo[4])
end

function setIsSelect(self, is)
    self.isSelect = is
    self.isSelectMask:SetActive(self.isSelect)
end

function updateView(self)
    -- --战员自选
    if (not self.mPropsGrid) then
        if self.vo.type == PropsType.EQUIP and self.vo.subType == PropsEquipSubType.SLOT_7 then
            self.mPropsGrid = BraceletsGrid2:poolGet()
        else
            self.mPropsGrid = PropsGrid:poolGet()
        end

    end

    self.vo.count = self.num
    self.mPropsGrid:setData(self.vo)
    self.mPropsGrid:setParent(self.mHeroGroup)
    if self.vo.count > 1 then
        self.mPropsGrid:setIsShowCount2(true)
    end
    self.mTxtName.text = self.vo.name

    self.isSelectMask:SetActive(false)
end

function addAllUIEvent(self)
    self:addUIEvent(self.btn, self.onSelfClick)
    self:addUIEvent(self.mBtnChack, self.onCheckHandler)
end

function onSelfClick(self)
    if selectedHero.SelectedHeroManager:getCurrentCount() < selectedHero.SelectedHeroManager:getMaxCount() or self.isSelect == true then
        self.isSelect = not self.isSelect
        self.isSelectMask:SetActive(self.isSelect)
        selectedHero.SelectedHeroManager:dispatchEvent(selectedHero.SelectedHeroManager.EVENT_HERO_SELECT, self.id)
    else
        gs.Message.Show(_TT(4046))
    end
end

function onCheckHandler(self)
    if self.vo.subType == 7 then
        local equipVo = LuaPoolMgr:poolGet(props.EquipVo)
        equipVo:setTid(self.vo.tid)
        TipsFactory:equipTips(equipVo)
    else
        local propsVo = props.PropsManager:getPropsConfigVo(self.vo.tid)
        TipsFactory:propsTips({propsVo = propsVo, isShowUseBtn = false}, {rectTransform = nil})
    end

end

function poolRecover(self)
    super.poolRecover(self)
    if (self.mPropsGrid) then
        self.mPropsGrid.count = 0

        -- gs.TransQuick:Scale(self.mPropsGrid.mImgIconEquip.rectTransform, 1, 1, 1)
        self.mPropsGrid:poolRecover()
        self.mPropsGrid = nil
    end

end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
