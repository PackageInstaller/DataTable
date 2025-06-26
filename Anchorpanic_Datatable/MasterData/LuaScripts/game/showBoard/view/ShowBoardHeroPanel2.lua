--[[ 
-----------------------------------------------------
@filename       : ShowBoardHeroPanel2
@Description    : 切换看板娘
@date           : 2021-12-08 19:51:16
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('showBoard.ShowBoardHeroPanel2', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("showBoard/ShowBoardHeroPanel2.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0 --是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    self.m_isDescending = true
    self.m_selectSortType = showBoard.panelSortType.COLOR
    self.m_selectFilterDic = {}
    for type in pairs(showBoard.panelFilterTypeDic) do
        self.m_selectFilterDic[type] = {}
        self.m_selectFilterDic[type][showBoard.filterSubTypeAll] = true
    end
end

-- 初始化
function configUI(self)
    self.mImgBgRect = self:getChildTrans("mImgBg")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mLyScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(showBoard.ShowBoardHeroItem2)
    -- 模型交互热区
    self.mModeHitBox = self:getChildGO("mModeHitBox")

    self.mBtnSelect = self:getChildGO("mBtnSelect")
    self.mBtnReturn = self:getChildGO("mBtnReturn")
end

--激活
function active(self)
    super.active(self)
    showBoard.ShowBoardManager:addEventListener(showBoard.ShowBoardManager.SHOW_HERO_SELECT, self.onSelectHeroHandler, self)
    showBoard.ShowBoardManager:addEventListener(showBoard.ShowBoardManager.SHOW_HERO_LIST_UPDATE, self.updateView, self)
    self.curSelectHeroId = role.RoleManager:getRoleVo():getShowBoardHeroId()
    self.saveHeroId = self.curSelectHeroId
    self:updateView()
    GameDispatcher:dispatchEvent(EventName.REQ_CAN_SHOW_BOARD_HERO)
    local w, h = ScreenUtil:getRealSize()
    self.moveModelX = gs.CameraMgr:ScreenToWorldBySCCamera(gs.Vector3((w - self.mImgBgRect.rect.size.x) * 0.5, h * 0.5, 0)).x * 0.4
    GameDispatcher:dispatchEvent(EventName.MOVE_SHOWBOARD_MODEL, { moveX = self.moveModelX, time = 0.3 ,open = true})
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    showBoard.ShowBoardManager:removeEventListener(showBoard.ShowBoardManager.SHOW_HERO_SELECT, self.onSelectHeroHandler, self)
    showBoard.ShowBoardManager:removeEventListener(showBoard.ShowBoardManager.SHOW_HERO_LIST_UPDATE, self.updateView, self)
    GameDispatcher:dispatchEvent(EventName.MOVE_SHOWBOARD_MODEL, { moveX = -self.moveModelX, time = 0.3 ,open = false})

    self.list = nil

    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:setBtnLabel(self.mBtnSelect, 1, "确定")
    self.mTxtTitle.text = _TT(1278)--战员选择
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnSelect, self.onClickSelect)
    self:addUIEvent(self.mBtnReturn, self.onClickClose)
    self:addUIEvent(self.mModeHitBox, self.onClickModelHandler)
end

--打开窗口
function open(self, args)
    if self.isPop == 1 then
        return
    end
    self.isPop = 1

    -- 取消了注册进UI管理器里

    if self.panelType ~= 1 and self.isBlur == 1 and self:getUiNodeName() then
        gs.UIBlurManager.SetSuperBlur(true, self.UIRootNode, self:getUiNodeName(), self.blurTweenTime)
    end

    if self.UIObject then
        self:addOnParent(args)
    end
    GameDispatcher:dispatchEvent(EventName.EVENT_UI_OPEN, self)
    if (self.panelType and self.panelType ~= 1) then
        AudioManager:playSoundEffect(self:getOpenSoundPath())
    end
end

function setMoneyBar(self)
end

function onClickClose(self)
    super.onClickClose(self)
    role.RoleManager:getRoleVo():setShowBoardHeroId(self.saveHeroId) --恢复未保存的
end

function onClickSelect(self)
    if (self.curSelectHeroId ~= self.saveHeroId) then
        GameDispatcher:dispatchEvent(EventName.REQ_CHANGE_SHOW_BOARD_HERO, { heroId = self.curSelectHeroId })
    end
    self:close()
end
-- 英雄选择变化
function onSelectHeroHandler(self, args)
    if self.curSelectHeroId == args.id then return end
    self.curSelectHeroId = args.id
    role.RoleManager:getRoleVo():setShowBoardHeroId(self.curSelectHeroId) --替换成临时选中的，修改主场景模型展示，关闭则恢复
end

function onClickModelHandler(self)
    GameDispatcher:dispatchEvent(EventName.PLAY_MAIN_MODEL_ACT)
end

function updateView(self)
    if not self.list or table.empty(self.list) then
        self.list = showBoard.ShowBoardManager:getShowBoardHeroList2(self.m_selectSortType, self.m_selectFilterDic, self.m_isDescending)
    end
    if self.mLyScroller.Count <= 0 then
        self.mLyScroller.DataProvider = self.list
    else
        self.mLyScroller:ReplaceAllDataProvider(self.list)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]