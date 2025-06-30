--[[ 
-----------------------------------------------------
@filename       : TeachingHeadItem
@Description    : 教学布阵战员item
@date           : 2021-09-07 18:02:00
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.teaching.view.item.TeachingHeadItem', Class.impl(BaseReuseItem))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("teaching/TeachingHeadItem.prefab")

EVENT_SELECT = "EVENT_SELECT"

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    self.isAlready = false
    self.monsterId = 0
end

-- 初始化
function configUI(self)
    self.mImgBg = self:getChildGO("mImgBg")
    self.mGroupClick = self:getChildGO("mGroupClick")
    self.mImgAlready = self:getChildGO("mImgAlready")
    self.mImgSelect = self:getChildGO("mImgSelect")
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mImgHead = self:getChildTrans("mImgHead")
    self.mTextLvl = self:getChildGO("TextLvl"):GetComponent(ty.Text)
    self.GroupStar = self:getChildGO("GroupStar")
    self.mStars = {}

    for i = 1, 6 do
        self.mStars[i] = self:getChildGO("Image" .. i)
    end
end

--激活
function active(self)
    super.active(self)
    self.GroupStar:SetActive(false)
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
    -- if self.isAlready then
    --     -- gs.Message.Show2("已上阵")
    --     gs.Message.Show2(_TT(47704))
    --     return
    -- end

    self:dispatchEvent(self.EVENT_SELECT, { item = self })
end

function setData(self, cusParent, cusMonsterId, cusDes)
    self:setParentTrans(cusParent)
    self.monsterId = cusMonsterId
    local monsterTidVo = monster.MonsterManager:getMonsterVo(self.monsterId)
    if not monsterTidVo then
        logError("=========找异哥，怪物表 mon_data 不存在 怪物ID：" .. self.monsterId)
        return
    end
    local monsterVo = monster.MonsterManager:getMonsterVo01(monsterTidVo.tid)
    if not monsterVo then
        logError("=========找异哥，怪物基础表 mon_base_data 不存在 怪物TID：" .. monsterTidVo.tid)
        return
    end

    self.mTextLvl.text = monsterTidVo.lvl
    self.mImgBg:GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor(ColorUtil:getPropLineColor(monsterVo.color))
    self.mImgHead:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getMonsterHeadUrl(self.monsterId), false)
    self.mTxtName.text = monsterTidVo:getBaseConfig().name
    self.mTxtTips.text = _TT(cusDes)
    self:updateStarLvl(monsterTidVo.evolutionLvl)
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


function setSelectPos(self, cusLoclPos, cusFormationPos)
    self.localPos = cusLoclPos
    self.formationPos = cusFormationPos
end

-- 已上阵
function setAlready(self, isAlready)
    self.isAlready = isAlready
    if isAlready then
        self.mImgAlready:SetActive(true)
    else
        self.mImgAlready:SetActive(false)
    end
end
-- 选中
function setSelect(self, isSelect)
    self.isSelect = isSelect
    --美术效果图选中效果为当前已上阵效果
    if isSelect then
        self.mImgSelect:SetActive(true)
    else
        self.mImgSelect:SetActive(false)
    end
end

function poolRecover(self)
    super.poolRecover(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]