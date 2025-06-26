--[[ 
-----------------------------------------------------
@filename       : MazeEventInfoPanel
@Description    : 迷宫·事件信息面板
@date           : 2021年5月11日 15:59:35
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('maze.MazeEventInfoPanel', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("maze/MazeEventInfoPanel.prefab")

panelType = 2 -- 窗口类型 1 全屏 2 弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(713, 263)
    self.mIsNotice = false
end

-- 初始化数据
function initData(self)
    super.initData(self)
end

--初始化UI
function configUI(self)
    self.mTxtDes = self:getChildGO('mTxtDes'):GetComponent(ty.Text)
    self.mBtnUnable = self:getChildGO('mBtnUnable')
    self.mBtnAble = self:getChildGO('mBtnAble')
    self.mBtnCancel = self:getChildGO('mBtnCancel')
    self.mBtnNotice = self:getChildGO("mBtnNotice")
    self.mImgSelect = self:getChildGO("mImgSelect"):GetComponent(ty.AutoRefImage)
end

function initViewText(self)
    self:setBtnLabel(self.mBtnCancel, 2, "取消")
end

function addAllUIEvent(self)
    self:addOnClick(self.mBtnUnable, self.__onClickUnableHandler)
    self:addOnClick(self.mBtnAble, self.__onClickAbleHandler)
    self:addOnClick(self.mBtnCancel, self.close)
    self:addUIEvent(self.mBtnNotice, self.onClickNotRemindHandler)
end

--激活
function active(self, args)
    super.active(self, args)

    self.mMazeId = args.mazeId
    self.mEventVo = args.eventVo
    self.mCallFun = args.callFun
    self.noticeStr = args.noticeStr
    self:__updateView()
end

--非激活
function deActive(self)
    super.deActive(self)
    if self.mIsNotice then 
        gs.StorageUtil.SaveInt(self.noticeStr, GameManager:getClientTime())
    end
end

function __updateView(self)
    local playerVo = maze.MazeSceneManager:getPlayerThingVo(self.mMazeId)
    local eventConfigVo = maze.MazeSceneManager:getEventConfigVo(self.mEventVo:getEventId())
    local tileConfigVo = maze.MazeSceneManager:getTileConfigVoById(self.mMazeId, self.mEventVo:getTileId())
    local pathList = playerVo:getPathList(tileConfigVo:getRow(), tileConfigVo:getCol(), eventConfigVo:triggerRange())
    if(pathList and #pathList > 0)then
        self.mBtnUnable:SetActive(false)
        self.mBtnAble:SetActive(true)
    else
        self.mBtnUnable:SetActive(true)
        self.mBtnAble:SetActive(false)
    end

    self:setTxtTitle(eventConfigVo:getEventTitle())
    self.mTxtDes.text = eventConfigVo:getEventDes()
    self:setBtnLabel(self.mBtnAble, -1, eventConfigVo:getTextAbleBtn())
    self:setBtnLabel(self.mBtnUnable, -1, eventConfigVo:getTextUnAbleBtn())
    self.mBtnCancel:SetActive(eventConfigVo:getIsShowCancel())

    local isShowNotice = self.noticeStr ~= nil
    self.mBtnNotice:SetActive(isShowNotice)
    if isShowNotice then
        self.mImgSelect:SetImg(UrlManager:getCommon5Path("common_0018.png"), false)
    end
end

function __onClickUnableHandler(self)
    -- local eventConfigVo = maze.MazeSceneManager:getEventConfigVo(self.mEventVo:getEventId())
    gs.Message.Show2(_TT(46807))
end

function __onClickAbleHandler(self)
    if(self.mCallFun)then
        self.mCallFun()
    end
    self:close()
end

function onClickNotRemindHandler(self)
    self.mIsNotice = not self.mIsNotice
    if self.mIsNotice then
        self.mImgSelect:SetImg(UrlManager:getCommon5Path("common_0017.png"), false)
    else
        self.mImgSelect:SetImg(UrlManager:getCommon5Path("common_0018.png"), false)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
