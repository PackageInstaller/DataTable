local raw = {
  [1] = ProtobufI("DropDisplayGacha", {
    gachaId = 1,
    resourceType = 15,
    probability = 1000,
    qualityProbability = {
      [1] = ProtobufI("DropDisplayGacha.QualityProbability", {color = 4, probability = 800}),
      [2] = ProtobufI("DropDisplayGacha.QualityProbability", {color = 3, probability = 3500}),
      [3] = ProtobufI("DropDisplayGacha.QualityProbability", {color = 2, probability = 4500}),
      [4] = ProtobufI("DropDisplayGacha.QualityProbability", {color = 1, probability = 1200})
    }
  }),
  [2] = ProtobufI("DropDisplayGacha", {
    gachaId = 1,
    resourceType = 11,
    probability = 500,
    qualityProbability = {
      [1] = ProtobufI("DropDisplayGacha.QualityProbability", {color = 4, probability = 900}),
      [2] = ProtobufI("DropDisplayGacha.QualityProbability", {color = 3, probability = 3600}),
      [3] = ProtobufI("DropDisplayGacha.QualityProbability", {color = 2, probability = 4500}),
      [4] = ProtobufI("DropDisplayGacha.QualityProbability", {color = 1, probability = 1200})
    }
  }),
  [3] = ProtobufI("DropDisplayGacha", {
    gachaId = 1,
    resourceType = 12,
    probability = 500,
    qualityProbability = {
      [1] = ProtobufI("DropDisplayGacha.QualityProbability", {color = 4, probability = 1000}),
      [2] = ProtobufI("DropDisplayGacha.QualityProbability", {color = 3, probability = 3700}),
      [3] = ProtobufI("DropDisplayGacha.QualityProbability", {color = 2, probability = 4500}),
      [4] = ProtobufI("DropDisplayGacha.QualityProbability", {color = 1, probability = 1200})
    }
  })
}
local indexed = {}
return {raw, indexed}
