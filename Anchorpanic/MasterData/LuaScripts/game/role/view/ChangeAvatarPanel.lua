-- 头像、头像框界面
module("role.ChangeAvatarPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("role/ChangeAvatarPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2
isScreensave = 0 --是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)
isAdapta = 0--是否开启适配刘海 0 否 1 是
--构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(25209))
    self:setSize(1120, 520)
    self:setUICode(LinkCode.HomePage)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    --当前现在界面 0：头像界面，1：头像框界面
    self.mCurPage = decorate.TabType.HEAD
    --头像框和头像列表
    self.mHeadList = {}
    --当前选中的id
    self.mCurSelectId = 0
    --当前数据List
    self.mCurShowList = {}
    --"新"字典
    self.mNewDic = {}
end

function configUI(self)
    super.configUI(self)
    self.mBtnFrame = self:getChildGO("mBtnFrame")
    self.mBtnAvatar = self:getChildGO("mBtnAvatar")
    self.mImgUsingTip = self:getChildGO("mImgUsingTip")
    self.mBtnDetermine = self:getChildGO("mBtnDetermine")
    self.mHeadContent = self:getChildTrans("mHeadContent")
    self.mBtnFrameNomal = self:getChildGO("mBtnFrameNomal")
    self.mBtnFrameSelect = self:getChildGO("mBtnFrameSelect")
    self.mBtnAvatarNomal = self:getChildGO("mBtnAvatarNomal")
    self.mBtnmAvatarSelect = self:getChildGO("mBtnmAvatarSelect")
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtInfo = self:getChildGO("mTxtInfo"):GetComponent(ty.Text)
    self.mHeadIcon = self:getChildGO("mHeadIcon"):GetComponent(ty.AutoRefImage)
    self.mImgFrame = self:getChildGO("mImgFrame"):GetComponent(ty.AutoRefImage)
    self.mAvatarGroup = self:getChildGO("mAvatarGroup"):GetComponent(ty.ScrollRect)
    self.mGroupHead = self:getChildTrans("mGroupHead")
    self.mTxtTime = self:getChildTrans("mTxtTime"):GetComponent(ty.Text)
end

function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList()
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_AVATAR, self.updateView, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_AVATAR_FRAME, self.updateView, self)
    decorate.DecorateManager:addEventListener(decorate.DecorateManager.UPDATE_NEW_BUBBLE, self.updateBubble, self)
    self:updateBubble()
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_AVATAR, self.updateView, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_AVATAR_FRAME, self.updateView, self)
    decorate.DecorateManager:removeEventListener(decorate.DecorateManager.UPDATE_NEW_BUBBLE, self.updateBubble, self)
    decorate.DecorateManager:setFrameSelectIndex(0)
    decorate.DecorateManager:setSelectIndex(0)
    self:clearHeadList()
    RedPointManager:remove(self.mBtnAvatar.transform)
    RedPointManager:remove(self.mBtnFrame.transform)

    if self.mPlayerHeadGrid then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
end

function initViewText(self)
    self:setBtnLabel(self.mBtnDetermine, 1, "确认")
    self:setBtnLabel(self.mBtnAvatarNomal, 28146, "头像")
    self:setBtnLabel(self.mBtnFrameNomal, 28147, "头像框")
    self:setBtnLabel(self.mBtnFrameSelect, 28147, "头像框")
    self:setBtnLabel(self.mBtnmAvatarSelect, 28146, "头像")
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnAvatar, self.onClickHeadHandelr)
    self:addUIEvent(self.mBtnFrame, self.onClickHeadFrameHandelr)
    self:addUIEvent(self.mBtnDetermine, self.onClickDetermineHandelr)
end

-- 确认选中信息
function onClickDetermineHandelr(self)
    local moduleType = self.mCurPage == decorate.TabType.HEAD_FRAME and decorate.ModuleType.HEAD_FRAME or decorate.ModuleType.HEAD
    GameDispatcher:dispatchEvent(EventName.REQ_SET_DECORATE, { moduleType = moduleType, id = self.mCurSelectId })
    self:setUsingIdByType(self.mCurSelectId)
end
--头像回调
function onClickHeadHandelr(self)
    self.mCurPage = decorate.TabType.HEAD
    self:updateView()
    self.mAvatarGroup.verticalNormalizedPosition = 1
end
--头像框回调
function onClickHeadFrameHandelr(self)
    self.mCurPage = decorate.TabType.HEAD_FRAME
    self:updateView()
    self.mAvatarGroup.verticalNormalizedPosition = 1
end

-- 更新页面
function updateView(self, args)
    self:clearHeadList()
    self:updateBtnState(self.mCurPage)
    self.mBtnFrame:SetActive(funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HOME_HEAD_FRAME, false) == true)
    self.mBtnAvatar:SetActive(funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HOME_HEAD, false) == true)
    self.mCurShowList = decorate.DecorateManager:getPlayerHeadConfigList()
    if self.mCurPage == decorate.TabType.HEAD_FRAME then
        self.mCurShowList = decorate.DecorateManager:getPlayerHeadFrameConfigList()
    end
    local index = 1
    for i, vo in ipairs(self.mCurShowList) do
        local isActive = decorate.DecorateManager:getIsActive(self.mCurPage, vo:getRefID())
        if isActive then
            local playerHeadGrid = PlayerHeadGrid:create(self.mHeadContent, vo:getRefID(), 1, false)
            playerHeadGrid:setHeadFrame(vo:getRefID())
            playerHeadGrid:setIsShowFrame(self.mCurPage == decorate.TabType.HEAD_FRAME)
            local roleVo = role.RoleManager:getPersonalInfoList()
            local isSelect = self:getIndexByType() <= 0 and decorate.DecorateManager:getIsUsing(self.mCurPage, vo:getRefID()) or i == self:getIndexByType()
            local isNew = decorate.DecorateManager:getIsNew(self.mCurPage, vo:getRefID())
            if not self.mNewDic[vo:getRefID()] then
                self.mNewDic[vo:getRefID()] = vo
                self.mNewDic[vo:getRefID()].isNew = isNew
            end
            local isNewNum = self.mNewDic[vo:getRefID()].isNew == true and 0 or 1
            playerHeadGrid:setIsNew(self.mNewDic[vo:getRefID()].isNew)
            playerHeadGrid:setIsSelect(isSelect)
            playerHeadGrid:setScale(1)
            local function onClickSelectHandelr(self)
                if self.mNewDic[vo:getRefID()].isNew then
                    self.mNewDic[vo:getRefID()].isNew = false
                    GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = decorate.getReadTypeByModuleType(self.mCurPage), id = vo:getRefID() })
                end
                for _, headGrid in ipairs(self.mHeadList) do
                    headGrid:setIsSelect(headGrid:getData() == vo:getRefID())
                end
                playerHeadGrid:setIsNew(false)
                self:setIndexByType(i)
                self:updateInfoView(vo)
            end
            playerHeadGrid:setCallBack(self, onClickSelectHandelr)
            local isUsing = decorate.DecorateManager:getIsUsing(self.mCurPage, vo:getRefID())
            -- playerHeadGrid:setIsLock(isActive)
            playerHeadGrid:setIsUsing(isUsing == true, _TT(25194))
            playerHeadGrid:setActievBg(true)
            if index == 1 then
                index = isUsing == true and i or 1
            end
            table.insert(self.mHeadList, playerHeadGrid)
        end
    end
    local showIndex = self:getIndexByType() <= 0 and index or self:getIndexByType()
    self:updateInfoView(self.mCurShowList[showIndex])
end
-- 更新界面
function updateInfoView(self, vo)
    self.mCurSelectId = vo:getRefID()
    local isUsing = decorate.DecorateManager:getIsUsing(self.mCurPage, vo:getRefID())
    local isActive = decorate.DecorateManager:getIsActive(self.mCurPage, vo:getRefID())
    self.mBtnDetermine:SetActive((isUsing == false and isActive == true))
    self.mImgUsingTip:SetActive((isUsing == true and isActive == true))

    if not self.mPlayerHeadGrid then
        self.mPlayerHeadGrid = PlayerHeadGrid:poolGet()
    end

    local roleVo = role.RoleManager:getPersonalInfoList()
    if self.mCurPage == decorate.TabType.HEAD_FRAME then
        self.mPlayerHeadGrid:setData(roleVo:getAvatarId())
        self.mPlayerHeadGrid:setHeadFrame(vo:getRefID())
        self.mPlayerHeadGrid:showHeadFrameAnim()
    else
        self.mPlayerHeadGrid:setData(vo:getRefID())
        self.mPlayerHeadGrid:setHeadFrame(roleVo:getAvatarFrameId())
    end
    self.mPlayerHeadGrid:setParent(self.mGroupHead)

    self.mTxtName.text = _TT(vo:getResName())
    self.mTxtInfo.text = _TT(vo:getGetDescription())

    local decorateVo = decorate.DecorateManager:getDecorateVo(self.mCurPage, vo:getRefID())
    if (decorateVo.expiredTime <= 0) then
        self.mTxtTime.text = ""
    else
        local time = decorateVo.expiredTime - GameManager:getClientTime()
        self.mTxtTime.text = _TT(25199, TimeUtil.getFormatTimeBySeconds_2(time))
    end
end

-- 更新按钮状态
function updateBtnState(self, curShowType)
    self.mBtnmAvatarSelect:SetActive(curShowType == decorate.TabType.HEAD)
    self.mBtnFrameSelect:SetActive(curShowType ~= decorate.TabType.HEAD)
end

-- 根据当前页面不同类型设置Index
function setIndexByType(self, index)
    if self.mCurPage == decorate.TabType.HEAD_FRAME then
        decorate.DecorateManager:setFrameSelectIndex(index)
    else
        decorate.DecorateManager:setSelectIndex(index)
    end
end
-- 根据当前页面不同类型设置使用中id
function setUsingIdByType(self, id)
    if self.mCurPage == decorate.TabType.HEAD_FRAME then
        decorate.DecorateManager:setFrameUsingId(id)
    else
        decorate.DecorateManager:setUsingId(id)
    end
end
-- 根据当前页面不同类型获取Index
function getIndexByType(self)
    if self.mCurPage == decorate.TabType.HEAD_FRAME then
        return decorate.DecorateManager:getFrameSelectIndex()
    else
        return decorate.DecorateManager:getSelectIndex()
    end
end

function clearHeadList(self)
    if self.mHeadList then
        for i = 1, #self.mHeadList do
            self.mHeadList[i]:setIsUsing(false, _TT(25194))
            self.mHeadList[i]:poolRecover()
            self.mHeadList[i] = nil
        end
        self.mHeadList = {}
    end
end

function updateBubble(self)
    for i = 0, 1 do
        if decorate.DecorateManager:isModuleTypeBubble(i) then
            if i == decorate.TabType.HEAD then
                RedPointManager:add(self.mBtnAvatar.transform, nil, 69.5, 28)
            else
                RedPointManager:add(self.mBtnFrame.transform, nil, 69.5, 28)
            end
        else
            if i == decorate.TabType.HEAD then
                RedPointManager:remove(self.mBtnAvatar.transform)
            else
                RedPointManager:remove(self.mBtnFrame.transform)
            end
        end
    end

end

-- 玩家点击关闭
function onClickClose(self)
    self:playerClose()
    super.onClickClose(self)
end
-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    self:playerClose()
    super.onCloseAllCall(self)
end

function playerClose(self)
    self:initData()
end


return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(25209):	"<size=24>个</size>性头像"
]]