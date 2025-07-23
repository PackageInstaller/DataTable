--[[ 
-----------------------------------------------------
@filename       : MazeMercenaryInfoPanel
@Description    : 迷宫·雇佣兵详情
@date           : 2021年5月11日 15:59:35
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('maze.MazeMercenaryInfoPanel', Class.impl(maze.MazeEventInfoPanel))

UIRes = UrlManager:getUIPrefabPath("maze/MazeMercenaryInfoPanel.prefab")

panelType = 2 -- 窗口类型 1 全屏 2 弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mSelectGoDic = {}
    self.mShowItemList = {}
    self.mMonsterHeadList = {}

    self.mSelectTidConfigVo = nil
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
    self:__removeItem()
    self.mSelectTidConfigVo = nil
end

function __updateView(self)
    super.__updateView(self)

    local idList = self.mEventVo:getEffecctList()    
    for i = 1, #idList do
        local monsterTidVo = monster.MonsterManager:getMonsterVo(idList[i])
        -- local monsterConfigVo = monster.MonsterManager:getMonsterVo01(monsterTidVo.tid)
        local item = SimpleInsItem:create(self:getChildGO("ItemMonster"), self:getChildTrans("ContentMonster"), "MazeMercenaryInfoPanelItemMonster")
        local monsterHead = MonsterHeadGrid:poolGet()
        monsterHead:setData(monsterTidVo)
        monsterHead:setParent(item:getChildTrans("HeadNode"))
        monsterHead:setName("")
        -- monsterHead:setClickEnable(false)
        monsterHead:setCallBack(self, self.__onClickHeadHandler)
        self.mSelectGoDic[idList[i]] = item:getChildGO("GroupSelect")
        table.insert(self.mMonsterHeadList, monsterHead)
        table.insert(self.mShowItemList, item)
    end

    self:__updateSelectState()
end

function __updateSelectState(self)
    for uniqueTid, go in pairs(self.mSelectGoDic) do
        if(self.mSelectTidConfigVo and uniqueTid == self.mSelectTidConfigVo.uniqueTid)then
            go:SetActive(true)
        else
            go:SetActive(false)
        end
    end
end

function __onClickHeadHandler(self, monsterTidConfigVo)
    if(self.mSelectTidConfigVo and monsterTidConfigVo.uniqueTid == monsterTidConfigVo.uniqueTid)then
        self.mSelectTidConfigVo = nil
    else
        self.mSelectTidConfigVo = monsterTidConfigVo
    end
    self:__updateSelectState()
end

function __onClickUnableHandler(self)
    super.__onClickUnableHandler(self)
end

function __onClickAbleHandler(self)
    if(self.mSelectTidConfigVo)then
        if(self.mCallFun)then
            self.mCallFun({self.mSelectTidConfigVo.uniqueTid})
        end
        self:close()
    else
        gs.Message.Show("请选择雇佣兵")
    end
end

function __removeItem(self)
    self.mSelectGoDic = {}

    if (self.mMonsterHeadList) then
        for i = #self.mMonsterHeadList, 1, -1 do
            local item = self.mMonsterHeadList[i]
            item:poolRecover()
        end
    end
    self.mMonsterHeadList = {}

    if (self.mShowItemList) then
        for i = #self.mShowItemList, 1, -1 do
            local item = self.mShowItemList[i]
            item:poolRecover()
        end
    end
    self.mShowItemList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
