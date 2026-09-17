local this = class("cellPetRoulette", G_UIModuleBase)

function this.bind()
  return {
    modulePetPuzzle = {
      moduleName = "pages/petPuzzleRoulette/cellPetPuzzle"
    },
    transNodeRot = L_Vector3.new(0, 0, 0),
    petNodeRot = L_Vector3.new(0, 0, 0)
  }
end

function this.methods()
  return {
    modulePetPuzzle = {
      onClick_selectPet = function(self, isFake, id, petConfId)
        self:emit("onClick_selectPet", isFake, id, petConfId)
      end
    }
  }
end

function this:open()
  if self.bind.isFake then
    self.modules.modulePetPuzzle:setPetConfId(self.bind.petConfId)
  else
    self.modules.modulePetPuzzle:setPetId(self.bind.id)
  end
end

return this
