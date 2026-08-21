
--[[ 
-----------------------------------------------------
@filename       : SeabedCollectionAwardPanel
@Description    : 收藏目标界面                 
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("seabed.SeabedCollectionAwardPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("seabed/SeabedCollectionAwardPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 520)
    self:setTxtTitle(_TT(27611))
end

-- 初始化数据
function initData(self)
    self.mHeroId = nil

    self.mDelayRecover = nil 
    self.mDelayData = nil
    self.mDelayScroller = nil
end

function configUI(self)
    super.configUI(self)
    self.m_scroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.m_scroller:SetItemRender(seabed.SeabedCollectionAwardItem )
end

function active(self, args)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_SEABED_COLLECTION_AWARD_PANEL,self.updateView,self)
    self.type = args.type
    --hero.HeroLvlTargetManager:addEventListener(hero.HeroLvlTargetManager.UPDATE_LVL_TARGET_lIST, self.onHeroLvlTargetUpdateHandler, self)

    -- self.mHeroId = args.heroId
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    self:removeAllDelay()
    GameDispatcher:removeEventListener(EventName.UPDATE_SEABED_COLLECTION_AWARD_PANEL,self.updateView,self)
    --hero.HeroLvlTargetManager:removeEventListener(hero.HeroLvlTargetManager.UPDATE_LVL_TARGET_lIST, self.onHeroLvlTargetUpdateHandler, self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

function updateView(self)
    local scrollList = {}

    local rewardData = seabed.SeabedManager:getSeabedCollectionRewardData()
    local filterList = {}
    for i = 1, #rewardData, 1 do
        if rewardData[i].type == self.type then
            table.insert(filterList,rewardData[i])
        end
    end

    local hasNum = 0
    if self.type == seabed.SeabedBattleType.Collage then
        hasNum = seabed.SeabedManager:getHisCollNum()
    else
        hasNum = seabed.SeabedManager:getHisBuffNum()
    end
    --可领取 未领取 已领取
    for i= 1,#filterList do
        local state = seabed.SeabedManager:getCollageOrBuffIsHas(filterList[i].id)
        if state == true then
            filterList[i].state = 3
        else
            local isUnLock = filterList[i].num <= hasNum
            if isUnLock == false then
                filterList[i].state = 2
            else
                filterList[i].state = 1
            end
        end
        filterList[i].battleType = self.type
    end

    table.sort(filterList,function (vo1,vo2)
        if vo1.state == vo2.state then
            return vo1.id <vo2.id
        else
            return vo1.state < vo2.state
        end
       
    end)

    self.m_scroller.DataProvider = filterList
end

function recoverListData(self, list)
    if (list and #list > 0) then
        for i, v in ipairs(list) do
            LuaPoolMgr:poolRecover(v)
        end
    end
end

function removeAllDelay(self)
    if (self.mDelayRecover) then
        LoopManager:removeFrameByIndex(self.mDelayRecover)
        self.mDelayRecover = nil
    end
    if (self.mDelayData) then
        LoopManager:removeFrameByIndex(self.mDelayData)
        self.mDelayData = nil
    end
    if (self.mDelayScroller) then
        LoopManager:removeFrameByIndex(self.mDelayScroller)
        self.mDelayScroller = nil
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]