module("formation.FormationElementHomologyPanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("formation/FormationElementHomologyPanel.prefab")
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

-- 构造函数
function ctor(self)
    super.ctor(self)
    -- self:setTxtTitle(_TT(1286))
    -- self:setSize(1120, 520)
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

-- 初始化UI
function configUI(self)
    super.configUI(self)

    self.mTipTxt = self:getChildGO("mTipTxt"):GetComponent(ty.Text)
    self.mConTxt = self:getChildGO("mConTxt"):GetComponent(ty.Text)

    self.mElementScroller = self:getChildGO("mElementScroller"):GetComponent(ty.LyScroller)
    self.mElementScroller:SetItemRender(formation.FormationElementScrollerItem)

    self:setGuideTrans("funcTips_guide_formation_Element_guide", self.mElementScroller.transform)
end

function initViewText(self)
    self.mTipTxt.text = _TT(3069)
    self.mConTxt.text = _TT(3070)
end

function active(self, args)
    super.active(self, args)
    self:setManager(args.manager)
    self.mTeamId = args.data.teamId

    local heroList = self:getManager():getSelectFormationHeroList(self.mTeamId)
    local resonanceData = self.mManager:getElementResonanceData()

    self.mEleTypeList = {}
    for k, v in pairs(heroList) do
        local heroVo = hero.HeroManager:getHeroVo(v.heroId)
        if heroVo then
            if self.mEleTypeList[heroVo.eleType] == nil then
                self.mEleTypeList[heroVo.eleType] = 1
            else
                self.mEleTypeList[heroVo.eleType] = self.mEleTypeList[heroVo.eleType] + 1
            end
        end
    end

    local dataList = {}
    for k, v in pairs(resonanceData) do
        local needNum = v.data.num
        local hasNum = self.mEleTypeList[v.data.type]== nil and 0 or self.mEleTypeList[v.data.type]

        table.insert(dataList, {
            id = k,
            type = v.data.type,
            needNum = needNum,
            skillId = v.data.skill_id,
            hasNum = hasNum,
            isOk = hasNum >= needNum and 1 or 0
        })
    end

    local listOk = {}
    local listNotOk = {}
    for i = 1,#dataList do
        if dataList[i].isOk == 1 then
            table.insert(listOk,dataList[i])
        else
            table.insert(listNotOk,dataList[i])
        end
    end

    for i=1,#listNotOk do
        table.insert(listOk,listNotOk[i])
    end

    -- table.sort(dataList, function(a, b)
    --     return a.id > b.id
    -- end)

    -- table.sort(dataList, function(a, b)
    --     return a.isOk > b.isOk
    -- end)

    self.mElementScroller.DataProvider = listOk
end

function deActive(self)
    super.deActive(self)
end

return _M
