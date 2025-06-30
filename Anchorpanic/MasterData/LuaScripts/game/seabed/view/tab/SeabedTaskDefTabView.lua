module("seabed.SeabedTaskDefTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("seabed/tab/SeabedTaskTabView.prefab")

function getOpenType()
    return seabed.SeabedTaskType.Def
end

-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.mScrollerHeight = 0
end

function configUI(self)
    super.configUI(self)

    self.LyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.LyScroller:SetItemRender(seabed.SeabedTaskItem)

    self.mAutoReceive = self:getChildGO("mAutoReceive")
    self.mTxtAutoReceive = self:getChildGO("mTxtAutoReceive"):GetComponent(ty.Text)
    self.mBtnAll = self:getChildGO("mBtnAll")
end

function active(self, args)
    super.active(self, args)

    GameDispatcher:addEventListener(EventName.UPDATE_SEABED_TASK_PANEL,self.showPanel,self)
    self:showPanel()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SEABED_TASK_PANEL,self.showPanel,self)
    if self.LyScroller then
        self.LyScroller:CleanAllItem()
    end
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnAll, self.onBtnAllClickHandler)
end

function onBtnAllClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_SEABED_TASK_REWARD,self.canGetIds)
end
--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)

end

function showPanel(self)
    local taskType = self:getOpenType()
    local list = seabed.SeabedManager:getSeabedTaskDataByType(taskType)

    self.canGetIds = {}
    for i = 1, #list, 1 do
        
        list[i].msgVo = seabed.SeabedManager:getSeabedTaskMsgData(list[i].id)
        if list[i].msgVo.state == 0 then
            table.insert(self.canGetIds, list[i].id)
        end
    end


    table.sort(list, function(a, b)
        if a.msgVo.state == b.msgVo.state then
            return a.id < b.id
        else
            return a.msgVo.state < b.msgVo.state
        end
    end)

    for i = 1, #list do
        list[i].tweenId = 2 + (i - 1) * 4
    end
    
    if self.LyScroller.Count > 0 then
        self.LyScroller:ReplaceAllDataProvider(list)
    else
        self.LyScroller.DataProvider = list
    end
    
    self.mAutoReceive:SetActive(#self.canGetIds>0)
    self.mTxtAutoReceive.text = string.format("有%s个可领取的任务奖励",#self.canGetIds)

    
    if self.mScrollerHeight == 0 then
        self.mScrollerHeight = self.LyScroller:GetComponent(ty.RectTransform).sizeDelta.y
    end
    local height = self.mAutoReceive.activeSelf == true and (self.mScrollerHeight - self.mAutoReceive:GetComponent(ty.RectTransform).rect.height) or self.mScrollerHeight
    gs.TransQuick:SizeDelta02(self.LyScroller.gameObject.transform, height)
end

return _M