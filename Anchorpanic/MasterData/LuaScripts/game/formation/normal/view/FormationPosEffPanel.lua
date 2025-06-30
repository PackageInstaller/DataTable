module("formation.FormationPosEffPanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("formation/FormationPosEffPanel.prefab")
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

-- 构造函数
function ctor(self)
    super.ctor(self)
end

function getManager(self)
    return self.mManager
end

function setManager(self, cusManager)
    self.mManager = cusManager
end

-- 析构函数
function dtor(self)
    super.dtor(self)
end

function initData(self)
    self.mItemList = {}
end

-- 初始化UI
function configUI(self)
    super.configUI(self)

    self.mTipTxt = self:getChildGO("mTipTxt"):GetComponent(ty.Text)
    self.mConTxt = self:getChildGO("mConTxt"):GetComponent(ty.Text)

    self.mPosEffScroller = self:getChildGO("mPosEffScroller"):GetComponent(ty.ScrollRect)
    -- self.mPosEffScroller:SetItemRender(formation.FormationPosEffItem)
end

function initViewText(self)
    self.mTipTxt.text = _TT(3075)
    self.mConTxt.text = _TT(3076)
end

function active(self, args)
    super.active(self, args)

    self:setManager(args.manager)
    self.manager = args.data.manager
    self.posEffIds = args.data.posEffIds
    local hasSkill = {}
    local dataList = {}

    for i = 1,#self.posEffIds do
        local posEffId = self.posEffIds[i]
        local posEffVo = self.manager:getPosEffConfigData(posEffId)
        if posEffVo.posList[1] == 0 then
            table.insert(dataList, {
                id = posEffVo.posList[1],
                effSkillId = posEffVo.effectSkillList[1],
                icon = posEffVo.iconList[1],
                backGround = posEffVo.backGroundList[1]
            })
        else
            for i = 1, #posEffVo.posList do
                --过滤重复的技能id
                if table.indexof01(hasSkill,posEffVo.effectSkillList[i]) == 0 then
                    table.insert(dataList, {
                        id = posEffVo.posList[i],
                        effSkillId = posEffVo.effectSkillList[i],
                        icon = posEffVo.iconList[i],
                        backGround = posEffVo.backGroundList[i]
                    })
                    table.insert(hasSkill,posEffVo.effectSkillList[i])    
                end
            end
        end
    end

    self:clearItems()
    for i = 1, #dataList do
        local item = formation.FormationPosEffItem:poolGet()
        item:setData(self.mPosEffScroller.content, dataList[i])
        self:setGuideTrans("funcTips_guide_formationPos_" .. i, item:getAdaptaTrans())
        table.insert(self.mItemList, item)
    end

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mPosEffScroller.content) 
end

function clearItems(self)
    for i = 1, #self.mItemList do
        self.mItemList[i]:poolRecover()
    end
    self.mItemList = {}
end

function deActive(self)
    super.deActive(self)
    self:clearItems()
end

return _M
