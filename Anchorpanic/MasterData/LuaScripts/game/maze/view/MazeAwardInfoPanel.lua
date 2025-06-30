--[[ 
-----------------------------------------------------
@filename       : MazeAwardInfoPanel
@Description    : 迷宫·奖励信息面板
@date           : 2021年5月11日 15:59:35
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('maze.MazeAwardInfoPanel', Class.impl(maze.MazeEventInfoPanel))

UIRes = UrlManager:getUIPrefabPath("maze/MazeAwardInfoPanel.prefab")

panelType = 2 -- 窗口类型 1 全屏 2 弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)

    self:setSize(828, 333)
    self:setTxtTitle(_TT(29543))
end

-- 初始化数据
function initData(self)
    super.initData(self)
end

--初始化UI
function configUI(self)
    super.configUI(self)
    self.mTransPorpsScroller = self:getChildTrans('PorpsScroller')
    self.mAwardContent = self:getChildTrans('AwardContent')
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
    self:setBtnLabel(self.mBtnAble, 40028, "领取奖励")
    self:__updateProps()
end

function __updateProps(self)
    self:__removeItem()
    local list = AwardPackManager:getAwardListById(self.mEventVo:getEffecctList()[1])

    local awardList = {}
    for _, v in ipairs(list) do
        local configVo = props.PropsManager:getPropsConfigVo(v.tid)
        if configVo.type == PropsType.EQUIP then
            -- 服务器发来的会自动合并tid一样的，前端先全部拆分
            local count = v.num
            v.count = 1
            for i = 1, count do
                local equipVo = LuaPoolMgr:poolGet(props.EquipVo)
                equipVo:setConfigData(configVo)
                table.insert(awardList, equipVo)
            end
        else
            local propsVo = LuaPoolMgr:poolGet(props.PropsVo)
            propsVo:setConfigData(configVo)
            propsVo.num = v.num
            table.insert(awardList, propsVo)
        end
    end
    table.sort(awardList, bag.BagManager.sortPropsListByDescending)

    gs.TransQuick:LPosX(self.mAwardContent, 0) 
    for i = 1, #list do
        local vo = list[i]
        local propsGrid = PropsGrid:create(self.mAwardContent, {vo.tid, vo.num}, 0.9)
        propsGrid:setIsShowName(true)
        table.insert(self.m_awardList, propsGrid)
    end
    if(#list <= 5)then
        gs.TransQuick:SizeDelta01(self.mTransPorpsScroller, (#list * 128) + (15 * (#list - 1)))
    end
end

function __removeItem(self)
    if(self.m_awardList)then
        for i = #self.m_awardList, 1, -1 do
            local item = self.m_awardList[i]
            item:poolRecover()
            table.remove(self.m_awardList, i)
        end
    end
    self.m_awardList = {}
end

function __onClickUnableHandler(self)
    super.__onClickUnableHandler(self)
end

function __onClickAbleHandler(self)
    if(self.mCallFun)then
        self.mCallFun()
    end
    self:close()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
