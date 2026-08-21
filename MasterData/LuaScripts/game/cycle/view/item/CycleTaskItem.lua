module("cycle.CycleTaskItem", Class.impl(BaseReuseItem))
UIRes = UrlManager:getUIPrefabPath("cycle/item/CycleTaskItem.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end

function configUI(self)
    super.configUI(self)

    self.mImgTaskLv = self:getChildGO("mImgTaskLv"):GetComponent(ty.AutoRefImage)
    self.mTxtTaskName = self:getChildGO("mTxtTaskName"):GetComponent(ty.Text)
    self.mTxtTaskDes = self:getChildGO("mTxtTaskDes"):GetComponent(ty.Text)
    self.mTxtTaskExp = self:getChildGO("mTxtTaskExp"):GetComponent(ty.Text)
    self.mBtnRefresh = self:getChildGO("mBtnRefresh")

    self.mTimerBG = self:getChildGO("mTimerBG"):GetComponent(ty.RectTransform)
    self.mImgTimer = self:getChildGO("mImgTimer"):GetComponent(ty.RectTransform)
    self.mTxtTimer = self:getChildGO("mTxtTimer"):GetComponent(ty.Text)

    self.mTaskFinish = self:getChildGO("mTaskFinish")

    self.mAnimator = self.UIObject:GetComponent(ty.Animator)

    --self.mGroupItem = self:getChildGO("mGroupItem"):GetComponent(ty.CanvasGroup)
end

function active(self)
    super.active(self)
  
end

function deActive(self)
    super.deActive(self)

    if self.aniSn then
        self:clearTimeout(self.aniSn)
        self.aniSn = nil
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)

    self:addUIEvent(self.mBtnRefresh, self.onBtnRefreshClick)
end

function onBtnRefreshClick(self)
    local function onResTaskHandler()
        cycle.CycleManager:setLastIndex(self.mData.index,self.mData.id)
        GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_TASK_REFRESH, {
            taskId = self.mData.id
        })
    end

    UIFactory:alertMessge(_TT(27537), true, function()
        onResTaskHandler()
    end, _TT(1), nil, true, function()
    end, _TT(2), _TT(5), nil, RemindConst.CYCLE_TASK)
end

function showRef(self,cusData,index)
    self.mData = cusData

    self.mData.index = index
    self:updateView()
    self.mAnimator:SetTrigger("show")
end

function setData(self, cusParent, cusData)
    self:setParentTrans(cusParent)
    self.mParentTrans = cusParent
    self.mData = cusData

    if self.aniSn then
        self:clearTimeout(self.aniSn)
        self.aniSn = nil
    end
   
    self.UIObject:SetActive(false)

    self:updateView()

    if self.mData.index > 0 then
        self.aniSn = self:setTimeout(self.mData.index * 0.03, function()
            self.UIObject:SetActive(true)
            self.mAnimator:SetTrigger("enter")
        end)
    else
        self.UIObject:SetActive(true)
        self.mAnimator:SetTrigger("enter")
    end
end

function updateView(self)
   
    local taskVo = cycle.CycleManager:getCycleTaskData(self.mData.id)
    self.mImgTaskLv:SetImg(UrlManager:getIconPath("cycle/Infinitycity_title_0" .. taskVo.icon .. ".png"), false)
    self.mTxtTaskName.text = _TT(taskVo.title)
    self.mTxtTaskDes.text = _TT(taskVo.des)
    self.mTxtTaskExp.text = _TT(77843).."+" .. taskVo.exp

    gs.TransQuick:SizeDelta01(self.mImgTimer, self.mData.count / taskVo.times * (self.mTimerBG.sizeDelta.x))
    self.mTxtTimer.text = self.mData.count .. "/" .. taskVo.times

    self.mTaskFinish:SetActive(self.mData.count >= taskVo.times)
    self.mBtnRefresh:SetActive(self.mData.count < taskVo.times and cycle.CycleManager:getTaskRefreshTimes() > 0)

end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27537):	"消耗刷新次数刷新任务"
]]
