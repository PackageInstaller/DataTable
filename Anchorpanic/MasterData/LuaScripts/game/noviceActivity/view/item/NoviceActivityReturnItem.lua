--[[ 
-----------------------------------------------------
@filename       : NoviceActivityReturnItem
@Description    : 新手活动招募 Item
@date           : 2023-06-27
@Author         : tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("noviceActivity.NoviceActivityReturnItem ", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.awardPropsList = {}
    self.mImPro = self:getChildGO("ImPro"):GetComponent(ty.Image)
    self.mTextName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTextPro = self:getChildGO("TextPro"):GetComponent(ty.Text)
    self:getChildGO("TextGet"):GetComponent(ty.Text).text = _TT(3)
    self:getChildGO("mTxtIng"):GetComponent(ty.Text).text = _TT(4)--前往
    self.Content = self:getChildTrans("Content")
    self:addOnClick(self:getChildGO("mBtnGet"), self.__onClickRecHandler)
    self:addOnClick(self:getChildGO("mGroupIng"), self.__onClickRecHandler)
end

function deActive(self)
    super.deActive(self)
    self:recoverGrid()
end

function onDelete(self)
    super.onDelete(self)

end

function setData(self, param)
    super.setData(self, param)
    if self.data then
        self.mTextName.text = _TT(self.data.des)
        local msgVo = noviceActivity.NoviceActivityManager:getReturnMsgVoById(self.data.id)
        -- local nowGetNum = msgVo.count > self.data.reachLv and self.data.reachLv or msgVo.count
        self.mTextPro.text = msgVo.count .. "/" .. self.data.reachLv
        self.mImPro.fillAmount = msgVo.count / self.data.reachLv

        local received = msgVo.state == 2
        self:getChildGO("GroupHasRec"):SetActive(received)

        self.canReceive = not received and msgVo.count >= self.data.reachLv
        self:getChildGO("mBtnGet"):SetActive(self.canReceive)

        self.canNotReceive = msgVo.count < self.data.reachLv and not received
        self:getChildGO("mGroupIng"):SetActive(self.canNotReceive)

        self:recoverGrid()
        for _, awardPropsVo in pairs(self.data.reward)
        do
            local grid = PropsGrid:createByData({ tid = awardPropsVo.tid, num = awardPropsVo.num, parent = self.Content, scale = 1, showUseInTip = true, isTween = false })
            grid:setCountTextSize(26)
            table.insert(self.awardPropsList, grid)
        end
    else

    end
end

function __onClickRecHandler(self)
    local taskId = self.data.id
    if self.canReceive then
        GameDispatcher:dispatchEvent(EventName.REQ_RECEIVE_RETURN, taskId)
    end
    if self.canNotReceive then
        local mHeroVo = hero.HeroManager:getHeroVoByTid(self.data.heroTid)
        if mHeroVo then
            hero.HeroManager:dispatchEvent(hero.HeroManager.HERO_LIST_SELECT, { heroVo = mHeroVo })
            GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DEVELOP_PANEL, { heroId = mHeroVo.id, tabType = hero.DevelopTabType.LVL_UP, subData = {} })

        else
            gs.Message.Show("请先获取战员")
            GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.HeroCulture })
        end
    end
end

function recoverGrid(self)
    if next(self.awardPropsList) then
        for i = 1, #self.awardPropsList do
            self.awardPropsList[i]:poolRecover()
        end
        self.awardPropsList = {}
    end
end

return _M