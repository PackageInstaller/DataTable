module("MonsterHeadGrid", Class.impl(BaseComponent))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("commonGrid/MonsterHeadGrid.prefab")

function __initData(self)
    super.__initData(self)
    
    -- 一些常用的脚本
    self.mTxtName = nil
    self.m_textLvl = nil
    self.m_imgHead = nil
    self.m_imgColor = nil

    --------------------------------------------- 数据源 self.m_data 为 monster.MonsterConfigVo ---------------------------------------------
    -- 名称
    self.m_gridName = nil
    -- 等级
    self.m_heroLvl = nil
    -- 进化等级/星级
    self.m_starLvl = nil
end

function __updateCustomView(self)
    self:__updateBasicView()
end

-- 更新基础的信息显示
function __updateBasicView(self)
    self:__updateName()
    self:__updateLvl()
    self:__updateHead()
    self:__updateColorBg()
    self:__updateStarLvl()
end

-- 点击默认触发
function __onDefaultClickHandler(self)
    -- 内部默认处理
    tips.MonsterTips:showTips(self:getData())
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
            self.m_childGos["GroupLvl"]:SetActive(false)
            self.m_textLvl.text = ""
        else
            self.m_childGos["GroupLvl"]:SetActive(true)
            self.m_textLvl.text = "Lv."..self.m_heroLvl
        end
    end
end

function __updateHead(self)
    if (self.m_isLoadFinish) then
        if (self.m_imgHead == nil) then
            self.m_imgHead = self.m_childTrans["ImgHead"]:GetComponent(ty.AutoRefImage)
        end
        local monsterTidVo = self:getData()
        local monsterConfigVo = monsterTidVo:getBaseConfig()
        self.m_imgHead:SetImg(UrlManager:getIconPath(monsterConfigVo.head), false)
    end
end

function __updateColorBg(self)
    if (self.m_isLoadFinish) then
        if (self.m_imgColor == nil) then
            self.m_imgColor = self.m_childTrans["ImgColor"]:GetComponent(ty.AutoRefImage)
        end
        local monsterTidVo = self:getData()
        local monsterConfigVo = monsterTidVo:getBaseConfig()
        self.m_imgColor.gameObject:SetActive(monsterConfigVo.color > 0)
        if(monsterConfigVo.color > 0)then
            self.m_imgColor:SetImg(UrlManager:getHeroColorIconUrl_2(monsterConfigVo.color), false)
        end
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
        if (starLvl ~= nil) then
            if(hero.HeroStarManager:getHeroStarDic(self:getData().tid))then
                self.m_childGos["GroupStar"]:SetActive(true)
                for i = 1, 6 do
                    if(i <= starLvl)then
                        self.m_childGos["ImgStar_"..i]:SetActive(true)
                    else
                        self.m_childGos["ImgStar_"..i]:SetActive(false)
                    end
                end
            else
                self.m_childGos["GroupStar"]:SetActive(false)
            end
        end
    end
end

return _M
