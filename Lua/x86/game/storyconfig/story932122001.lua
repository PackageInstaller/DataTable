return {
	Play932122001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 932122001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play932122002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST12"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 0

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.ST12

				var_4_5.transform.localPosition = var_4_4
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = (var_4_5.transform.localPosition - var_4_3).z
					local var_4_8 = manager.ui.mainCameraCom_
					local var_4_9 = 2 * var_4_7 * Mathf.Tan(var_4_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_10 = var_4_9 * var_4_8.aspect
					local var_4_11 = var_4_6.sprite.bounds.size.x
					local var_4_12 = var_4_6.sprite.bounds.size.y
					local var_4_13 = var_4_10 / var_4_11
					local var_4_14 = var_4_9 / var_4_12
					local var_4_15 = var_4_14 < var_4_13 and var_4_13 or var_4_14

					var_4_5.transform.localScale = Vector3.New(var_4_15, var_4_15, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST12" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 2

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_18) / var_4_19
				local var_4_21 = Color.New(0, 0, 0)

				var_4_21.a = Mathf.Lerp(1, 0, var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_22 = Color.New(0, 0, 0)
				local var_4_23 = 0

				arg_1_1.mask_.enabled = false
				var_4_22.a = var_4_23
				arg_1_1.mask_.color = var_4_22
			end

			local var_4_24 = "1019"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1019")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(var_4_25, arg_1_1.canvasGo_.transform)

					var_4_26.transform:SetSiblingIndex(1)

					var_4_26.name = var_4_24
					var_4_26.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_24] = var_4_26

					local var_4_27 = var_4_26:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs(var_4_27) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_28 = arg_1_1.actors_["1019"]
			local var_4_29 = 0

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps1019 == nil then
				arg_1_1.var_.actorSpriteComps1019 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.2

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps1019 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								local var_4_32 = Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, var_4_31)
								local var_4_33 = Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, var_4_31)
								local var_4_34 = Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, var_4_31)

								iter_4_5.color = Color.New(var_4_32, var_4_33, var_4_34)
							else
								local var_4_35 = Mathf.Lerp(iter_4_5.color.r, 1, var_4_31)

								iter_4_5.color = Color.New(var_4_35, var_4_35, var_4_35)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps1019 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps1019 = nil
			end

			local var_4_36 = arg_1_1.actors_["1019"].transform
			local var_4_37 = 0

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos1019 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1019", 2)

				local var_4_38 = var_4_36.childCount

				for iter_4_8 = 0, var_4_38 - 1 do
					local var_4_39 = var_4_36:GetChild(iter_4_8)

					if var_4_39.name == "" or not string.find(var_4_39.name, "split") then
						var_4_39.gameObject:SetActive(true)
					else
						var_4_39.gameObject:SetActive(false)
					end
				end
			end

			local var_4_40 = 0.001

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_37) / var_4_40
				local var_4_42 = Vector3.New(-400, -290, -300)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1019, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_40 and arg_1_1.time_ < var_4_37 + var_4_40 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(-400, -290, -300)
			end

			local var_4_43 = "1194"

			if arg_1_1.actors_[var_4_43] == nil then
				local var_4_44 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1194")

				if not isNil(var_4_44) then
					local var_4_45 = Object.Instantiate(var_4_44, arg_1_1.canvasGo_.transform)

					var_4_45.transform:SetSiblingIndex(1)

					var_4_45.name = var_4_43
					var_4_45.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_43] = var_4_45

					local var_4_46 = var_4_45:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_1_1.isInRecall_ then
						for iter_4_9, iter_4_10 in ipairs(var_4_46) do
							iter_4_10.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_47 = arg_1_1.actors_["1194"].transform
			local var_4_48 = 0

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				arg_1_1.var_.moveOldPos1194 = var_4_47.localPosition
				var_4_47.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1194", 4)

				local var_4_49 = var_4_47.childCount

				for iter_4_11 = 0, var_4_49 - 1 do
					local var_4_50 = var_4_47:GetChild(iter_4_11)

					if var_4_50.name == "" or not string.find(var_4_50.name, "split") then
						var_4_50.gameObject:SetActive(true)
					else
						var_4_50.gameObject:SetActive(false)
					end
				end
			end

			local var_4_51 = 0.001

			if var_4_48 <= arg_1_1.time_ and arg_1_1.time_ < var_4_48 + var_4_51 then
				local var_4_52 = (arg_1_1.time_ - var_4_48) / var_4_51
				local var_4_53 = Vector3.New(395, -360, -240)

				var_4_47.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1194, var_4_53, var_4_52)
			end

			if arg_1_1.time_ >= var_4_48 + var_4_51 and arg_1_1.time_ < var_4_48 + var_4_51 + arg_4_0 then
				var_4_47.localPosition = Vector3.New(395, -360, -240)
			end

			local var_4_54 = 0
			local var_4_55 = 0.3

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				local var_4_56 = "play"
				local var_4_57 = "music"

				arg_1_1:AudioAction(var_4_56, var_4_57, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_58 = ""
				local var_4_59 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_59 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_59 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_59

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_59
						arg_1_1.bgmTxt2_.text = var_4_59
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_4_60 = 0.433333333333333
			local var_4_61 = 1

			if var_4_60 < arg_1_1.time_ and arg_1_1.time_ <= var_4_60 + arg_4_0 then
				local var_4_62 = "play"
				local var_4_63 = "music"

				arg_1_1:AudioAction(var_4_62, var_4_63, "bgm_story_office_new", "bgm_story_office_new", "bgm_story_office_new.awb")

				local var_4_64 = ""
				local var_4_65 = manager.audio:GetAudioName("bgm_story_office_new", "bgm_story_office_new")

				if var_4_65 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_65 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_65

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_65
						arg_1_1.bgmTxt2_.text = var_4_65
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_4_66 = 0
			local var_4_67 = 0.3

			if var_4_66 < arg_1_1.time_ and arg_1_1.time_ <= var_4_66 + arg_4_0 then
				local var_4_68 = "play"
				local var_4_69 = "effect"

				arg_1_1:AudioAction(var_4_68, var_4_69, "minigame_activity_4_6", "minigame_activity_4_6_marble_stop_amb", "")
			end

			local var_4_70 = 0
			local var_4_71 = 0.825

			if var_4_70 < arg_1_1.time_ and arg_1_1.time_ <= var_4_70 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_72 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_72:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_72:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_72:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_73 = arg_1_1:FormatText(StoryNameCfg[13].name)

				arg_1_1.leftNameTxt_.text = var_4_73

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_74 = arg_1_1:GetWordFromCfg(932122001)
				local var_4_75 = arg_1_1:FormatText(var_4_74.content)

				arg_1_1.text_.text = var_4_75

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_76 = 33
				local var_4_77 = utf8.len(var_4_75)
				local var_4_78 = var_4_76 <= 0 and var_4_71 or var_4_71 * (var_4_77 / var_4_76)

				if var_4_78 > 0 and var_4_71 < var_4_78 then
					arg_1_1.talkMaxDuration = var_4_78
					var_4_70 = var_4_70 + 0.3

					if var_4_78 + var_4_70 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_78 + var_4_70
					end
				end

				arg_1_1.text_.text = var_4_75
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_79 = var_4_70 + 0.3
			local var_4_80 = math.max(var_4_71, arg_1_1.talkMaxDuration)

			if var_4_79 <= arg_1_1.time_ and arg_1_1.time_ < var_4_79 + var_4_80 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_79) / var_4_80

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_79 + var_4_80 and arg_1_1.time_ < var_4_79 + var_4_80 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1194",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play932122002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 932122002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play932122003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1194"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps1194 == nil then
				arg_9_1.var_.actorSpriteComps1194 = var_12_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_2 = 0.2

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.actorSpriteComps1194 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps1194:ToTable()) do
						if iter_12_1 then
							if arg_9_1.isInRecall_ then
								local var_12_4 = Mathf.Lerp(iter_12_1.color.r, arg_9_1.hightColor1.r, var_12_3)
								local var_12_5 = Mathf.Lerp(iter_12_1.color.g, arg_9_1.hightColor1.g, var_12_3)
								local var_12_6 = Mathf.Lerp(iter_12_1.color.b, arg_9_1.hightColor1.b, var_12_3)

								iter_12_1.color = Color.New(var_12_4, var_12_5, var_12_6)
							else
								local var_12_7 = Mathf.Lerp(iter_12_1.color.r, 1, var_12_3)

								iter_12_1.color = Color.New(var_12_7, var_12_7, var_12_7)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps1194 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps1194:ToTable()) do
					if iter_12_3 then
						if arg_9_1.isInRecall_ then
							iter_12_3.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_12_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps1194 = nil
			end

			local var_12_8 = arg_9_1.actors_["1019"]
			local var_12_9 = 0

			if var_12_9 < arg_9_1.time_ and arg_9_1.time_ <= var_12_9 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.actorSpriteComps1019 == nil then
				arg_9_1.var_.actorSpriteComps1019 = var_12_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_10 = 0.2

			if var_12_9 <= arg_9_1.time_ and arg_9_1.time_ < var_12_9 + var_12_10 and not isNil(var_12_8) then
				local var_12_11 = (arg_9_1.time_ - var_12_9) / var_12_10

				if arg_9_1.var_.actorSpriteComps1019 then
					for iter_12_4, iter_12_5 in pairs(arg_9_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_12_5 then
							if arg_9_1.isInRecall_ then
								local var_12_12 = Mathf.Lerp(iter_12_5.color.r, arg_9_1.hightColor2.r, var_12_11)
								local var_12_13 = Mathf.Lerp(iter_12_5.color.g, arg_9_1.hightColor2.g, var_12_11)
								local var_12_14 = Mathf.Lerp(iter_12_5.color.b, arg_9_1.hightColor2.b, var_12_11)

								iter_12_5.color = Color.New(var_12_12, var_12_13, var_12_14)
							else
								local var_12_15 = Mathf.Lerp(iter_12_5.color.r, 0.5, var_12_11)

								iter_12_5.color = Color.New(var_12_15, var_12_15, var_12_15)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_9 + var_12_10 and arg_9_1.time_ < var_12_9 + var_12_10 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.actorSpriteComps1019 then
				for iter_12_6, iter_12_7 in pairs(arg_9_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_12_7 then
						if arg_9_1.isInRecall_ then
							iter_12_7.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps1019 = nil
			end

			local var_12_16 = arg_9_1.actors_["1019"].transform
			local var_12_17 = 0

			if var_12_17 < arg_9_1.time_ and arg_9_1.time_ <= var_12_17 + arg_12_0 then
				arg_9_1.var_.moveOldPos1019 = var_12_16.localPosition
				var_12_16.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1019", 2)

				local var_12_18 = var_12_16.childCount

				for iter_12_8 = 0, var_12_18 - 1 do
					local var_12_19 = var_12_16:GetChild(iter_12_8)

					if var_12_19.name == "" or not string.find(var_12_19.name, "split") then
						var_12_19.gameObject:SetActive(true)
					else
						var_12_19.gameObject:SetActive(false)
					end
				end
			end

			local var_12_20 = 0.001

			if var_12_17 <= arg_9_1.time_ and arg_9_1.time_ < var_12_17 + var_12_20 then
				local var_12_21 = (arg_9_1.time_ - var_12_17) / var_12_20
				local var_12_22 = Vector3.New(-400, -290, -300)

				var_12_16.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1019, var_12_22, var_12_21)
			end

			if arg_9_1.time_ >= var_12_17 + var_12_20 and arg_9_1.time_ < var_12_17 + var_12_20 + arg_12_0 then
				var_12_16.localPosition = Vector3.New(-400, -290, -300)
			end

			local var_12_23 = arg_9_1.actors_["1194"].transform
			local var_12_24 = 0

			if var_12_24 < arg_9_1.time_ and arg_9_1.time_ <= var_12_24 + arg_12_0 then
				arg_9_1.var_.moveOldPos1194 = var_12_23.localPosition
				var_12_23.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1194", 4)

				local var_12_25 = var_12_23.childCount

				for iter_12_9 = 0, var_12_25 - 1 do
					local var_12_26 = var_12_23:GetChild(iter_12_9)

					if var_12_26.name == "" or not string.find(var_12_26.name, "split") then
						var_12_26.gameObject:SetActive(true)
					else
						var_12_26.gameObject:SetActive(false)
					end
				end
			end

			local var_12_27 = 0.001

			if var_12_24 <= arg_9_1.time_ and arg_9_1.time_ < var_12_24 + var_12_27 then
				local var_12_28 = (arg_9_1.time_ - var_12_24) / var_12_27
				local var_12_29 = Vector3.New(395, -360, -240)

				var_12_23.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1194, var_12_29, var_12_28)
			end

			if arg_9_1.time_ >= var_12_24 + var_12_27 and arg_9_1.time_ < var_12_24 + var_12_27 + arg_12_0 then
				var_12_23.localPosition = Vector3.New(395, -360, -240)
			end

			local var_12_30 = 0
			local var_12_31 = 0.25

			if var_12_30 < arg_9_1.time_ and arg_9_1.time_ <= var_12_30 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_32 = arg_9_1:FormatText(StoryNameCfg[181].name)

				arg_9_1.leftNameTxt_.text = var_12_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_33 = arg_9_1:GetWordFromCfg(932122002)
				local var_12_34 = arg_9_1:FormatText(var_12_33.content)

				arg_9_1.text_.text = var_12_34

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_35 = 10
				local var_12_36 = utf8.len(var_12_34)
				local var_12_37 = var_12_35 <= 0 and var_12_31 or var_12_31 * (var_12_36 / var_12_35)

				if var_12_37 > 0 and var_12_31 < var_12_37 then
					arg_9_1.talkMaxDuration = var_12_37

					if var_12_37 + var_12_30 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_37 + var_12_30
					end
				end

				arg_9_1.text_.text = var_12_34
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_38 = math.max(var_12_31, arg_9_1.talkMaxDuration)

			if var_12_30 <= arg_9_1.time_ and arg_9_1.time_ < var_12_30 + var_12_38 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_30) / var_12_38

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_30 + var_12_38 and arg_9_1.time_ < var_12_30 + var_12_38 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1194",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play932122003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 932122003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play932122004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1019"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps1019 == nil then
				arg_13_1.var_.actorSpriteComps1019 = var_16_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_2 = 0.2

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.actorSpriteComps1019 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_16_1 then
							if arg_13_1.isInRecall_ then
								local var_16_4 = Mathf.Lerp(iter_16_1.color.r, arg_13_1.hightColor1.r, var_16_3)
								local var_16_5 = Mathf.Lerp(iter_16_1.color.g, arg_13_1.hightColor1.g, var_16_3)
								local var_16_6 = Mathf.Lerp(iter_16_1.color.b, arg_13_1.hightColor1.b, var_16_3)

								iter_16_1.color = Color.New(var_16_4, var_16_5, var_16_6)
							else
								local var_16_7 = Mathf.Lerp(iter_16_1.color.r, 1, var_16_3)

								iter_16_1.color = Color.New(var_16_7, var_16_7, var_16_7)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps1019 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_16_3 then
						if arg_13_1.isInRecall_ then
							iter_16_3.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1019 = nil
			end

			local var_16_8 = arg_13_1.actors_["1194"]
			local var_16_9 = 0

			if var_16_9 < arg_13_1.time_ and arg_13_1.time_ <= var_16_9 + arg_16_0 and not isNil(var_16_8) and arg_13_1.var_.actorSpriteComps1194 == nil then
				arg_13_1.var_.actorSpriteComps1194 = var_16_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_10 = 0.2

			if var_16_9 <= arg_13_1.time_ and arg_13_1.time_ < var_16_9 + var_16_10 and not isNil(var_16_8) then
				local var_16_11 = (arg_13_1.time_ - var_16_9) / var_16_10

				if arg_13_1.var_.actorSpriteComps1194 then
					for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps1194:ToTable()) do
						if iter_16_5 then
							if arg_13_1.isInRecall_ then
								local var_16_12 = Mathf.Lerp(iter_16_5.color.r, arg_13_1.hightColor2.r, var_16_11)
								local var_16_13 = Mathf.Lerp(iter_16_5.color.g, arg_13_1.hightColor2.g, var_16_11)
								local var_16_14 = Mathf.Lerp(iter_16_5.color.b, arg_13_1.hightColor2.b, var_16_11)

								iter_16_5.color = Color.New(var_16_12, var_16_13, var_16_14)
							else
								local var_16_15 = Mathf.Lerp(iter_16_5.color.r, 0.5, var_16_11)

								iter_16_5.color = Color.New(var_16_15, var_16_15, var_16_15)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_9 + var_16_10 and arg_13_1.time_ < var_16_9 + var_16_10 + arg_16_0 and not isNil(var_16_8) and arg_13_1.var_.actorSpriteComps1194 then
				for iter_16_6, iter_16_7 in pairs(arg_13_1.var_.actorSpriteComps1194:ToTable()) do
					if iter_16_7 then
						if arg_13_1.isInRecall_ then
							iter_16_7.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1194 = nil
			end

			local var_16_16 = arg_13_1.actors_["1019"].transform
			local var_16_17 = 0

			if var_16_17 < arg_13_1.time_ and arg_13_1.time_ <= var_16_17 + arg_16_0 then
				arg_13_1.var_.moveOldPos1019 = var_16_16.localPosition
				var_16_16.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1019", 2)

				local var_16_18 = var_16_16.childCount

				for iter_16_8 = 0, var_16_18 - 1 do
					local var_16_19 = var_16_16:GetChild(iter_16_8)

					if var_16_19.name == "split_1" or not string.find(var_16_19.name, "split") then
						var_16_19.gameObject:SetActive(true)
					else
						var_16_19.gameObject:SetActive(false)
					end
				end
			end

			local var_16_20 = 0.001

			if var_16_17 <= arg_13_1.time_ and arg_13_1.time_ < var_16_17 + var_16_20 then
				local var_16_21 = (arg_13_1.time_ - var_16_17) / var_16_20
				local var_16_22 = Vector3.New(-400, -290, -300)

				var_16_16.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1019, var_16_22, var_16_21)
			end

			if arg_13_1.time_ >= var_16_17 + var_16_20 and arg_13_1.time_ < var_16_17 + var_16_20 + arg_16_0 then
				var_16_16.localPosition = Vector3.New(-400, -290, -300)
			end

			local var_16_23 = arg_13_1.actors_["1194"].transform
			local var_16_24 = 0

			if var_16_24 < arg_13_1.time_ and arg_13_1.time_ <= var_16_24 + arg_16_0 then
				arg_13_1.var_.moveOldPos1194 = var_16_23.localPosition
				var_16_23.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1194", 4)

				local var_16_25 = var_16_23.childCount

				for iter_16_9 = 0, var_16_25 - 1 do
					local var_16_26 = var_16_23:GetChild(iter_16_9)

					if var_16_26.name == "" or not string.find(var_16_26.name, "split") then
						var_16_26.gameObject:SetActive(true)
					else
						var_16_26.gameObject:SetActive(false)
					end
				end
			end

			local var_16_27 = 0.001

			if var_16_24 <= arg_13_1.time_ and arg_13_1.time_ < var_16_24 + var_16_27 then
				local var_16_28 = (arg_13_1.time_ - var_16_24) / var_16_27
				local var_16_29 = Vector3.New(395, -360, -240)

				var_16_23.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1194, var_16_29, var_16_28)
			end

			if arg_13_1.time_ >= var_16_24 + var_16_27 and arg_13_1.time_ < var_16_24 + var_16_27 + arg_16_0 then
				var_16_23.localPosition = Vector3.New(395, -360, -240)
			end

			local var_16_30 = 0
			local var_16_31 = 0.825

			if var_16_30 < arg_13_1.time_ and arg_13_1.time_ <= var_16_30 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_32 = arg_13_1:FormatText(StoryNameCfg[13].name)

				arg_13_1.leftNameTxt_.text = var_16_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_33 = arg_13_1:GetWordFromCfg(932122003)
				local var_16_34 = arg_13_1:FormatText(var_16_33.content)

				arg_13_1.text_.text = var_16_34

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_35 = 33
				local var_16_36 = utf8.len(var_16_34)
				local var_16_37 = var_16_35 <= 0 and var_16_31 or var_16_31 * (var_16_36 / var_16_35)

				if var_16_37 > 0 and var_16_31 < var_16_37 then
					arg_13_1.talkMaxDuration = var_16_37

					if var_16_37 + var_16_30 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_37 + var_16_30
					end
				end

				arg_13_1.text_.text = var_16_34
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_38 = math.max(var_16_31, arg_13_1.talkMaxDuration)

			if var_16_30 <= arg_13_1.time_ and arg_13_1.time_ < var_16_30 + var_16_38 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_30) / var_16_38

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_30 + var_16_38 and arg_13_1.time_ < var_16_30 + var_16_38 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1194",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play932122004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 932122004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play932122005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1194"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps1194 == nil then
				arg_17_1.var_.actorSpriteComps1194 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps1194 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps1194:ToTable()) do
						if iter_20_1 then
							if arg_17_1.isInRecall_ then
								local var_20_4 = Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor1.r, var_20_3)
								local var_20_5 = Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor1.g, var_20_3)
								local var_20_6 = Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor1.b, var_20_3)

								iter_20_1.color = Color.New(var_20_4, var_20_5, var_20_6)
							else
								local var_20_7 = Mathf.Lerp(iter_20_1.color.r, 1, var_20_3)

								iter_20_1.color = Color.New(var_20_7, var_20_7, var_20_7)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps1194 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1194:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1194 = nil
			end

			local var_20_8 = arg_17_1.actors_["1019"]
			local var_20_9 = 0

			if var_20_9 < arg_17_1.time_ and arg_17_1.time_ <= var_20_9 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.actorSpriteComps1019 == nil then
				arg_17_1.var_.actorSpriteComps1019 = var_20_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_10 = 0.2

			if var_20_9 <= arg_17_1.time_ and arg_17_1.time_ < var_20_9 + var_20_10 and not isNil(var_20_8) then
				local var_20_11 = (arg_17_1.time_ - var_20_9) / var_20_10

				if arg_17_1.var_.actorSpriteComps1019 then
					for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_20_5 then
							if arg_17_1.isInRecall_ then
								local var_20_12 = Mathf.Lerp(iter_20_5.color.r, arg_17_1.hightColor2.r, var_20_11)
								local var_20_13 = Mathf.Lerp(iter_20_5.color.g, arg_17_1.hightColor2.g, var_20_11)
								local var_20_14 = Mathf.Lerp(iter_20_5.color.b, arg_17_1.hightColor2.b, var_20_11)

								iter_20_5.color = Color.New(var_20_12, var_20_13, var_20_14)
							else
								local var_20_15 = Mathf.Lerp(iter_20_5.color.r, 0.5, var_20_11)

								iter_20_5.color = Color.New(var_20_15, var_20_15, var_20_15)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_9 + var_20_10 and arg_17_1.time_ < var_20_9 + var_20_10 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.actorSpriteComps1019 then
				for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_20_7 then
						if arg_17_1.isInRecall_ then
							iter_20_7.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1019 = nil
			end

			local var_20_16 = arg_17_1.actors_["1019"].transform
			local var_20_17 = 0

			if var_20_17 < arg_17_1.time_ and arg_17_1.time_ <= var_20_17 + arg_20_0 then
				arg_17_1.var_.moveOldPos1019 = var_20_16.localPosition
				var_20_16.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1019", 2)

				local var_20_18 = var_20_16.childCount

				for iter_20_8 = 0, var_20_18 - 1 do
					local var_20_19 = var_20_16:GetChild(iter_20_8)

					if var_20_19.name == "" or not string.find(var_20_19.name, "split") then
						var_20_19.gameObject:SetActive(true)
					else
						var_20_19.gameObject:SetActive(false)
					end
				end
			end

			local var_20_20 = 0.001

			if var_20_17 <= arg_17_1.time_ and arg_17_1.time_ < var_20_17 + var_20_20 then
				local var_20_21 = (arg_17_1.time_ - var_20_17) / var_20_20
				local var_20_22 = Vector3.New(-400, -290, -300)

				var_20_16.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1019, var_20_22, var_20_21)
			end

			if arg_17_1.time_ >= var_20_17 + var_20_20 and arg_17_1.time_ < var_20_17 + var_20_20 + arg_20_0 then
				var_20_16.localPosition = Vector3.New(-400, -290, -300)
			end

			local var_20_23 = arg_17_1.actors_["1194"].transform
			local var_20_24 = 0

			if var_20_24 < arg_17_1.time_ and arg_17_1.time_ <= var_20_24 + arg_20_0 then
				arg_17_1.var_.moveOldPos1194 = var_20_23.localPosition
				var_20_23.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1194", 4)

				local var_20_25 = var_20_23.childCount

				for iter_20_9 = 0, var_20_25 - 1 do
					local var_20_26 = var_20_23:GetChild(iter_20_9)

					if var_20_26.name == "" or not string.find(var_20_26.name, "split") then
						var_20_26.gameObject:SetActive(true)
					else
						var_20_26.gameObject:SetActive(false)
					end
				end
			end

			local var_20_27 = 0.001

			if var_20_24 <= arg_17_1.time_ and arg_17_1.time_ < var_20_24 + var_20_27 then
				local var_20_28 = (arg_17_1.time_ - var_20_24) / var_20_27
				local var_20_29 = Vector3.New(395, -360, -240)

				var_20_23.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1194, var_20_29, var_20_28)
			end

			if arg_17_1.time_ >= var_20_24 + var_20_27 and arg_17_1.time_ < var_20_24 + var_20_27 + arg_20_0 then
				var_20_23.localPosition = Vector3.New(395, -360, -240)
			end

			local var_20_30 = 0
			local var_20_31 = 0.3

			if var_20_30 < arg_17_1.time_ and arg_17_1.time_ <= var_20_30 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_32 = arg_17_1:FormatText(StoryNameCfg[181].name)

				arg_17_1.leftNameTxt_.text = var_20_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_33 = arg_17_1:GetWordFromCfg(932122004)
				local var_20_34 = arg_17_1:FormatText(var_20_33.content)

				arg_17_1.text_.text = var_20_34

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_35 = 12
				local var_20_36 = utf8.len(var_20_34)
				local var_20_37 = var_20_35 <= 0 and var_20_31 or var_20_31 * (var_20_36 / var_20_35)

				if var_20_37 > 0 and var_20_31 < var_20_37 then
					arg_17_1.talkMaxDuration = var_20_37

					if var_20_37 + var_20_30 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_37 + var_20_30
					end
				end

				arg_17_1.text_.text = var_20_34
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_38 = math.max(var_20_31, arg_17_1.talkMaxDuration)

			if var_20_30 <= arg_17_1.time_ and arg_17_1.time_ < var_20_30 + var_20_38 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_30) / var_20_38

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_30 + var_20_38 and arg_17_1.time_ < var_20_30 + var_20_38 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1194",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play932122005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 932122005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play932122006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1194"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps1194 == nil then
				arg_21_1.var_.actorSpriteComps1194 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps1194 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps1194:ToTable()) do
						if iter_24_1 then
							if arg_21_1.isInRecall_ then
								local var_24_4 = Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor2.r, var_24_3)
								local var_24_5 = Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor2.g, var_24_3)
								local var_24_6 = Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor2.b, var_24_3)

								iter_24_1.color = Color.New(var_24_4, var_24_5, var_24_6)
							else
								local var_24_7 = Mathf.Lerp(iter_24_1.color.r, 0.5, var_24_3)

								iter_24_1.color = Color.New(var_24_7, var_24_7, var_24_7)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps1194 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps1194:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1194 = nil
			end

			local var_24_8 = arg_21_1.actors_["1019"].transform
			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 then
				arg_21_1.var_.moveOldPos1019 = var_24_8.localPosition
				var_24_8.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1019", 7)

				local var_24_10 = var_24_8.childCount

				for iter_24_4 = 0, var_24_10 - 1 do
					local var_24_11 = var_24_8:GetChild(iter_24_4)

					if var_24_11.name == "" or not string.find(var_24_11.name, "split") then
						var_24_11.gameObject:SetActive(true)
					else
						var_24_11.gameObject:SetActive(false)
					end
				end
			end

			local var_24_12 = 0.001

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_12 then
				local var_24_13 = (arg_21_1.time_ - var_24_9) / var_24_12
				local var_24_14 = Vector3.New(0, -2000, 200)

				var_24_8.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1019, var_24_14, var_24_13)
			end

			if arg_21_1.time_ >= var_24_9 + var_24_12 and arg_21_1.time_ < var_24_9 + var_24_12 + arg_24_0 then
				var_24_8.localPosition = Vector3.New(0, -2000, 200)
			end

			local var_24_15 = arg_21_1.actors_["1194"].transform
			local var_24_16 = 0

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.var_.moveOldPos1194 = var_24_15.localPosition
				var_24_15.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1194", 3)

				local var_24_17 = var_24_15.childCount

				for iter_24_5 = 0, var_24_17 - 1 do
					local var_24_18 = var_24_15:GetChild(iter_24_5)

					if var_24_18.name == "" or not string.find(var_24_18.name, "split") then
						var_24_18.gameObject:SetActive(true)
					else
						var_24_18.gameObject:SetActive(false)
					end
				end
			end

			local var_24_19 = 0.001

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_19 then
				local var_24_20 = (arg_21_1.time_ - var_24_16) / var_24_19
				local var_24_21 = Vector3.New(-60, -360, -240)

				var_24_15.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1194, var_24_21, var_24_20)
			end

			if arg_21_1.time_ >= var_24_16 + var_24_19 and arg_21_1.time_ < var_24_16 + var_24_19 + arg_24_0 then
				var_24_15.localPosition = Vector3.New(-60, -360, -240)
			end

			local var_24_22 = 0
			local var_24_23 = 0.525

			if var_24_22 < arg_21_1.time_ and arg_21_1.time_ <= var_24_22 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_24 = arg_21_1:GetWordFromCfg(932122005)
				local var_24_25 = arg_21_1:FormatText(var_24_24.content)

				arg_21_1.text_.text = var_24_25

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_26 = 21
				local var_24_27 = utf8.len(var_24_25)
				local var_24_28 = var_24_26 <= 0 and var_24_23 or var_24_23 * (var_24_27 / var_24_26)

				if var_24_28 > 0 and var_24_23 < var_24_28 then
					arg_21_1.talkMaxDuration = var_24_28

					if var_24_28 + var_24_22 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_28 + var_24_22
					end
				end

				arg_21_1.text_.text = var_24_25
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_29 = math.max(var_24_23, arg_21_1.talkMaxDuration)

			if var_24_22 <= arg_21_1.time_ and arg_21_1.time_ < var_24_22 + var_24_29 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_22) / var_24_29

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_22 + var_24_29 and arg_21_1.time_ < var_24_22 + var_24_29 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1194",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play932122006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 932122006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play932122007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "ST34"

			if arg_25_1.bgs_[var_28_0] == nil then
				local var_28_1 = Object.Instantiate(arg_25_1.paintGo_)

				var_28_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_28_0)
				var_28_1.name = var_28_0
				var_28_1.transform.parent = arg_25_1.stage_.transform
				var_28_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.bgs_[var_28_0] = var_28_1
			end

			local var_28_2 = 0

			if var_28_2 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				local var_28_3 = manager.ui.mainCamera.transform.localPosition
				local var_28_4 = Vector3.New(0, 0, 10) + Vector3.New(var_28_3.x, var_28_3.y, 0)
				local var_28_5 = arg_25_1.bgs_.ST34

				var_28_5.transform.localPosition = var_28_4
				var_28_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_6 = var_28_5:GetComponent("SpriteRenderer")

				if var_28_6 and var_28_6.sprite then
					local var_28_7 = (var_28_5.transform.localPosition - var_28_3).z
					local var_28_8 = manager.ui.mainCameraCom_
					local var_28_9 = 2 * var_28_7 * Mathf.Tan(var_28_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_28_10 = var_28_9 * var_28_8.aspect
					local var_28_11 = var_28_6.sprite.bounds.size.x
					local var_28_12 = var_28_6.sprite.bounds.size.y
					local var_28_13 = var_28_10 / var_28_11
					local var_28_14 = var_28_9 / var_28_12
					local var_28_15 = var_28_14 < var_28_13 and var_28_13 or var_28_14

					var_28_5.transform.localScale = Vector3.New(var_28_15, var_28_15, 0)
				end

				for iter_28_0, iter_28_1 in pairs(arg_25_1.bgs_) do
					if iter_28_0 ~= "ST34" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 then
				arg_25_1.allBtn_.enabled = false
			end

			local var_28_17 = 0.3

			if arg_25_1.time_ >= var_28_16 + var_28_17 and arg_25_1.time_ < var_28_16 + var_28_17 + arg_28_0 then
				arg_25_1.allBtn_.enabled = true
			end

			local var_28_18 = 0

			if var_28_18 < arg_25_1.time_ and arg_25_1.time_ <= var_28_18 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_19 = 2

			if var_28_18 <= arg_25_1.time_ and arg_25_1.time_ < var_28_18 + var_28_19 then
				local var_28_20 = (arg_25_1.time_ - var_28_18) / var_28_19
				local var_28_21 = Color.New(0, 0, 0)

				var_28_21.a = Mathf.Lerp(1, 0, var_28_20)
				arg_25_1.mask_.color = var_28_21
			end

			if arg_25_1.time_ >= var_28_18 + var_28_19 and arg_25_1.time_ < var_28_18 + var_28_19 + arg_28_0 then
				local var_28_22 = Color.New(0, 0, 0)
				local var_28_23 = 0

				arg_25_1.mask_.enabled = false
				var_28_22.a = var_28_23
				arg_25_1.mask_.color = var_28_22
			end

			local var_28_24 = arg_25_1.actors_["1194"].transform
			local var_28_25 = 0

			if var_28_25 < arg_25_1.time_ and arg_25_1.time_ <= var_28_25 + arg_28_0 then
				arg_25_1.var_.moveOldPos1194 = var_28_24.localPosition
				var_28_24.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1194", 3)

				local var_28_26 = var_28_24.childCount

				for iter_28_2 = 0, var_28_26 - 1 do
					local var_28_27 = var_28_24:GetChild(iter_28_2)

					if var_28_27.name == "" or not string.find(var_28_27.name, "split") then
						var_28_27.gameObject:SetActive(true)
					else
						var_28_27.gameObject:SetActive(false)
					end
				end
			end

			local var_28_28 = 0.001

			if var_28_25 <= arg_25_1.time_ and arg_25_1.time_ < var_28_25 + var_28_28 then
				local var_28_29 = (arg_25_1.time_ - var_28_25) / var_28_28
				local var_28_30 = Vector3.New(-60, -360, -240)

				var_28_24.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1194, var_28_30, var_28_29)
			end

			if arg_25_1.time_ >= var_28_25 + var_28_28 and arg_25_1.time_ < var_28_25 + var_28_28 + arg_28_0 then
				var_28_24.localPosition = Vector3.New(-60, -360, -240)
			end

			local var_28_31 = 0
			local var_28_32 = 0.4

			if var_28_31 < arg_25_1.time_ and arg_25_1.time_ <= var_28_31 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_33 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_33:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_34 = arg_25_1:FormatText(StoryNameCfg[177].name)

				arg_25_1.leftNameTxt_.text = var_28_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_35 = arg_25_1:GetWordFromCfg(932122006)
				local var_28_36 = arg_25_1:FormatText(var_28_35.content)

				arg_25_1.text_.text = var_28_36

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_37 = 16
				local var_28_38 = utf8.len(var_28_36)
				local var_28_39 = var_28_37 <= 0 and var_28_32 or var_28_32 * (var_28_38 / var_28_37)

				if var_28_39 > 0 and var_28_32 < var_28_39 then
					arg_25_1.talkMaxDuration = var_28_39
					var_28_31 = var_28_31 + 0.3

					if var_28_39 + var_28_31 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_39 + var_28_31
					end
				end

				arg_25_1.text_.text = var_28_36
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_40 = var_28_31 + 0.3
			local var_28_41 = math.max(var_28_32, arg_25_1.talkMaxDuration)

			if var_28_40 <= arg_25_1.time_ and arg_25_1.time_ < var_28_40 + var_28_41 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_40) / var_28_41

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_40 + var_28_41 and arg_25_1.time_ < var_28_40 + var_28_41 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play932122007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 932122007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play932122008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1194"]
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.actorSpriteComps1194 == nil then
				arg_31_1.var_.actorSpriteComps1194 = var_34_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_2 = 0.2

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 and not isNil(var_34_0) then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2

				if arg_31_1.var_.actorSpriteComps1194 then
					for iter_34_0, iter_34_1 in pairs(arg_31_1.var_.actorSpriteComps1194:ToTable()) do
						if iter_34_1 then
							if arg_31_1.isInRecall_ then
								local var_34_4 = Mathf.Lerp(iter_34_1.color.r, arg_31_1.hightColor1.r, var_34_3)
								local var_34_5 = Mathf.Lerp(iter_34_1.color.g, arg_31_1.hightColor1.g, var_34_3)
								local var_34_6 = Mathf.Lerp(iter_34_1.color.b, arg_31_1.hightColor1.b, var_34_3)

								iter_34_1.color = Color.New(var_34_4, var_34_5, var_34_6)
							else
								local var_34_7 = Mathf.Lerp(iter_34_1.color.r, 1, var_34_3)

								iter_34_1.color = Color.New(var_34_7, var_34_7, var_34_7)
							end
						end
					end
				end
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.actorSpriteComps1194 then
				for iter_34_2, iter_34_3 in pairs(arg_31_1.var_.actorSpriteComps1194:ToTable()) do
					if iter_34_3 then
						if arg_31_1.isInRecall_ then
							iter_34_3.color = arg_31_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_34_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_31_1.var_.actorSpriteComps1194 = nil
			end

			local var_34_8 = arg_31_1.actors_["1194"].transform
			local var_34_9 = 0

			if var_34_9 < arg_31_1.time_ and arg_31_1.time_ <= var_34_9 + arg_34_0 then
				arg_31_1.var_.moveOldPos1194 = var_34_8.localPosition
				var_34_8.localScale = Vector3.New(1, 1, 1)

				arg_31_1:CheckSpriteTmpPos("1194", 3)

				local var_34_10 = var_34_8.childCount

				for iter_34_4 = 0, var_34_10 - 1 do
					local var_34_11 = var_34_8:GetChild(iter_34_4)

					if var_34_11.name == "split_1" or not string.find(var_34_11.name, "split") then
						var_34_11.gameObject:SetActive(true)
					else
						var_34_11.gameObject:SetActive(false)
					end
				end
			end

			local var_34_12 = 0.001

			if var_34_9 <= arg_31_1.time_ and arg_31_1.time_ < var_34_9 + var_34_12 then
				local var_34_13 = (arg_31_1.time_ - var_34_9) / var_34_12
				local var_34_14 = Vector3.New(-60, -360, -240)

				var_34_8.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1194, var_34_14, var_34_13)
			end

			if arg_31_1.time_ >= var_34_9 + var_34_12 and arg_31_1.time_ < var_34_9 + var_34_12 + arg_34_0 then
				var_34_8.localPosition = Vector3.New(-60, -360, -240)
			end

			local var_34_15 = 0
			local var_34_16 = 0.075

			if var_34_15 < arg_31_1.time_ and arg_31_1.time_ <= var_34_15 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_17 = arg_31_1:FormatText(StoryNameCfg[181].name)

				arg_31_1.leftNameTxt_.text = var_34_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_18 = arg_31_1:GetWordFromCfg(932122007)
				local var_34_19 = arg_31_1:FormatText(var_34_18.content)

				arg_31_1.text_.text = var_34_19

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_20 = 3
				local var_34_21 = utf8.len(var_34_19)
				local var_34_22 = var_34_20 <= 0 and var_34_16 or var_34_16 * (var_34_21 / var_34_20)

				if var_34_22 > 0 and var_34_16 < var_34_22 then
					arg_31_1.talkMaxDuration = var_34_22

					if var_34_22 + var_34_15 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_22 + var_34_15
					end
				end

				arg_31_1.text_.text = var_34_19
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_23 = math.max(var_34_16, arg_31_1.talkMaxDuration)

			if var_34_15 <= arg_31_1.time_ and arg_31_1.time_ < var_34_15 + var_34_23 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_15) / var_34_23

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_15 + var_34_23 and arg_31_1.time_ < var_34_15 + var_34_23 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play932122008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 932122008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play932122009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["1194"]
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.actorSpriteComps1194 == nil then
				arg_35_1.var_.actorSpriteComps1194 = var_38_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_2 = 0.2

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 and not isNil(var_38_0) then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2

				if arg_35_1.var_.actorSpriteComps1194 then
					for iter_38_0, iter_38_1 in pairs(arg_35_1.var_.actorSpriteComps1194:ToTable()) do
						if iter_38_1 then
							if arg_35_1.isInRecall_ then
								local var_38_4 = Mathf.Lerp(iter_38_1.color.r, arg_35_1.hightColor2.r, var_38_3)
								local var_38_5 = Mathf.Lerp(iter_38_1.color.g, arg_35_1.hightColor2.g, var_38_3)
								local var_38_6 = Mathf.Lerp(iter_38_1.color.b, arg_35_1.hightColor2.b, var_38_3)

								iter_38_1.color = Color.New(var_38_4, var_38_5, var_38_6)
							else
								local var_38_7 = Mathf.Lerp(iter_38_1.color.r, 0.5, var_38_3)

								iter_38_1.color = Color.New(var_38_7, var_38_7, var_38_7)
							end
						end
					end
				end
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.actorSpriteComps1194 then
				for iter_38_2, iter_38_3 in pairs(arg_35_1.var_.actorSpriteComps1194:ToTable()) do
					if iter_38_3 then
						if arg_35_1.isInRecall_ then
							iter_38_3.color = arg_35_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_38_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_35_1.var_.actorSpriteComps1194 = nil
			end

			local var_38_8 = arg_35_1.actors_["1194"].transform
			local var_38_9 = 0

			if var_38_9 < arg_35_1.time_ and arg_35_1.time_ <= var_38_9 + arg_38_0 then
				arg_35_1.var_.moveOldPos1194 = var_38_8.localPosition
				var_38_8.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("1194", 3)

				local var_38_10 = var_38_8.childCount

				for iter_38_4 = 0, var_38_10 - 1 do
					local var_38_11 = var_38_8:GetChild(iter_38_4)

					if var_38_11.name == "" or not string.find(var_38_11.name, "split") then
						var_38_11.gameObject:SetActive(true)
					else
						var_38_11.gameObject:SetActive(false)
					end
				end
			end

			local var_38_12 = 0.001

			if var_38_9 <= arg_35_1.time_ and arg_35_1.time_ < var_38_9 + var_38_12 then
				local var_38_13 = (arg_35_1.time_ - var_38_9) / var_38_12
				local var_38_14 = Vector3.New(-60, -360, -240)

				var_38_8.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1194, var_38_14, var_38_13)
			end

			if arg_35_1.time_ >= var_38_9 + var_38_12 and arg_35_1.time_ < var_38_9 + var_38_12 + arg_38_0 then
				var_38_8.localPosition = Vector3.New(-60, -360, -240)
			end

			local var_38_15 = 0
			local var_38_16 = 0.875

			if var_38_15 < arg_35_1.time_ and arg_35_1.time_ <= var_38_15 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_17 = arg_35_1:FormatText(StoryNameCfg[177].name)

				arg_35_1.leftNameTxt_.text = var_38_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_18 = arg_35_1:GetWordFromCfg(932122008)
				local var_38_19 = arg_35_1:FormatText(var_38_18.content)

				arg_35_1.text_.text = var_38_19

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_20 = 35
				local var_38_21 = utf8.len(var_38_19)
				local var_38_22 = var_38_20 <= 0 and var_38_16 or var_38_16 * (var_38_21 / var_38_20)

				if var_38_22 > 0 and var_38_16 < var_38_22 then
					arg_35_1.talkMaxDuration = var_38_22

					if var_38_22 + var_38_15 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_22 + var_38_15
					end
				end

				arg_35_1.text_.text = var_38_19
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_23 = math.max(var_38_16, arg_35_1.talkMaxDuration)

			if var_38_15 <= arg_35_1.time_ and arg_35_1.time_ < var_38_15 + var_38_23 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_15) / var_38_23

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_15 + var_38_23 and arg_35_1.time_ < var_38_15 + var_38_23 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play932122009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 932122009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play932122010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1194"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.actorSpriteComps1194 == nil then
				arg_39_1.var_.actorSpriteComps1194 = var_42_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_2 = 0.2

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 and not isNil(var_42_0) then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2

				if arg_39_1.var_.actorSpriteComps1194 then
					for iter_42_0, iter_42_1 in pairs(arg_39_1.var_.actorSpriteComps1194:ToTable()) do
						if iter_42_1 then
							if arg_39_1.isInRecall_ then
								local var_42_4 = Mathf.Lerp(iter_42_1.color.r, arg_39_1.hightColor1.r, var_42_3)
								local var_42_5 = Mathf.Lerp(iter_42_1.color.g, arg_39_1.hightColor1.g, var_42_3)
								local var_42_6 = Mathf.Lerp(iter_42_1.color.b, arg_39_1.hightColor1.b, var_42_3)

								iter_42_1.color = Color.New(var_42_4, var_42_5, var_42_6)
							else
								local var_42_7 = Mathf.Lerp(iter_42_1.color.r, 1, var_42_3)

								iter_42_1.color = Color.New(var_42_7, var_42_7, var_42_7)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.actorSpriteComps1194 then
				for iter_42_2, iter_42_3 in pairs(arg_39_1.var_.actorSpriteComps1194:ToTable()) do
					if iter_42_3 then
						if arg_39_1.isInRecall_ then
							iter_42_3.color = arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_42_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_39_1.var_.actorSpriteComps1194 = nil
			end

			local var_42_8 = arg_39_1.actors_["1194"].transform
			local var_42_9 = 0

			if var_42_9 < arg_39_1.time_ and arg_39_1.time_ <= var_42_9 + arg_42_0 then
				arg_39_1.var_.moveOldPos1194 = var_42_8.localPosition
				var_42_8.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("1194", 3)

				local var_42_10 = var_42_8.childCount

				for iter_42_4 = 0, var_42_10 - 1 do
					local var_42_11 = var_42_8:GetChild(iter_42_4)

					if var_42_11.name == "" or not string.find(var_42_11.name, "split") then
						var_42_11.gameObject:SetActive(true)
					else
						var_42_11.gameObject:SetActive(false)
					end
				end
			end

			local var_42_12 = 0.001

			if var_42_9 <= arg_39_1.time_ and arg_39_1.time_ < var_42_9 + var_42_12 then
				local var_42_13 = (arg_39_1.time_ - var_42_9) / var_42_12
				local var_42_14 = Vector3.New(-60, -360, -240)

				var_42_8.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1194, var_42_14, var_42_13)
			end

			if arg_39_1.time_ >= var_42_9 + var_42_12 and arg_39_1.time_ < var_42_9 + var_42_12 + arg_42_0 then
				var_42_8.localPosition = Vector3.New(-60, -360, -240)
			end

			local var_42_15 = 0
			local var_42_16 = 0.35

			if var_42_15 < arg_39_1.time_ and arg_39_1.time_ <= var_42_15 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_17 = arg_39_1:FormatText(StoryNameCfg[181].name)

				arg_39_1.leftNameTxt_.text = var_42_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_18 = arg_39_1:GetWordFromCfg(932122009)
				local var_42_19 = arg_39_1:FormatText(var_42_18.content)

				arg_39_1.text_.text = var_42_19

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_20 = 14
				local var_42_21 = utf8.len(var_42_19)
				local var_42_22 = var_42_20 <= 0 and var_42_16 or var_42_16 * (var_42_21 / var_42_20)

				if var_42_22 > 0 and var_42_16 < var_42_22 then
					arg_39_1.talkMaxDuration = var_42_22

					if var_42_22 + var_42_15 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_22 + var_42_15
					end
				end

				arg_39_1.text_.text = var_42_19
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_23 = math.max(var_42_16, arg_39_1.talkMaxDuration)

			if var_42_15 <= arg_39_1.time_ and arg_39_1.time_ < var_42_15 + var_42_23 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_15) / var_42_23

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_15 + var_42_23 and arg_39_1.time_ < var_42_15 + var_42_23 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play932122010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 932122010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play932122011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1194"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.actorSpriteComps1194 == nil then
				arg_43_1.var_.actorSpriteComps1194 = var_46_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_2 = 0.2

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 and not isNil(var_46_0) then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2

				if arg_43_1.var_.actorSpriteComps1194 then
					for iter_46_0, iter_46_1 in pairs(arg_43_1.var_.actorSpriteComps1194:ToTable()) do
						if iter_46_1 then
							if arg_43_1.isInRecall_ then
								local var_46_4 = Mathf.Lerp(iter_46_1.color.r, arg_43_1.hightColor2.r, var_46_3)
								local var_46_5 = Mathf.Lerp(iter_46_1.color.g, arg_43_1.hightColor2.g, var_46_3)
								local var_46_6 = Mathf.Lerp(iter_46_1.color.b, arg_43_1.hightColor2.b, var_46_3)

								iter_46_1.color = Color.New(var_46_4, var_46_5, var_46_6)
							else
								local var_46_7 = Mathf.Lerp(iter_46_1.color.r, 0.5, var_46_3)

								iter_46_1.color = Color.New(var_46_7, var_46_7, var_46_7)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.actorSpriteComps1194 then
				for iter_46_2, iter_46_3 in pairs(arg_43_1.var_.actorSpriteComps1194:ToTable()) do
					if iter_46_3 then
						if arg_43_1.isInRecall_ then
							iter_46_3.color = arg_43_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_46_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_43_1.var_.actorSpriteComps1194 = nil
			end

			local var_46_8 = arg_43_1.actors_["1194"].transform
			local var_46_9 = 0

			if var_46_9 < arg_43_1.time_ and arg_43_1.time_ <= var_46_9 + arg_46_0 then
				arg_43_1.var_.moveOldPos1194 = var_46_8.localPosition
				var_46_8.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("1194", 7)

				local var_46_10 = var_46_8.childCount

				for iter_46_4 = 0, var_46_10 - 1 do
					local var_46_11 = var_46_8:GetChild(iter_46_4)

					if var_46_11.name == "" or not string.find(var_46_11.name, "split") then
						var_46_11.gameObject:SetActive(true)
					else
						var_46_11.gameObject:SetActive(false)
					end
				end
			end

			local var_46_12 = 0.001

			if var_46_9 <= arg_43_1.time_ and arg_43_1.time_ < var_46_9 + var_46_12 then
				local var_46_13 = (arg_43_1.time_ - var_46_9) / var_46_12
				local var_46_14 = Vector3.New(0, -2000, 0)

				var_46_8.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1194, var_46_14, var_46_13)
			end

			if arg_43_1.time_ >= var_46_9 + var_46_12 and arg_43_1.time_ < var_46_9 + var_46_12 + arg_46_0 then
				var_46_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_46_15 = 0
			local var_46_16 = 1.8

			if var_46_15 < arg_43_1.time_ and arg_43_1.time_ <= var_46_15 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_17 = arg_43_1:GetWordFromCfg(932122010)
				local var_46_18 = arg_43_1:FormatText(var_46_17.content)

				arg_43_1.text_.text = var_46_18

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_19 = 72
				local var_46_20 = utf8.len(var_46_18)
				local var_46_21 = var_46_19 <= 0 and var_46_16 or var_46_16 * (var_46_20 / var_46_19)

				if var_46_21 > 0 and var_46_16 < var_46_21 then
					arg_43_1.talkMaxDuration = var_46_21

					if var_46_21 + var_46_15 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_21 + var_46_15
					end
				end

				arg_43_1.text_.text = var_46_18
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_22 = math.max(var_46_16, arg_43_1.talkMaxDuration)

			if var_46_15 <= arg_43_1.time_ and arg_43_1.time_ < var_46_15 + var_46_22 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_15) / var_46_22

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_15 + var_46_22 and arg_43_1.time_ < var_46_15 + var_46_22 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play932122011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 932122011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play932122012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0
			local var_50_1 = 1.2

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_2 = arg_47_1:GetWordFromCfg(932122011)
				local var_50_3 = arg_47_1:FormatText(var_50_2.content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 48
				local var_50_5 = utf8.len(var_50_3)
				local var_50_6 = var_50_4 <= 0 and var_50_1 or var_50_1 * (var_50_5 / var_50_4)

				if var_50_6 > 0 and var_50_1 < var_50_6 then
					arg_47_1.talkMaxDuration = var_50_6

					if var_50_6 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_6 + var_50_0
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = math.max(var_50_1, arg_47_1.talkMaxDuration)

			if var_50_0 <= arg_47_1.time_ and arg_47_1.time_ < var_50_0 + var_50_7 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_0) / var_50_7

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_0 + var_50_7 and arg_47_1.time_ < var_50_0 + var_50_7 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play932122012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 932122012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play932122013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1194"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.actorSpriteComps1194 == nil then
				arg_51_1.var_.actorSpriteComps1194 = var_54_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_2 = 0.2

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.actorSpriteComps1194 then
					for iter_54_0, iter_54_1 in pairs(arg_51_1.var_.actorSpriteComps1194:ToTable()) do
						if iter_54_1 then
							if arg_51_1.isInRecall_ then
								local var_54_4 = Mathf.Lerp(iter_54_1.color.r, arg_51_1.hightColor1.r, var_54_3)
								local var_54_5 = Mathf.Lerp(iter_54_1.color.g, arg_51_1.hightColor1.g, var_54_3)
								local var_54_6 = Mathf.Lerp(iter_54_1.color.b, arg_51_1.hightColor1.b, var_54_3)

								iter_54_1.color = Color.New(var_54_4, var_54_5, var_54_6)
							else
								local var_54_7 = Mathf.Lerp(iter_54_1.color.r, 1, var_54_3)

								iter_54_1.color = Color.New(var_54_7, var_54_7, var_54_7)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.actorSpriteComps1194 then
				for iter_54_2, iter_54_3 in pairs(arg_51_1.var_.actorSpriteComps1194:ToTable()) do
					if iter_54_3 then
						if arg_51_1.isInRecall_ then
							iter_54_3.color = arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_54_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_51_1.var_.actorSpriteComps1194 = nil
			end

			local var_54_8 = arg_51_1.actors_["1194"].transform
			local var_54_9 = 0

			if var_54_9 < arg_51_1.time_ and arg_51_1.time_ <= var_54_9 + arg_54_0 then
				arg_51_1.var_.moveOldPos1194 = var_54_8.localPosition
				var_54_8.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("1194", 3)

				local var_54_10 = var_54_8.childCount

				for iter_54_4 = 0, var_54_10 - 1 do
					local var_54_11 = var_54_8:GetChild(iter_54_4)

					if var_54_11.name == "split_1" or not string.find(var_54_11.name, "split") then
						var_54_11.gameObject:SetActive(true)
					else
						var_54_11.gameObject:SetActive(false)
					end
				end
			end

			local var_54_12 = 0.001

			if var_54_9 <= arg_51_1.time_ and arg_51_1.time_ < var_54_9 + var_54_12 then
				local var_54_13 = (arg_51_1.time_ - var_54_9) / var_54_12
				local var_54_14 = Vector3.New(-60, -360, -240)

				var_54_8.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1194, var_54_14, var_54_13)
			end

			if arg_51_1.time_ >= var_54_9 + var_54_12 and arg_51_1.time_ < var_54_9 + var_54_12 + arg_54_0 then
				var_54_8.localPosition = Vector3.New(-60, -360, -240)
			end

			local var_54_15 = 0
			local var_54_16 = 0.2

			if var_54_15 < arg_51_1.time_ and arg_51_1.time_ <= var_54_15 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_17 = arg_51_1:FormatText(StoryNameCfg[181].name)

				arg_51_1.leftNameTxt_.text = var_54_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_18 = arg_51_1:GetWordFromCfg(932122012)
				local var_54_19 = arg_51_1:FormatText(var_54_18.content)

				arg_51_1.text_.text = var_54_19

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_20 = 8
				local var_54_21 = utf8.len(var_54_19)
				local var_54_22 = var_54_20 <= 0 and var_54_16 or var_54_16 * (var_54_21 / var_54_20)

				if var_54_22 > 0 and var_54_16 < var_54_22 then
					arg_51_1.talkMaxDuration = var_54_22

					if var_54_22 + var_54_15 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_22 + var_54_15
					end
				end

				arg_51_1.text_.text = var_54_19
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_23 = math.max(var_54_16, arg_51_1.talkMaxDuration)

			if var_54_15 <= arg_51_1.time_ and arg_51_1.time_ < var_54_15 + var_54_23 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_15) / var_54_23

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_15 + var_54_23 and arg_51_1.time_ < var_54_15 + var_54_23 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play932122013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 932122013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play932122014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1194"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos1194 = var_58_0.localPosition
				var_58_0.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("1194", 3)

				local var_58_2 = var_58_0.childCount

				for iter_58_0 = 0, var_58_2 - 1 do
					local var_58_3 = var_58_0:GetChild(iter_58_0)

					if var_58_3.name == "split_1" or not string.find(var_58_3.name, "split") then
						var_58_3.gameObject:SetActive(true)
					else
						var_58_3.gameObject:SetActive(false)
					end
				end
			end

			local var_58_4 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_4 then
				local var_58_5 = (arg_55_1.time_ - var_58_1) / var_58_4
				local var_58_6 = Vector3.New(-60, -360, -240)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1194, var_58_6, var_58_5)
			end

			if arg_55_1.time_ >= var_58_1 + var_58_4 and arg_55_1.time_ < var_58_1 + var_58_4 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(-60, -360, -240)
			end

			local var_58_7 = 0
			local var_58_8 = 0.275

			if var_58_7 < arg_55_1.time_ and arg_55_1.time_ <= var_58_7 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_9 = arg_55_1:FormatText(StoryNameCfg[181].name)

				arg_55_1.leftNameTxt_.text = var_58_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_10 = arg_55_1:GetWordFromCfg(932122013)
				local var_58_11 = arg_55_1:FormatText(var_58_10.content)

				arg_55_1.text_.text = var_58_11

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_12 = 11
				local var_58_13 = utf8.len(var_58_11)
				local var_58_14 = var_58_12 <= 0 and var_58_8 or var_58_8 * (var_58_13 / var_58_12)

				if var_58_14 > 0 and var_58_8 < var_58_14 then
					arg_55_1.talkMaxDuration = var_58_14

					if var_58_14 + var_58_7 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_14 + var_58_7
					end
				end

				arg_55_1.text_.text = var_58_11
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_15 = math.max(var_58_8, arg_55_1.talkMaxDuration)

			if var_58_7 <= arg_55_1.time_ and arg_55_1.time_ < var_58_7 + var_58_15 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_7) / var_58_15

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_7 + var_58_15 and arg_55_1.time_ < var_58_7 + var_58_15 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play932122014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 932122014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play932122015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = "ST01"

			if arg_59_1.bgs_[var_62_0] == nil then
				local var_62_1 = Object.Instantiate(arg_59_1.paintGo_)

				var_62_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_62_0)
				var_62_1.name = var_62_0
				var_62_1.transform.parent = arg_59_1.stage_.transform
				var_62_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_59_1.bgs_[var_62_0] = var_62_1
			end

			local var_62_2 = 0

			if var_62_2 < arg_59_1.time_ and arg_59_1.time_ <= var_62_2 + arg_62_0 then
				local var_62_3 = manager.ui.mainCamera.transform.localPosition
				local var_62_4 = Vector3.New(0, 0, 10) + Vector3.New(var_62_3.x, var_62_3.y, 0)
				local var_62_5 = arg_59_1.bgs_.ST01

				var_62_5.transform.localPosition = var_62_4
				var_62_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_62_6 = var_62_5:GetComponent("SpriteRenderer")

				if var_62_6 and var_62_6.sprite then
					local var_62_7 = (var_62_5.transform.localPosition - var_62_3).z
					local var_62_8 = manager.ui.mainCameraCom_
					local var_62_9 = 2 * var_62_7 * Mathf.Tan(var_62_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_62_10 = var_62_9 * var_62_8.aspect
					local var_62_11 = var_62_6.sprite.bounds.size.x
					local var_62_12 = var_62_6.sprite.bounds.size.y
					local var_62_13 = var_62_10 / var_62_11
					local var_62_14 = var_62_9 / var_62_12
					local var_62_15 = var_62_14 < var_62_13 and var_62_13 or var_62_14

					var_62_5.transform.localScale = Vector3.New(var_62_15, var_62_15, 0)
				end

				for iter_62_0, iter_62_1 in pairs(arg_59_1.bgs_) do
					if iter_62_0 ~= "ST01" then
						iter_62_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_62_16 = 0

			if var_62_16 < arg_59_1.time_ and arg_59_1.time_ <= var_62_16 + arg_62_0 then
				arg_59_1.allBtn_.enabled = false
			end

			local var_62_17 = 0.3

			if arg_59_1.time_ >= var_62_16 + var_62_17 and arg_59_1.time_ < var_62_16 + var_62_17 + arg_62_0 then
				arg_59_1.allBtn_.enabled = true
			end

			local var_62_18 = 0

			if var_62_18 < arg_59_1.time_ and arg_59_1.time_ <= var_62_18 + arg_62_0 then
				arg_59_1.mask_.enabled = true
				arg_59_1.mask_.raycastTarget = true

				arg_59_1:SetGaussion(false)
			end

			local var_62_19 = 2

			if var_62_18 <= arg_59_1.time_ and arg_59_1.time_ < var_62_18 + var_62_19 then
				local var_62_20 = (arg_59_1.time_ - var_62_18) / var_62_19
				local var_62_21 = Color.New(0, 0, 0)

				var_62_21.a = Mathf.Lerp(1, 0, var_62_20)
				arg_59_1.mask_.color = var_62_21
			end

			if arg_59_1.time_ >= var_62_18 + var_62_19 and arg_59_1.time_ < var_62_18 + var_62_19 + arg_62_0 then
				local var_62_22 = Color.New(0, 0, 0)
				local var_62_23 = 0

				arg_59_1.mask_.enabled = false
				var_62_22.a = var_62_23
				arg_59_1.mask_.color = var_62_22
			end

			local var_62_24 = arg_59_1.actors_["1194"]
			local var_62_25 = 0

			if var_62_25 < arg_59_1.time_ and arg_59_1.time_ <= var_62_25 + arg_62_0 and not isNil(var_62_24) and arg_59_1.var_.actorSpriteComps1194 == nil then
				arg_59_1.var_.actorSpriteComps1194 = var_62_24:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_26 = 0.2

			if var_62_25 <= arg_59_1.time_ and arg_59_1.time_ < var_62_25 + var_62_26 and not isNil(var_62_24) then
				local var_62_27 = (arg_59_1.time_ - var_62_25) / var_62_26

				if arg_59_1.var_.actorSpriteComps1194 then
					for iter_62_2, iter_62_3 in pairs(arg_59_1.var_.actorSpriteComps1194:ToTable()) do
						if iter_62_3 then
							if arg_59_1.isInRecall_ then
								local var_62_28 = Mathf.Lerp(iter_62_3.color.r, arg_59_1.hightColor2.r, var_62_27)
								local var_62_29 = Mathf.Lerp(iter_62_3.color.g, arg_59_1.hightColor2.g, var_62_27)
								local var_62_30 = Mathf.Lerp(iter_62_3.color.b, arg_59_1.hightColor2.b, var_62_27)

								iter_62_3.color = Color.New(var_62_28, var_62_29, var_62_30)
							else
								local var_62_31 = Mathf.Lerp(iter_62_3.color.r, 0.5, var_62_27)

								iter_62_3.color = Color.New(var_62_31, var_62_31, var_62_31)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= var_62_25 + var_62_26 and arg_59_1.time_ < var_62_25 + var_62_26 + arg_62_0 and not isNil(var_62_24) and arg_59_1.var_.actorSpriteComps1194 then
				for iter_62_4, iter_62_5 in pairs(arg_59_1.var_.actorSpriteComps1194:ToTable()) do
					if iter_62_5 then
						if arg_59_1.isInRecall_ then
							iter_62_5.color = arg_59_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_62_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_59_1.var_.actorSpriteComps1194 = nil
			end

			local var_62_32 = arg_59_1.actors_["1194"].transform
			local var_62_33 = 0

			if var_62_33 < arg_59_1.time_ and arg_59_1.time_ <= var_62_33 + arg_62_0 then
				arg_59_1.var_.moveOldPos1194 = var_62_32.localPosition
				var_62_32.localScale = Vector3.New(1, 1, 1)

				arg_59_1:CheckSpriteTmpPos("1194", 7)

				local var_62_34 = var_62_32.childCount

				for iter_62_6 = 0, var_62_34 - 1 do
					local var_62_35 = var_62_32:GetChild(iter_62_6)

					if var_62_35.name == "" or not string.find(var_62_35.name, "split") then
						var_62_35.gameObject:SetActive(true)
					else
						var_62_35.gameObject:SetActive(false)
					end
				end
			end

			local var_62_36 = 0.001

			if var_62_33 <= arg_59_1.time_ and arg_59_1.time_ < var_62_33 + var_62_36 then
				local var_62_37 = (arg_59_1.time_ - var_62_33) / var_62_36
				local var_62_38 = Vector3.New(0, -2000, 0)

				var_62_32.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1194, var_62_38, var_62_37)
			end

			if arg_59_1.time_ >= var_62_33 + var_62_36 and arg_59_1.time_ < var_62_33 + var_62_36 + arg_62_0 then
				var_62_32.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_62_39 = 0
			local var_62_40 = 1.75

			if var_62_39 < arg_59_1.time_ and arg_59_1.time_ <= var_62_39 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0

				arg_59_1.dialog_:SetActive(true)

				arg_59_1.dialogCg_.alpha = 0

				local var_62_41 = LeanTween.value(arg_59_1.dialog_, 0, 1, 0.3)

				var_62_41:setOnUpdate(LuaHelper.FloatAction(function(arg_63_0)
					arg_59_1.dialogCg_.alpha = arg_63_0
				end))
				var_62_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_59_1.dialog_)
					var_62_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_59_1.duration_ = arg_59_1.duration_ + 0.3

				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_42 = arg_59_1:GetWordFromCfg(932122014)
				local var_62_43 = arg_59_1:FormatText(var_62_42.content)

				arg_59_1.text_.text = var_62_43

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_44 = 70
				local var_62_45 = utf8.len(var_62_43)
				local var_62_46 = var_62_44 <= 0 and var_62_40 or var_62_40 * (var_62_45 / var_62_44)

				if var_62_46 > 0 and var_62_40 < var_62_46 then
					arg_59_1.talkMaxDuration = var_62_46
					var_62_39 = var_62_39 + 0.3

					if var_62_46 + var_62_39 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_46 + var_62_39
					end
				end

				arg_59_1.text_.text = var_62_43
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_47 = var_62_39 + 0.3
			local var_62_48 = math.max(var_62_40, arg_59_1.talkMaxDuration)

			if var_62_47 <= arg_59_1.time_ and arg_59_1.time_ < var_62_47 + var_62_48 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_47) / var_62_48

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_47 + var_62_48 and arg_59_1.time_ < var_62_47 + var_62_48 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play932122015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 932122015
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play932122016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1194"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1194 == nil then
				arg_65_1.var_.actorSpriteComps1194 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps1194 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps1194:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								local var_68_4 = Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor1.r, var_68_3)
								local var_68_5 = Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor1.g, var_68_3)
								local var_68_6 = Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor1.b, var_68_3)

								iter_68_1.color = Color.New(var_68_4, var_68_5, var_68_6)
							else
								local var_68_7 = Mathf.Lerp(iter_68_1.color.r, 1, var_68_3)

								iter_68_1.color = Color.New(var_68_7, var_68_7, var_68_7)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1194 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps1194:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1194 = nil
			end

			local var_68_8 = arg_65_1.actors_["1194"].transform
			local var_68_9 = 0

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 then
				arg_65_1.var_.moveOldPos1194 = var_68_8.localPosition
				var_68_8.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("1194", 3)

				local var_68_10 = var_68_8.childCount

				for iter_68_4 = 0, var_68_10 - 1 do
					local var_68_11 = var_68_8:GetChild(iter_68_4)

					if var_68_11.name == "split_2" or not string.find(var_68_11.name, "split") then
						var_68_11.gameObject:SetActive(true)
					else
						var_68_11.gameObject:SetActive(false)
					end
				end
			end

			local var_68_12 = 0.001

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_12 then
				local var_68_13 = (arg_65_1.time_ - var_68_9) / var_68_12
				local var_68_14 = Vector3.New(-60, -360, -240)

				var_68_8.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1194, var_68_14, var_68_13)
			end

			if arg_65_1.time_ >= var_68_9 + var_68_12 and arg_65_1.time_ < var_68_9 + var_68_12 + arg_68_0 then
				var_68_8.localPosition = Vector3.New(-60, -360, -240)
			end

			local var_68_15 = 0
			local var_68_16 = 0.425

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_17 = arg_65_1:FormatText(StoryNameCfg[181].name)

				arg_65_1.leftNameTxt_.text = var_68_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_18 = arg_65_1:GetWordFromCfg(932122015)
				local var_68_19 = arg_65_1:FormatText(var_68_18.content)

				arg_65_1.text_.text = var_68_19

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_20 = 17
				local var_68_21 = utf8.len(var_68_19)
				local var_68_22 = var_68_20 <= 0 and var_68_16 or var_68_16 * (var_68_21 / var_68_20)

				if var_68_22 > 0 and var_68_16 < var_68_22 then
					arg_65_1.talkMaxDuration = var_68_22

					if var_68_22 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_22 + var_68_15
					end
				end

				arg_65_1.text_.text = var_68_19
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_23 = math.max(var_68_16, arg_65_1.talkMaxDuration)

			if var_68_15 <= arg_65_1.time_ and arg_65_1.time_ < var_68_15 + var_68_23 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_15) / var_68_23

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_15 + var_68_23 and arg_65_1.time_ < var_68_15 + var_68_23 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play932122016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 932122016
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
			arg_69_1.auto_ = false
		end

		function arg_69_1.playNext_(arg_71_0)
			arg_69_1.onStoryFinished_()
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1194"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps1194 == nil then
				arg_69_1.var_.actorSpriteComps1194 = var_72_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_2 = 0.2

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.actorSpriteComps1194 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps1194:ToTable()) do
						if iter_72_1 then
							if arg_69_1.isInRecall_ then
								local var_72_4 = Mathf.Lerp(iter_72_1.color.r, arg_69_1.hightColor2.r, var_72_3)
								local var_72_5 = Mathf.Lerp(iter_72_1.color.g, arg_69_1.hightColor2.g, var_72_3)
								local var_72_6 = Mathf.Lerp(iter_72_1.color.b, arg_69_1.hightColor2.b, var_72_3)

								iter_72_1.color = Color.New(var_72_4, var_72_5, var_72_6)
							else
								local var_72_7 = Mathf.Lerp(iter_72_1.color.r, 0.5, var_72_3)

								iter_72_1.color = Color.New(var_72_7, var_72_7, var_72_7)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps1194 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps1194:ToTable()) do
					if iter_72_3 then
						if arg_69_1.isInRecall_ then
							iter_72_3.color = arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_72_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps1194 = nil
			end

			local var_72_8 = arg_69_1.actors_["1194"].transform
			local var_72_9 = 0

			if var_72_9 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 then
				arg_69_1.var_.moveOldPos1194 = var_72_8.localPosition
				var_72_8.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1194", 3)

				local var_72_10 = var_72_8.childCount

				for iter_72_4 = 0, var_72_10 - 1 do
					local var_72_11 = var_72_8:GetChild(iter_72_4)

					if var_72_11.name == "" or not string.find(var_72_11.name, "split") then
						var_72_11.gameObject:SetActive(true)
					else
						var_72_11.gameObject:SetActive(false)
					end
				end
			end

			local var_72_12 = 0.001

			if var_72_9 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_12 then
				local var_72_13 = (arg_69_1.time_ - var_72_9) / var_72_12
				local var_72_14 = Vector3.New(-60, -360, -240)

				var_72_8.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1194, var_72_14, var_72_13)
			end

			if arg_69_1.time_ >= var_72_9 + var_72_12 and arg_69_1.time_ < var_72_9 + var_72_12 + arg_72_0 then
				var_72_8.localPosition = Vector3.New(-60, -360, -240)
			end

			local var_72_15 = 0
			local var_72_16 = 0.25

			if var_72_15 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_17 = arg_69_1:FormatText(StoryNameCfg[177].name)

				arg_69_1.leftNameTxt_.text = var_72_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_18 = arg_69_1:GetWordFromCfg(932122016)
				local var_72_19 = arg_69_1:FormatText(var_72_18.content)

				arg_69_1.text_.text = var_72_19

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_20 = 10
				local var_72_21 = utf8.len(var_72_19)
				local var_72_22 = var_72_20 <= 0 and var_72_16 or var_72_16 * (var_72_21 / var_72_20)

				if var_72_22 > 0 and var_72_16 < var_72_22 then
					arg_69_1.talkMaxDuration = var_72_22

					if var_72_22 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_22 + var_72_15
					end
				end

				arg_69_1.text_.text = var_72_19
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_23 = math.max(var_72_16, arg_69_1.talkMaxDuration)

			if var_72_15 <= arg_69_1.time_ and arg_69_1.time_ < var_72_15 + var_72_23 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_15) / var_72_23

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_15 + var_72_23 and arg_69_1.time_ < var_72_15 + var_72_23 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST34",
		"TextureConfig/Background/ST01"
	},
	voices = {}
}
