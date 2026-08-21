module("hero.MonsterCard", Class.impl(BaseComponent))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("hero/item/MonsterCard.prefab")

function __initData(self)
    super.__initData(self)
    
    -- 一些常用的脚本
    self.m_textLvl = nil
    self.mTxtName = nil
    self.m_imgColor = nil
    self.m_imgProfession = nil
    self.m_imgBody = nil
    self.m_groupSelect = nil

    --------------------------------------------- 数据源 self.m_data 为 monster.MonsterConfigVo ---------------------------------------------
    -- 名称
    self.m_gridName = nil
    -- 等级
    self.m_heroLvl = nil
    -- 进化等级/星级
    self.m_starLvl = nil

    -- 是否被选择
    self.m_isSelect = nil
end

-- 通过外部传保存进来的需要重置的数据
function __reset(self)
    -- 默认不显示选择界面，为给外部显示用
    if (self.m_groupSelect and not gs.GoUtil.IsGoNull(self.m_groupSelect)) then
        self.m_groupSelect:SetActive(false)
    end

    super.__reset(self)
end

function __updateCustomView(self)
    self:__updateLvl()
    self:__updateName()
    self:__updateStarLvl()
    self:__updateProfession()
    self:__updateBody()
    self:__updateColor()
    self:__updateSelect()
end

-- 更新基础的信息显示
function __updateBasicView(self)
end

-- 点击默认触发
function __onDefaultClickHandler(self)
    -- 内部默认处理
    tips.MonsterTips:showTips(self:getData())
end

function setLvl(self, cusLvl)
    self.m_heroLvl = cusLvl
    self:__updateLvl()
end

function __updateLvl(self)
    if (self.m_isLoadFinish) then
        if (self.m_textLvl == nil) then
            self.m_textLvl = self.m_childTrans["TextLvl"]:GetComponent(ty.Text)
        end
        if (self.m_heroLvl == nil) then
            self.m_textLvl.gameObject:SetActive(false)
            self.m_textLvl.text = ""
        else
            self.m_textLvl.gameObject:SetActive(true)
            self.m_textLvl.text = "Lv."..self.m_heroLvl
        end
    end
end

function setName(self, cusName)
    self.m_gridName = cusName
    self:__updateName()
end

function __updateName(self)
    if (self.m_isLoadFinish) then
        if (self.mTxtName == nil) then
            self.mTxtName = self.m_childTrans["TextName"]:GetComponent(ty.Text)
        end
        if (self.m_gridName == nil) then
			local monsterTidVo = self:getData()
			local monsterConfigVo = monsterTidVo:getBaseConfig()
            self.mTxtName.text = monsterConfigVo.name
        else
            self.mTxtName.text = self.m_gridName
        end
    end
end

function __updateColor(self)
    if (self.m_isLoadFinish) then
        if (self.m_imgColor == nil) then
            self.m_imgColor = self:getChildGO("ImgColor"):GetComponent(ty.Image)
            local monsterTidVo = self:getData()
            local monsterConfigVo = monsterTidVo:getBaseConfig()
            local color = monsterConfigVo.color
            if color == 2 then 
                self.m_imgColor.color = gs.ColorUtil.GetColor("74c0fbff")
            elseif color == 3 then 
                self.m_imgColor.color = gs.ColorUtil.GetColor("de7dd9ff")
            else
                self.m_imgColor.color = gs.ColorUtil.GetColor("ffbc3aff")
            end
        end
    end
end

-- 设置是否显示品质
function setSelect(self, isSelect)
    self.m_isSelect = isSelect
    self:__updateSelect()
end

function __updateSelect(self)
    if (self.m_isLoadFinish) then
        if (self.m_groupSelect == nil) then
            self.m_groupSelect = self.m_childGos["GroupSelect"]
        end
        self.m_groupSelect:SetActive(self.m_isSelect)
    end
end

function __updateProfession(self)
    if (self.m_isLoadFinish) then
        if (self.m_imgProfession == nil) then
            self.m_imgProfession = self.m_childTrans["ImgProfession"]:GetComponent(ty.AutoRefImage)
        end
        local monsterTidVo = self:getData()
        local monsterConfigVo = monsterTidVo:getBaseConfig()
        self.m_imgProfession:SetImg(UrlManager:getIconPath(string.format(UrlManager:getIconPath("heroProfession/hero4_job_%s.png"), monsterConfigVo.professionType)), false)
    end
end

function __updateBody(self)
    if (self.m_isLoadFinish) then
        if (self.m_imgBody == nil) then
            self.m_imgBody = self.m_childTrans["ImgBody"]:GetComponent(ty.AutoRefImage)
        end
        local monsterTidVo = self:getData()
        local monsterConfigVo = monsterTidVo:getBaseConfig()
        self.m_imgBody:SetImg(UrlManager:getIconPath(monsterConfigVo.head), false)
    end
end

function setStarLvl(self, cusStarLvl)
    self.m_starLvl = cusStarLvl
    self:__updateStarLvl()
end

function __updateStarLvl(self)
    if (self.m_isLoadFinish) then
        local monsterTidVo = self:getData()
        local monsterConfigVo = monsterTidVo:getBaseConfig()
        local starLvl = self.m_starLvl and self.m_starLvl or monsterTidVo.evolutionLvl
        local curIntegers, curDecimals = math.modf(starLvl / 2)
        if (starLvl ~= nil) then
            if(hero.HeroStarManager:getHeroStarDic(self:getData().tid))then
                for i = 1, 6 do
                    if i <= curIntegers then
                        self:getChildGO("mImgStar_" .. i):SetActive(true)
                        self:getChildGO("mImgStarBg_" .. i):SetActive(true)
                    else
                        self:getChildGO("mImgStar_" .. i):SetActive(false)
                        if curDecimals > 0 and i == curIntegers + 1 then
                            self:getChildGO("mImgStarBg_" .. i):SetActive(true)
                        else
                            self:getChildGO("mImgStarBg_" .. i):SetActive(false)
                        end
                    end
                end
            else
                self.m_childGos["GroupStar"]:SetActive(false)
            end
        end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
