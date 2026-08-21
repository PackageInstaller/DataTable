_class("choose_assistant_ui_data_skin", Object)
choose_assistant_ui_data_skin = choose_assistant_ui_data_skin

function choose_assistant_ui_data_skin:Constructor(petId, grade, skinId, asId)
  self.petid = petId
  self.grade = grade
  self.skinid = skinId
  self.asid = asId
end

_class("choose_assistant_ui_data_pet", Object)
choose_assistant_ui_data_pet = choose_assistant_ui_data_pet

function choose_assistant_ui_data_pet:Constructor(petId, grade, skinId, asId, withPet)
  self.withPet = withPet
  self.petid = petId
  self.grade = grade
  self.skinid = skinId
  self.asid = asId
  self.skinList = {}
  self.aslist = {}
end

function choose_assistant_ui_data_pet:AppendSkinData(skinData)
  table.insert(self.skinList, skinData)
end

function choose_assistant_ui_data_pet:AppendAsData(asData)
  table.insert(self.aslist, asData)
end
