module("hero.HeroEquipAttrListPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("hero/HeroAttrListPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)

    self.gBtnClose:SetActive(false)
    if (self.base_childGos["gImgBg2"]) then
        self.base_childGos["gImgBg2"]:SetActive(false)
    end
    if (self.base_childGos["gImgBg3"]) then
        self.base_childGos["gImgBg3"]:SetActive(false)
    end
end

-- 初始化数据
function initData(self)
    self.mAttrTypeDic = {}
    self.mAttrGroupList = {}
    self.mAttrItemList = {}
end

function configUI(self)
    super.configUI(self)
    self.mTextTitle = self:getChildGO("TextTitle"):GetComponent(ty.Text)
    self.mContent = self:getChildTrans("Content")
    self.mAttrGroup = self:getChildGO("mAttrGroup")
end

function active(self, args)
    super.active(self, args)
    hero.HeroManager:addEventListener(hero.HeroManager.HERO_EQUIP_ALL_TOTAL_ATTR_UPDATE, self.onEquipUpdateHandler, self)
    self:setData(args)
end

function deActive(self)
    super.deActive(self)
    hero.HeroManager:removeEventListener(hero.HeroManager.HERO_EQUIP_ALL_TOTAL_ATTR_UPDATE, self.onEquipUpdateHandler, self)
end

function initViewText(self)
    self.mTextTitle.text = "属性总览"
end

function addAllUIEvent(self)
end

function setData(self, heroVo)
    self.heroVo = heroVo
    self:updateView()
end

function onEquipUpdateHandler(self)
    self:updateView()
end

function updateView(self)
    if not self.heroVo.equipAttrListAll then
        -- 请求英雄芯片属性数据
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_EQUIP_ALL_TOTAL_ATTR, { heroId = self.heroVo.id })
        return
    end

    self.mAttrTypeDic = {}
    for i = 1, #self.heroVo.attrList do
        local attrData = self.heroVo.attrList[i]
        local attrType = AttConst.getAttrType(attrData.key)
        if(attrType ~= AttConst.AttrType.Baseic)then
            local attrList = self.mAttrTypeDic[attrType]
            if(not attrList)then
                attrList = {}
                self.mAttrTypeDic[attrType] = attrList
            end
            table.insert(attrList, {key = attrData.key, value = self.heroVo.equipAttrDicAll[attrData.key] == nil and 0 or self.heroVo.equipAttrDicAll[attrData.key]})
            table.sort(attrList, AttConst.sort)
        end
    end

    self:recoverAllItem()
    for attrType, v in pairs(self.mAttrTypeDic) do 
        local groupItem = SimpleInsItem:create(self.mAttrGroup, self.mContent, "HeroAttrListPanelattrGroupItem")
        local txtAttrTitle = groupItem:getChildGO("mTxtAttrTitle"):GetComponent(ty.Text)
        if attrType == AttConst.AttrType.Baseic then 
            txtAttrTitle.text = _TT(3029)
        elseif attrType == AttConst.AttrType.Special then
            txtAttrTitle.text = _TT(3030)
        elseif attrType == AttConst.AttrType.Element then 
            txtAttrTitle.text = _TT(3064)
        end

        for m, n in pairs(v) do 
            local attrItem = SimpleInsItem:create(groupItem:getChildGO("mAttrItem"), groupItem:getTrans(), "HeroAttrListPanelattrItem")
            local attrName = attrItem:getChildGO("mTxtAttrName"):GetComponent(ty.Text)
            local attrValue = attrItem:getChildGO("mTxtAttrValue"):GetComponent(ty.Text)
            local equipValue = attrItem:getChildGO("mTxtEquipAddValue"):GetComponent(ty.Text)

            if attrType ~= AttConst.AttrType.Baseic then 
                attrName.text = AttConst.getName(n.key)
                attrValue.text = AttConst.getValueStr(n.key, n.value)
                equipValue.text = ""
            end
            table.insert(self.mAttrItemList, attrItem)
        end
        table.insert(self.mAttrGroupList, groupItem)
    end
end

function recoverAllItem(self)
    for k, v in pairs(self.mAttrItemList) do 
        v:poolRecover()
    end
    self.mAttrItemList = {}

    for k, v in pairs(self.mAttrGroupList) do 
        v:poolRecover()
    end
    self.mAttrGroupList = {}
end

return _M