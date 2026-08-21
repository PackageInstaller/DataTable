--[[
----------------------------------------------------- 
   @CreateTime:2024/12/11 16:31:22 
   @Author:zengweiwen 
   @Copyright: (LY)2021 雷焰网络 
   @Description:TODO 
]] 

dna = {}

dna.DnaIncubateSucceedView = require("game/dna/view/DnaIncubateSucceedView")
dna.DnaCultivateChoiceView = require("game/dna/view/DnaCultivateChoiceView")
dna.DnaCultivateChoiceItem = require("game/dna/view/item/DnaCultivateChoiceItem")
dna.DnaCultivatePanel = require("game/dna/view/DnaCultivatePanel")
dna.DnaBubbleCtrl = require("game/dna/view/DnaBubbleCtrl")
dna.DnaFrameAniCtrl = require("game/dna/view/DnaFrameAniCtrl")
dna.DnaManualView = require("game/dna/view/DnaManualView")
dna.DnaManualItem = require("game/dna/view/item/DnaManualItem")
dna.DnaEggGridItem = require("game/dna/view/item/DnaEggGridItem")
dna.DnaHeroGridItem = require("game/dna/view/item/DnaHeroGridItem")
dna.DnaTips = require("game/dna/view/DnaTips")
dna.DnaSkillAllLvTipsView = require("game/dna/view/DnaSkillAllLvTipsView")
dna.DnaSwitchActiveAttrView = require("game/dna/view/DnaSwitchActiveAttrView")
dna.DnaOpenBoxEfxPanel = require("game/dna/view/DnaOpenBoxEfxPanel")

dna.DnaManager = require("game/dna/manager/DnaManager").new() 

dna.DnaEggDataConfigVo = require("game/dna/manager/vo/DnaEggDataConfigVo")
dna.DnaHeroEggDataConfigVo = require("game/dna/manager/vo/DnaHeroEggDataConfigVo")

dna.DnaController = require("game/dna/controller/DnaController").new() 
local module = { dna.DnaController } 
return module 
