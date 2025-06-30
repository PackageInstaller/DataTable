--[[ 
-----------------------------------------------------
@filename       : DupApostlesWarGoalPanel
@Description    : 使徒之战目标奖励
@date           : 2021-08-12 20:03:20
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_apostle_war.view.DupApostlesWarGoalPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupApostleWar/DupApostlesWarGoalPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("dup_apostles_war_bg_1.jpg", false, "dup")
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mScroller = self:getChildGO("mScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(dup.DupApostlesWarGoalItem)

    self.mBtnOneKey = self:getChildGO("mBtnOneKey")
end

--激活
function active(self)
    super.active(self)
    dup.DupApostlesWarManager:addEventListener(dup.DupApostlesWarManager.EVENT_DATA_UPDATE, self.updateView, self)
    dup.DupApostlesWarManager:addEventListener(dup.DupApostlesWarManager.EVENT_GOAL_UPDATE, self.updateView, self)

    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    dup.DupApostlesWarManager:removeEventListener(dup.DupApostlesWarManager.EVENT_DATA_UPDATE, self.updateView, self)
    dup.DupApostlesWarManager:removeEventListener(dup.DupApostlesWarManager.EVENT_GOAL_UPDATE, self.updateView, self)

end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnOneKey, self.onClickOneKey)
end

function onClickOneKey(self)
    GameDispatcher:dispatchEvent(EventName.REQ_GAIN_APOSTLES_WAR_REWARD, 0)
end

function updateView(self)
    self:updateInfo()
end

function updateInfo(self)
    local list = dup.DupApostlesWarManager:getGoalRewardList()
    if self.mScroller.Count <= 0 then
        self.mScroller.DataProvider = list
    else
        self.mScroller:ReplaceAllDataProvider(list)
    end

    if dup.DupApostlesWarManager.minPassTime > 0 then
        self.mTxtTime.text = TimeUtil.getMSByTime(dup.DupApostlesWarManager.minPassTime)
    else
        self.mTxtTime.text = "--"
    end

    self:updateShowOneKey()
end

function updateShowOneKey(self)
    local isFlag = dup.DupApostlesWarManager:checkFlag()
    if isFlag then
        self.mBtnOneKey:SetActive(true)
    else
        self.mBtnOneKey:SetActive(false)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
