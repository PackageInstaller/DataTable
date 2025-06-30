module("hero.DnaSwitchActiveAttrView", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("dna/DnaSwitchActiveAttrView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2   -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

local toggleDataDefine = {
    [1] = { attrId = AttConst.HP_MAX, lanId = 149942 },
    [2] = { attrId = AttConst.ATTACK, lanId = 149944 },
    [3] = { attrId = AttConst.DEFENSE, lanId = 149945 }
}

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(834, 335)
    self:setTxtTitle(_TT(149946))
end

function initData(self)
    self.mItemList = {}
end

function configUI(self)
    self.mItem = self:getChildGO("mItem")
    self.mItem:SetActive(false)
    self.mGroup = self:getChildTrans("mGroup")
end

function initViewText(self)
    super.initViewText(self)
end

function initArgs(self, args)
    self.heroId = args and args.heroId or nil
end

function active(self, args)
    super.active(self)
    self:initArgs(args)

    self:refreshView()
end

function deActive(self)
    super.deActive(self)
    self:initArgs()

    self:recoverItem()
end

function recoverItem(self)
    for k, item in pairs(self.mItemList) do
        local mToggleActive = item:getChildGO("mToggleActive"):GetComponent(ty.Toggle)
        mToggleActive.onValueChanged:RemoveAllListeners()
        item:poolRecover()
        self.mItemList[k] = nil
    end
    self.mItemList = {}
end

function refreshView(self)
    self:recoverItem()
    local heroVo = hero.HeroManager:getHeroVo(self.heroId)
    for i, toggleData in ipairs(toggleDataDefine) do
        local item = SimpleInsItem:create(self.mItem, self.mGroup, "mItem")
        item:getChildGO("mTxtAttr"):GetComponent(ty.Text).text = _TT(toggleData.lanId)
        local mToggleActive = item:getChildGO("mToggleActive"):GetComponent(ty.Toggle)
        local isOn = true
        if table.indexof(heroVo.egg_attr_cal, toggleData.attrId) then
            isOn = false
        end
        mToggleActive.isOn = isOn
        mToggleActive.onValueChanged:AddListener(function()
            self:onToggleActiveAttrChange(i)
        end)

        self.mItemList[i] = item
    end
end

function onToggleActiveAttrChange(self, toggleIdx)
    local item = self.mItemList[toggleIdx]
    local mToggleActive = item:getChildGO("mToggleActive"):GetComponent(ty.Toggle)
    local isOn = mToggleActive.isOn
    local yesCb = function()
        local heroVo = hero.HeroManager:getHeroVo(self.heroId)
        local toggleData = toggleDataDefine[toggleIdx]
        if isOn then
            local idx = table.indexof(heroVo.egg_attr_cal, toggleData.attrId)
            table.remove(heroVo.egg_attr_cal, idx)
        else
            table.insert(heroVo.egg_attr_cal, toggleData.attrId)
        end
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_EGG_CAL_SWITCH, {
            hero_id = self.heroId,
            close_attr_list = heroVo.egg_attr_cal
        })
    end
    local noCb = function()
        self:refreshView()
    end
    if not isOn then
        UIFactory:alertMessge(_TT(149943), nil, yesCb, nil, nil, nil, noCb)
    else
        yesCb()
    end
end

return _M
