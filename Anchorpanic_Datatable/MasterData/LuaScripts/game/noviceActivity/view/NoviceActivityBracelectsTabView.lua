--[[ 
-----------------------------------------------------
@filename       : NoviceActivityLinkTabView
@Description    : 新手活动 链接次数页签
@date           : 2023-6-6 16:50:35
@Author         : tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("noviceActivity.NoviceActivityBracelectsTabView", Class.impl(TabSubView))
UIRes = UrlManager:getUIPrefabPath("noviceActivity/NoviceActivityBraceletsTabView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
end
-- 初始化
function configUI(self)
    super.configUI(self)
    self.mLyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(self:getItemRender())
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtTimer = self:getChildGO("mTxtTimer"):GetComponent(ty.Text)
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_RECEIVE_RECRUIT_BRACELETS, self.setScollerData, self)
    self:setScollerData()
    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_RECEIVE_RECRUIT_BRACELETS, self.setScollerData, self)
    MoneyManager:setMoneyTidList()
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtTitle.text = _TT(3530)  -- 剩余时间
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)

end

function getItemRender(self)
    return noviceActivity.NoviceActivityBraceltesItem
end

function setScollerData(self)
    if not self.list then
        self.list = table.copy(noviceActivity.NoviceActivityManager:getBraceletsConfig())
    end

    local msgList = noviceActivity.NoviceActivityManager.mActivityBraceletMsgDic

    if next(msgList) then
        local listHelper = {}
        for _, id in pairs(msgList) do
            local vo = noviceActivity.NoviceActivityManager:getBraceletsRecuitItemConfigById(id)
            table.insert(listHelper, vo)
            for idx, vo in pairs(self.list)
            do
                if vo.id == id then
                    table.remove(self.list, idx)
                    break
                end
            end
        end

        for _, vo in pairs(listHelper) do
            table.insert(self.list, vo)
        end
    end

    for i = 1, #self.list do
        self.list[i].tweenId = i * 3.5
    end


    if self.mLyScroller.Count < 1 then
        self.mLyScroller.DataProvider = self.list
    else
        self.mLyScroller:ReplaceAllDataProvider(self.list)
    end
end

function updateView(self)
    local lefTime = activity.ActivityManager.noviceActivityEndTime - GameManager:getClientTime()
    local updateTime = function()
        if lefTime > 0 then
            self.mTxtTimer.text = TimeUtil.getNewRoleShowTime(lefTime, true)
            lefTime = lefTime - 1
        end
    end
    updateTime()
    self:addTimer(1, 0, updateTime)
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]