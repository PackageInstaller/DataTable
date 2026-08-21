
--[[ 
-----------------------------------------------------
@filename       : SeabedStoryAwardPanel
@Description    : 剧情目标界面                 
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("seabed.SeabedStoryAwardPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("seabed/SeabedStoryAwardPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 520)
    self:setTxtTitle(_TT(111030))
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
    self.m_scroller:SetItemRender(seabed.SeabedStoryAwardItem)
end

function active(self, args)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_SEABED_STORY_AWARD_PANEL,self.updateView,self)
    
    --hero.HeroLvlTargetManager:addEventListener(hero.HeroLvlTargetManager.UPDATE_LVL_TARGET_lIST, self.onHeroLvlTargetUpdateHandler, self)

    -- self.mHeroId = args.heroId
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    self:removeAllDelay()
    GameDispatcher:removeEventListener(EventName.UPDATE_SEABED_STORY_AWARD_PANEL,self.updateView,self)
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

    local storyData = seabed.SeabedManager:getSeabedSeabedShowroomData()
    local list = {}
    for k, v in pairs(storyData) do
        table.insert(list,v)
    end

    --可领取 未领取 已领取
    for i= 1,#list do
        local state = seabed.SeabedManager:getSeabedStoryAwardIsGet(list[i].id)
        if state == true then
            list[i].state = 3
        else
            local isUnLock = seabed.SeabedManager:getSeabedStoryListIsUnLock(list[i].storyId)
            if isUnLock == false then
                list[i].state = 2
            else
                list[i].state = 1
            end
        end
    end

    table.sort(list,function (vo1,vo2)
        if vo1.state == vo2.state then
            return vo1.id <vo2.id
        else
            return vo1.state < vo2.state
        end
       
    end)

    self.m_scroller.DataProvider = list
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