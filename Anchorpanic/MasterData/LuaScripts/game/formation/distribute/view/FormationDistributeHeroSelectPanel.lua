--[[ 
-----------------------------------------------------
@filename       : FormationDistributeHeroSelectPanel
@Description    : 剧情分配战员面板
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("formation.FormationDistributeHeroSelectPanel", Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("formation/FormationDistributeHeroSelectPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setInnerOffset(0, 0, 0, 0)
    self:setTxtTitle("")
    self:setContentBg("")
end

--析构
function dtor(self)
end

function initData(self)
    self.m_fightHeroPool = {}
    self.m_otherHeroPool = {}
    self.m_selectHeroPool = {}

    self.m_typeFightHero = 1
    self.m_typeOtherHero = 2
    self.m_typeSelectHero = 3

    -- 队伍可选数量上限
    self.m_count = 3
end

-- 初始化
function configUI(self)
    self.m_textTitleFightHero = self:getChildTrans("TextTitleFightHero"):GetComponent(ty.Text)
    self.m_textTitleOtherHero = self:getChildTrans("TextTitleOtherHero"):GetComponent(ty.Text)
    self.m_textTitleSelectHero = self:getChildTrans("TextTitleSelectHero"):GetComponent(ty.Text)

    self.m_contentFightHero = self:getChildTrans("ContentFightHero")
    self.m_contentOtherHero = self:getChildTrans("ContentOtherHero")
    self.m_contentSelectHero = self:getChildTrans("ContentSelectHero")

    self.m_btnConfirm = self:getChildGO("BtnConfirm")
    self.m_scrollItem = self:getChildGO("Scrollitem")
    
    self.m_nodeMenuFightHero = self:getChildTrans("NodeMenuFightHero")
    self.m_nodeMenuOtherHero = self:getChildTrans("NodeMenuOtherHero")
    self.m_nodeMenuSelectHero = self:getChildTrans("NodeMenuSelectHero")
    self.m_groupMenu = self:getChildGO("GroupMenu")
    self.m_btn_1 = self:getChildGO("Btn_1")
    self.m_btn_2 = self:getChildGO("Btn_2")
end

function initViewText(self)
    self.m_textTitleFightHero.text = self:getTitle(self.m_typeFightHero)
    self.m_textTitleOtherHero.text = self:getTitle(self.m_typeOtherHero)
    self.m_textTitleSelectHero.text = self:getTitle(self.m_typeSelectHero)
    self:setBtnLabel(self.m_btnConfirm, -1, "确定分配")
end

function addAllUIEvent(self)
    self:addOnClick(self.m_btnConfirm, self.__onClickConfirmHandler)
end

--激活
function active(self, args)
    super.active(self, args)
    self:__setData(args)
    self.manager:addEventListener(self.manager.RES_SET_SUPPORT_HERO, self.onUpdateSelectResultHandler, self)
    self:__updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self.manager:removeEventListener(self.manager.RES_SET_SUPPORT_HERO, self.onUpdateSelectResultHandler, self)
end

-- 玩家点击关闭
function onClickClose(self)
    self:__playerClose()
    super.onClickClose(self)
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    self:__playerClose()
    super.onCloseAllCall(self)
end

function __playerClose(self)
    self:__recoverPool()
end

function onUpdateSelectResultHandler(self)
    self:close()
end

function getTitle(self, type)
    if(type == self.m_typeFightHero)then
        return _TT(1245)
    elseif(type == self.m_typeOtherHero)then
        return _TT(1246)
    elseif(type == self.m_typeSelectHero)then
        return _TT(1247)
    end
end

function __onClickConfirmHandler(self)
    if(#self.m_selectHeroPool > 0)then
        gs.Message.Show(_TT(1248))
    else
        local formationId_1 = self.distributeTeam_1[1]
        local selectList_1 = {}
        local tip = _TT(1249)
        for i = 1, #self.m_fightHeroPool do
            local itemData = self.m_fightHeroPool[i]
            local monsterConfigVo = monster.MonsterManager:getMonsterVo01(itemData.data.tid)
            tip = tip .. monsterConfigVo.name
            if(i ~= #self.m_fightHeroPool)then
                tip = tip .. "，"
            end
            if(itemData.data.uniqueTid ~= self.distributeTeam_1[2])then
                table.insert(selectList_1, itemData.data.uniqueTid)
            end
        end

        local formationId_2 = self.distributeTeam_2[1]
        local selectList_2 = {}
        for i = 1, #self.m_otherHeroPool do
            local itemData = self.m_otherHeroPool[i]
            if(itemData.data.uniqueTid ~= self.distributeTeam_2[2])then
                table.insert(selectList_2, 1, itemData.data.uniqueTid)
            end
        end

        UIFactory:alertMessge(tip, true, 
        function() 
            self.manager:dispatchEvent(self.manager.REQ_SET_SUPPORT_HERO, {battleType = self.storyRo:getBattleType(), dupId = self.storyRo:getBattleFieldId(), formationId_1 = formationId_1, selectList_1 = selectList_1, formationId_2 = formationId_2, selectList_2 = selectList_2})
        end, _TT(1), nil,
        true, 
        function() 
        end, _TT(2),
        _TT(5), nil, nil)
    end
end

function __onClickScrollItemHandler(self, data)
    if(data.itemData.data.uniqueTid == self.distributeTeam_1[2] or data.itemData.data.uniqueTid == self.distributeTeam_2[2])then
        gs.Message.Show(_TT(1250))
    else
        local menuType_1 = nil
        local menuType_2 = nil
        if(data.itemData.type == self.m_typeFightHero)then
            self.m_groupMenu:SetActive(not self.m_groupMenu.activeSelf)
            self.m_groupMenu.transform:SetParent(self.m_nodeMenuFightHero, false)
            menuType_1 = self.m_typeOtherHero
            menuType_2 = self.m_typeSelectHero
        elseif(data.itemData.type == self.m_typeOtherHero)then
            self.m_groupMenu:SetActive(not self.m_groupMenu.activeSelf)
            self.m_groupMenu.transform:SetParent(self.m_nodeMenuOtherHero, false)
            menuType_1 = self.m_typeFightHero
            menuType_2 = self.m_typeSelectHero
        elseif(data.itemData.type == self.m_typeSelectHero)then
            self.m_groupMenu:SetActive(not self.m_groupMenu.activeSelf)
            self.m_groupMenu.transform:SetParent(self.m_nodeMenuSelectHero, false)
            menuType_1 = self.m_typeFightHero
            menuType_2 = self.m_typeOtherHero
        end
    
        self:setBtnLabel(self.m_btn_1, -1, self:getTitle(menuType_1))
        self:setBtnLabel(self.m_btn_2, -1, self:getTitle(menuType_2))
        local onClickMenu_1 = function()
            self:removeOnClick(self.m_btn_1)
            self.m_groupMenu:SetActive(false)
            self:__onClickMenuItemHandler(data.itemData, menuType_1)
        end
        local onClickMenu_2 = function()
            self:removeOnClick(self.m_btn_2)
            self.m_groupMenu:SetActive(false)
            self:__onClickMenuItemHandler(data.itemData, menuType_2)
        end
        self:addOnClick(self.m_btn_1, onClickMenu_1)
        self:addOnClick(self.m_btn_2, onClickMenu_2)
    end
end

function __onClickMenuItemHandler(self, itemData, menuType)
    if(menuType == self.m_typeFightHero and #self.m_fightHeroPool >= self.m_count or menuType == self.m_typeOtherHero and #self.m_otherHeroPool >= self.m_count)then
        gs.Message.Show(_TT(1241, self.m_count))
        return
    end
    if(menuType == self.m_typeFightHero)then
        itemData.go.transform:SetParent(self.m_contentFightHero, false)
    elseif(menuType == self.m_typeOtherHero)then
        itemData.go.transform:SetParent(self.m_contentOtherHero, false)
    elseif(menuType == self.m_typeSelectHero)then
        itemData.go.transform:SetParent(self.m_contentSelectHero, false)
    end
    self:updateActivePoolData(itemData, menuType)
end

-- 设置数据
function __setData(self, args)
    self.storyRo = args.storyRo
    self.manager = args.manager
    local storyEffectParam = storyTalk.StoryTalkManager:getStoryParamByEffectType(self.storyRo:getBattleType(), self.storyRo:getBattleFieldId(), 8)
    -- 第一队数据
    self.distributeTeam_1 = storyEffectParam[1]
    -- 第二队数据
    self.distributeTeam_2 = storyEffectParam[2]
    -- 可分配的怪物id列表
    self.distributeIdList = storyEffectParam[3]
end

function __updateView(self)
    if(#self.m_fightHeroPool <= 0 and #self.m_otherHeroPool <= 0 and #self.m_selectHeroPool <= 0)then
        self.m_groupMenu:SetActive(false)
    
        local itemData = nil
    
        local monsterTidVo = monster.MonsterManager:getMonsterVo(self.distributeTeam_1[2])
        local monsterConfigVo = monster.MonsterManager:getMonsterVo01(monsterTidVo.tid)
        itemData = self:__getPool(self.m_typeFightHero, monsterTidVo)
        itemData.go.transform:SetParent(self.m_contentFightHero, false)
        itemData.imgLockGo:SetActive(true)
        itemData.textName.text = monsterConfigVo.name
    
        local monsterTidVo = monster.MonsterManager:getMonsterVo(self.distributeTeam_2[2])
        local monsterConfigVo = monster.MonsterManager:getMonsterVo01(monsterTidVo.tid)
        itemData = self:__getPool(self.m_typeOtherHero, monsterTidVo)
        itemData.go.transform:SetParent(self.m_contentOtherHero, false)
        itemData.imgLockGo:SetActive(true)
        itemData.textName.text = monsterConfigVo.name
    
        local idList = self.distributeIdList
        for i = 1, #idList do
            local monsterTidVo = monster.MonsterManager:getMonsterVo(idList[i])
            local monsterConfigVo = monster.MonsterManager:getMonsterVo01(monsterTidVo.tid)
            itemData = self:__getPool(self.m_typeSelectHero, monsterTidVo)
            itemData.go.transform:SetParent(self.m_contentSelectHero, false)
            itemData.imgLockGo:SetActive(false)
            itemData.textName.text = monsterConfigVo.name
        end
    end
end

function __recoverPool(self)
    if (self.m_deactivePool) then
        for i = #self.m_fightHeroPool, 1, -1 do
            local itemData = self.m_fightHeroPool[i]
            itemData.go:SetActive(false)
            self:removeOnClick(itemData.go)
            table.insert(self.m_deactivePool, itemData)
        end
        self.m_fightHeroPool = {}
    
        for i = #self.m_otherHeroPool, 1, -1 do
            local itemData = self.m_otherHeroPool[i]
            itemData.go:SetActive(false)
            self:removeOnClick(itemData.go)
            table.insert(self.m_deactivePool, itemData)
        end
        self.m_otherHeroPool = {}
    
        for i = #self.m_selectHeroPool, 1, -1 do
            local itemData = self.m_selectHeroPool[i]
            itemData.go:SetActive(false)
            self:removeOnClick(itemData.go)
            table.insert(self.m_deactivePool, itemData)
        end
        self.m_selectHeroPool = {}
    end
end

function __getPool(self, type, data)
    if (not self.m_deactivePool) then
        self.m_deactivePool = {}
    end
    local itemData = nil
    if (#self.m_deactivePool > 0) then
        itemData = self.m_deactivePool[1]
        table.remove(self.m_deactivePool, 1)
        itemData.type = type
        itemData.data = data
    else
        local go = gs.GameObject.Instantiate(self.m_scrollItem)
        local childGos, childTrans = GoUtil.GetChildHash(go)
        local textName = childGos['TextName']:GetComponent(ty.Text)
        local imgLockGo = childGos['ImgLock']
        itemData = {go = go, textName = textName, imgLockGo = imgLockGo, data = data, type = type}
    end
    itemData.go:SetActive(true)
    self:updateActivePoolData(itemData, type)
    return itemData
end

function updateActivePoolData(self, itemData, type)
    local pool = nil
    if(itemData.type == self.m_typeFightHero)then
        pool = self.m_fightHeroPool
    elseif(itemData.type == self.m_typeOtherHero)then
        pool = self.m_otherHeroPool
    elseif(itemData.type == self.m_typeSelectHero)then
        pool = self.m_selectHeroPool
    end
    for i = 1, #pool do
        if(pool[i].go == itemData.go)then
            table.remove(pool, i)
            break
        end
    end

    itemData.type = type
    if(type == self.m_typeFightHero)then
        table.insert(self.m_fightHeroPool, itemData)
    elseif(type == self.m_typeOtherHero)then
        table.insert(self.m_otherHeroPool, itemData)
    elseif(type == self.m_typeSelectHero)then
        table.insert(self.m_selectHeroPool, itemData)
    end

    self:removeOnClick(itemData.go)
    self:addOnClick(itemData.go, self.__onClickScrollItemHandler, nil, {itemData = itemData})
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1250):	"小队队长不可移动"
	语言包: _TT(1249):	"关闭阀门前，将固定阵容，是否以这样的阵容继续？\n您指挥的队员为："
	语言包: _TT(1248):	"有队员未分配"
	语言包: _TT(1247):	"待分配成员"
	语言包: _TT(1246):	"地面翼安全阀"
	语言包: _TT(1245):	"井下安全阀"
	语言包: _TT(5):	"提示"
	语言包: _TT(2):	"取消"
	语言包: _TT(1):	"确定"
]]
