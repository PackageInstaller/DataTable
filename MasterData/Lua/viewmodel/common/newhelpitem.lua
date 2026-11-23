





NewHelpItem = {}

NewHelpItem.__index = NewHelpItem

local objs = {
    title_1 = {path = "Title_1",type = "Text"},
    title_1_outlineEx = {path = "Title_1",type = "Outline"},
    title_2 = {path = "Title_2",type = "Text"},
    title_2_outlineEx = {path = "Title_2",type = "Outline"},

    helpType_1 = {path = "HelpType1",type = "GameObject"},
    type_1_heroPic = {path = "HelpType1/HeroPic",type = "RawImage"},
    type_1_introContent = {path = "HelpType1/IntroContent",type = "Transform"},
    
    helpType_2 = {path = "HelpType2",type = "GameObject"},
    type_2_helpImg = {path = "HelpType2/HelpImg",type = "RawImage"},
    type_2_introContent = {path = "HelpType2/IntroContent",type = "Transform"},

    helpType_3 = {path = "HelpType3",type = "GameObject"},
    type_3_helpImg = {path = "HelpType3/HelpImg",type = "RawImage"},
    type_3_text = {path = "HelpType3/Text",type = "Text"},

    helpType_4 = {path = "HelpType4",type = "GameObject"},
    type_4_helpImg_1 = {path = "HelpType4/HelpImg_1",type = "RawImage"},
    type_4_helpImg_2 = {path = "HelpType4/HelpImg_2",type = "RawImage"},
    type_4_text = {path = "HelpType4/Text",type = "Text"},

    helpType_5 = {path = "HelpType5",type = "GameObject"},
    type_5_helpImg_1 = {path = "HelpType5/HelpImg_1",type = "RawImage"},
    type_5_text_1 = {path = "HelpType5/HelpImg_1/HelpText_1",type = "Text"},
    type_5_helpImg_2 = {path = "HelpType5/HelpImg_2",type = "RawImage"},
    type_5_text_2 = {path = "HelpType5/HelpImg_2/HelpText_2",type = "Text"},
}

function NewHelpItem.New(prefab, parent)
    local self = {}
    setmetatable(self, NewHelpItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    return self
end

function NewHelpItem:SetData(data,introObject)
    self.data = data
    self.introObject = introObject
    local titleColor,outlineColor = nil,nil
    if self.data.Type == 1 then
        titleColor = UnityEngine.Color(1, 1, 1, 1)
        outlineColor = UnityEngine.Color(136 / 255, 117 / 255, 97 / 255, 1)
    else
        titleColor = UnityEngine.Color(36 / 255, 95 / 255, 97 / 255, 1)
        outlineColor = UnityEngine.Color(215 / 255, 206 / 255, 190 / 255, 1)
    end
    self.title_1.color = titleColor
    self.title_1_outlineEx.effectColor = outlineColor
    self.title_1.text = LuaMgr.GetLangText(self.data.Name01Lan)
    
    self.title_2.color = titleColor
    self.title_2_outlineEx.effectColor = outlineColor
    self.title_2.text = LuaMgr.GetLangText(self.data.Name02Lan)
    local helpTexture = nil
    if self.data.Type == 1 then

        if not TableIsNull(self.data.PicturePos) then
            self.type_1_heroPic.gameObject.transform.anchoredPosition = Vector2(self.data.PicturePos[1],self.data.PicturePos[2])
        end
        helpTexture = LuaMgr.GetTexture(string.format(Path.Help_Texture_Path,self.data.InsertPicture[1][1]))
        self.type_1_heroPic.texture = helpTexture
        self:SetHelpIntro(self.type_1_introContent)
    elseif self.data.Type == 2 then

        helpTexture = LuaMgr.GetTexture(string.format(Path.Help_Texture_Path,self.data.InsertPicture[1][1]))
        self.type_2_helpImg.texture = helpTexture
        self:SetHelpIntro(self.type_2_introContent)
    elseif self.data.Type == 3 then

        helpTexture = LuaMgr.GetTexture(string.format(Path.Help_Texture_Path,self.data.InsertPicture[1][1]))
        self.type_3_helpImg.texture = helpTexture
        self.type_3_text.text = LuaMgr.GetLangText(self.data.TextLan)
    elseif self.data.Type == 4 then

        helpTexture = LuaMgr.GetTexture(string.format(Path.Help_Texture_Path,self.data.InsertPicture[1][1]))
        self.type_4_helpImg_1.texture = helpTexture
        helpTexture = LuaMgr.GetTexture(string.format(Path.Help_Texture_Path,self.data.InsertPicture[2][1]))
        self.type_4_helpImg_2.texture = helpTexture
        self.type_4_text.text = LuaMgr.GetLangText(self.data.TextLan)
    elseif self.data.Type == 5 then

        helpTexture = LuaMgr.GetTexture(string.format(Path.Help_Texture_Path,self.data.InsertPicture[1][1]))
        self.type_5_helpImg_1.texture = helpTexture
        helpTexture = LuaMgr.GetTexture(string.format(Path.Help_Texture_Path,self.data.InsertPicture[2][1]))
        self.type_5_helpImg_2.texture = helpTexture
        local tempStr = LuaMgr.GetLangText(self.data.TextLan)
        if IsNullOrEmpty(tempStr) then
            return
        end
        local introStr = NumTool.split(tempStr,"|")
        self.type_5_text_1.text = #introStr >= 1 and introStr[1] or ""
        self.type_5_text_2.text = #introStr >= 2 and introStr[2] or ""
    end
    SetActive(self.helpType_1,self.data.Type == 1)
    SetActive(self.helpType_2,self.data.Type == 2)
    SetActive(self.helpType_3,self.data.Type == 3)
    SetActive(self.helpType_4,self.data.Type == 4)
    SetActive(self.helpType_5,self.data.Type == 5)
    self.gameObject:SetActive(true)
end

function NewHelpItem:SetHelpIntro(parent)
    local tempStr = LuaMgr.GetLangText(self.data.TextLan)
    if IsNullOrEmpty(tempStr) then
        return
    end
    local introStr = NumTool.split(tempStr,"|")
    local length = #introStr
    if TableIsNull(introStr) or length < 1 then
        return
    end
    if TableIsNull(self.introList) then
        self.introList = {}
    end
    local introItem = nil
    for i = 1, length do
        if #self.introList < i then
            introItem = NewHelpIntroItem.New(self.introObject,parent)
            table.insert(self.introList,introItem)
        end
        self.introList[i]:SetData(introStr[i],i,self.data.Type)
    end
    for i = length + 1, #self.introList do
        self.introList[i]:Clear()
    end
end

function NewHelpItem:Clear()
    self.data = nil
    self.introObject = nil
    self.gameObject:SetActive(false)
    if not TableIsNull(self.introList) then
        for i = 1, #self.introList do
            self.introList[i]:Clear()
            self.introList[i]:Destroy()
        end
        self.introList = nil
    end
end

function NewHelpItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end