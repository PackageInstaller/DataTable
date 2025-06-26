--[[
-----------------------------------------------------
   @CreateTime:2024/12/25 15:13:51
   @Author:zengweiwen
   @Copyright: (LY)2021 雷焰网络
   @Description:TODO
]]

module("game.dna.view.DnaCultivateChoiceView", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("dna/DnaCultivateChoiceView.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1   -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

function ctor(self)
    super.ctor(self)
end

function initData(self)
    self.mChoiceItemList = {}
    self.mCurSelect = nil
end

function configUI(self)
    self.mGroupChoice = self:getChildTrans("mGroupChoice")
    self.mBtnYes = self:getChildGO("mBtnYes")
    self.mTxtDesc = self:getChildGO("mTxtDesc"):GetComponent(ty.Text)
end

function initViewText(self)
    super.initViewText(self)
    self:getChildGO("mTxtDesc"):GetComponent(ty.Text).text = _TT(149907)
end

function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mBtnYes, self.onClickBtnYesHandler)
end

function initArgs(self, args)
    self.mCurHeroId = args and args.heroId or nil
end

function active(self, args)
    super.active(self)
    self:initArgs(args)
    GameDispatcher:addEventListener(EventName.DNA_CULTIVATE_CHOICE_VIEW_SELECT_ITEM, self.onDnaCultivateChoiceViewSelectItemHandler, self)

    self:refreshView()
end

function deActive(self)
    super.deActive(self)
    self:initArgs()
    GameDispatcher:removeEventListener(EventName.DNA_CULTIVATE_CHOICE_VIEW_SELECT_ITEM, self.onDnaCultivateChoiceViewSelectItemHandler, self)

    self:recoverChoiceItem()
end

function recoverChoiceItem(self)
    for k, dnaCultivateChoiceItem in pairs(self.mChoiceItemList) do
        dnaCultivateChoiceItem:poolRecover()
        self.mChoiceItemList[k] = nil
    end
    self.mChoiceItemList = {}
end

function refreshView(self)
    self:recoverChoiceItem()
    local list_eggDataCfgVo = dna.DnaManager:getSelectWearEggDataCfgVoListByHeroId(self.mCurHeroId)
    for i, eggDataCfgVo in ipairs(list_eggDataCfgVo) do
        local dnaCultivateChoiceItem = dna.DnaCultivateChoiceItem:create(self.mGroupChoice, eggDataCfgVo, 1, false)
        self.mChoiceItemList[i] = dnaCultivateChoiceItem
    end
end

function refreshItemSelect(self)
    for _, dnaCultivateChoiceItem in pairs(self.mChoiceItemList) do
        local eggDataCfgVo = dnaCultivateChoiceItem:getData()
        dnaCultivateChoiceItem:updateSelect(self.mCurSelect == eggDataCfgVo.quality)
    end
end

function onClickBtnYesHandler(self)
    if not self.mCurSelect then
        gs.Message.Show(_TT(149922))
        return 
    end

    local heroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    local tipslanguage
    if heroVo:checkDnaStatus(hero.eggType.none) then
        local heroEggDataCfgVo = dna.DnaManager:getSingleHeroEggDataConfigVo(heroVo.tid, true)
        tipslanguage = heroEggDataCfgVo == nil and 149941 or 149910
    else
        tipslanguage = 149934
    end

    local function __confirmCb()
        GameDispatcher:dispatchEvent(EventName.REQ_WEAR_DNA_EGG, {
            hero_id = self.mCurHeroId,
            egg_id = self.mCurSelect
            })
        self:close()
    end
    UIFactory:alertMessge(_TT(tipslanguage), nil, __confirmCb)
end

function onDnaCultivateChoiceViewSelectItemHandler(self, eggDataCfgVo)
    if eggDataCfgVo.quality == self.mCurSelect then
        return 
    end
    local item_id = eggDataCfgVo.item_id
    if not bag.BagManager:checkPropsCountIsEnough(item_id, 1) then
        return 
    end
    self.mCurSelect = eggDataCfgVo.quality
    self:refreshItemSelect()
end

return _M
