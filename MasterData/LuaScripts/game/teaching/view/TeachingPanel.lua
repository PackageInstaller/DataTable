--[[ 
-----------------------------------------------------
@filename       : TeachingPanel
@Description    : 上阵教学面板
@date           : 2021-08-30 17:53:00
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.teaching.view.TeachingPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("teaching/TeachingPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setBg("formation_bg_01.jpg", true, "formation")
    self:setTxtTitle(_TT(4546))
    self:setUICode(LinkCode.BranchTactivs)
end
--析构  
function dtor(self)
end

function initData(self)
    self.mLeftItemDic = {}
    self.mRightItemDic = {}
    self.mHeroItemList = {}
end
-- 设置货币栏
function setMoneyBar(self)
end

-- 初始化
function configUI(self)
    self.mTxtLeftFormation = self:getChildGO("mTxtLeftFormation"):GetComponent(ty.Text)
    self.mGroupLeftFormation = self:getChildTrans("mGroupLeftFormation")

    self.mTxtRightFormation = self:getChildGO("mTxtRightFormation"):GetComponent(ty.Text)
    self.mGroupRightFormation = self:getChildTrans("mGroupRightFormation")

    self.mTxtMsg = self:getChildGO("mTxtMsg"):GetComponent(ty.Text)
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mBtnTips = self:getChildGO("mBtnTips")

    self.mGroupHero = self:getChildTrans("mGroupHero")

    self:setGuideTrans("funcTips_teaching_1", self:getChildTrans("mFunctionTips_teaching_1"))
    self:setGuideTrans("funcTips_teaching_2", self:getChildTrans("mFunctionTips_teaching_2"))
    self:setGuideTrans("funcTips_teaching_3", self:getChildTrans("mFunctionTips_teaching_3"))
    self:setGuideTrans("funcTips_teaching_4", self:getChildTrans("mFunctionTips_teaching_4"))
    self:setGuideTrans("guide_TeachingTips", self:getChildTrans("mTipsGuide"))
    self:setGuideTrans("guide_TeachingTipsBtn", self:getChildTrans("mBtnTips"))
    self:setGuideTrans("guide_TeachingGroupGuide", self:getChildTrans("mGroupHeroGuide"))

    self:initFormationTile()
end

--激活
function active(self, args)
    super.active(self, args)
    self.battleType = args.battleType
    self.dupId = args.dupId
    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    teaching.TeachingManager:clearSelectHeroList()
    self.mSelectItem = nil
    self:recoverItemList()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:setBtnLabel(self.mBtnFight, 46501, "挑战")
    self.mTxtLeftFormation.text = _TT(47701)--"我方阵容"
    self.mTxtRightFormation.text = _TT(47702)--"训练对手"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnFight, self.onFight)
    self:addUIEvent(self.mBtnTips, self.onOpenTipsView)
    self:addUIEvent(self:getChildGO("mBtnFuncTips"), self.onClickFuncTipsHandler)
end

function onOpenTipsView(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_TEACHING_TIPS_VIEW, { resList = self.mBaseData.tipsRes, title = self.mBaseData.pointTitle, des = self.mBaseData.pointDes })
end

function onFight(self)
    local formationConfigVo = formation.FormationManager:getFormationConfigVo(self.mBaseData:getHeroFormationId())
    if not formationConfigVo then
        logError("=========找异哥，找不到阵形ID：" .. self.mBaseData:getHeroFormationId())
        return
    end
    local formationConfigList = formationConfigVo:getFormationList()
    local list = teaching.TeachingManager:getSelectHeroList()
    if #list < #formationConfigList then
        -- gs.Message.Show("还有位置没放置战员")
        gs.Message.Show(_TT(47703))
        return
    end
    GameDispatcher:dispatchEvent(EventName.REQ_TEACHING_FORMATION_FIGHT, { battleType = self.battleType, dupId = self.dupId, formationId = self.mBaseData:getHeroFormationId() })
    -- self:close()
end

--打开规则说明界面
function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.BranchTactivs })
end

function updateView(self)
    self.mBaseData = teaching.TeachingManager:getBaseData(self.dupId)
    self.mTxtMsg.text = self.mBaseData:getTeachingDes()

    self:setLeftFormation()
    self:setRightFormation()
    self:setHeroList()
end

function initFormationTile(self)
    local index = 1
    for c = 1, 4 do
        for r = 1, 3 do
            local item = teaching.TeachingFormationItem:poolGet()
            item:setParentTrans(self.mGroupLeftFormation)
            if not self.mLeftItemDic[c] then
                self.mLeftItemDic[c] = {}
            end
            self.mLeftItemDic[c][r] = item
            item:setLocalPos(index)

            local item = teaching.TeachingFormationItem:poolGet()
            item:setParentTrans(self.mGroupRightFormation)
            if not self.mRightItemDic[c] then
                self.mRightItemDic[c] = {}
            end
            self.mRightItemDic[c][r] = item
            item:setLocalPos(index)

            index = index + 1
        end
    end
end

function setLeftFormation(self)
    local formationConfigVo = formation.FormationManager:getFormationConfigVo(self.mBaseData:getHeroFormationId())
    local formationConfigList = formationConfigVo:getFormationList()
    for c = 1, 4 do
        for r = 1, 3 do
            local item = self.mLeftItemDic[c][r]
            local isban = self.mBaseData:getHeroFormationTileIsBan(c, r)
            item:setHero(nil)
            if isban then
                item:setLock(true)
            else
                item:setEmpty(true)
            end
        end
    end

    for i = 1, #formationConfigList do
        local pos = formationConfigList[i][1]
        local col = formationConfigList[i][2][1]
        local row = formationConfigList[i][2][2]
        local item = self.mLeftItemDic[col][row]
        item:setLock(false)

        item:addEventListener(item.EVENT_SELECT, self.onItemSelect, self)
        item:setFormationPos(pos)
        local monsterId = self.mBaseData:getFixedHeroTidByPos(pos)
        if monsterId then
            item:setFixedHero(monsterId)
            teaching.TeachingManager:setSelectHeroList(monsterId, pos)
        else
            if not self.mSelectItem then
                self.mSelectItem = item
                self.mSelectItem:setSelect(true)
            end
        end
    end
end

function setRightFormation(self)
    local formationConfigVo = formation.FormationManager:getMonFormationConfigVo(self.mBaseData:getMonFormationId())
    local formationConfigList = formationConfigVo:getFormationList()

    for c = 1, 4 do
        for r = 1, 3 do
            local item = self.mRightItemDic[c][r]
            item:setEmpty(true)
        end
    end

    for i = 1, #formationConfigList do
        local pos = formationConfigList[i][1]
        local col = formationConfigList[i][2][1]
        local row = formationConfigList[i][2][2]
        local item = self.mRightItemDic[col][row]
        item:setLock(false)
        local monsterId = self.mBaseData:getMonsterIdByPos(pos)
        if monsterId then
            item:setMonster(monsterId)
        end
    end
end

function recoverItemList(self)
    for c = 1, 4 do
        for r = 1, 3 do
            local item = self.mLeftItemDic[c][r]
            item:removeEventListener(item.EVENT_SELECT, self.onItemSelect, self)
            item:poolRecover()
            local item = self.mRightItemDic[c][r]
            item:poolRecover()
        end
    end
    self.mLeftItemDic = {}
    self.mRightItemDic = {}
end

function onItemSelect(self, args)
    local item = args.item
    if self.mSelectItem then
        self.mSelectItem:setSelect(false)
    end
    self.mSelectItem = item
    self.mSelectItem:setSelect(true)

    self:updateHeroList()
end

function setHeroList(self)
    self:recoverHeroItem()
    local list = self.mBaseData:getHeroList()
    for i, id in ipairs(list) do
        local item = teaching.TeachingHeadItem:poolGet()
        item:setData(self.mGroupHero, id, self.mBaseData:getHeroDesByPos(i))
        item:addEventListener(item.EVENT_SELECT, self.onHeroSelect, self)
        table.insert(self.mHeroItemList, item)
    end
end

function onHeroSelect(self, args)
    if self.mSelectItem then
        teaching.TeachingManager:setSelectHeroList(args.item.monsterId, self.mSelectItem.formationPos)
        if args.item.monsterId == self.mSelectItem.monsterId then
            self.mSelectItem:setHero(nil)
            args.item:setSelectPos(nil, nil)
        else
            local formationConfigVo = formation.FormationManager:getFormationConfigVo(self.mBaseData:getHeroFormationId())
            local formationConfigList = formationConfigVo:getFormationList()
            if args.item.isAlready then 
                for i = 1, #formationConfigList do
                    local pos = formationConfigList[i][1]
                    local col = formationConfigList[i][2][1]
                    local row = formationConfigList[i][2][2]
                    local item = self.mLeftItemDic[col][row]
                    if item.monsterId == args.item.monsterId then 
                        teaching.TeachingManager:setSelectHeroList(self.mSelectItem.monsterId, item.formationPos)
                        item:setHero(self.mSelectItem.monsterId)
                        break
                    end
                end
            end
            self.mSelectItem:setHero(args.item.monsterId)

            for i = 1, #formationConfigList do
                local pos = formationConfigList[i][1]
                local col = formationConfigList[i][2][1]
                local row = formationConfigList[i][2][2]
                local item = self.mLeftItemDic[col][row]
                if not teaching.TeachingManager:getHeroIdByFormationPos(pos) then 
                    item:onClick()
                    break
                end
            end
        end
    end

    self:updateHeroList()
end

function updateHeroList(self)
    for i, item in pairs(self.mHeroItemList) do
        local chooseHero = {}
        local formationConfigVo = formation.FormationManager:getFormationConfigVo(self.mBaseData:getHeroFormationId())
        local formationConfigList = formationConfigVo:getFormationList()
        for i = 1, #formationConfigList do
            local pos = formationConfigList[i][1]
            local col = formationConfigList[i][2][1]
            local row = formationConfigList[i][2][2]
            local leftItem = self.mLeftItemDic[col][row]
            table.insert(chooseHero, leftItem.monsterId)
        end
        item:setAlready(table.indexof(chooseHero, item.monsterId))
    end
end
-- 回收项
function recoverHeroItem(self)
    if self.mHeroItemList then
        for i, v in pairs(self.mHeroItemList) do
            v:poolRecover()
        end
    end
    self.mHeroItemList = {}
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]