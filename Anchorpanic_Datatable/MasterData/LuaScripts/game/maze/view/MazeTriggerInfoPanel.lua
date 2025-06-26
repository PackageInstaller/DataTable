--[[ 
-----------------------------------------------------
@filename       : MazeTriggerInfoPanel
@Description    : 迷宫·触发型信息面板
@date           : 2021年5月11日 15:59:35
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('maze.MazeTriggerInfoPanel', Class.impl(maze.MazeEventInfoPanel))

UIRes = UrlManager:getUIPrefabPath("maze/MazeEventInfoPanel.prefab")

panelType = 2 -- 窗口类型 1 全屏 2 弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
end

--初始化UI
function configUI(self)
    super.configUI(self)
end

function initViewText(self)
    super.initViewText(self)
end

function addAllUIEvent(self)
    super.addAllUIEvent(self)
end

--激活
function active(self, args)
    super.active(self, args)
end

--非激活
function deActive(self)
    super.deActive(self)
end

function __updateView(self)
    super.__updateView(self)
    
    local playerVo = maze.MazeSceneManager:getPlayerThingVo(self.mMazeId)
    local eventConfigVo = maze.MazeSceneManager:getEventConfigVo(self.mEventVo:getEventId())
    local tileConfigVo = maze.MazeSceneManager:getTileConfigVoById(self.mMazeId, self.mEventVo:getTileId())
    local pathList = playerVo:getPathList(tileConfigVo:getRow(), tileConfigVo:getCol(), eventConfigVo:triggerRange())
    if(pathList and #pathList > 0)then
        local isCanTrigger = maze.MazeSceneManager:isEventCanTrigger(self.mEventVo:getEventId())
        if(isCanTrigger)then
            self.mBtnUnable:SetActive(false)
            self.mBtnAble:SetActive(true)
        else
            self.mBtnUnable:SetActive(false)
            self.mBtnAble:SetActive(false)
        end
    else
        self.mBtnUnable:SetActive(true)
        self.mBtnAble:SetActive(false)
    end

    self:setTxtTitle(eventConfigVo:getEventTitle())
    self.mTxtDes.text = eventConfigVo:getEventDes()
    self:setBtnLabel(self.mBtnAble, -1, eventConfigVo:getTextAbleBtn())
    self:setBtnLabel(self.mBtnUnable, -1, eventConfigVo:getTextUnAbleBtn())
    self.mBtnCancel:SetActive(eventConfigVo:getIsShowCancel())
end

function __onClickUnableHandler(self)
    super.__onClickUnableHandler(self)
end

function __onClickAbleHandler(self)
    local isCanTrigger = maze.MazeSceneManager:isEventCanTrigger(self.mEventVo:getEventId())
    if(isCanTrigger and self.mCallFun)then
        self.mCallFun()
    end
    self:close()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
