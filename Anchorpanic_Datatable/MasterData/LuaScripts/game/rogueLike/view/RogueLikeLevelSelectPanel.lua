--[[ 
-----------------------------------------------------
@filename       : RogueLikeLevelSelectPanel
@Description    : 肉鸽等级选择界面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("rogueLike.RogueLikeLevelSelectPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikeLevelSelectPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(331))
    self:setBg("infinityCity_bg_5.jpg", false, "infiniteCity")
end

-- 析构
function dtor(self)
end

function initData(self)
    self.propsItems = {}
    self.lockItems = {}
    self.levelItems = {}
    --动画播放序列数
    self.mShowIndex = 0
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mLevelSelectTitle = self:getChildGO("mLevelSelectTitle"):GetComponent(ty.Text)
    self.mLevelSelectScroll = self:getChildGO("mLevelSelectScroll"):GetComponent(ty.ScrollRect)
    self.mRogueLikeLevelItem = self:getChildGO("mRogueLikeLevelItem")
    self.mLockItem = self:getChildGO("mLockItem")
end

-- 激活
function active(self)
    super.active(self)
    self:updateView()
    self.mShowIndex = 0
    self:DoTweenEffect()
end

function updateView(self)
    self:clearLockItem()
    self:clearPropsItem()
    self:clearLevelItem()
    local roleVo = role.RoleManager:getRoleVo()
    local difDic = rogueLike.RogueLikeManager:getDifficultyDic()
    local difficultInfo = rogueLike.RogueLikeManager:getDifficultInfo()
    for id, data in pairs(difDic) do
        local item = SimpleInsItem:create(self.mRogueLikeLevelItem, self.mLevelSelectScroll.content, "RogueLikeLevelSelectPanelmRogueLikeLevelItem")
        item:getChildGO("mTxtName"):GetComponent(ty.Text).text = _TT(data.name)
        item:getChildGO("mTxtLevel"):GetComponent(ty.Text).text = _TT(4530, id)
        item:getChildGO("mTxtAward"):GetComponent(ty.Text).text = _TT(49005)

        local isPass = false
        if difficultInfo == nil or table.indexof01(difficultInfo, id) < 1 then
            isPass = false
        else
            isPass = true
        end

        item:getChildGO("mPassImg"):SetActive(isPass)

        local content = item:getChildGO("mPropsScroll"):GetComponent(ty.ScrollRect).content
        local list = AwardPackManager:getAwardListById(data.award)
        for i, vo in ipairs(list) do
            local propsGrid = PropsGrid:create(content, { vo.tid, vo.num })
            table.insert(self.propsItems, propsGrid)
        end

        item:getChildGO("mTxtLock"):GetComponent(ty.Text).text = _TT(27166)

        local isLock = false
        local lock1 = false
        local lock2 = false
        for i = 1, 2 do
            local lockItem = SimpleInsItem:create(self.mLockItem, item:getChildTrans("mLockContent"), "RogueLikeLevelSelectPanelmLockItem")
            if i == 1 then
                lockItem:getChildGO("mLockDes"):GetComponent(ty.Text).text = _TT(27164, data.roleLevel)
                local color
                if roleVo:getPlayerLvl() >= data.roleLevel then
                    lock1 = true
                    color = "03950dff"
                else
                    color = "82898cff"
                end
                lockItem:getChildGO("mLockImg"):GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor(color)
                lockItem:getChildGO("mLockDes"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor(color)
            else
                lockItem:getChildGO("mLockDes"):GetComponent(ty.Text).text = _TT(27165)
                local color
                if id == 1 then
                    lock2 = true
                    color = "03950dff"
                else
                    if difficultInfo == nil or table.indexof01(difficultInfo, id - 1) < 1 then
                        lock2 = false
                        color = "82898cff"
                    else
                        lock2 = true
                        color = "03950dff"
                    end
                end
                lockItem:getChildGO("mLockImg"):GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor(color)
                lockItem:getChildGO("mLockDes"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor(color)
            end
            table.insert(self.lockItems, lockItem)
        end
        isLock = lock1 == true and lock2 == true
        item:getChildGO("mIsLock"):SetActive(not isLock)
        item:getChildGO("mTxtAward").gameObject:SetActive(isLock)

        item:addUIEvent("mBtnClick", self.levelItemsClick, nil, { id = id, isLock = isLock })
        table.insert(self.levelItems, item)
    end
end

function levelItemsClick(self, args)
    if not args.isLock then
        gs.Message.Show("需要完成前置条件")
    else
        local dupId = args.id
        formation.openFormation(formation.TYPE.ROGUELIKE, nil, { id = args.id, isFirst = true })
    end
end
--动效缓动
function DoTweenEffect(self)
    for i = 1, #self.levelItems do
        self.levelItems[i]:getGo():SetActive(false)
    end
    self.mAnimatorDoTween = LoopManager:addFrame(2, #self.levelItems, self, function()
        self.mShowIndex = self.mShowIndex + 1
        if (self.mShowIndex > #self.levelItems) then
            LoopManager:removeFrameByIndex(self.mAnimatorDoTween)
            return
        end
        self.levelItems[self.mShowIndex]:getGo():SetActive(true)
        self.levelItems[self.mShowIndex]:getGo():GetComponent(ty.UIDoTween):BeginTween()
    end)
end

function clearLockItem(self)
    for i = 1, #self.lockItems do
        self.lockItems[i]:poolRecover()
        self.lockItems[i] = nil
    end
    self.lockItems = {}
end

function clearPropsItem(self)
    for i = 1, #self.propsItems do
        self.propsItems[i]:poolRecover()
    end
    self.propsItems = {}
end

function clearLevelItem(self)
    for i = 1, #self.levelItems do
        self.levelItems[i]:poolRecover()
    end
    self.levelItems = {}
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

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(49005):	"首通奖励"
]]