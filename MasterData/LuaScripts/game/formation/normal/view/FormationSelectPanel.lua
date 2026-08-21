--[[ 
-----------------------------------------------------
@filename       : FormationSelectPanel
@Description    : 阵型-选择界面
@date           : 2021-05-12 17:00:26
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("formation.FormationSelectPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("formation/FormationSelectPanel.prefab")
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
-- destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 1 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(1286))
    self:setSize(1120, 520)
end

function getManager(self)
    return self.m_manager
end

function setManager(self, cusManager)
    self.m_manager = cusManager
end

-- 初始化数据
function initData(self)
end

-- 初始化
function configUI(self)
    self.mScrollerSelect = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mScrollerSelect:SetItemRender(self:getSelectItem())
end

function getSelectItem(self)
    return formation.FormationSelectItem
end

-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)
end

-- 激活
function active(self, args)
    super.active(self, args)
    self:setManager(args.manager)
    self:getManager():addEventListener(self:getManager().HERO_FORMATION_SEE, self.onFormationSelectHandler, self)

    self:setData(args.data, true)
end

-- 非激活
function deActive(self)
    super.deActive(self)
    self:getManager():removeEventListener(self:getManager().HERO_FORMATION_SEE, self.onFormationSelectHandler, self)
end

function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

function onFormationSelectHandler(self, args)
    self:close()
end

function setData(self, cusData, isInit)
    if cusData then
        self.m_teamId = cusData.teamId
        self.m_formationId = cusData.formationId
    end
    self:__updateView(isInit)
end

function getDataList(self)
    local formationConfigList = self:getManager():getFormationConfigList()
    local scrollDataList = {}
    for i = 1, #formationConfigList do
        if formationConfigList[i]:getIsShow() == 1 then
            local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
            scrollVo:setDataVo({ showTeamId = self.m_teamId, formationConfigVo = formationConfigList[i], manager = self:getManager() })
            if (self.m_formationId ~= formationConfigList[i]:getRefID()) then
                scrollVo:setSelect(false)
            else
                scrollVo:setSelect(true)
            end
            table.insert(scrollDataList, scrollVo)
        end
    end
    return scrollDataList
end

function __updateView(self, isInit)
    -- 此处poolRecover回收数据后，要确保接下来会执行DataProvider或ReplaceAllDataProvider，以彻底断开LyScroller数据列表和Lua对象池内的引用关系
    self:recoverListData(self.mScrollerSelect.DataProvider)
    local scrollList = self:getDataList()
    if isInit or self.mScrollerSelect.Count <= 0 then
        self.mScrollerSelect.DataProvider = scrollList
    else
        self.mScrollerSelect:ReplaceAllDataProvider(scrollList)
    end
end

function recoverListData(self, list)
    if (list and #list > 0) then
        for i, v in ipairs(list) do
            LuaPoolMgr:poolRecover(v)
        end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1286):	"<size=24>阵</size>型选择"
]]
