module("hero.HeroAttrListPanel", Class.impl(View))

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
    self.mAttrDic = {}
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
    self:setData(args)
end

function deActive(self)
    super.deActive(self)
end

function initViewText(self)
    self.mTextTitle.text = "属性总览"
end

function addAllUIEvent(self)
end

function setData(self, heroVo)
    self.heroVo = heroVo
    local attrList = heroVo:getAttrListByType()
    local equipList = heroVo.equipAttrList
    table.sort(attrList, AttConst.sort)
    for k, v in pairs(attrList) do
        local key = AttConst.getAttrType(v.key)
        if not self.mAttrDic[key] then 
            self.mAttrDic[key] = {}
        end
        local equipValue = 0
        for m, n in pairs(equipList) do 
            if v.key == n.key then 
                equipValue = n.value
            end
        end 
        table.insert(self.mAttrDic[key], {key = v.key, value = v.value, equipValue = equipValue})
    end
    self:updateView()
end

function updateView(self)
    self:recoverAllItem()
    for k, v in pairs(self.mAttrDic) do 
        local groupItem = SimpleInsItem:create(self.mAttrGroup, self.mContent, "HeroAttrListPanelattrGroupItem")
        local txtAttrTitle = groupItem:getChildGO("mTxtAttrTitle"):GetComponent(ty.Text)
        if k == AttConst.AttrType.Baseic then 
            txtAttrTitle.text = _TT(3029)
        elseif k == AttConst.AttrType.Special then
            txtAttrTitle.text = _TT(3030)
        elseif k == AttConst.AttrType.Element then 
            txtAttrTitle.text = _TT(3064)
        end

        for m, n in pairs(v) do 

            local attrItem = SimpleInsItem:create(groupItem:getChildGO("mAttrItem"), groupItem:getTrans(), "HeroAttrListPanelattrItem")
            local attrName = attrItem:getChildGO("mTxtAttrName"):GetComponent(ty.Text)
            local attrValue = attrItem:getChildGO("mTxtAttrValue"):GetComponent(ty.Text)
            local equipValue = attrItem:getChildGO("mTxtEquipAddValue"):GetComponent(ty.Text)

            -- if n.key >= 401 and n.key <= 403 then --三种属性伤害
            --     n.value = n.value + self.heroVo.allElementDemage 
            -- elseif n.key >= 501 and n.key <= 503 then --三种属性抗性
            --     n.value = n.value + self.heroVo.allElementDefine 
            -- end
            if k == AttConst.AttrType.Baseic then 
                attrName.text = AttConst.getName(n.key)
                attrValue.text = AttConst.getValueStr(n.key, n.value - n.equipValue)
                if n.equipValue ~= 0 then
                    equipValue.text = "+"..AttConst.getValueStr(n.key, n.equipValue)
                    equipValue.gameObject:SetActive(true)
                else
                    equipValue.text=""
                end
            else
                attrName.text = AttConst.getName(n.key)
                attrValue.text = AttConst.getValueStr(n.key, n.value)
                equipValue.text="" 
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
 
--[[ 替换语言包自动生成，请勿修改！
]]
