--[[ 
-----------------------------------------------------
@filename       : TeachingFormationItem
@Description    : 教学布阵item
@date           : 2021-09-07 18:02:00
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.teaching.view.item.TeachingFormationItem', Class.impl(BaseReuseItem))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("teaching/TeachingFormationItem.prefab")

EVENT_SELECT = "EVENT_SELECT"

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    self.isSelect = false
    self.isLock = true
    self.isFixedHero = false
    self.isMonster = false
    self.formationPos = 0
end

-- 初始化
function configUI(self)
    self.mImgBg = self:getChildGO("mImgBg")
    self.mImgAdd = self:getChildGO("mImgAdd")
    self.mImgLock = self:getChildGO("mImgLock")
    self.GroupStar = self:getChildGO("GroupStar")
    self.mImgSelect = self:getChildGO("mImgSelect")
    self.mGroupClick = self:getChildGO("mGroupClick")
    self.mImgHeroBg = self:getChildGO("mImgHeroBg")
    self.mTextLvl = self:getChildGO("TextLvl"):GetComponent(ty.Text)
    self.mImgHead = self:getChildGO("mImgHead"):GetComponent(ty.AutoRefImage)
    self.mStars = {}

    for i = 1, 6 do
        self.mStars[i] = self:getChildGO("Image" .. i)
    end
    self.GroupStar:SetActive(false)

    self.mMonsterTag = self:getChildGO("mMonsterTag"):GetComponent(ty.Image)
    self.mTxtTag = self:getChildGO("mTxtTag"):GetComponent(ty.Text)
end

--激活
function active(self)
    super.active(self)

end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mGroupClick, self.onClick)
end

function onClick(self)
    if self.isLock or self.isMonster then
        return
    end
    if self.isFixedHero then
        -- gs.Message.Show2("该位置为固定英雄")
        gs.Message.Show2(_TT(47705))
        return
    end

    self:dispatchEvent(self.EVENT_SELECT, { item = self })
end

-- 设置格子位置
function setLocalPos(self, cusPos)
    self.localPos = cusPos
    self.isFixedHero = false
end

function getLocalPos(self)
    return self.localPos
end

-- 设置格子归属阵形位置
function setFormationPos(self, cusFormationPos)
    self.formationPos = cusFormationPos
end

function getFormationPos(self)
    return self.formationPos
end

-- 设置可变英雄
function setHero(self, monsterId)
    self.monsterId = monsterId

    self:setHead()
end

-- 设置固定英雄
function setFixedHero(self, monsterId)
    self.isFixedHero = true
    self.monsterId = monsterId

    self:setHead()
end

-- 设置怪物，不可点击
function setMonster(self, monsterId)
    self.isMonster = true
    self.monsterId = monsterId

    self:setHead()
end

function setHead(self)
    self.mMonsterTag.gameObject:SetActive(false)
    if not self.monsterId then
        self.mImgHeroBg:SetActive(false)
        self.mImgAdd:SetActive(true)
        self.GroupStar:SetActive(false)
    else
        local monsterTidVo = monster.MonsterManager:getMonsterVo(self.monsterId)
        local monsterVo = monster.MonsterManager:getMonsterVo01(monsterTidVo.tid)
        self.mTextLvl.text = monsterTidVo.lvl

        local color = '2e95ffff'
        local txt = ""
        if monsterVo.color == 3 then --  精英
            color = 'ff72f1ff' -- 紫色
            txt = "精英"
        elseif monsterVo.color == 4 then -- 首领
            color = 'ff9e35ff' -- 橙色
            txt = "首领"
        end
        if monsterVo.color >= 3 and self.formationPos == 0 then 
            self.mMonsterTag.gameObject:SetActive(true)
            self.mMonsterTag.color = gs.ColorUtil.GetColor(color)
            self.mTxtTag.text = txt
        end
        self.mImgBg:GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor(color)
        self.mImgHead:SetImg(UrlManager:getMonsterHeadUrl(self.monsterId), false)
        self.mImgAdd:SetActive(false)
        self.mImgHeroBg:SetActive(true)
        self:updateStarLvl(monsterTidVo.evolutionLvl)
        self.GroupStar:SetActive(false)
    end
end

function updateStarLvl(self, stars)
    local mod = stars % 2
    local sub = math.floor(stars / 2)
    for i = 1, 6 do
        if (i <= sub) then
            self.mStars[i]:SetActive(true)
            self.mStars[i]:GetComponent(ty.Image).color = gs.ColorUtil.GetColor("FFFFFFff")
        else
            if (mod == 1 and i == (sub + 1)) then
                self.mStars[i]:SetActive(true)
                self.mStars[i]:GetComponent(ty.Image).color = gs.ColorUtil.GetColor("FFFFFFff")
            else
                self.mStars[i]:SetActive(false)
            end
        end
    end
end

function setSelect(self, isSelect)
    self.isSelect = isSelect
    --美术效果无选中效果故隐藏逻辑
    if isSelect then
        self.mImgSelect:SetActive(true)
    else
        self.mImgSelect:SetActive(false)
    end
end

function setLock(self, isLock)
    self.isLock = isLock
    if isLock then
        self.mImgLock:SetActive(true)
        self.mImgBg:SetActive(false)
        self.mImgAdd:SetActive(false)
        self.mImgHeroBg:SetActive(false)
    else
        self.mImgLock:SetActive(false)
        self.mImgBg:SetActive(true)
        self.mImgAdd:SetActive(true)
    end
end

function setEmpty(self, isEmpty)
    self.isEmpty = isEmpty
    if isEmpty then
        self.mImgLock:SetActive(false)
        self.mImgBg:SetActive(false)
        self.mImgAdd:SetActive(false)
        self.mImgHeroBg:SetActive(false)
    else
        -- self.mImgLock:SetActive(false)
        -- self.mImgBg:SetActive(true)
    end
end

function poolRecover(self)
    self:setSelect(false)
    self.isMonster = false
    self.isFixedHero = false
    super.poolRecover(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]