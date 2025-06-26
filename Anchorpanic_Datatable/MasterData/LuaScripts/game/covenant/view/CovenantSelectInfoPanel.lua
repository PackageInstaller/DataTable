--[[ 
-----------------------------------------------------
@filename       : CovenantSelectInfoPanel
@Description    : 盟约选择详细信息界面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("covenant.CovenantSelectInfoPanel", Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("covenant/CovenantSelectInfoPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构
function dtor(self)
end

function initData(self)
    --标签页字典
    self.mTabDic = {}
    self.mTabChildList = {}
    self.mObjsList = {}

    self.mProp = nil

    self.mPosYList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTitleTxt = self:getChildGO("TitleTxt"):GetComponent(ty.Text)
    self.mchangeBg = self:getChildGO("ChangeBg"):GetComponent(ty.AutoRefImage)

    self.mTabScroll = self:getChildGO("TabScrollRect"):GetComponent(ty.ScrollRect)
    self.mTabChildScroll = self:getChildGO("TabChildScrollRect"):GetComponent(ty.ScrollRect)

    self.mItemPool = self:getChildGO("ItemPool")
    self.mTabItem = self:getChildGO("TabItem")
    self.mTabChildItem = self:getChildGO("TabChildItem")
    self.mImageItem = self:getChildGO("ImageItem")
    self.mTextItem = self:getChildGO("TextItem")

    self.mPropItem = self:getChildGO("PropItem")
end

function show(self, args)
    self.cusId = args.id

    self.isShowInfo = args.showInfo

    --是否是首次
    self.isfirst = covenant.CovenantManager:getForcesId() == 0
    self.data = covenant.CovenantManager:getCovenantSelectData(self.cusId)
    self.mTitleTxt.text = "-" .. _TT(self.data.name) .. "-"

    self:__addTab()
    self:_addChildInfo()
end

--添加标签页
function __addTab(self)
    for id, da in pairs(self.data.contractDes) do
        --如果只是显示页面的话 将不显示id为3的内容
        if self.isShowInfo == true and id == 3 then
        else
            local go = gs.GameObject.Instantiate(self.mTabItem, self.mTabScroll.content.transform, false)
            go.transform:Find("TabName"):GetComponent(ty.Text).text = _TT(da.title)
            self.mTabDic[id] = {obj = go, para = da}
        end
    end
end

--添加子标签页内容
function _addChildInfo(self)
    for id, data in pairs(self.mTabDic) do
        local type = data.para.type

        --标签栏
        local tabChildObj = gs.GameObject.Instantiate(self.mTabChildItem, self.mTabChildScroll.content.transform, false)
        tabChildObj.transform:Find("Text"):GetComponent(ty.Text).text = _TT(data.para.title)
        table.insert(self.mTabChildList, tabChildObj)

        if type == 1 then --- 纯文本  (标签+文本)
            local textObj = gs.GameObject.Instantiate(self.mTextItem, self.mTabChildScroll.content.transform, false)
            textObj.transform:Find("Info"):GetComponent(ty.Text).text = _TT(data.para.des)
            table.insert(self.mObjsList, textObj)
        elseif type == 2 then --- 图片加文本  (标签+图片+文本)
            local textObj = gs.GameObject.Instantiate(self.mTextItem, self.mTabChildScroll.content.transform, false)
            textObj.transform:Find("Info"):GetComponent(ty.Text).text = _TT(data.para.des)
            table.insert(self.mObjsList, textObj)

            local imageItem = gs.GameObject.Instantiate(self.mImageItem, self.mTabChildScroll.content.transform, false)
            imageItem:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(data.para.icon))
            table.insert(self.mObjsList, imageItem)
        elseif type == 3 then --- 契约签订  (标签+契约页面)
            local propItem = gs.GameObject.Instantiate(self.mPropItem, self.mTabChildScroll.content.transform, false)
            if self.isfirst then
                propItem.transform:Find("PropTxt"):GetComponent(ty.Text).text = _TT(41018)
            else
                propItem.transform:Find("PropTxt"):GetComponent(ty.Text).text = _TT(41031)
            end
             --

            local tran = propItem.transform:Find("PropContent").transform
            local btn = propItem.transform:Find("JoinBtn").gameObject
            local joinTxt = btn.transform:Find("JoinTxt"):GetComponent(ty.Text)
            joinTxt.text = _TT(41019)
            self:addUIEvent(btn, self.__onJointBtnClick)

            self:__clearProp()

            local propData = {}
            propData[1] = self.data.keepsake
            propData[2] = self.data.keepsake_num
            self.propsGrid = PropsGrid:create(tran, propData, 0.8)

            local propNameTxt = propItem.transform:Find("PropNameTxt"):GetComponent(ty.Text)
            propNameTxt.text = self.propsGrid:getData().name

            if (self.isfirst) then
                propNameTxt.gameObject:SetActive(false)
                tran.gameObject:SetActive(false)
            end

            table.insert(self.mObjsList, propItem)
        end

        self:addUIEvent(self.mTabDic[id].obj, self.__tabClick, nil, id)
    end

    --scrollview 值变动监听
    local function scValueChanged(value)
        self:__updateCusIndex()
    end
    self.mTabChildScroll.onValueChanged:AddListener(scValueChanged)

    self:__updateSize()
    self.cusIndex = 1

    --self:__addTabChildPosY()
    LoopManager:addFrame(5, 1, self, self.__addTabChildPosY)
end

--content size fitter自身缓帧BUG
function __updateSize(self)
    gs.GoUtil.UpdateSize(self.mTabChildScroll.content.gameObject)
end

--添加localposY坐标 有BUG 占时放在延时帧中处理
function __addTabChildPosY(self)
    table.insert(self.mPosYList, 0)

    --第一个标签默认存0 从第二个标签开始算  20的标签向上偏移量
    for i = 2, #self.mTabChildList do
        local y = math.abs(self.mTabChildList[i]:GetComponent(ty.RectTransform).localPosition.y + 20)
        table.insert(self.mPosYList, y)
    end

    table.insert(self.mPosYList, 999999)

    self:__tabClick(1)
end

--标签栏被点击
function __tabClick(self, id)
    self.mTabChildScroll:StopMovement()
    self.mTabChildScroll.content.localPosition =
        gs.Vector3(
        self.mTabChildScroll.content.localPosition.x,
        self.mPosYList[id],
        self.mTabChildScroll.content.localPosition.z
    )
end

--更新标签索引
function __updateCusIndex(self)
    local y = self.mTabChildScroll.content.localPosition.y
    y = gs.Mathf.Clamp(y, 0, 999999)

    for i = 1, #self.mPosYList - 1 do
        if self.mPosYList[i] <= y and y <= self.mPosYList[i + 1] then
            self.cusIndex = i
        end
    end

    self:__setTab()
end

--设置标签状态
function __setTab(self)
    for id, data in pairs(self.mTabDic) do
        if id == self.cusIndex then
            self.mTabDic[id].obj:GetComponent(ty.AutoRefImage):SetImg(
                UrlManager:getPackPath("covenant/covenant_tab_select_2.png", false)
            )
            self.mTabDic[id].obj.transform:Find("TabName"):GetComponent(ty.Text).text =
                HtmlUtil:color(_TT(data.para.title), ColorUtil.PURE_BLACK_NUM)
        else
            self.mTabDic[id].obj:GetComponent(ty.AutoRefImage):SetImg(
                UrlManager:getPackPath("covenant/covenant_tab_select_1.png", false)
            )
            self.mTabDic[id].obj.transform:Find("TabName"):GetComponent(ty.Text).text =
                HtmlUtil:color(_TT(data.para.title), ColorUtil.PURE_WHITE_NUM)
        end
    end
end

--激活
function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.REQ_JOIN_RESULT, self.onResJoinResHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_CHANGE_RESULT, self.onResChangeResHandler, self)

    self:show(args)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.REQ_JOIN_RESULT, self.onResJoinResHandler, self)
    GameDispatcher:removeEventListener(EventName.REQ_CHANGE_RESULT, self.onResChangeResHandler, self)
    self:__clearProp()
    self:__clearObj()

    self.mTabChildScroll.onValueChanged:RemoveAllListeners()
end

function __clearObj(self)
    for id, data in pairs(self.mTabDic) do
        gs.GameObject.Destroy(self.mTabDic[id].obj)
    end
    self.mTabDic = {}

    for i = 1, #self.mTabChildList do
        gs.GameObject.Destroy(self.mTabChildList[i])
    end
    self.mTabChildList = {}

    for i = 1, #self.mObjsList do
        gs.GameObject.Destroy(self.mObjsList[i])
    end
    self.mObjsList = {}
end

function __clearProp(self)
    if self.propsGrid == nil then
    else
        self.propsGrid:poolRecover()
    end
end

function __onJointBtnClick(self)
    local propsTid = self.data.keepsake
    local propsNum = self.data.keepsake_num
    local num = bag.BagManager:getPropsCountByTid(propsTid)

    if self.isfirst then
        GameDispatcher:dispatchEvent(EventName.OPEN_COVENANT_SELECT_SURE_PANEL, {id = self.cusId})
    else
        --持有道具数量不足
        if (num < propsNum) then
            gs.Message.Show(_TT(41020))
        else
            GameDispatcher:dispatchEvent(EventName.OPEN_COVENANT_SELECT_SURE_PANEL, {id = self.cusId})
        end
    end
end

--加入盟约返回结果
function onResJoinResHandler(self, msg)
    if msg == 1 then
        self:onClickClose()
    end
end

--变更盟约返回结果
function onResChangeResHandler(self, msg)
    if msg == 1 then
        self:onClickClose()
    end
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
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
