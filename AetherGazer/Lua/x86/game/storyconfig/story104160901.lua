return {
	Play416091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416091001
		arg_1_1.duration_ = 6.63

		local var_1_0 = {
			zh = 5.2,
			ja = 6.633
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play416091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 2

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_1 = 0.133333333333333

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_2 = "ST2101"

			if arg_1_1.bgs_[var_4_2] == nil then
				local var_4_3 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_2)
				var_4_3.name = var_4_2
				var_4_3.transform.parent = arg_1_1.stage_.transform
				var_4_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_2] = var_4_3
			end

			local var_4_4 = 0

			if var_4_4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				local var_4_5 = manager.ui.mainCamera.transform.localPosition
				local var_4_6 = Vector3.New(0, 0, 10) + Vector3.New(var_4_5.x, var_4_5.y, 0)
				local var_4_7 = arg_1_1.bgs_.ST2101

				var_4_7.transform.localPosition = var_4_6
				var_4_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_8 = var_4_7:GetComponent("SpriteRenderer")

				if var_4_8 and var_4_8.sprite then
					local var_4_9 = (var_4_7.transform.localPosition - var_4_5).z
					local var_4_10 = manager.ui.mainCameraCom_
					local var_4_11 = 2 * var_4_9 * Mathf.Tan(var_4_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_12 = var_4_11 * var_4_10.aspect
					local var_4_13 = var_4_8.sprite.bounds.size.x
					local var_4_14 = var_4_8.sprite.bounds.size.y
					local var_4_15 = var_4_12 / var_4_13
					local var_4_16 = var_4_11 / var_4_14
					local var_4_17 = var_4_16 < var_4_15 and var_4_15 or var_4_16

					var_4_7.transform.localScale = Vector3.New(var_4_17, var_4_17, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST2101" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
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

			local var_4_24 = "1033"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1033")

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

			local var_4_28 = arg_1_1.actors_["1033"]
			local var_4_29 = 1.66666666666667

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps1033 == nil then
				arg_1_1.var_.actorSpriteComps1033 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.125

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps1033 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps1033 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps1033 = nil
			end

			local var_4_36 = arg_1_1.actors_["1033"].transform
			local var_4_37 = 1.66666666666667

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos1033 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1033", 3)

				local var_4_38 = var_4_36.childCount

				for iter_4_8 = 0, var_4_38 - 1 do
					local var_4_39 = var_4_36:GetChild(iter_4_8)

					if var_4_39.name == "split_6" or not string.find(var_4_39.name, "split") then
						var_4_39.gameObject:SetActive(true)
					else
						var_4_39.gameObject:SetActive(false)
					end
				end
			end

			local var_4_40 = 0.001

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_37) / var_4_40
				local var_4_42 = Vector3.New(0, -420, 0)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1033, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_40 and arg_1_1.time_ < var_4_37 + var_4_40 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(0, -420, 0)
			end

			local var_4_43 = arg_1_1.actors_["1033"]
			local var_4_44 = 1.66666666666667

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = var_4_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_45 then
					arg_1_1.var_.alphaOldValue1033 = var_4_45.alpha
					arg_1_1.var_.characterEffect1033 = var_4_45
				end

				arg_1_1.var_.alphaOldValue1033 = 0
			end

			local var_4_46 = 0.366666666666666

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_44) / var_4_46
				local var_4_48 = Mathf.Lerp(arg_1_1.var_.alphaOldValue1033, 1, var_4_47)

				if arg_1_1.var_.characterEffect1033 then
					arg_1_1.var_.characterEffect1033.alpha = var_4_48
				end
			end

			if arg_1_1.time_ >= var_4_44 + var_4_46 and arg_1_1.time_ < var_4_44 + var_4_46 + arg_4_0 and arg_1_1.var_.characterEffect1033 then
				arg_1_1.var_.characterEffect1033.alpha = 1
			end

			local var_4_49 = 0
			local var_4_50 = 0.2

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "music"

				arg_1_1:AudioAction(var_4_51, var_4_52, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_53 = ""
				local var_4_54 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_54 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_54 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_54

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_54
						arg_1_1.bgmTxt2_.text = var_4_54
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

			local var_4_55 = 0.466666666666667
			local var_4_56 = 1

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				local var_4_57 = "play"
				local var_4_58 = "music"

				arg_1_1:AudioAction(var_4_57, var_4_58, "bgm_activity_3_8_story_corg", "bgm_activity_3_8_story_corg", "bgm_activity_3_8_story_corg.awb")

				local var_4_59 = ""
				local var_4_60 = manager.audio:GetAudioName("bgm_activity_3_8_story_corg", "bgm_activity_3_8_story_corg")

				if var_4_60 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_60 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_60

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_60
						arg_1_1.bgmTxt2_.text = var_4_60
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_61 = 2
			local var_4_62 = 0.325

			if var_4_61 < arg_1_1.time_ and arg_1_1.time_ <= var_4_61 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_63 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_63:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_64 = arg_1_1:FormatText(StoryNameCfg[236].name)

				arg_1_1.leftNameTxt_.text = var_4_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_65 = arg_1_1:GetWordFromCfg(416091001)
				local var_4_66 = arg_1_1:FormatText(var_4_65.content)

				arg_1_1.text_.text = var_4_66

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_67 = 13
				local var_4_68 = utf8.len(var_4_66)
				local var_4_69 = var_4_67 <= 0 and var_4_62 or var_4_62 * (var_4_68 / var_4_67)

				if var_4_69 > 0 and var_4_62 < var_4_69 then
					arg_1_1.talkMaxDuration = var_4_69
					var_4_61 = var_4_61 + 0.3

					if var_4_69 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_69 + var_4_61
					end
				end

				arg_1_1.text_.text = var_4_66
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091001", "story_v_out_416091.awb") ~= 0 then
					local var_4_70 = manager.audio:GetVoiceLength("story_v_out_416091", "416091001", "story_v_out_416091.awb") / 1000

					if var_4_70 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_70 + var_4_61
					end

					if var_4_65.prefab_name ~= "" and arg_1_1.actors_[var_4_65.prefab_name] ~= nil then
						local var_4_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_65.prefab_name].transform, "story_v_out_416091", "416091001", "story_v_out_416091.awb")

						arg_1_1:RecordAudio("416091001", var_4_71)
						arg_1_1:RecordAudio("416091001", var_4_71)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416091", "416091001", "story_v_out_416091.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416091", "416091001", "story_v_out_416091.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_72 = var_4_61 + 0.3
			local var_4_73 = math.max(var_4_62, arg_1_1.talkMaxDuration)

			if var_4_72 <= arg_1_1.time_ and arg_1_1.time_ < var_4_72 + var_4_73 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_72) / var_4_73

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_72 + var_4_73 and arg_1_1.time_ < var_4_72 + var_4_73 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play416091002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416091002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play416091003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1033"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos1033 = var_12_0.localPosition
				var_12_0.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1033", 7)

				local var_12_2 = var_12_0.childCount

				for iter_12_0 = 0, var_12_2 - 1 do
					local var_12_3 = var_12_0:GetChild(iter_12_0)

					if var_12_3.name == "split_6" or not string.find(var_12_3.name, "split") then
						var_12_3.gameObject:SetActive(true)
					else
						var_12_3.gameObject:SetActive(false)
					end
				end
			end

			local var_12_4 = 0.001

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_4 then
				local var_12_5 = (arg_9_1.time_ - var_12_1) / var_12_4
				local var_12_6 = Vector3.New(0, -2000, 0)

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1033, var_12_6, var_12_5)
			end

			if arg_9_1.time_ >= var_12_1 + var_12_4 and arg_9_1.time_ < var_12_1 + var_12_4 + arg_12_0 then
				var_12_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_12_7 = 0
			local var_12_8 = 1.275

			if var_12_7 < arg_9_1.time_ and arg_9_1.time_ <= var_12_7 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_9 = arg_9_1:GetWordFromCfg(416091002)
				local var_12_10 = arg_9_1:FormatText(var_12_9.content)

				arg_9_1.text_.text = var_12_10

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_11 = 51
				local var_12_12 = utf8.len(var_12_10)
				local var_12_13 = var_12_11 <= 0 and var_12_8 or var_12_8 * (var_12_12 / var_12_11)

				if var_12_13 > 0 and var_12_8 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_7 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_7
					end
				end

				arg_9_1.text_.text = var_12_10
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_14 = math.max(var_12_8, arg_9_1.talkMaxDuration)

			if var_12_7 <= arg_9_1.time_ and arg_9_1.time_ < var_12_7 + var_12_14 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_7) / var_12_14

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_7 + var_12_14 and arg_9_1.time_ < var_12_7 + var_12_14 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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
	Play416091003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416091003
		arg_13_1.duration_ = 6.77

		local var_13_0 = {
			zh = 4.166,
			ja = 6.766
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play416091004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1033"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1033 = var_16_0.localPosition
				var_16_0.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1033", 3)

				local var_16_2 = var_16_0.childCount

				for iter_16_0 = 0, var_16_2 - 1 do
					local var_16_3 = var_16_0:GetChild(iter_16_0)

					if var_16_3.name == "split_6" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_4 then
				local var_16_5 = (arg_13_1.time_ - var_16_1) / var_16_4
				local var_16_6 = Vector3.New(0, -420, 0)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1033, var_16_6, var_16_5)
			end

			if arg_13_1.time_ >= var_16_1 + var_16_4 and arg_13_1.time_ < var_16_1 + var_16_4 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, -420, 0)
			end

			local var_16_7 = arg_13_1.actors_["1033"]
			local var_16_8 = 0

			if var_16_8 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps1033 == nil then
				arg_13_1.var_.actorSpriteComps1033 = var_16_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_9 = 0.125

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_9 and not isNil(var_16_7) then
				local var_16_10 = (arg_13_1.time_ - var_16_8) / var_16_9

				if arg_13_1.var_.actorSpriteComps1033 then
					for iter_16_1, iter_16_2 in pairs(arg_13_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_16_2 then
							if arg_13_1.isInRecall_ then
								local var_16_11 = Mathf.Lerp(iter_16_2.color.r, arg_13_1.hightColor1.r, var_16_10)
								local var_16_12 = Mathf.Lerp(iter_16_2.color.g, arg_13_1.hightColor1.g, var_16_10)
								local var_16_13 = Mathf.Lerp(iter_16_2.color.b, arg_13_1.hightColor1.b, var_16_10)

								iter_16_2.color = Color.New(var_16_11, var_16_12, var_16_13)
							else
								local var_16_14 = Mathf.Lerp(iter_16_2.color.r, 1, var_16_10)

								iter_16_2.color = Color.New(var_16_14, var_16_14, var_16_14)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_8 + var_16_9 and arg_13_1.time_ < var_16_8 + var_16_9 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps1033 then
				for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_16_4 then
						if arg_13_1.isInRecall_ then
							iter_16_4.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1033 = nil
			end

			local var_16_15 = 0
			local var_16_16 = 0.525

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_17 = arg_13_1:FormatText(StoryNameCfg[236].name)

				arg_13_1.leftNameTxt_.text = var_16_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_18 = arg_13_1:GetWordFromCfg(416091003)
				local var_16_19 = arg_13_1:FormatText(var_16_18.content)

				arg_13_1.text_.text = var_16_19

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_20 = 21
				local var_16_21 = utf8.len(var_16_19)
				local var_16_22 = var_16_20 <= 0 and var_16_16 or var_16_16 * (var_16_21 / var_16_20)

				if var_16_22 > 0 and var_16_16 < var_16_22 then
					arg_13_1.talkMaxDuration = var_16_22

					if var_16_22 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_22 + var_16_15
					end
				end

				arg_13_1.text_.text = var_16_19
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091003", "story_v_out_416091.awb") ~= 0 then
					local var_16_23 = manager.audio:GetVoiceLength("story_v_out_416091", "416091003", "story_v_out_416091.awb") / 1000

					if var_16_23 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_23 + var_16_15
					end

					if var_16_18.prefab_name ~= "" and arg_13_1.actors_[var_16_18.prefab_name] ~= nil then
						local var_16_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_18.prefab_name].transform, "story_v_out_416091", "416091003", "story_v_out_416091.awb")

						arg_13_1:RecordAudio("416091003", var_16_24)
						arg_13_1:RecordAudio("416091003", var_16_24)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_416091", "416091003", "story_v_out_416091.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_416091", "416091003", "story_v_out_416091.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_25 = math.max(var_16_16, arg_13_1.talkMaxDuration)

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_25 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_15) / var_16_25

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_15 + var_16_25 and arg_13_1.time_ < var_16_15 + var_16_25 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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
	Play416091004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416091004
		arg_17_1.duration_ = 5.57

		local var_17_0 = {
			zh = 3.7,
			ja = 5.566
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play416091005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1033"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps1033 == nil then
				arg_17_1.var_.actorSpriteComps1033 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.125

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps1033 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_20_1 then
							if arg_17_1.isInRecall_ then
								local var_20_4 = Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor2.r, var_20_3)
								local var_20_5 = Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor2.g, var_20_3)
								local var_20_6 = Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor2.b, var_20_3)

								iter_20_1.color = Color.New(var_20_4, var_20_5, var_20_6)
							else
								local var_20_7 = Mathf.Lerp(iter_20_1.color.r, 0.5, var_20_3)

								iter_20_1.color = Color.New(var_20_7, var_20_7, var_20_7)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps1033 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1033 = nil
			end

			local var_20_8 = "10054"

			if arg_17_1.actors_[var_20_8] == nil then
				local var_20_9 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10054")

				if not isNil(var_20_9) then
					local var_20_10 = Object.Instantiate(var_20_9, arg_17_1.canvasGo_.transform)

					var_20_10.transform:SetSiblingIndex(1)

					var_20_10.name = var_20_8
					var_20_10.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_[var_20_8] = var_20_10

					local var_20_11 = var_20_10:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_17_1.isInRecall_ then
						for iter_20_4, iter_20_5 in ipairs(var_20_11) do
							iter_20_5.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_12 = arg_17_1.actors_["10054"]
			local var_20_13 = 0

			if var_20_13 < arg_17_1.time_ and arg_17_1.time_ <= var_20_13 + arg_20_0 and not isNil(var_20_12) and arg_17_1.var_.actorSpriteComps10054 == nil then
				arg_17_1.var_.actorSpriteComps10054 = var_20_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_14 = 0.125

			if var_20_13 <= arg_17_1.time_ and arg_17_1.time_ < var_20_13 + var_20_14 and not isNil(var_20_12) then
				local var_20_15 = (arg_17_1.time_ - var_20_13) / var_20_14

				if arg_17_1.var_.actorSpriteComps10054 then
					for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_20_7 then
							if arg_17_1.isInRecall_ then
								local var_20_16 = Mathf.Lerp(iter_20_7.color.r, arg_17_1.hightColor1.r, var_20_15)
								local var_20_17 = Mathf.Lerp(iter_20_7.color.g, arg_17_1.hightColor1.g, var_20_15)
								local var_20_18 = Mathf.Lerp(iter_20_7.color.b, arg_17_1.hightColor1.b, var_20_15)

								iter_20_7.color = Color.New(var_20_16, var_20_17, var_20_18)
							else
								local var_20_19 = Mathf.Lerp(iter_20_7.color.r, 1, var_20_15)

								iter_20_7.color = Color.New(var_20_19, var_20_19, var_20_19)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_13 + var_20_14 and arg_17_1.time_ < var_20_13 + var_20_14 + arg_20_0 and not isNil(var_20_12) and arg_17_1.var_.actorSpriteComps10054 then
				for iter_20_8, iter_20_9 in pairs(arg_17_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_20_9 then
						if arg_17_1.isInRecall_ then
							iter_20_9.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10054 = nil
			end

			local var_20_20 = arg_17_1.actors_["10054"].transform
			local var_20_21 = 0

			if var_20_21 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 then
				arg_17_1.var_.moveOldPos10054 = var_20_20.localPosition
				var_20_20.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10054", 4)

				local var_20_22 = var_20_20.childCount

				for iter_20_10 = 0, var_20_22 - 1 do
					local var_20_23 = var_20_20:GetChild(iter_20_10)

					if var_20_23.name == "" or not string.find(var_20_23.name, "split") then
						var_20_23.gameObject:SetActive(true)
					else
						var_20_23.gameObject:SetActive(false)
					end
				end
			end

			local var_20_24 = 0.001

			if var_20_21 <= arg_17_1.time_ and arg_17_1.time_ < var_20_21 + var_20_24 then
				local var_20_25 = (arg_17_1.time_ - var_20_21) / var_20_24
				local var_20_26 = Vector3.New(390, -331.1, -274.72)

				var_20_20.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10054, var_20_26, var_20_25)
			end

			if arg_17_1.time_ >= var_20_21 + var_20_24 and arg_17_1.time_ < var_20_21 + var_20_24 + arg_20_0 then
				var_20_20.localPosition = Vector3.New(390, -331.1, -274.72)
			end

			local var_20_27 = arg_17_1.actors_["1033"].transform
			local var_20_28 = 0

			if var_20_28 < arg_17_1.time_ and arg_17_1.time_ <= var_20_28 + arg_20_0 then
				arg_17_1.var_.moveOldPos1033 = var_20_27.localPosition
				var_20_27.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1033", 2)

				local var_20_29 = var_20_27.childCount

				for iter_20_11 = 0, var_20_29 - 1 do
					local var_20_30 = var_20_27:GetChild(iter_20_11)

					if var_20_30.name == "split_6" or not string.find(var_20_30.name, "split") then
						var_20_30.gameObject:SetActive(true)
					else
						var_20_30.gameObject:SetActive(false)
					end
				end
			end

			local var_20_31 = 0.001

			if var_20_28 <= arg_17_1.time_ and arg_17_1.time_ < var_20_28 + var_20_31 then
				local var_20_32 = (arg_17_1.time_ - var_20_28) / var_20_31
				local var_20_33 = Vector3.New(-390, -420, 0)

				var_20_27.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1033, var_20_33, var_20_32)
			end

			if arg_17_1.time_ >= var_20_28 + var_20_31 and arg_17_1.time_ < var_20_28 + var_20_31 + arg_20_0 then
				var_20_27.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_20_34 = 0
			local var_20_35 = 0.475

			if var_20_34 < arg_17_1.time_ and arg_17_1.time_ <= var_20_34 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_36 = arg_17_1:FormatText(StoryNameCfg[487].name)

				arg_17_1.leftNameTxt_.text = var_20_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_37 = arg_17_1:GetWordFromCfg(416091004)
				local var_20_38 = arg_17_1:FormatText(var_20_37.content)

				arg_17_1.text_.text = var_20_38

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_39 = 19
				local var_20_40 = utf8.len(var_20_38)
				local var_20_41 = var_20_39 <= 0 and var_20_35 or var_20_35 * (var_20_40 / var_20_39)

				if var_20_41 > 0 and var_20_35 < var_20_41 then
					arg_17_1.talkMaxDuration = var_20_41

					if var_20_41 + var_20_34 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_41 + var_20_34
					end
				end

				arg_17_1.text_.text = var_20_38
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091004", "story_v_out_416091.awb") ~= 0 then
					local var_20_42 = manager.audio:GetVoiceLength("story_v_out_416091", "416091004", "story_v_out_416091.awb") / 1000

					if var_20_42 + var_20_34 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_42 + var_20_34
					end

					if var_20_37.prefab_name ~= "" and arg_17_1.actors_[var_20_37.prefab_name] ~= nil then
						local var_20_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_37.prefab_name].transform, "story_v_out_416091", "416091004", "story_v_out_416091.awb")

						arg_17_1:RecordAudio("416091004", var_20_43)
						arg_17_1:RecordAudio("416091004", var_20_43)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416091", "416091004", "story_v_out_416091.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416091", "416091004", "story_v_out_416091.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_44 = math.max(var_20_35, arg_17_1.talkMaxDuration)

			if var_20_34 <= arg_17_1.time_ and arg_17_1.time_ < var_20_34 + var_20_44 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_34) / var_20_44

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_34 + var_20_44 and arg_17_1.time_ < var_20_34 + var_20_44 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
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
	Play416091005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416091005
		arg_21_1.duration_ = 3.5

		local var_21_0 = {
			zh = 2.3,
			ja = 3.5
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play416091006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1033"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps1033 == nil then
				arg_21_1.var_.actorSpriteComps1033 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.125

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps1033 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_24_1 then
							if arg_21_1.isInRecall_ then
								local var_24_4 = Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor1.r, var_24_3)
								local var_24_5 = Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor1.g, var_24_3)
								local var_24_6 = Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor1.b, var_24_3)

								iter_24_1.color = Color.New(var_24_4, var_24_5, var_24_6)
							else
								local var_24_7 = Mathf.Lerp(iter_24_1.color.r, 1, var_24_3)

								iter_24_1.color = Color.New(var_24_7, var_24_7, var_24_7)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps1033 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1033 = nil
			end

			local var_24_8 = arg_21_1.actors_["10054"]
			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps10054 == nil then
				arg_21_1.var_.actorSpriteComps10054 = var_24_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_10 = 0.125

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_10 and not isNil(var_24_8) then
				local var_24_11 = (arg_21_1.time_ - var_24_9) / var_24_10

				if arg_21_1.var_.actorSpriteComps10054 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_24_5 then
							if arg_21_1.isInRecall_ then
								local var_24_12 = Mathf.Lerp(iter_24_5.color.r, arg_21_1.hightColor2.r, var_24_11)
								local var_24_13 = Mathf.Lerp(iter_24_5.color.g, arg_21_1.hightColor2.g, var_24_11)
								local var_24_14 = Mathf.Lerp(iter_24_5.color.b, arg_21_1.hightColor2.b, var_24_11)

								iter_24_5.color = Color.New(var_24_12, var_24_13, var_24_14)
							else
								local var_24_15 = Mathf.Lerp(iter_24_5.color.r, 0.5, var_24_11)

								iter_24_5.color = Color.New(var_24_15, var_24_15, var_24_15)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_9 + var_24_10 and arg_21_1.time_ < var_24_9 + var_24_10 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps10054 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_24_7 then
						if arg_21_1.isInRecall_ then
							iter_24_7.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10054 = nil
			end

			local var_24_16 = 0
			local var_24_17 = 0.3

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_18 = arg_21_1:FormatText(StoryNameCfg[236].name)

				arg_21_1.leftNameTxt_.text = var_24_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_19 = arg_21_1:GetWordFromCfg(416091005)
				local var_24_20 = arg_21_1:FormatText(var_24_19.content)

				arg_21_1.text_.text = var_24_20

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_21 = 12
				local var_24_22 = utf8.len(var_24_20)
				local var_24_23 = var_24_21 <= 0 and var_24_17 or var_24_17 * (var_24_22 / var_24_21)

				if var_24_23 > 0 and var_24_17 < var_24_23 then
					arg_21_1.talkMaxDuration = var_24_23

					if var_24_23 + var_24_16 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_16
					end
				end

				arg_21_1.text_.text = var_24_20
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091005", "story_v_out_416091.awb") ~= 0 then
					local var_24_24 = manager.audio:GetVoiceLength("story_v_out_416091", "416091005", "story_v_out_416091.awb") / 1000

					if var_24_24 + var_24_16 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_24 + var_24_16
					end

					if var_24_19.prefab_name ~= "" and arg_21_1.actors_[var_24_19.prefab_name] ~= nil then
						local var_24_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_19.prefab_name].transform, "story_v_out_416091", "416091005", "story_v_out_416091.awb")

						arg_21_1:RecordAudio("416091005", var_24_25)
						arg_21_1:RecordAudio("416091005", var_24_25)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_416091", "416091005", "story_v_out_416091.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_416091", "416091005", "story_v_out_416091.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_26 = math.max(var_24_17, arg_21_1.talkMaxDuration)

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_26 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_16) / var_24_26

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_16 + var_24_26 and arg_21_1.time_ < var_24_16 + var_24_26 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play416091006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 416091006
		arg_25_1.duration_ = 11.93

		local var_25_0 = {
			zh = 6.366,
			ja = 11.933
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play416091007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.825

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[236].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(416091006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 33
				local var_28_6 = utf8.len(var_28_4)
				local var_28_7 = var_28_5 <= 0 and var_28_1 or var_28_1 * (var_28_6 / var_28_5)

				if var_28_7 > 0 and var_28_1 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091006", "story_v_out_416091.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091006", "story_v_out_416091.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_416091", "416091006", "story_v_out_416091.awb")

						arg_25_1:RecordAudio("416091006", var_28_9)
						arg_25_1:RecordAudio("416091006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_416091", "416091006", "story_v_out_416091.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_416091", "416091006", "story_v_out_416091.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_10 and arg_25_1.time_ < var_28_0 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play416091007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 416091007
		arg_29_1.duration_ = 8.43

		local var_29_0 = {
			zh = 5.233,
			ja = 8.433
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play416091008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1033"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps1033 == nil then
				arg_29_1.var_.actorSpriteComps1033 = var_32_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_2 = 0.125

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.actorSpriteComps1033 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_32_1 then
							if arg_29_1.isInRecall_ then
								local var_32_4 = Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor2.r, var_32_3)
								local var_32_5 = Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor2.g, var_32_3)
								local var_32_6 = Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor2.b, var_32_3)

								iter_32_1.color = Color.New(var_32_4, var_32_5, var_32_6)
							else
								local var_32_7 = Mathf.Lerp(iter_32_1.color.r, 0.5, var_32_3)

								iter_32_1.color = Color.New(var_32_7, var_32_7, var_32_7)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps1033 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_32_3 then
						if arg_29_1.isInRecall_ then
							iter_32_3.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps1033 = nil
			end

			local var_32_8 = arg_29_1.actors_["10054"]
			local var_32_9 = 0

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps10054 == nil then
				arg_29_1.var_.actorSpriteComps10054 = var_32_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_10 = 0.125

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_10 and not isNil(var_32_8) then
				local var_32_11 = (arg_29_1.time_ - var_32_9) / var_32_10

				if arg_29_1.var_.actorSpriteComps10054 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_32_5 then
							if arg_29_1.isInRecall_ then
								local var_32_12 = Mathf.Lerp(iter_32_5.color.r, arg_29_1.hightColor1.r, var_32_11)
								local var_32_13 = Mathf.Lerp(iter_32_5.color.g, arg_29_1.hightColor1.g, var_32_11)
								local var_32_14 = Mathf.Lerp(iter_32_5.color.b, arg_29_1.hightColor1.b, var_32_11)

								iter_32_5.color = Color.New(var_32_12, var_32_13, var_32_14)
							else
								local var_32_15 = Mathf.Lerp(iter_32_5.color.r, 1, var_32_11)

								iter_32_5.color = Color.New(var_32_15, var_32_15, var_32_15)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_9 + var_32_10 and arg_29_1.time_ < var_32_9 + var_32_10 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps10054 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_32_7 then
						if arg_29_1.isInRecall_ then
							iter_32_7.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10054 = nil
			end

			local var_32_16 = 0
			local var_32_17 = 0.65

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_18 = arg_29_1:FormatText(StoryNameCfg[487].name)

				arg_29_1.leftNameTxt_.text = var_32_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_19 = arg_29_1:GetWordFromCfg(416091007)
				local var_32_20 = arg_29_1:FormatText(var_32_19.content)

				arg_29_1.text_.text = var_32_20

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_21 = 26
				local var_32_22 = utf8.len(var_32_20)
				local var_32_23 = var_32_21 <= 0 and var_32_17 or var_32_17 * (var_32_22 / var_32_21)

				if var_32_23 > 0 and var_32_17 < var_32_23 then
					arg_29_1.talkMaxDuration = var_32_23

					if var_32_23 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_23 + var_32_16
					end
				end

				arg_29_1.text_.text = var_32_20
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091007", "story_v_out_416091.awb") ~= 0 then
					local var_32_24 = manager.audio:GetVoiceLength("story_v_out_416091", "416091007", "story_v_out_416091.awb") / 1000

					if var_32_24 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_24 + var_32_16
					end

					if var_32_19.prefab_name ~= "" and arg_29_1.actors_[var_32_19.prefab_name] ~= nil then
						local var_32_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_19.prefab_name].transform, "story_v_out_416091", "416091007", "story_v_out_416091.awb")

						arg_29_1:RecordAudio("416091007", var_32_25)
						arg_29_1:RecordAudio("416091007", var_32_25)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_416091", "416091007", "story_v_out_416091.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_416091", "416091007", "story_v_out_416091.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_26 = math.max(var_32_17, arg_29_1.talkMaxDuration)

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_26 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_16) / var_32_26

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_16 + var_32_26 and arg_29_1.time_ < var_32_16 + var_32_26 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play416091008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 416091008
		arg_33_1.duration_ = 8.3

		local var_33_0 = {
			zh = 5.933,
			ja = 8.3
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play416091009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1033"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps1033 == nil then
				arg_33_1.var_.actorSpriteComps1033 = var_36_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_2 = 0.125

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.actorSpriteComps1033 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_36_1 then
							if arg_33_1.isInRecall_ then
								local var_36_4 = Mathf.Lerp(iter_36_1.color.r, arg_33_1.hightColor1.r, var_36_3)
								local var_36_5 = Mathf.Lerp(iter_36_1.color.g, arg_33_1.hightColor1.g, var_36_3)
								local var_36_6 = Mathf.Lerp(iter_36_1.color.b, arg_33_1.hightColor1.b, var_36_3)

								iter_36_1.color = Color.New(var_36_4, var_36_5, var_36_6)
							else
								local var_36_7 = Mathf.Lerp(iter_36_1.color.r, 1, var_36_3)

								iter_36_1.color = Color.New(var_36_7, var_36_7, var_36_7)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps1033 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_36_3 then
						if arg_33_1.isInRecall_ then
							iter_36_3.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps1033 = nil
			end

			local var_36_8 = arg_33_1.actors_["10054"]
			local var_36_9 = 0

			if var_36_9 < arg_33_1.time_ and arg_33_1.time_ <= var_36_9 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.actorSpriteComps10054 == nil then
				arg_33_1.var_.actorSpriteComps10054 = var_36_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_10 = 0.125

			if var_36_9 <= arg_33_1.time_ and arg_33_1.time_ < var_36_9 + var_36_10 and not isNil(var_36_8) then
				local var_36_11 = (arg_33_1.time_ - var_36_9) / var_36_10

				if arg_33_1.var_.actorSpriteComps10054 then
					for iter_36_4, iter_36_5 in pairs(arg_33_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_36_5 then
							if arg_33_1.isInRecall_ then
								local var_36_12 = Mathf.Lerp(iter_36_5.color.r, arg_33_1.hightColor2.r, var_36_11)
								local var_36_13 = Mathf.Lerp(iter_36_5.color.g, arg_33_1.hightColor2.g, var_36_11)
								local var_36_14 = Mathf.Lerp(iter_36_5.color.b, arg_33_1.hightColor2.b, var_36_11)

								iter_36_5.color = Color.New(var_36_12, var_36_13, var_36_14)
							else
								local var_36_15 = Mathf.Lerp(iter_36_5.color.r, 0.5, var_36_11)

								iter_36_5.color = Color.New(var_36_15, var_36_15, var_36_15)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_9 + var_36_10 and arg_33_1.time_ < var_36_9 + var_36_10 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.actorSpriteComps10054 then
				for iter_36_6, iter_36_7 in pairs(arg_33_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_36_7 then
						if arg_33_1.isInRecall_ then
							iter_36_7.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10054 = nil
			end

			local var_36_16 = 0
			local var_36_17 = 0.875

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_18 = arg_33_1:FormatText(StoryNameCfg[236].name)

				arg_33_1.leftNameTxt_.text = var_36_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_19 = arg_33_1:GetWordFromCfg(416091008)
				local var_36_20 = arg_33_1:FormatText(var_36_19.content)

				arg_33_1.text_.text = var_36_20

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_21 = 35
				local var_36_22 = utf8.len(var_36_20)
				local var_36_23 = var_36_21 <= 0 and var_36_17 or var_36_17 * (var_36_22 / var_36_21)

				if var_36_23 > 0 and var_36_17 < var_36_23 then
					arg_33_1.talkMaxDuration = var_36_23

					if var_36_23 + var_36_16 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_23 + var_36_16
					end
				end

				arg_33_1.text_.text = var_36_20
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091008", "story_v_out_416091.awb") ~= 0 then
					local var_36_24 = manager.audio:GetVoiceLength("story_v_out_416091", "416091008", "story_v_out_416091.awb") / 1000

					if var_36_24 + var_36_16 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_24 + var_36_16
					end

					if var_36_19.prefab_name ~= "" and arg_33_1.actors_[var_36_19.prefab_name] ~= nil then
						local var_36_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_19.prefab_name].transform, "story_v_out_416091", "416091008", "story_v_out_416091.awb")

						arg_33_1:RecordAudio("416091008", var_36_25)
						arg_33_1:RecordAudio("416091008", var_36_25)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_416091", "416091008", "story_v_out_416091.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_416091", "416091008", "story_v_out_416091.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_26 = math.max(var_36_17, arg_33_1.talkMaxDuration)

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_26 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_16) / var_36_26

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_16 + var_36_26 and arg_33_1.time_ < var_36_16 + var_36_26 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play416091009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 416091009
		arg_37_1.duration_ = 1.73

		local var_37_0 = {
			zh = 1.733,
			ja = 1.566
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play416091010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1033"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps1033 == nil then
				arg_37_1.var_.actorSpriteComps1033 = var_40_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_2 = 0.125

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.actorSpriteComps1033 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_40_1 then
							if arg_37_1.isInRecall_ then
								local var_40_4 = Mathf.Lerp(iter_40_1.color.r, arg_37_1.hightColor2.r, var_40_3)
								local var_40_5 = Mathf.Lerp(iter_40_1.color.g, arg_37_1.hightColor2.g, var_40_3)
								local var_40_6 = Mathf.Lerp(iter_40_1.color.b, arg_37_1.hightColor2.b, var_40_3)

								iter_40_1.color = Color.New(var_40_4, var_40_5, var_40_6)
							else
								local var_40_7 = Mathf.Lerp(iter_40_1.color.r, 0.5, var_40_3)

								iter_40_1.color = Color.New(var_40_7, var_40_7, var_40_7)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps1033 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_40_3 then
						if arg_37_1.isInRecall_ then
							iter_40_3.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps1033 = nil
			end

			local var_40_8 = arg_37_1.actors_["10054"]
			local var_40_9 = 0

			if var_40_9 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps10054 == nil then
				arg_37_1.var_.actorSpriteComps10054 = var_40_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_10 = 0.125

			if var_40_9 <= arg_37_1.time_ and arg_37_1.time_ < var_40_9 + var_40_10 and not isNil(var_40_8) then
				local var_40_11 = (arg_37_1.time_ - var_40_9) / var_40_10

				if arg_37_1.var_.actorSpriteComps10054 then
					for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_40_5 then
							if arg_37_1.isInRecall_ then
								local var_40_12 = Mathf.Lerp(iter_40_5.color.r, arg_37_1.hightColor1.r, var_40_11)
								local var_40_13 = Mathf.Lerp(iter_40_5.color.g, arg_37_1.hightColor1.g, var_40_11)
								local var_40_14 = Mathf.Lerp(iter_40_5.color.b, arg_37_1.hightColor1.b, var_40_11)

								iter_40_5.color = Color.New(var_40_12, var_40_13, var_40_14)
							else
								local var_40_15 = Mathf.Lerp(iter_40_5.color.r, 1, var_40_11)

								iter_40_5.color = Color.New(var_40_15, var_40_15, var_40_15)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_9 + var_40_10 and arg_37_1.time_ < var_40_9 + var_40_10 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps10054 then
				for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_40_7 then
						if arg_37_1.isInRecall_ then
							iter_40_7.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10054 = nil
			end

			local var_40_16 = 0
			local var_40_17 = 0.05

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_18 = arg_37_1:FormatText(StoryNameCfg[487].name)

				arg_37_1.leftNameTxt_.text = var_40_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_19 = arg_37_1:GetWordFromCfg(416091009)
				local var_40_20 = arg_37_1:FormatText(var_40_19.content)

				arg_37_1.text_.text = var_40_20

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_21 = 2
				local var_40_22 = utf8.len(var_40_20)
				local var_40_23 = var_40_21 <= 0 and var_40_17 or var_40_17 * (var_40_22 / var_40_21)

				if var_40_23 > 0 and var_40_17 < var_40_23 then
					arg_37_1.talkMaxDuration = var_40_23

					if var_40_23 + var_40_16 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_16
					end
				end

				arg_37_1.text_.text = var_40_20
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091009", "story_v_out_416091.awb") ~= 0 then
					local var_40_24 = manager.audio:GetVoiceLength("story_v_out_416091", "416091009", "story_v_out_416091.awb") / 1000

					if var_40_24 + var_40_16 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_24 + var_40_16
					end

					if var_40_19.prefab_name ~= "" and arg_37_1.actors_[var_40_19.prefab_name] ~= nil then
						local var_40_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_19.prefab_name].transform, "story_v_out_416091", "416091009", "story_v_out_416091.awb")

						arg_37_1:RecordAudio("416091009", var_40_25)
						arg_37_1:RecordAudio("416091009", var_40_25)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_416091", "416091009", "story_v_out_416091.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_416091", "416091009", "story_v_out_416091.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_26 = math.max(var_40_17, arg_37_1.talkMaxDuration)

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_26 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_16) / var_40_26

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_16 + var_40_26 and arg_37_1.time_ < var_40_16 + var_40_26 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play416091010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 416091010
		arg_41_1.duration_ = 5.73

		local var_41_0 = {
			zh = 2.3,
			ja = 5.733
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play416091011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1033"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps1033 == nil then
				arg_41_1.var_.actorSpriteComps1033 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.125

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps1033 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								local var_44_4 = Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor1.r, var_44_3)
								local var_44_5 = Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor1.g, var_44_3)
								local var_44_6 = Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor1.b, var_44_3)

								iter_44_1.color = Color.New(var_44_4, var_44_5, var_44_6)
							else
								local var_44_7 = Mathf.Lerp(iter_44_1.color.r, 1, var_44_3)

								iter_44_1.color = Color.New(var_44_7, var_44_7, var_44_7)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps1033 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1033 = nil
			end

			local var_44_8 = arg_41_1.actors_["10054"]
			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10054 == nil then
				arg_41_1.var_.actorSpriteComps10054 = var_44_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_10 = 0.125

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_10 and not isNil(var_44_8) then
				local var_44_11 = (arg_41_1.time_ - var_44_9) / var_44_10

				if arg_41_1.var_.actorSpriteComps10054 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_44_5 then
							if arg_41_1.isInRecall_ then
								local var_44_12 = Mathf.Lerp(iter_44_5.color.r, arg_41_1.hightColor2.r, var_44_11)
								local var_44_13 = Mathf.Lerp(iter_44_5.color.g, arg_41_1.hightColor2.g, var_44_11)
								local var_44_14 = Mathf.Lerp(iter_44_5.color.b, arg_41_1.hightColor2.b, var_44_11)

								iter_44_5.color = Color.New(var_44_12, var_44_13, var_44_14)
							else
								local var_44_15 = Mathf.Lerp(iter_44_5.color.r, 0.5, var_44_11)

								iter_44_5.color = Color.New(var_44_15, var_44_15, var_44_15)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_9 + var_44_10 and arg_41_1.time_ < var_44_9 + var_44_10 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10054 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_44_7 then
						if arg_41_1.isInRecall_ then
							iter_44_7.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10054 = nil
			end

			local var_44_16 = 0
			local var_44_17 = 0.325

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_18 = arg_41_1:FormatText(StoryNameCfg[236].name)

				arg_41_1.leftNameTxt_.text = var_44_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_19 = arg_41_1:GetWordFromCfg(416091010)
				local var_44_20 = arg_41_1:FormatText(var_44_19.content)

				arg_41_1.text_.text = var_44_20

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_21 = 13
				local var_44_22 = utf8.len(var_44_20)
				local var_44_23 = var_44_21 <= 0 and var_44_17 or var_44_17 * (var_44_22 / var_44_21)

				if var_44_23 > 0 and var_44_17 < var_44_23 then
					arg_41_1.talkMaxDuration = var_44_23

					if var_44_23 + var_44_16 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_23 + var_44_16
					end
				end

				arg_41_1.text_.text = var_44_20
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091010", "story_v_out_416091.awb") ~= 0 then
					local var_44_24 = manager.audio:GetVoiceLength("story_v_out_416091", "416091010", "story_v_out_416091.awb") / 1000

					if var_44_24 + var_44_16 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_24 + var_44_16
					end

					if var_44_19.prefab_name ~= "" and arg_41_1.actors_[var_44_19.prefab_name] ~= nil then
						local var_44_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_19.prefab_name].transform, "story_v_out_416091", "416091010", "story_v_out_416091.awb")

						arg_41_1:RecordAudio("416091010", var_44_25)
						arg_41_1:RecordAudio("416091010", var_44_25)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_416091", "416091010", "story_v_out_416091.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_416091", "416091010", "story_v_out_416091.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_26 = math.max(var_44_17, arg_41_1.talkMaxDuration)

			if var_44_16 <= arg_41_1.time_ and arg_41_1.time_ < var_44_16 + var_44_26 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_16) / var_44_26

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_16 + var_44_26 and arg_41_1.time_ < var_44_16 + var_44_26 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play416091011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 416091011
		arg_45_1.duration_ = 7.3

		local var_45_0 = {
			zh = 4.566,
			ja = 7.3
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play416091012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1033"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps1033 == nil then
				arg_45_1.var_.actorSpriteComps1033 = var_48_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_2 = 0.125

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.actorSpriteComps1033 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								local var_48_4 = Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor2.r, var_48_3)
								local var_48_5 = Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor2.g, var_48_3)
								local var_48_6 = Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor2.b, var_48_3)

								iter_48_1.color = Color.New(var_48_4, var_48_5, var_48_6)
							else
								local var_48_7 = Mathf.Lerp(iter_48_1.color.r, 0.5, var_48_3)

								iter_48_1.color = Color.New(var_48_7, var_48_7, var_48_7)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps1033 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_48_3 then
						if arg_45_1.isInRecall_ then
							iter_48_3.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1033 = nil
			end

			local var_48_8 = arg_45_1.actors_["10054"]
			local var_48_9 = 0

			if var_48_9 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.actorSpriteComps10054 == nil then
				arg_45_1.var_.actorSpriteComps10054 = var_48_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_10 = 0.125

			if var_48_9 <= arg_45_1.time_ and arg_45_1.time_ < var_48_9 + var_48_10 and not isNil(var_48_8) then
				local var_48_11 = (arg_45_1.time_ - var_48_9) / var_48_10

				if arg_45_1.var_.actorSpriteComps10054 then
					for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_48_5 then
							if arg_45_1.isInRecall_ then
								local var_48_12 = Mathf.Lerp(iter_48_5.color.r, arg_45_1.hightColor1.r, var_48_11)
								local var_48_13 = Mathf.Lerp(iter_48_5.color.g, arg_45_1.hightColor1.g, var_48_11)
								local var_48_14 = Mathf.Lerp(iter_48_5.color.b, arg_45_1.hightColor1.b, var_48_11)

								iter_48_5.color = Color.New(var_48_12, var_48_13, var_48_14)
							else
								local var_48_15 = Mathf.Lerp(iter_48_5.color.r, 1, var_48_11)

								iter_48_5.color = Color.New(var_48_15, var_48_15, var_48_15)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_9 + var_48_10 and arg_45_1.time_ < var_48_9 + var_48_10 + arg_48_0 and not isNil(var_48_8) and arg_45_1.var_.actorSpriteComps10054 then
				for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_48_7 then
						if arg_45_1.isInRecall_ then
							iter_48_7.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10054 = nil
			end

			local var_48_16 = 0
			local var_48_17 = 0.5

			if var_48_16 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_18 = arg_45_1:FormatText(StoryNameCfg[487].name)

				arg_45_1.leftNameTxt_.text = var_48_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_19 = arg_45_1:GetWordFromCfg(416091011)
				local var_48_20 = arg_45_1:FormatText(var_48_19.content)

				arg_45_1.text_.text = var_48_20

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_21 = 20
				local var_48_22 = utf8.len(var_48_20)
				local var_48_23 = var_48_21 <= 0 and var_48_17 or var_48_17 * (var_48_22 / var_48_21)

				if var_48_23 > 0 and var_48_17 < var_48_23 then
					arg_45_1.talkMaxDuration = var_48_23

					if var_48_23 + var_48_16 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_23 + var_48_16
					end
				end

				arg_45_1.text_.text = var_48_20
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091011", "story_v_out_416091.awb") ~= 0 then
					local var_48_24 = manager.audio:GetVoiceLength("story_v_out_416091", "416091011", "story_v_out_416091.awb") / 1000

					if var_48_24 + var_48_16 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_24 + var_48_16
					end

					if var_48_19.prefab_name ~= "" and arg_45_1.actors_[var_48_19.prefab_name] ~= nil then
						local var_48_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_19.prefab_name].transform, "story_v_out_416091", "416091011", "story_v_out_416091.awb")

						arg_45_1:RecordAudio("416091011", var_48_25)
						arg_45_1:RecordAudio("416091011", var_48_25)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_416091", "416091011", "story_v_out_416091.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_416091", "416091011", "story_v_out_416091.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_26 = math.max(var_48_17, arg_45_1.talkMaxDuration)

			if var_48_16 <= arg_45_1.time_ and arg_45_1.time_ < var_48_16 + var_48_26 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_16) / var_48_26

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_16 + var_48_26 and arg_45_1.time_ < var_48_16 + var_48_26 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play416091012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 416091012
		arg_49_1.duration_ = 11.93

		local var_49_0 = {
			zh = 6.666,
			ja = 11.933
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play416091013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1033"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps1033 == nil then
				arg_49_1.var_.actorSpriteComps1033 = var_52_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_2 = 0.125

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.actorSpriteComps1033 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								local var_52_4 = Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor1.r, var_52_3)
								local var_52_5 = Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor1.g, var_52_3)
								local var_52_6 = Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor1.b, var_52_3)

								iter_52_1.color = Color.New(var_52_4, var_52_5, var_52_6)
							else
								local var_52_7 = Mathf.Lerp(iter_52_1.color.r, 1, var_52_3)

								iter_52_1.color = Color.New(var_52_7, var_52_7, var_52_7)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps1033 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_52_3 then
						if arg_49_1.isInRecall_ then
							iter_52_3.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps1033 = nil
			end

			local var_52_8 = arg_49_1.actors_["10054"]
			local var_52_9 = 0

			if var_52_9 < arg_49_1.time_ and arg_49_1.time_ <= var_52_9 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.actorSpriteComps10054 == nil then
				arg_49_1.var_.actorSpriteComps10054 = var_52_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_10 = 0.125

			if var_52_9 <= arg_49_1.time_ and arg_49_1.time_ < var_52_9 + var_52_10 and not isNil(var_52_8) then
				local var_52_11 = (arg_49_1.time_ - var_52_9) / var_52_10

				if arg_49_1.var_.actorSpriteComps10054 then
					for iter_52_4, iter_52_5 in pairs(arg_49_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_52_5 then
							if arg_49_1.isInRecall_ then
								local var_52_12 = Mathf.Lerp(iter_52_5.color.r, arg_49_1.hightColor2.r, var_52_11)
								local var_52_13 = Mathf.Lerp(iter_52_5.color.g, arg_49_1.hightColor2.g, var_52_11)
								local var_52_14 = Mathf.Lerp(iter_52_5.color.b, arg_49_1.hightColor2.b, var_52_11)

								iter_52_5.color = Color.New(var_52_12, var_52_13, var_52_14)
							else
								local var_52_15 = Mathf.Lerp(iter_52_5.color.r, 0.5, var_52_11)

								iter_52_5.color = Color.New(var_52_15, var_52_15, var_52_15)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_9 + var_52_10 and arg_49_1.time_ < var_52_9 + var_52_10 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.actorSpriteComps10054 then
				for iter_52_6, iter_52_7 in pairs(arg_49_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_52_7 then
						if arg_49_1.isInRecall_ then
							iter_52_7.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10054 = nil
			end

			local var_52_16 = 0
			local var_52_17 = 0.825

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_18 = arg_49_1:FormatText(StoryNameCfg[236].name)

				arg_49_1.leftNameTxt_.text = var_52_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_19 = arg_49_1:GetWordFromCfg(416091012)
				local var_52_20 = arg_49_1:FormatText(var_52_19.content)

				arg_49_1.text_.text = var_52_20

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_21 = 33
				local var_52_22 = utf8.len(var_52_20)
				local var_52_23 = var_52_21 <= 0 and var_52_17 or var_52_17 * (var_52_22 / var_52_21)

				if var_52_23 > 0 and var_52_17 < var_52_23 then
					arg_49_1.talkMaxDuration = var_52_23

					if var_52_23 + var_52_16 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_23 + var_52_16
					end
				end

				arg_49_1.text_.text = var_52_20
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091012", "story_v_out_416091.awb") ~= 0 then
					local var_52_24 = manager.audio:GetVoiceLength("story_v_out_416091", "416091012", "story_v_out_416091.awb") / 1000

					if var_52_24 + var_52_16 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_24 + var_52_16
					end

					if var_52_19.prefab_name ~= "" and arg_49_1.actors_[var_52_19.prefab_name] ~= nil then
						local var_52_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_19.prefab_name].transform, "story_v_out_416091", "416091012", "story_v_out_416091.awb")

						arg_49_1:RecordAudio("416091012", var_52_25)
						arg_49_1:RecordAudio("416091012", var_52_25)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_416091", "416091012", "story_v_out_416091.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_416091", "416091012", "story_v_out_416091.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_26 = math.max(var_52_17, arg_49_1.talkMaxDuration)

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_26 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_16) / var_52_26

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_16 + var_52_26 and arg_49_1.time_ < var_52_16 + var_52_26 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play416091013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 416091013
		arg_53_1.duration_ = 8.73

		local var_53_0 = {
			zh = 4.433,
			ja = 8.733
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play416091014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.625

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[236].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(416091013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 25
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091013", "story_v_out_416091.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091013", "story_v_out_416091.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_416091", "416091013", "story_v_out_416091.awb")

						arg_53_1:RecordAudio("416091013", var_56_9)
						arg_53_1:RecordAudio("416091013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_416091", "416091013", "story_v_out_416091.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_416091", "416091013", "story_v_out_416091.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_10 and arg_53_1.time_ < var_56_0 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play416091014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 416091014
		arg_57_1.duration_ = 10.57

		local var_57_0 = {
			zh = 5.6,
			ja = 10.566
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play416091015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1033"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps1033 == nil then
				arg_57_1.var_.actorSpriteComps1033 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 0.125

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps1033 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								local var_60_4 = Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor2.r, var_60_3)
								local var_60_5 = Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor2.g, var_60_3)
								local var_60_6 = Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor2.b, var_60_3)

								iter_60_1.color = Color.New(var_60_4, var_60_5, var_60_6)
							else
								local var_60_7 = Mathf.Lerp(iter_60_1.color.r, 0.5, var_60_3)

								iter_60_1.color = Color.New(var_60_7, var_60_7, var_60_7)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps1033 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps1033 = nil
			end

			local var_60_8 = arg_57_1.actors_["10054"]
			local var_60_9 = 0

			if var_60_9 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps10054 == nil then
				arg_57_1.var_.actorSpriteComps10054 = var_60_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_10 = 0.125

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_10 and not isNil(var_60_8) then
				local var_60_11 = (arg_57_1.time_ - var_60_9) / var_60_10

				if arg_57_1.var_.actorSpriteComps10054 then
					for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_60_5 then
							if arg_57_1.isInRecall_ then
								local var_60_12 = Mathf.Lerp(iter_60_5.color.r, arg_57_1.hightColor1.r, var_60_11)
								local var_60_13 = Mathf.Lerp(iter_60_5.color.g, arg_57_1.hightColor1.g, var_60_11)
								local var_60_14 = Mathf.Lerp(iter_60_5.color.b, arg_57_1.hightColor1.b, var_60_11)

								iter_60_5.color = Color.New(var_60_12, var_60_13, var_60_14)
							else
								local var_60_15 = Mathf.Lerp(iter_60_5.color.r, 1, var_60_11)

								iter_60_5.color = Color.New(var_60_15, var_60_15, var_60_15)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_9 + var_60_10 and arg_57_1.time_ < var_60_9 + var_60_10 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps10054 then
				for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_60_7 then
						if arg_57_1.isInRecall_ then
							iter_60_7.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10054 = nil
			end

			local var_60_16 = 0
			local var_60_17 = 0.725

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_18 = arg_57_1:FormatText(StoryNameCfg[487].name)

				arg_57_1.leftNameTxt_.text = var_60_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_19 = arg_57_1:GetWordFromCfg(416091014)
				local var_60_20 = arg_57_1:FormatText(var_60_19.content)

				arg_57_1.text_.text = var_60_20

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_21 = 29
				local var_60_22 = utf8.len(var_60_20)
				local var_60_23 = var_60_21 <= 0 and var_60_17 or var_60_17 * (var_60_22 / var_60_21)

				if var_60_23 > 0 and var_60_17 < var_60_23 then
					arg_57_1.talkMaxDuration = var_60_23

					if var_60_23 + var_60_16 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_23 + var_60_16
					end
				end

				arg_57_1.text_.text = var_60_20
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091014", "story_v_out_416091.awb") ~= 0 then
					local var_60_24 = manager.audio:GetVoiceLength("story_v_out_416091", "416091014", "story_v_out_416091.awb") / 1000

					if var_60_24 + var_60_16 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_24 + var_60_16
					end

					if var_60_19.prefab_name ~= "" and arg_57_1.actors_[var_60_19.prefab_name] ~= nil then
						local var_60_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_19.prefab_name].transform, "story_v_out_416091", "416091014", "story_v_out_416091.awb")

						arg_57_1:RecordAudio("416091014", var_60_25)
						arg_57_1:RecordAudio("416091014", var_60_25)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_416091", "416091014", "story_v_out_416091.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_416091", "416091014", "story_v_out_416091.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_26 = math.max(var_60_17, arg_57_1.talkMaxDuration)

			if var_60_16 <= arg_57_1.time_ and arg_57_1.time_ < var_60_16 + var_60_26 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_16) / var_60_26

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_16 + var_60_26 and arg_57_1.time_ < var_60_16 + var_60_26 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play416091015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 416091015
		arg_61_1.duration_ = 7.27

		local var_61_0 = {
			zh = 5.7,
			ja = 7.266
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play416091016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1033"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps1033 == nil then
				arg_61_1.var_.actorSpriteComps1033 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 0.125

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps1033 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								local var_64_4 = Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor1.r, var_64_3)
								local var_64_5 = Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor1.g, var_64_3)
								local var_64_6 = Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor1.b, var_64_3)

								iter_64_1.color = Color.New(var_64_4, var_64_5, var_64_6)
							else
								local var_64_7 = Mathf.Lerp(iter_64_1.color.r, 1, var_64_3)

								iter_64_1.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps1033 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps1033 = nil
			end

			local var_64_8 = arg_61_1.actors_["10054"]
			local var_64_9 = 0

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps10054 == nil then
				arg_61_1.var_.actorSpriteComps10054 = var_64_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_10 = 0.125

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_10 and not isNil(var_64_8) then
				local var_64_11 = (arg_61_1.time_ - var_64_9) / var_64_10

				if arg_61_1.var_.actorSpriteComps10054 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_64_5 then
							if arg_61_1.isInRecall_ then
								local var_64_12 = Mathf.Lerp(iter_64_5.color.r, arg_61_1.hightColor2.r, var_64_11)
								local var_64_13 = Mathf.Lerp(iter_64_5.color.g, arg_61_1.hightColor2.g, var_64_11)
								local var_64_14 = Mathf.Lerp(iter_64_5.color.b, arg_61_1.hightColor2.b, var_64_11)

								iter_64_5.color = Color.New(var_64_12, var_64_13, var_64_14)
							else
								local var_64_15 = Mathf.Lerp(iter_64_5.color.r, 0.5, var_64_11)

								iter_64_5.color = Color.New(var_64_15, var_64_15, var_64_15)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_9 + var_64_10 and arg_61_1.time_ < var_64_9 + var_64_10 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps10054 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_64_7 then
						if arg_61_1.isInRecall_ then
							iter_64_7.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10054 = nil
			end

			local var_64_16 = 0
			local var_64_17 = 0.625

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_18 = arg_61_1:FormatText(StoryNameCfg[236].name)

				arg_61_1.leftNameTxt_.text = var_64_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_19 = arg_61_1:GetWordFromCfg(416091015)
				local var_64_20 = arg_61_1:FormatText(var_64_19.content)

				arg_61_1.text_.text = var_64_20

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_21 = 25
				local var_64_22 = utf8.len(var_64_20)
				local var_64_23 = var_64_21 <= 0 and var_64_17 or var_64_17 * (var_64_22 / var_64_21)

				if var_64_23 > 0 and var_64_17 < var_64_23 then
					arg_61_1.talkMaxDuration = var_64_23

					if var_64_23 + var_64_16 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_23 + var_64_16
					end
				end

				arg_61_1.text_.text = var_64_20
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091015", "story_v_out_416091.awb") ~= 0 then
					local var_64_24 = manager.audio:GetVoiceLength("story_v_out_416091", "416091015", "story_v_out_416091.awb") / 1000

					if var_64_24 + var_64_16 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_24 + var_64_16
					end

					if var_64_19.prefab_name ~= "" and arg_61_1.actors_[var_64_19.prefab_name] ~= nil then
						local var_64_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_19.prefab_name].transform, "story_v_out_416091", "416091015", "story_v_out_416091.awb")

						arg_61_1:RecordAudio("416091015", var_64_25)
						arg_61_1:RecordAudio("416091015", var_64_25)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_416091", "416091015", "story_v_out_416091.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_416091", "416091015", "story_v_out_416091.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_26 = math.max(var_64_17, arg_61_1.talkMaxDuration)

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_26 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_16) / var_64_26

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_16 + var_64_26 and arg_61_1.time_ < var_64_16 + var_64_26 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play416091016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 416091016
		arg_65_1.duration_ = 3.23

		local var_65_0 = {
			zh = 3.233,
			ja = 3
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play416091017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.3

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[236].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:GetWordFromCfg(416091016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 12
				local var_68_6 = utf8.len(var_68_4)
				local var_68_7 = var_68_5 <= 0 and var_68_1 or var_68_1 * (var_68_6 / var_68_5)

				if var_68_7 > 0 and var_68_1 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091016", "story_v_out_416091.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091016", "story_v_out_416091.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_416091", "416091016", "story_v_out_416091.awb")

						arg_65_1:RecordAudio("416091016", var_68_9)
						arg_65_1:RecordAudio("416091016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_416091", "416091016", "story_v_out_416091.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_416091", "416091016", "story_v_out_416091.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_10 and arg_65_1.time_ < var_68_0 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play416091017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 416091017
		arg_69_1.duration_ = 9

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play416091018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = "STblack"

			if arg_69_1.bgs_[var_72_0] == nil then
				local var_72_1 = Object.Instantiate(arg_69_1.paintGo_)

				var_72_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_72_0)
				var_72_1.name = var_72_0
				var_72_1.transform.parent = arg_69_1.stage_.transform
				var_72_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_[var_72_0] = var_72_1
			end

			local var_72_2 = 2

			if var_72_2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				local var_72_3 = manager.ui.mainCamera.transform.localPosition
				local var_72_4 = Vector3.New(0, 0, 10) + Vector3.New(var_72_3.x, var_72_3.y, 0)
				local var_72_5 = arg_69_1.bgs_.STblack

				var_72_5.transform.localPosition = var_72_4
				var_72_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_6 = var_72_5:GetComponent("SpriteRenderer")

				if var_72_6 and var_72_6.sprite then
					local var_72_7 = (var_72_5.transform.localPosition - var_72_3).z
					local var_72_8 = manager.ui.mainCameraCom_
					local var_72_9 = 2 * var_72_7 * Mathf.Tan(var_72_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_72_10 = var_72_9 * var_72_8.aspect
					local var_72_11 = var_72_6.sprite.bounds.size.x
					local var_72_12 = var_72_6.sprite.bounds.size.y
					local var_72_13 = var_72_10 / var_72_11
					local var_72_14 = var_72_9 / var_72_12
					local var_72_15 = var_72_14 < var_72_13 and var_72_13 or var_72_14

					var_72_5.transform.localScale = Vector3.New(var_72_15, var_72_15, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "STblack" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_16 = 4

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 then
				arg_69_1.allBtn_.enabled = false
			end

			local var_72_17 = 0.3

			if arg_69_1.time_ >= var_72_16 + var_72_17 and arg_69_1.time_ < var_72_16 + var_72_17 + arg_72_0 then
				arg_69_1.allBtn_.enabled = true
			end

			local var_72_18 = 0

			if var_72_18 < arg_69_1.time_ and arg_69_1.time_ <= var_72_18 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_19 = 2

			if var_72_18 <= arg_69_1.time_ and arg_69_1.time_ < var_72_18 + var_72_19 then
				local var_72_20 = (arg_69_1.time_ - var_72_18) / var_72_19
				local var_72_21 = Color.New(0, 0, 0)

				var_72_21.a = Mathf.Lerp(0, 1, var_72_20)
				arg_69_1.mask_.color = var_72_21
			end

			if arg_69_1.time_ >= var_72_18 + var_72_19 and arg_69_1.time_ < var_72_18 + var_72_19 + arg_72_0 then
				local var_72_22 = Color.New(0, 0, 0)

				var_72_22.a = 1
				arg_69_1.mask_.color = var_72_22
			end

			local var_72_23 = 2

			if var_72_23 < arg_69_1.time_ and arg_69_1.time_ <= var_72_23 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_24 = 2

			if var_72_23 <= arg_69_1.time_ and arg_69_1.time_ < var_72_23 + var_72_24 then
				local var_72_25 = (arg_69_1.time_ - var_72_23) / var_72_24
				local var_72_26 = Color.New(0, 0, 0)

				var_72_26.a = Mathf.Lerp(1, 0, var_72_25)
				arg_69_1.mask_.color = var_72_26
			end

			if arg_69_1.time_ >= var_72_23 + var_72_24 and arg_69_1.time_ < var_72_23 + var_72_24 + arg_72_0 then
				local var_72_27 = Color.New(0, 0, 0)
				local var_72_28 = 0

				arg_69_1.mask_.enabled = false
				var_72_27.a = var_72_28
				arg_69_1.mask_.color = var_72_27
			end

			local var_72_29 = arg_69_1.actors_["10054"].transform
			local var_72_30 = 1.966

			if var_72_30 < arg_69_1.time_ and arg_69_1.time_ <= var_72_30 + arg_72_0 then
				arg_69_1.var_.moveOldPos10054 = var_72_29.localPosition
				var_72_29.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10054", 7)

				local var_72_31 = var_72_29.childCount

				for iter_72_2 = 0, var_72_31 - 1 do
					local var_72_32 = var_72_29:GetChild(iter_72_2)

					if var_72_32.name == "" or not string.find(var_72_32.name, "split") then
						var_72_32.gameObject:SetActive(true)
					else
						var_72_32.gameObject:SetActive(false)
					end
				end
			end

			local var_72_33 = 0.001

			if var_72_30 <= arg_69_1.time_ and arg_69_1.time_ < var_72_30 + var_72_33 then
				local var_72_34 = (arg_69_1.time_ - var_72_30) / var_72_33
				local var_72_35 = Vector3.New(0, -2000, 0)

				var_72_29.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10054, var_72_35, var_72_34)
			end

			if arg_69_1.time_ >= var_72_30 + var_72_33 and arg_69_1.time_ < var_72_30 + var_72_33 + arg_72_0 then
				var_72_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_72_36 = arg_69_1.actors_["1033"].transform
			local var_72_37 = 1.966

			if var_72_37 < arg_69_1.time_ and arg_69_1.time_ <= var_72_37 + arg_72_0 then
				arg_69_1.var_.moveOldPos1033 = var_72_36.localPosition
				var_72_36.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1033", 7)

				local var_72_38 = var_72_36.childCount

				for iter_72_3 = 0, var_72_38 - 1 do
					local var_72_39 = var_72_36:GetChild(iter_72_3)

					if var_72_39.name == "" or not string.find(var_72_39.name, "split") then
						var_72_39.gameObject:SetActive(true)
					else
						var_72_39.gameObject:SetActive(false)
					end
				end
			end

			local var_72_40 = 0.001

			if var_72_37 <= arg_69_1.time_ and arg_69_1.time_ < var_72_37 + var_72_40 then
				local var_72_41 = (arg_69_1.time_ - var_72_37) / var_72_40
				local var_72_42 = Vector3.New(0, -2000, 0)

				var_72_36.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1033, var_72_42, var_72_41)
			end

			if arg_69_1.time_ >= var_72_37 + var_72_40 and arg_69_1.time_ < var_72_37 + var_72_40 + arg_72_0 then
				var_72_36.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_72_43 = 1.73333333333333
			local var_72_44 = 1

			if var_72_43 < arg_69_1.time_ and arg_69_1.time_ <= var_72_43 + arg_72_0 then
				local var_72_45 = "play"
				local var_72_46 = "effect"

				arg_69_1:AudioAction(var_72_45, var_72_46, "se_story_138", "se_story_138_footstep", "")
			end

			local var_72_47 = 0
			local var_72_48 = 0.2

			if var_72_47 < arg_69_1.time_ and arg_69_1.time_ <= var_72_47 + arg_72_0 then
				local var_72_49 = "play"
				local var_72_50 = "music"

				arg_69_1:AudioAction(var_72_49, var_72_50, "ui_battle", "ui_battle_stopbgm", "")

				local var_72_51 = ""
				local var_72_52 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_72_52 ~= "" then
					if arg_69_1.bgmTxt_.text ~= var_72_52 and arg_69_1.bgmTxt_.text ~= "" then
						if arg_69_1.bgmTxt2_.text ~= "" then
							arg_69_1.bgmTxt_.text = arg_69_1.bgmTxt2_.text
						end

						arg_69_1.bgmTxt2_.text = var_72_52

						arg_69_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_69_1.bgmTxt_.text = var_72_52
						arg_69_1.bgmTxt2_.text = var_72_52
					end

					if arg_69_1.bgmTimer then
						arg_69_1.bgmTimer:Stop()

						arg_69_1.bgmTimer = nil
					end

					if arg_69_1.settingData.show_music_name == 1 then
						arg_69_1.musicController:SetSelectedState("show")
						arg_69_1.musicAnimator_:Play("open", 0, 0)

						if arg_69_1.settingData.music_time ~= 0 then
							arg_69_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_69_1.settingData.music_time), function()
								if arg_69_1 == nil or isNil(arg_69_1.bgmTxt_) then
									return
								end

								arg_69_1.musicController:SetSelectedState("hide")
								arg_69_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_53 = 4
			local var_72_54 = 1.425

			if var_72_53 < arg_69_1.time_ and arg_69_1.time_ <= var_72_53 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_55 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_55:setOnUpdate(LuaHelper.FloatAction(function(arg_74_0)
					arg_69_1.dialogCg_.alpha = arg_74_0
				end))
				var_72_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_56 = arg_69_1:GetWordFromCfg(416091017)
				local var_72_57 = arg_69_1:FormatText(var_72_56.content)

				arg_69_1.text_.text = var_72_57

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_58 = 57
				local var_72_59 = utf8.len(var_72_57)
				local var_72_60 = var_72_58 <= 0 and var_72_54 or var_72_54 * (var_72_59 / var_72_58)

				if var_72_60 > 0 and var_72_54 < var_72_60 then
					arg_69_1.talkMaxDuration = var_72_60
					var_72_53 = var_72_53 + 0.3

					if var_72_60 + var_72_53 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_60 + var_72_53
					end
				end

				arg_69_1.text_.text = var_72_57
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_61 = var_72_53 + 0.3
			local var_72_62 = math.max(var_72_54, arg_69_1.talkMaxDuration)

			if var_72_61 <= arg_69_1.time_ and arg_69_1.time_ < var_72_61 + var_72_62 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_61) / var_72_62

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_61 + var_72_62 and arg_69_1.time_ < var_72_61 + var_72_62 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play416091018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 416091018
		arg_76_1.duration_ = 4.47

		local var_76_0 = {
			zh = 4.466,
			ja = 3.7
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play416091019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = "1148"

			if arg_76_1.actors_[var_79_0] == nil then
				local var_79_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1148")

				if not isNil(var_79_1) then
					local var_79_2 = Object.Instantiate(var_79_1, arg_76_1.canvasGo_.transform)

					var_79_2.transform:SetSiblingIndex(1)

					var_79_2.name = var_79_0
					var_79_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_76_1.actors_[var_79_0] = var_79_2

					local var_79_3 = var_79_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_76_1.isInRecall_ then
						for iter_79_0, iter_79_1 in ipairs(var_79_3) do
							iter_79_1.color = arg_76_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_79_4 = arg_76_1.actors_["1148"]
			local var_79_5 = 0

			if var_79_5 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.actorSpriteComps1148 == nil then
				arg_76_1.var_.actorSpriteComps1148 = var_79_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_6 = 0.125

			if var_79_5 <= arg_76_1.time_ and arg_76_1.time_ < var_79_5 + var_79_6 and not isNil(var_79_4) then
				local var_79_7 = (arg_76_1.time_ - var_79_5) / var_79_6

				if arg_76_1.var_.actorSpriteComps1148 then
					for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_79_3 then
							if arg_76_1.isInRecall_ then
								local var_79_8 = Mathf.Lerp(iter_79_3.color.r, arg_76_1.hightColor1.r, var_79_7)
								local var_79_9 = Mathf.Lerp(iter_79_3.color.g, arg_76_1.hightColor1.g, var_79_7)
								local var_79_10 = Mathf.Lerp(iter_79_3.color.b, arg_76_1.hightColor1.b, var_79_7)

								iter_79_3.color = Color.New(var_79_8, var_79_9, var_79_10)
							else
								local var_79_11 = Mathf.Lerp(iter_79_3.color.r, 1, var_79_7)

								iter_79_3.color = Color.New(var_79_11, var_79_11, var_79_11)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= var_79_5 + var_79_6 and arg_76_1.time_ < var_79_5 + var_79_6 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.actorSpriteComps1148 then
				for iter_79_4, iter_79_5 in pairs(arg_76_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_79_5 then
						if arg_76_1.isInRecall_ then
							iter_79_5.color = arg_76_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_79_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps1148 = nil
			end

			local var_79_12 = arg_76_1.actors_["1148"].transform
			local var_79_13 = 0

			if var_79_13 < arg_76_1.time_ and arg_76_1.time_ <= var_79_13 + arg_79_0 then
				arg_76_1.var_.moveOldPos1148 = var_79_12.localPosition
				var_79_12.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("1148", 3)

				local var_79_14 = var_79_12.childCount

				for iter_79_6 = 0, var_79_14 - 1 do
					local var_79_15 = var_79_12:GetChild(iter_79_6)

					if var_79_15.name == "" or not string.find(var_79_15.name, "split") then
						var_79_15.gameObject:SetActive(true)
					else
						var_79_15.gameObject:SetActive(false)
					end
				end
			end

			local var_79_16 = 0.001

			if var_79_13 <= arg_76_1.time_ and arg_76_1.time_ < var_79_13 + var_79_16 then
				local var_79_17 = (arg_76_1.time_ - var_79_13) / var_79_16
				local var_79_18 = Vector3.New(0, -429, -180)

				var_79_12.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1148, var_79_18, var_79_17)
			end

			if arg_76_1.time_ >= var_79_13 + var_79_16 and arg_76_1.time_ < var_79_13 + var_79_16 + arg_79_0 then
				var_79_12.localPosition = Vector3.New(0, -429, -180)
			end

			local var_79_19 = 0
			local var_79_20 = 1

			if var_79_19 < arg_76_1.time_ and arg_76_1.time_ <= var_79_19 + arg_79_0 then
				local var_79_21 = "play"
				local var_79_22 = "effect"

				arg_76_1:AudioAction(var_79_21, var_79_22, "se_story_138", "se_story_138_footstep", "")
			end

			local var_79_23 = 0
			local var_79_24 = 0.375

			if var_79_23 < arg_76_1.time_ and arg_76_1.time_ <= var_79_23 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_25 = arg_76_1:FormatText(StoryNameCfg[8].name)

				arg_76_1.leftNameTxt_.text = var_79_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_26 = arg_76_1:GetWordFromCfg(416091018)
				local var_79_27 = arg_76_1:FormatText(var_79_26.content)

				arg_76_1.text_.text = var_79_27

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_28 = 15
				local var_79_29 = utf8.len(var_79_27)
				local var_79_30 = var_79_28 <= 0 and var_79_24 or var_79_24 * (var_79_29 / var_79_28)

				if var_79_30 > 0 and var_79_24 < var_79_30 then
					arg_76_1.talkMaxDuration = var_79_30

					if var_79_30 + var_79_23 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_30 + var_79_23
					end
				end

				arg_76_1.text_.text = var_79_27
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091018", "story_v_out_416091.awb") ~= 0 then
					local var_79_31 = manager.audio:GetVoiceLength("story_v_out_416091", "416091018", "story_v_out_416091.awb") / 1000

					if var_79_31 + var_79_23 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_31 + var_79_23
					end

					if var_79_26.prefab_name ~= "" and arg_76_1.actors_[var_79_26.prefab_name] ~= nil then
						local var_79_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_26.prefab_name].transform, "story_v_out_416091", "416091018", "story_v_out_416091.awb")

						arg_76_1:RecordAudio("416091018", var_79_32)
						arg_76_1:RecordAudio("416091018", var_79_32)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_416091", "416091018", "story_v_out_416091.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_416091", "416091018", "story_v_out_416091.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_33 = math.max(var_79_24, arg_76_1.talkMaxDuration)

			if var_79_23 <= arg_76_1.time_ and arg_76_1.time_ < var_79_23 + var_79_33 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_23) / var_79_33

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_23 + var_79_33 and arg_76_1.time_ < var_79_23 + var_79_33 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play416091019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 416091019
		arg_80_1.duration_ = 3

		local var_80_0 = {
			zh = 1.9,
			ja = 3
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play416091020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0.225
			local var_83_1 = 0.775

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				local var_83_2 = "play"
				local var_83_3 = "effect"

				arg_80_1:AudioAction(var_83_2, var_83_3, "se_story_138", "se_story_138_footstep", "")
			end

			local var_83_4 = 0
			local var_83_5 = 0.225

			if var_83_4 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_6 = arg_80_1:FormatText(StoryNameCfg[8].name)

				arg_80_1.leftNameTxt_.text = var_83_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_7 = arg_80_1:GetWordFromCfg(416091019)
				local var_83_8 = arg_80_1:FormatText(var_83_7.content)

				arg_80_1.text_.text = var_83_8

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_9 = 9
				local var_83_10 = utf8.len(var_83_8)
				local var_83_11 = var_83_9 <= 0 and var_83_5 or var_83_5 * (var_83_10 / var_83_9)

				if var_83_11 > 0 and var_83_5 < var_83_11 then
					arg_80_1.talkMaxDuration = var_83_11

					if var_83_11 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_11 + var_83_4
					end
				end

				arg_80_1.text_.text = var_83_8
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091019", "story_v_out_416091.awb") ~= 0 then
					local var_83_12 = manager.audio:GetVoiceLength("story_v_out_416091", "416091019", "story_v_out_416091.awb") / 1000

					if var_83_12 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_12 + var_83_4
					end

					if var_83_7.prefab_name ~= "" and arg_80_1.actors_[var_83_7.prefab_name] ~= nil then
						local var_83_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_7.prefab_name].transform, "story_v_out_416091", "416091019", "story_v_out_416091.awb")

						arg_80_1:RecordAudio("416091019", var_83_13)
						arg_80_1:RecordAudio("416091019", var_83_13)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_416091", "416091019", "story_v_out_416091.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_416091", "416091019", "story_v_out_416091.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_14 = math.max(var_83_5, arg_80_1.talkMaxDuration)

			if var_83_4 <= arg_80_1.time_ and arg_80_1.time_ < var_83_4 + var_83_14 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_4) / var_83_14

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_4 + var_83_14 and arg_80_1.time_ < var_83_4 + var_83_14 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play416091020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 416091020
		arg_84_1.duration_ = 5.87

		local var_84_0 = {
			zh = 3.266,
			ja = 5.866
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play416091021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1148"].transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos1148 = var_87_0.localPosition
				var_87_0.localScale = Vector3.New(1, 1, 1)

				arg_84_1:CheckSpriteTmpPos("1148", 2)

				local var_87_2 = var_87_0.childCount

				for iter_87_0 = 0, var_87_2 - 1 do
					local var_87_3 = var_87_0:GetChild(iter_87_0)

					if var_87_3.name == "" or not string.find(var_87_3.name, "split") then
						var_87_3.gameObject:SetActive(true)
					else
						var_87_3.gameObject:SetActive(false)
					end
				end
			end

			local var_87_4 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_4 then
				local var_87_5 = (arg_84_1.time_ - var_87_1) / var_87_4
				local var_87_6 = Vector3.New(-390, -429, -180)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1148, var_87_6, var_87_5)
			end

			if arg_84_1.time_ >= var_87_1 + var_87_4 and arg_84_1.time_ < var_87_1 + var_87_4 + arg_87_0 then
				var_87_0.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_87_7 = arg_84_1.actors_["1148"]
			local var_87_8 = 0

			if var_87_8 < arg_84_1.time_ and arg_84_1.time_ <= var_87_8 + arg_87_0 and not isNil(var_87_7) and arg_84_1.var_.actorSpriteComps1148 == nil then
				arg_84_1.var_.actorSpriteComps1148 = var_87_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_9 = 0.125

			if var_87_8 <= arg_84_1.time_ and arg_84_1.time_ < var_87_8 + var_87_9 and not isNil(var_87_7) then
				local var_87_10 = (arg_84_1.time_ - var_87_8) / var_87_9

				if arg_84_1.var_.actorSpriteComps1148 then
					for iter_87_1, iter_87_2 in pairs(arg_84_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_87_2 then
							if arg_84_1.isInRecall_ then
								local var_87_11 = Mathf.Lerp(iter_87_2.color.r, arg_84_1.hightColor2.r, var_87_10)
								local var_87_12 = Mathf.Lerp(iter_87_2.color.g, arg_84_1.hightColor2.g, var_87_10)
								local var_87_13 = Mathf.Lerp(iter_87_2.color.b, arg_84_1.hightColor2.b, var_87_10)

								iter_87_2.color = Color.New(var_87_11, var_87_12, var_87_13)
							else
								local var_87_14 = Mathf.Lerp(iter_87_2.color.r, 0.5, var_87_10)

								iter_87_2.color = Color.New(var_87_14, var_87_14, var_87_14)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= var_87_8 + var_87_9 and arg_84_1.time_ < var_87_8 + var_87_9 + arg_87_0 and not isNil(var_87_7) and arg_84_1.var_.actorSpriteComps1148 then
				for iter_87_3, iter_87_4 in pairs(arg_84_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_87_4 then
						if arg_84_1.isInRecall_ then
							iter_87_4.color = arg_84_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_87_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_84_1.var_.actorSpriteComps1148 = nil
			end

			local var_87_15 = "10108"

			if arg_84_1.actors_[var_87_15] == nil then
				local var_87_16 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10108")

				if not isNil(var_87_16) then
					local var_87_17 = Object.Instantiate(var_87_16, arg_84_1.canvasGo_.transform)

					var_87_17.transform:SetSiblingIndex(1)

					var_87_17.name = var_87_15
					var_87_17.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_84_1.actors_[var_87_15] = var_87_17

					local var_87_18 = var_87_17:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_84_1.isInRecall_ then
						for iter_87_5, iter_87_6 in ipairs(var_87_18) do
							iter_87_6.color = arg_84_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_87_19 = arg_84_1.actors_["10108"]
			local var_87_20 = 0

			if var_87_20 < arg_84_1.time_ and arg_84_1.time_ <= var_87_20 + arg_87_0 and not isNil(var_87_19) and arg_84_1.var_.actorSpriteComps10108 == nil then
				arg_84_1.var_.actorSpriteComps10108 = var_87_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_21 = 0.125

			if var_87_20 <= arg_84_1.time_ and arg_84_1.time_ < var_87_20 + var_87_21 and not isNil(var_87_19) then
				local var_87_22 = (arg_84_1.time_ - var_87_20) / var_87_21

				if arg_84_1.var_.actorSpriteComps10108 then
					for iter_87_7, iter_87_8 in pairs(arg_84_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_87_8 then
							if arg_84_1.isInRecall_ then
								local var_87_23 = Mathf.Lerp(iter_87_8.color.r, arg_84_1.hightColor1.r, var_87_22)
								local var_87_24 = Mathf.Lerp(iter_87_8.color.g, arg_84_1.hightColor1.g, var_87_22)
								local var_87_25 = Mathf.Lerp(iter_87_8.color.b, arg_84_1.hightColor1.b, var_87_22)

								iter_87_8.color = Color.New(var_87_23, var_87_24, var_87_25)
							else
								local var_87_26 = Mathf.Lerp(iter_87_8.color.r, 1, var_87_22)

								iter_87_8.color = Color.New(var_87_26, var_87_26, var_87_26)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= var_87_20 + var_87_21 and arg_84_1.time_ < var_87_20 + var_87_21 + arg_87_0 and not isNil(var_87_19) and arg_84_1.var_.actorSpriteComps10108 then
				for iter_87_9, iter_87_10 in pairs(arg_84_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_87_10 then
						if arg_84_1.isInRecall_ then
							iter_87_10.color = arg_84_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_87_10.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_84_1.var_.actorSpriteComps10108 = nil
			end

			local var_87_27 = arg_84_1.actors_["10108"].transform
			local var_87_28 = 0

			if var_87_28 < arg_84_1.time_ and arg_84_1.time_ <= var_87_28 + arg_87_0 then
				arg_84_1.var_.moveOldPos10108 = var_87_27.localPosition
				var_87_27.localScale = Vector3.New(1, 1, 1)

				arg_84_1:CheckSpriteTmpPos("10108", 4)

				local var_87_29 = var_87_27.childCount

				for iter_87_11 = 0, var_87_29 - 1 do
					local var_87_30 = var_87_27:GetChild(iter_87_11)

					if var_87_30.name == "" or not string.find(var_87_30.name, "split") then
						var_87_30.gameObject:SetActive(true)
					else
						var_87_30.gameObject:SetActive(false)
					end
				end
			end

			local var_87_31 = 0.001

			if var_87_28 <= arg_84_1.time_ and arg_84_1.time_ < var_87_28 + var_87_31 then
				local var_87_32 = (arg_84_1.time_ - var_87_28) / var_87_31
				local var_87_33 = Vector3.New(390, -399.6, -130)

				var_87_27.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos10108, var_87_33, var_87_32)
			end

			if arg_84_1.time_ >= var_87_28 + var_87_31 and arg_84_1.time_ < var_87_28 + var_87_31 + arg_87_0 then
				var_87_27.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_87_34 = 0
			local var_87_35 = 0.275

			if var_87_34 < arg_84_1.time_ and arg_84_1.time_ <= var_87_34 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_36 = arg_84_1:FormatText(StoryNameCfg[1083].name)

				arg_84_1.leftNameTxt_.text = var_87_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_37 = arg_84_1:GetWordFromCfg(416091020)
				local var_87_38 = arg_84_1:FormatText(var_87_37.content)

				arg_84_1.text_.text = var_87_38

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_39 = 11
				local var_87_40 = utf8.len(var_87_38)
				local var_87_41 = var_87_39 <= 0 and var_87_35 or var_87_35 * (var_87_40 / var_87_39)

				if var_87_41 > 0 and var_87_35 < var_87_41 then
					arg_84_1.talkMaxDuration = var_87_41

					if var_87_41 + var_87_34 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_41 + var_87_34
					end
				end

				arg_84_1.text_.text = var_87_38
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091020", "story_v_out_416091.awb") ~= 0 then
					local var_87_42 = manager.audio:GetVoiceLength("story_v_out_416091", "416091020", "story_v_out_416091.awb") / 1000

					if var_87_42 + var_87_34 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_42 + var_87_34
					end

					if var_87_37.prefab_name ~= "" and arg_84_1.actors_[var_87_37.prefab_name] ~= nil then
						local var_87_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_37.prefab_name].transform, "story_v_out_416091", "416091020", "story_v_out_416091.awb")

						arg_84_1:RecordAudio("416091020", var_87_43)
						arg_84_1:RecordAudio("416091020", var_87_43)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_416091", "416091020", "story_v_out_416091.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_416091", "416091020", "story_v_out_416091.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_44 = math.max(var_87_35, arg_84_1.talkMaxDuration)

			if var_87_34 <= arg_84_1.time_ and arg_84_1.time_ < var_87_34 + var_87_44 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_34) / var_87_44

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_34 + var_87_44 and arg_84_1.time_ < var_87_34 + var_87_44 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play416091021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 416091021
		arg_88_1.duration_ = 4.47

		local var_88_0 = {
			zh = 3.733,
			ja = 4.466
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play416091022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1148"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.actorSpriteComps1148 == nil then
				arg_88_1.var_.actorSpriteComps1148 = var_91_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_2 = 0.125

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.actorSpriteComps1148 then
					for iter_91_0, iter_91_1 in pairs(arg_88_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_91_1 then
							if arg_88_1.isInRecall_ then
								local var_91_4 = Mathf.Lerp(iter_91_1.color.r, arg_88_1.hightColor1.r, var_91_3)
								local var_91_5 = Mathf.Lerp(iter_91_1.color.g, arg_88_1.hightColor1.g, var_91_3)
								local var_91_6 = Mathf.Lerp(iter_91_1.color.b, arg_88_1.hightColor1.b, var_91_3)

								iter_91_1.color = Color.New(var_91_4, var_91_5, var_91_6)
							else
								local var_91_7 = Mathf.Lerp(iter_91_1.color.r, 1, var_91_3)

								iter_91_1.color = Color.New(var_91_7, var_91_7, var_91_7)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.actorSpriteComps1148 then
				for iter_91_2, iter_91_3 in pairs(arg_88_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_91_3 then
						if arg_88_1.isInRecall_ then
							iter_91_3.color = arg_88_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_91_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_88_1.var_.actorSpriteComps1148 = nil
			end

			local var_91_8 = arg_88_1.actors_["10108"]
			local var_91_9 = 0

			if var_91_9 < arg_88_1.time_ and arg_88_1.time_ <= var_91_9 + arg_91_0 and not isNil(var_91_8) and arg_88_1.var_.actorSpriteComps10108 == nil then
				arg_88_1.var_.actorSpriteComps10108 = var_91_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_10 = 0.125

			if var_91_9 <= arg_88_1.time_ and arg_88_1.time_ < var_91_9 + var_91_10 and not isNil(var_91_8) then
				local var_91_11 = (arg_88_1.time_ - var_91_9) / var_91_10

				if arg_88_1.var_.actorSpriteComps10108 then
					for iter_91_4, iter_91_5 in pairs(arg_88_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_91_5 then
							if arg_88_1.isInRecall_ then
								local var_91_12 = Mathf.Lerp(iter_91_5.color.r, arg_88_1.hightColor2.r, var_91_11)
								local var_91_13 = Mathf.Lerp(iter_91_5.color.g, arg_88_1.hightColor2.g, var_91_11)
								local var_91_14 = Mathf.Lerp(iter_91_5.color.b, arg_88_1.hightColor2.b, var_91_11)

								iter_91_5.color = Color.New(var_91_12, var_91_13, var_91_14)
							else
								local var_91_15 = Mathf.Lerp(iter_91_5.color.r, 0.5, var_91_11)

								iter_91_5.color = Color.New(var_91_15, var_91_15, var_91_15)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= var_91_9 + var_91_10 and arg_88_1.time_ < var_91_9 + var_91_10 + arg_91_0 and not isNil(var_91_8) and arg_88_1.var_.actorSpriteComps10108 then
				for iter_91_6, iter_91_7 in pairs(arg_88_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_91_7 then
						if arg_88_1.isInRecall_ then
							iter_91_7.color = arg_88_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_91_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_88_1.var_.actorSpriteComps10108 = nil
			end

			local var_91_16 = 0
			local var_91_17 = 0.4

			if var_91_16 < arg_88_1.time_ and arg_88_1.time_ <= var_91_16 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_18 = arg_88_1:FormatText(StoryNameCfg[8].name)

				arg_88_1.leftNameTxt_.text = var_91_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_19 = arg_88_1:GetWordFromCfg(416091021)
				local var_91_20 = arg_88_1:FormatText(var_91_19.content)

				arg_88_1.text_.text = var_91_20

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_21 = 16
				local var_91_22 = utf8.len(var_91_20)
				local var_91_23 = var_91_21 <= 0 and var_91_17 or var_91_17 * (var_91_22 / var_91_21)

				if var_91_23 > 0 and var_91_17 < var_91_23 then
					arg_88_1.talkMaxDuration = var_91_23

					if var_91_23 + var_91_16 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_23 + var_91_16
					end
				end

				arg_88_1.text_.text = var_91_20
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091021", "story_v_out_416091.awb") ~= 0 then
					local var_91_24 = manager.audio:GetVoiceLength("story_v_out_416091", "416091021", "story_v_out_416091.awb") / 1000

					if var_91_24 + var_91_16 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_24 + var_91_16
					end

					if var_91_19.prefab_name ~= "" and arg_88_1.actors_[var_91_19.prefab_name] ~= nil then
						local var_91_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_19.prefab_name].transform, "story_v_out_416091", "416091021", "story_v_out_416091.awb")

						arg_88_1:RecordAudio("416091021", var_91_25)
						arg_88_1:RecordAudio("416091021", var_91_25)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_416091", "416091021", "story_v_out_416091.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_416091", "416091021", "story_v_out_416091.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_26 = math.max(var_91_17, arg_88_1.talkMaxDuration)

			if var_91_16 <= arg_88_1.time_ and arg_88_1.time_ < var_91_16 + var_91_26 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_16) / var_91_26

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_16 + var_91_26 and arg_88_1.time_ < var_91_16 + var_91_26 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play416091022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 416091022
		arg_92_1.duration_ = 9.17

		local var_92_0 = {
			zh = 9.166,
			ja = 8.666
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play416091023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 4

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.allBtn_.enabled = false
			end

			local var_95_1 = 0.3

			if arg_92_1.time_ >= var_95_0 + var_95_1 and arg_92_1.time_ < var_95_0 + var_95_1 + arg_95_0 then
				arg_92_1.allBtn_.enabled = true
			end

			local var_95_2 = "ST0106"

			if arg_92_1.bgs_[var_95_2] == nil then
				local var_95_3 = Object.Instantiate(arg_92_1.paintGo_)

				var_95_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_95_2)
				var_95_3.name = var_95_2
				var_95_3.transform.parent = arg_92_1.stage_.transform
				var_95_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.bgs_[var_95_2] = var_95_3
			end

			local var_95_4 = 2

			if var_95_4 < arg_92_1.time_ and arg_92_1.time_ <= var_95_4 + arg_95_0 then
				local var_95_5 = manager.ui.mainCamera.transform.localPosition
				local var_95_6 = Vector3.New(0, 0, 10) + Vector3.New(var_95_5.x, var_95_5.y, 0)
				local var_95_7 = arg_92_1.bgs_.ST0106

				var_95_7.transform.localPosition = var_95_6
				var_95_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_95_8 = var_95_7:GetComponent("SpriteRenderer")

				if var_95_8 and var_95_8.sprite then
					local var_95_9 = (var_95_7.transform.localPosition - var_95_5).z
					local var_95_10 = manager.ui.mainCameraCom_
					local var_95_11 = 2 * var_95_9 * Mathf.Tan(var_95_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_95_12 = var_95_11 * var_95_10.aspect
					local var_95_13 = var_95_8.sprite.bounds.size.x
					local var_95_14 = var_95_8.sprite.bounds.size.y
					local var_95_15 = var_95_12 / var_95_13
					local var_95_16 = var_95_11 / var_95_14
					local var_95_17 = var_95_16 < var_95_15 and var_95_15 or var_95_16

					var_95_7.transform.localScale = Vector3.New(var_95_17, var_95_17, 0)
				end

				for iter_95_0, iter_95_1 in pairs(arg_92_1.bgs_) do
					if iter_95_0 ~= "ST0106" then
						iter_95_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_95_18 = 0

			if var_95_18 < arg_92_1.time_ and arg_92_1.time_ <= var_95_18 + arg_95_0 then
				arg_92_1.mask_.enabled = true
				arg_92_1.mask_.raycastTarget = true

				arg_92_1:SetGaussion(false)
			end

			local var_95_19 = 2

			if var_95_18 <= arg_92_1.time_ and arg_92_1.time_ < var_95_18 + var_95_19 then
				local var_95_20 = (arg_92_1.time_ - var_95_18) / var_95_19
				local var_95_21 = Color.New(0, 0, 0)

				var_95_21.a = Mathf.Lerp(0, 1, var_95_20)
				arg_92_1.mask_.color = var_95_21
			end

			if arg_92_1.time_ >= var_95_18 + var_95_19 and arg_92_1.time_ < var_95_18 + var_95_19 + arg_95_0 then
				local var_95_22 = Color.New(0, 0, 0)

				var_95_22.a = 1
				arg_92_1.mask_.color = var_95_22
			end

			local var_95_23 = 2

			if var_95_23 < arg_92_1.time_ and arg_92_1.time_ <= var_95_23 + arg_95_0 then
				arg_92_1.mask_.enabled = true
				arg_92_1.mask_.raycastTarget = true

				arg_92_1:SetGaussion(false)
			end

			local var_95_24 = 2

			if var_95_23 <= arg_92_1.time_ and arg_92_1.time_ < var_95_23 + var_95_24 then
				local var_95_25 = (arg_92_1.time_ - var_95_23) / var_95_24
				local var_95_26 = Color.New(0, 0, 0)

				var_95_26.a = Mathf.Lerp(1, 0, var_95_25)
				arg_92_1.mask_.color = var_95_26
			end

			if arg_92_1.time_ >= var_95_23 + var_95_24 and arg_92_1.time_ < var_95_23 + var_95_24 + arg_95_0 then
				local var_95_27 = Color.New(0, 0, 0)
				local var_95_28 = 0

				arg_92_1.mask_.enabled = false
				var_95_27.a = var_95_28
				arg_92_1.mask_.color = var_95_27
			end

			local var_95_29 = arg_92_1.actors_["1148"].transform
			local var_95_30 = 1.966

			if var_95_30 < arg_92_1.time_ and arg_92_1.time_ <= var_95_30 + arg_95_0 then
				arg_92_1.var_.moveOldPos1148 = var_95_29.localPosition
				var_95_29.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("1148", 7)

				local var_95_31 = var_95_29.childCount

				for iter_95_2 = 0, var_95_31 - 1 do
					local var_95_32 = var_95_29:GetChild(iter_95_2)

					if var_95_32.name == "" or not string.find(var_95_32.name, "split") then
						var_95_32.gameObject:SetActive(true)
					else
						var_95_32.gameObject:SetActive(false)
					end
				end
			end

			local var_95_33 = 0.001

			if var_95_30 <= arg_92_1.time_ and arg_92_1.time_ < var_95_30 + var_95_33 then
				local var_95_34 = (arg_92_1.time_ - var_95_30) / var_95_33
				local var_95_35 = Vector3.New(0, -2000, 0)

				var_95_29.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1148, var_95_35, var_95_34)
			end

			if arg_92_1.time_ >= var_95_30 + var_95_33 and arg_92_1.time_ < var_95_30 + var_95_33 + arg_95_0 then
				var_95_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_95_36 = arg_92_1.actors_["10108"].transform
			local var_95_37 = 1.966

			if var_95_37 < arg_92_1.time_ and arg_92_1.time_ <= var_95_37 + arg_95_0 then
				arg_92_1.var_.moveOldPos10108 = var_95_36.localPosition
				var_95_36.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("10108", 7)

				local var_95_38 = var_95_36.childCount

				for iter_95_3 = 0, var_95_38 - 1 do
					local var_95_39 = var_95_36:GetChild(iter_95_3)

					if var_95_39.name == "" or not string.find(var_95_39.name, "split") then
						var_95_39.gameObject:SetActive(true)
					else
						var_95_39.gameObject:SetActive(false)
					end
				end
			end

			local var_95_40 = 0.001

			if var_95_37 <= arg_92_1.time_ and arg_92_1.time_ < var_95_37 + var_95_40 then
				local var_95_41 = (arg_92_1.time_ - var_95_37) / var_95_40
				local var_95_42 = Vector3.New(0, -2000, 0)

				var_95_36.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10108, var_95_42, var_95_41)
			end

			if arg_92_1.time_ >= var_95_37 + var_95_40 and arg_92_1.time_ < var_95_37 + var_95_40 + arg_95_0 then
				var_95_36.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_95_43 = arg_92_1.actors_["1148"]
			local var_95_44 = 3.96666666666667

			if var_95_44 < arg_92_1.time_ and arg_92_1.time_ <= var_95_44 + arg_95_0 and not isNil(var_95_43) and arg_92_1.var_.actorSpriteComps1148 == nil then
				arg_92_1.var_.actorSpriteComps1148 = var_95_43:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_45 = 0.125

			if var_95_44 <= arg_92_1.time_ and arg_92_1.time_ < var_95_44 + var_95_45 and not isNil(var_95_43) then
				local var_95_46 = (arg_92_1.time_ - var_95_44) / var_95_45

				if arg_92_1.var_.actorSpriteComps1148 then
					for iter_95_4, iter_95_5 in pairs(arg_92_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_95_5 then
							if arg_92_1.isInRecall_ then
								local var_95_47 = Mathf.Lerp(iter_95_5.color.r, arg_92_1.hightColor1.r, var_95_46)
								local var_95_48 = Mathf.Lerp(iter_95_5.color.g, arg_92_1.hightColor1.g, var_95_46)
								local var_95_49 = Mathf.Lerp(iter_95_5.color.b, arg_92_1.hightColor1.b, var_95_46)

								iter_95_5.color = Color.New(var_95_47, var_95_48, var_95_49)
							else
								local var_95_50 = Mathf.Lerp(iter_95_5.color.r, 1, var_95_46)

								iter_95_5.color = Color.New(var_95_50, var_95_50, var_95_50)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= var_95_44 + var_95_45 and arg_92_1.time_ < var_95_44 + var_95_45 + arg_95_0 and not isNil(var_95_43) and arg_92_1.var_.actorSpriteComps1148 then
				for iter_95_6, iter_95_7 in pairs(arg_92_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_95_7 then
						if arg_92_1.isInRecall_ then
							iter_95_7.color = arg_92_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_95_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_92_1.var_.actorSpriteComps1148 = nil
			end

			local var_95_51 = arg_92_1.actors_["1148"].transform
			local var_95_52 = 3.96666666666667

			if var_95_52 < arg_92_1.time_ and arg_92_1.time_ <= var_95_52 + arg_95_0 then
				arg_92_1.var_.moveOldPos1148 = var_95_51.localPosition
				var_95_51.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("1148", 3)

				local var_95_53 = var_95_51.childCount

				for iter_95_8 = 0, var_95_53 - 1 do
					local var_95_54 = var_95_51:GetChild(iter_95_8)

					if var_95_54.name == "" or not string.find(var_95_54.name, "split") then
						var_95_54.gameObject:SetActive(true)
					else
						var_95_54.gameObject:SetActive(false)
					end
				end
			end

			local var_95_55 = 0.001

			if var_95_52 <= arg_92_1.time_ and arg_92_1.time_ < var_95_52 + var_95_55 then
				local var_95_56 = (arg_92_1.time_ - var_95_52) / var_95_55
				local var_95_57 = Vector3.New(0, -429, -180)

				var_95_51.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1148, var_95_57, var_95_56)
			end

			if arg_92_1.time_ >= var_95_52 + var_95_55 and arg_92_1.time_ < var_95_52 + var_95_55 + arg_95_0 then
				var_95_51.localPosition = Vector3.New(0, -429, -180)
			end

			local var_95_58 = 0
			local var_95_59 = 0.2

			if var_95_58 < arg_92_1.time_ and arg_92_1.time_ <= var_95_58 + arg_95_0 then
				local var_95_60 = "play"
				local var_95_61 = "music"

				arg_92_1:AudioAction(var_95_60, var_95_61, "ui_battle", "ui_battle_stopbgm", "")

				local var_95_62 = ""
				local var_95_63 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_95_63 ~= "" then
					if arg_92_1.bgmTxt_.text ~= var_95_63 and arg_92_1.bgmTxt_.text ~= "" then
						if arg_92_1.bgmTxt2_.text ~= "" then
							arg_92_1.bgmTxt_.text = arg_92_1.bgmTxt2_.text
						end

						arg_92_1.bgmTxt2_.text = var_95_63

						arg_92_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_92_1.bgmTxt_.text = var_95_63
						arg_92_1.bgmTxt2_.text = var_95_63
					end

					if arg_92_1.bgmTimer then
						arg_92_1.bgmTimer:Stop()

						arg_92_1.bgmTimer = nil
					end

					if arg_92_1.settingData.show_music_name == 1 then
						arg_92_1.musicController:SetSelectedState("show")
						arg_92_1.musicAnimator_:Play("open", 0, 0)

						if arg_92_1.settingData.music_time ~= 0 then
							arg_92_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_92_1.settingData.music_time), function()
								if arg_92_1 == nil or isNil(arg_92_1.bgmTxt_) then
									return
								end

								arg_92_1.musicController:SetSelectedState("hide")
								arg_92_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_95_64 = 1.23333333333333
			local var_95_65 = 1

			if var_95_64 < arg_92_1.time_ and arg_92_1.time_ <= var_95_64 + arg_95_0 then
				local var_95_66 = "play"
				local var_95_67 = "music"

				arg_92_1:AudioAction(var_95_66, var_95_67, "bgm_activity_3_8_story_tide", "bgm_activity_3_8_story_tide", "bgm_activity_3_8_story_tide.awb")

				local var_95_68 = ""
				local var_95_69 = manager.audio:GetAudioName("bgm_activity_3_8_story_tide", "bgm_activity_3_8_story_tide")

				if var_95_69 ~= "" then
					if arg_92_1.bgmTxt_.text ~= var_95_69 and arg_92_1.bgmTxt_.text ~= "" then
						if arg_92_1.bgmTxt2_.text ~= "" then
							arg_92_1.bgmTxt_.text = arg_92_1.bgmTxt2_.text
						end

						arg_92_1.bgmTxt2_.text = var_95_69

						arg_92_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_92_1.bgmTxt_.text = var_95_69
						arg_92_1.bgmTxt2_.text = var_95_69
					end

					if arg_92_1.bgmTimer then
						arg_92_1.bgmTimer:Stop()

						arg_92_1.bgmTimer = nil
					end

					if arg_92_1.settingData.show_music_name == 1 then
						arg_92_1.musicController:SetSelectedState("show")
						arg_92_1.musicAnimator_:Play("open", 0, 0)

						if arg_92_1.settingData.music_time ~= 0 then
							arg_92_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_92_1.settingData.music_time), function()
								if arg_92_1 == nil or isNil(arg_92_1.bgmTxt_) then
									return
								end

								arg_92_1.musicController:SetSelectedState("hide")
								arg_92_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_92_1.frameCnt_ <= 1 then
				arg_92_1.dialog_:SetActive(false)
			end

			local var_95_70 = 4
			local var_95_71 = 0.525

			if var_95_70 < arg_92_1.time_ and arg_92_1.time_ <= var_95_70 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0

				arg_92_1.dialog_:SetActive(true)

				arg_92_1.dialogCg_.alpha = 0

				local var_95_72 = LeanTween.value(arg_92_1.dialog_, 0, 1, 0.3)

				var_95_72:setOnUpdate(LuaHelper.FloatAction(function(arg_98_0)
					arg_92_1.dialogCg_.alpha = arg_98_0
				end))
				var_95_72:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_92_1.dialog_)
					var_95_72:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_92_1.duration_ = arg_92_1.duration_ + 0.3

				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_73 = arg_92_1:FormatText(StoryNameCfg[8].name)

				arg_92_1.leftNameTxt_.text = var_95_73

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_74 = arg_92_1:GetWordFromCfg(416091022)
				local var_95_75 = arg_92_1:FormatText(var_95_74.content)

				arg_92_1.text_.text = var_95_75

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_76 = 21
				local var_95_77 = utf8.len(var_95_75)
				local var_95_78 = var_95_76 <= 0 and var_95_71 or var_95_71 * (var_95_77 / var_95_76)

				if var_95_78 > 0 and var_95_71 < var_95_78 then
					arg_92_1.talkMaxDuration = var_95_78
					var_95_70 = var_95_70 + 0.3

					if var_95_78 + var_95_70 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_78 + var_95_70
					end
				end

				arg_92_1.text_.text = var_95_75
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091022", "story_v_out_416091.awb") ~= 0 then
					local var_95_79 = manager.audio:GetVoiceLength("story_v_out_416091", "416091022", "story_v_out_416091.awb") / 1000

					if var_95_79 + var_95_70 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_79 + var_95_70
					end

					if var_95_74.prefab_name ~= "" and arg_92_1.actors_[var_95_74.prefab_name] ~= nil then
						local var_95_80 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_74.prefab_name].transform, "story_v_out_416091", "416091022", "story_v_out_416091.awb")

						arg_92_1:RecordAudio("416091022", var_95_80)
						arg_92_1:RecordAudio("416091022", var_95_80)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_416091", "416091022", "story_v_out_416091.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_416091", "416091022", "story_v_out_416091.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_81 = var_95_70 + 0.3
			local var_95_82 = math.max(var_95_71, arg_92_1.talkMaxDuration)

			if var_95_81 <= arg_92_1.time_ and arg_92_1.time_ < var_95_81 + var_95_82 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_81) / var_95_82

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_81 + var_95_82 and arg_92_1.time_ < var_95_81 + var_95_82 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play416091023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 416091023
		arg_100_1.duration_ = 5.57

		local var_100_0 = {
			zh = 4.833,
			ja = 5.566
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play416091024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0
			local var_103_1 = 0.425

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_2 = arg_100_1:FormatText(StoryNameCfg[8].name)

				arg_100_1.leftNameTxt_.text = var_103_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_3 = arg_100_1:GetWordFromCfg(416091023)
				local var_103_4 = arg_100_1:FormatText(var_103_3.content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 17
				local var_103_6 = utf8.len(var_103_4)
				local var_103_7 = var_103_5 <= 0 and var_103_1 or var_103_1 * (var_103_6 / var_103_5)

				if var_103_7 > 0 and var_103_1 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_0
					end
				end

				arg_100_1.text_.text = var_103_4
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091023", "story_v_out_416091.awb") ~= 0 then
					local var_103_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091023", "story_v_out_416091.awb") / 1000

					if var_103_8 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_0
					end

					if var_103_3.prefab_name ~= "" and arg_100_1.actors_[var_103_3.prefab_name] ~= nil then
						local var_103_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_3.prefab_name].transform, "story_v_out_416091", "416091023", "story_v_out_416091.awb")

						arg_100_1:RecordAudio("416091023", var_103_9)
						arg_100_1:RecordAudio("416091023", var_103_9)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_416091", "416091023", "story_v_out_416091.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_416091", "416091023", "story_v_out_416091.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_10 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_10 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_10

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_10 and arg_100_1.time_ < var_103_0 + var_103_10 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play416091024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 416091024
		arg_104_1.duration_ = 6.5

		local var_104_0 = {
			zh = 3.933,
			ja = 6.5
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play416091025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1148"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.actorSpriteComps1148 == nil then
				arg_104_1.var_.actorSpriteComps1148 = var_107_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_2 = 0.125

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.actorSpriteComps1148 then
					for iter_107_0, iter_107_1 in pairs(arg_104_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_107_1 then
							if arg_104_1.isInRecall_ then
								local var_107_4 = Mathf.Lerp(iter_107_1.color.r, arg_104_1.hightColor2.r, var_107_3)
								local var_107_5 = Mathf.Lerp(iter_107_1.color.g, arg_104_1.hightColor2.g, var_107_3)
								local var_107_6 = Mathf.Lerp(iter_107_1.color.b, arg_104_1.hightColor2.b, var_107_3)

								iter_107_1.color = Color.New(var_107_4, var_107_5, var_107_6)
							else
								local var_107_7 = Mathf.Lerp(iter_107_1.color.r, 0.5, var_107_3)

								iter_107_1.color = Color.New(var_107_7, var_107_7, var_107_7)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.actorSpriteComps1148 then
				for iter_107_2, iter_107_3 in pairs(arg_104_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_107_3 then
						if arg_104_1.isInRecall_ then
							iter_107_3.color = arg_104_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_107_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_104_1.var_.actorSpriteComps1148 = nil
			end

			local var_107_8 = arg_104_1.actors_["10108"]
			local var_107_9 = 0

			if var_107_9 < arg_104_1.time_ and arg_104_1.time_ <= var_107_9 + arg_107_0 and not isNil(var_107_8) and arg_104_1.var_.actorSpriteComps10108 == nil then
				arg_104_1.var_.actorSpriteComps10108 = var_107_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_10 = 0.125

			if var_107_9 <= arg_104_1.time_ and arg_104_1.time_ < var_107_9 + var_107_10 and not isNil(var_107_8) then
				local var_107_11 = (arg_104_1.time_ - var_107_9) / var_107_10

				if arg_104_1.var_.actorSpriteComps10108 then
					for iter_107_4, iter_107_5 in pairs(arg_104_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_107_5 then
							if arg_104_1.isInRecall_ then
								local var_107_12 = Mathf.Lerp(iter_107_5.color.r, arg_104_1.hightColor1.r, var_107_11)
								local var_107_13 = Mathf.Lerp(iter_107_5.color.g, arg_104_1.hightColor1.g, var_107_11)
								local var_107_14 = Mathf.Lerp(iter_107_5.color.b, arg_104_1.hightColor1.b, var_107_11)

								iter_107_5.color = Color.New(var_107_12, var_107_13, var_107_14)
							else
								local var_107_15 = Mathf.Lerp(iter_107_5.color.r, 1, var_107_11)

								iter_107_5.color = Color.New(var_107_15, var_107_15, var_107_15)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= var_107_9 + var_107_10 and arg_104_1.time_ < var_107_9 + var_107_10 + arg_107_0 and not isNil(var_107_8) and arg_104_1.var_.actorSpriteComps10108 then
				for iter_107_6, iter_107_7 in pairs(arg_104_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_107_7 then
						if arg_104_1.isInRecall_ then
							iter_107_7.color = arg_104_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_107_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_104_1.var_.actorSpriteComps10108 = nil
			end

			local var_107_16 = arg_104_1.actors_["1148"].transform
			local var_107_17 = 0

			if var_107_17 < arg_104_1.time_ and arg_104_1.time_ <= var_107_17 + arg_107_0 then
				arg_104_1.var_.moveOldPos1148 = var_107_16.localPosition
				var_107_16.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("1148", 2)

				local var_107_18 = var_107_16.childCount

				for iter_107_8 = 0, var_107_18 - 1 do
					local var_107_19 = var_107_16:GetChild(iter_107_8)

					if var_107_19.name == "" or not string.find(var_107_19.name, "split") then
						var_107_19.gameObject:SetActive(true)
					else
						var_107_19.gameObject:SetActive(false)
					end
				end
			end

			local var_107_20 = 0.001

			if var_107_17 <= arg_104_1.time_ and arg_104_1.time_ < var_107_17 + var_107_20 then
				local var_107_21 = (arg_104_1.time_ - var_107_17) / var_107_20
				local var_107_22 = Vector3.New(-390, -429, -180)

				var_107_16.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1148, var_107_22, var_107_21)
			end

			if arg_104_1.time_ >= var_107_17 + var_107_20 and arg_104_1.time_ < var_107_17 + var_107_20 + arg_107_0 then
				var_107_16.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_107_23 = arg_104_1.actors_["10108"].transform
			local var_107_24 = 0

			if var_107_24 < arg_104_1.time_ and arg_104_1.time_ <= var_107_24 + arg_107_0 then
				arg_104_1.var_.moveOldPos10108 = var_107_23.localPosition
				var_107_23.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("10108", 4)

				local var_107_25 = var_107_23.childCount

				for iter_107_9 = 0, var_107_25 - 1 do
					local var_107_26 = var_107_23:GetChild(iter_107_9)

					if var_107_26.name == "" or not string.find(var_107_26.name, "split") then
						var_107_26.gameObject:SetActive(true)
					else
						var_107_26.gameObject:SetActive(false)
					end
				end
			end

			local var_107_27 = 0.001

			if var_107_24 <= arg_104_1.time_ and arg_104_1.time_ < var_107_24 + var_107_27 then
				local var_107_28 = (arg_104_1.time_ - var_107_24) / var_107_27
				local var_107_29 = Vector3.New(390, -399.6, -130)

				var_107_23.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos10108, var_107_29, var_107_28)
			end

			if arg_104_1.time_ >= var_107_24 + var_107_27 and arg_104_1.time_ < var_107_24 + var_107_27 + arg_107_0 then
				var_107_23.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_107_30 = 0
			local var_107_31 = 0.4

			if var_107_30 < arg_104_1.time_ and arg_104_1.time_ <= var_107_30 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_32 = arg_104_1:FormatText(StoryNameCfg[1083].name)

				arg_104_1.leftNameTxt_.text = var_107_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_33 = arg_104_1:GetWordFromCfg(416091024)
				local var_107_34 = arg_104_1:FormatText(var_107_33.content)

				arg_104_1.text_.text = var_107_34

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_35 = 16
				local var_107_36 = utf8.len(var_107_34)
				local var_107_37 = var_107_35 <= 0 and var_107_31 or var_107_31 * (var_107_36 / var_107_35)

				if var_107_37 > 0 and var_107_31 < var_107_37 then
					arg_104_1.talkMaxDuration = var_107_37

					if var_107_37 + var_107_30 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_37 + var_107_30
					end
				end

				arg_104_1.text_.text = var_107_34
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091024", "story_v_out_416091.awb") ~= 0 then
					local var_107_38 = manager.audio:GetVoiceLength("story_v_out_416091", "416091024", "story_v_out_416091.awb") / 1000

					if var_107_38 + var_107_30 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_38 + var_107_30
					end

					if var_107_33.prefab_name ~= "" and arg_104_1.actors_[var_107_33.prefab_name] ~= nil then
						local var_107_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_33.prefab_name].transform, "story_v_out_416091", "416091024", "story_v_out_416091.awb")

						arg_104_1:RecordAudio("416091024", var_107_39)
						arg_104_1:RecordAudio("416091024", var_107_39)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_416091", "416091024", "story_v_out_416091.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_416091", "416091024", "story_v_out_416091.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_40 = math.max(var_107_31, arg_104_1.talkMaxDuration)

			if var_107_30 <= arg_104_1.time_ and arg_104_1.time_ < var_107_30 + var_107_40 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_30) / var_107_40

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_30 + var_107_40 and arg_104_1.time_ < var_107_30 + var_107_40 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play416091025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 416091025
		arg_108_1.duration_ = 4.03

		local var_108_0 = {
			zh = 3.5,
			ja = 4.033
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play416091026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1148"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps1148 == nil then
				arg_108_1.var_.actorSpriteComps1148 = var_111_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_2 = 0.125

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.actorSpriteComps1148 then
					for iter_111_0, iter_111_1 in pairs(arg_108_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_111_1 then
							if arg_108_1.isInRecall_ then
								local var_111_4 = Mathf.Lerp(iter_111_1.color.r, arg_108_1.hightColor1.r, var_111_3)
								local var_111_5 = Mathf.Lerp(iter_111_1.color.g, arg_108_1.hightColor1.g, var_111_3)
								local var_111_6 = Mathf.Lerp(iter_111_1.color.b, arg_108_1.hightColor1.b, var_111_3)

								iter_111_1.color = Color.New(var_111_4, var_111_5, var_111_6)
							else
								local var_111_7 = Mathf.Lerp(iter_111_1.color.r, 1, var_111_3)

								iter_111_1.color = Color.New(var_111_7, var_111_7, var_111_7)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps1148 then
				for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_111_3 then
						if arg_108_1.isInRecall_ then
							iter_111_3.color = arg_108_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_111_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_108_1.var_.actorSpriteComps1148 = nil
			end

			local var_111_8 = arg_108_1.actors_["10108"]
			local var_111_9 = 0

			if var_111_9 < arg_108_1.time_ and arg_108_1.time_ <= var_111_9 + arg_111_0 and not isNil(var_111_8) and arg_108_1.var_.actorSpriteComps10108 == nil then
				arg_108_1.var_.actorSpriteComps10108 = var_111_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_10 = 0.125

			if var_111_9 <= arg_108_1.time_ and arg_108_1.time_ < var_111_9 + var_111_10 and not isNil(var_111_8) then
				local var_111_11 = (arg_108_1.time_ - var_111_9) / var_111_10

				if arg_108_1.var_.actorSpriteComps10108 then
					for iter_111_4, iter_111_5 in pairs(arg_108_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_111_5 then
							if arg_108_1.isInRecall_ then
								local var_111_12 = Mathf.Lerp(iter_111_5.color.r, arg_108_1.hightColor2.r, var_111_11)
								local var_111_13 = Mathf.Lerp(iter_111_5.color.g, arg_108_1.hightColor2.g, var_111_11)
								local var_111_14 = Mathf.Lerp(iter_111_5.color.b, arg_108_1.hightColor2.b, var_111_11)

								iter_111_5.color = Color.New(var_111_12, var_111_13, var_111_14)
							else
								local var_111_15 = Mathf.Lerp(iter_111_5.color.r, 0.5, var_111_11)

								iter_111_5.color = Color.New(var_111_15, var_111_15, var_111_15)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= var_111_9 + var_111_10 and arg_108_1.time_ < var_111_9 + var_111_10 + arg_111_0 and not isNil(var_111_8) and arg_108_1.var_.actorSpriteComps10108 then
				for iter_111_6, iter_111_7 in pairs(arg_108_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_111_7 then
						if arg_108_1.isInRecall_ then
							iter_111_7.color = arg_108_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_111_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_108_1.var_.actorSpriteComps10108 = nil
			end

			local var_111_16 = 0
			local var_111_17 = 0.4

			if var_111_16 < arg_108_1.time_ and arg_108_1.time_ <= var_111_16 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_18 = arg_108_1:FormatText(StoryNameCfg[8].name)

				arg_108_1.leftNameTxt_.text = var_111_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_19 = arg_108_1:GetWordFromCfg(416091025)
				local var_111_20 = arg_108_1:FormatText(var_111_19.content)

				arg_108_1.text_.text = var_111_20

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_21 = 16
				local var_111_22 = utf8.len(var_111_20)
				local var_111_23 = var_111_21 <= 0 and var_111_17 or var_111_17 * (var_111_22 / var_111_21)

				if var_111_23 > 0 and var_111_17 < var_111_23 then
					arg_108_1.talkMaxDuration = var_111_23

					if var_111_23 + var_111_16 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_23 + var_111_16
					end
				end

				arg_108_1.text_.text = var_111_20
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091025", "story_v_out_416091.awb") ~= 0 then
					local var_111_24 = manager.audio:GetVoiceLength("story_v_out_416091", "416091025", "story_v_out_416091.awb") / 1000

					if var_111_24 + var_111_16 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_24 + var_111_16
					end

					if var_111_19.prefab_name ~= "" and arg_108_1.actors_[var_111_19.prefab_name] ~= nil then
						local var_111_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_19.prefab_name].transform, "story_v_out_416091", "416091025", "story_v_out_416091.awb")

						arg_108_1:RecordAudio("416091025", var_111_25)
						arg_108_1:RecordAudio("416091025", var_111_25)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_416091", "416091025", "story_v_out_416091.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_416091", "416091025", "story_v_out_416091.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_26 = math.max(var_111_17, arg_108_1.talkMaxDuration)

			if var_111_16 <= arg_108_1.time_ and arg_108_1.time_ < var_111_16 + var_111_26 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_16) / var_111_26

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_16 + var_111_26 and arg_108_1.time_ < var_111_16 + var_111_26 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play416091026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 416091026
		arg_112_1.duration_ = 7.17

		local var_112_0 = {
			zh = 4.433,
			ja = 7.166
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play416091027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1148"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps1148 == nil then
				arg_112_1.var_.actorSpriteComps1148 = var_115_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_2 = 0.125

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.actorSpriteComps1148 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_115_1 then
							if arg_112_1.isInRecall_ then
								local var_115_4 = Mathf.Lerp(iter_115_1.color.r, arg_112_1.hightColor2.r, var_115_3)
								local var_115_5 = Mathf.Lerp(iter_115_1.color.g, arg_112_1.hightColor2.g, var_115_3)
								local var_115_6 = Mathf.Lerp(iter_115_1.color.b, arg_112_1.hightColor2.b, var_115_3)

								iter_115_1.color = Color.New(var_115_4, var_115_5, var_115_6)
							else
								local var_115_7 = Mathf.Lerp(iter_115_1.color.r, 0.5, var_115_3)

								iter_115_1.color = Color.New(var_115_7, var_115_7, var_115_7)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps1148 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_115_3 then
						if arg_112_1.isInRecall_ then
							iter_115_3.color = arg_112_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_115_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_112_1.var_.actorSpriteComps1148 = nil
			end

			local var_115_8 = arg_112_1.actors_["10108"]
			local var_115_9 = 0

			if var_115_9 < arg_112_1.time_ and arg_112_1.time_ <= var_115_9 + arg_115_0 and not isNil(var_115_8) and arg_112_1.var_.actorSpriteComps10108 == nil then
				arg_112_1.var_.actorSpriteComps10108 = var_115_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_10 = 0.125

			if var_115_9 <= arg_112_1.time_ and arg_112_1.time_ < var_115_9 + var_115_10 and not isNil(var_115_8) then
				local var_115_11 = (arg_112_1.time_ - var_115_9) / var_115_10

				if arg_112_1.var_.actorSpriteComps10108 then
					for iter_115_4, iter_115_5 in pairs(arg_112_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_115_5 then
							if arg_112_1.isInRecall_ then
								local var_115_12 = Mathf.Lerp(iter_115_5.color.r, arg_112_1.hightColor1.r, var_115_11)
								local var_115_13 = Mathf.Lerp(iter_115_5.color.g, arg_112_1.hightColor1.g, var_115_11)
								local var_115_14 = Mathf.Lerp(iter_115_5.color.b, arg_112_1.hightColor1.b, var_115_11)

								iter_115_5.color = Color.New(var_115_12, var_115_13, var_115_14)
							else
								local var_115_15 = Mathf.Lerp(iter_115_5.color.r, 1, var_115_11)

								iter_115_5.color = Color.New(var_115_15, var_115_15, var_115_15)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= var_115_9 + var_115_10 and arg_112_1.time_ < var_115_9 + var_115_10 + arg_115_0 and not isNil(var_115_8) and arg_112_1.var_.actorSpriteComps10108 then
				for iter_115_6, iter_115_7 in pairs(arg_112_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_115_7 then
						if arg_112_1.isInRecall_ then
							iter_115_7.color = arg_112_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_115_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_112_1.var_.actorSpriteComps10108 = nil
			end

			local var_115_16 = 0
			local var_115_17 = 0.425

			if var_115_16 < arg_112_1.time_ and arg_112_1.time_ <= var_115_16 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_18 = arg_112_1:FormatText(StoryNameCfg[1083].name)

				arg_112_1.leftNameTxt_.text = var_115_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_19 = arg_112_1:GetWordFromCfg(416091026)
				local var_115_20 = arg_112_1:FormatText(var_115_19.content)

				arg_112_1.text_.text = var_115_20

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_21 = 17
				local var_115_22 = utf8.len(var_115_20)
				local var_115_23 = var_115_21 <= 0 and var_115_17 or var_115_17 * (var_115_22 / var_115_21)

				if var_115_23 > 0 and var_115_17 < var_115_23 then
					arg_112_1.talkMaxDuration = var_115_23

					if var_115_23 + var_115_16 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_23 + var_115_16
					end
				end

				arg_112_1.text_.text = var_115_20
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091026", "story_v_out_416091.awb") ~= 0 then
					local var_115_24 = manager.audio:GetVoiceLength("story_v_out_416091", "416091026", "story_v_out_416091.awb") / 1000

					if var_115_24 + var_115_16 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_24 + var_115_16
					end

					if var_115_19.prefab_name ~= "" and arg_112_1.actors_[var_115_19.prefab_name] ~= nil then
						local var_115_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_19.prefab_name].transform, "story_v_out_416091", "416091026", "story_v_out_416091.awb")

						arg_112_1:RecordAudio("416091026", var_115_25)
						arg_112_1:RecordAudio("416091026", var_115_25)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_416091", "416091026", "story_v_out_416091.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_416091", "416091026", "story_v_out_416091.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_26 = math.max(var_115_17, arg_112_1.talkMaxDuration)

			if var_115_16 <= arg_112_1.time_ and arg_112_1.time_ < var_115_16 + var_115_26 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_16) / var_115_26

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_16 + var_115_26 and arg_112_1.time_ < var_115_16 + var_115_26 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play416091027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 416091027
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play416091028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["10108"].transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.var_.moveOldPos10108 = var_119_0.localPosition
				var_119_0.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("10108", 7)

				local var_119_2 = var_119_0.childCount

				for iter_119_0 = 0, var_119_2 - 1 do
					local var_119_3 = var_119_0:GetChild(iter_119_0)

					if var_119_3.name == "" or not string.find(var_119_3.name, "split") then
						var_119_3.gameObject:SetActive(true)
					else
						var_119_3.gameObject:SetActive(false)
					end
				end
			end

			local var_119_4 = 0.001

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_4 then
				local var_119_5 = (arg_116_1.time_ - var_119_1) / var_119_4
				local var_119_6 = Vector3.New(0, -2000, 0)

				var_119_0.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos10108, var_119_6, var_119_5)
			end

			if arg_116_1.time_ >= var_119_1 + var_119_4 and arg_116_1.time_ < var_119_1 + var_119_4 + arg_119_0 then
				var_119_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_119_7 = arg_116_1.actors_["1148"].transform
			local var_119_8 = 0

			if var_119_8 < arg_116_1.time_ and arg_116_1.time_ <= var_119_8 + arg_119_0 then
				arg_116_1.var_.moveOldPos1148 = var_119_7.localPosition
				var_119_7.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("1148", 7)

				local var_119_9 = var_119_7.childCount

				for iter_119_1 = 0, var_119_9 - 1 do
					local var_119_10 = var_119_7:GetChild(iter_119_1)

					if var_119_10.name == "" or not string.find(var_119_10.name, "split") then
						var_119_10.gameObject:SetActive(true)
					else
						var_119_10.gameObject:SetActive(false)
					end
				end
			end

			local var_119_11 = 0.001

			if var_119_8 <= arg_116_1.time_ and arg_116_1.time_ < var_119_8 + var_119_11 then
				local var_119_12 = (arg_116_1.time_ - var_119_8) / var_119_11
				local var_119_13 = Vector3.New(0, -2000, 0)

				var_119_7.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1148, var_119_13, var_119_12)
			end

			if arg_116_1.time_ >= var_119_8 + var_119_11 and arg_116_1.time_ < var_119_8 + var_119_11 + arg_119_0 then
				var_119_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_119_14 = 0
			local var_119_15 = 1

			if var_119_14 < arg_116_1.time_ and arg_116_1.time_ <= var_119_14 + arg_119_0 then
				local var_119_16 = "play"
				local var_119_17 = "effect"

				arg_116_1:AudioAction(var_119_16, var_119_17, "se_story_121_04", "se_story_121_04_gunready", "")
			end

			local var_119_18 = 0
			local var_119_19 = 1.3

			if var_119_18 < arg_116_1.time_ and arg_116_1.time_ <= var_119_18 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_20 = arg_116_1:GetWordFromCfg(416091027)
				local var_119_21 = arg_116_1:FormatText(var_119_20.content)

				arg_116_1.text_.text = var_119_21

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_22 = 52
				local var_119_23 = utf8.len(var_119_21)
				local var_119_24 = var_119_22 <= 0 and var_119_19 or var_119_19 * (var_119_23 / var_119_22)

				if var_119_24 > 0 and var_119_19 < var_119_24 then
					arg_116_1.talkMaxDuration = var_119_24

					if var_119_24 + var_119_18 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_24 + var_119_18
					end
				end

				arg_116_1.text_.text = var_119_21
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_25 = math.max(var_119_19, arg_116_1.talkMaxDuration)

			if var_119_18 <= arg_116_1.time_ and arg_116_1.time_ < var_119_18 + var_119_25 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_18) / var_119_25

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_18 + var_119_25 and arg_116_1.time_ < var_119_18 + var_119_25 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play416091028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 416091028
		arg_120_1.duration_ = 8.47

		local var_120_0 = {
			zh = 8.466,
			ja = 8.4
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play416091029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1148"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos1148 = var_123_0.localPosition
				var_123_0.localScale = Vector3.New(1, 1, 1)

				arg_120_1:CheckSpriteTmpPos("1148", 3)

				local var_123_2 = var_123_0.childCount

				for iter_123_0 = 0, var_123_2 - 1 do
					local var_123_3 = var_123_0:GetChild(iter_123_0)

					if var_123_3.name == "split_6" or not string.find(var_123_3.name, "split") then
						var_123_3.gameObject:SetActive(true)
					else
						var_123_3.gameObject:SetActive(false)
					end
				end
			end

			local var_123_4 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_4 then
				local var_123_5 = (arg_120_1.time_ - var_123_1) / var_123_4
				local var_123_6 = Vector3.New(0, -429, -180)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1148, var_123_6, var_123_5)
			end

			if arg_120_1.time_ >= var_123_1 + var_123_4 and arg_120_1.time_ < var_123_1 + var_123_4 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_123_7 = arg_120_1.actors_["1148"]
			local var_123_8 = 0

			if var_123_8 < arg_120_1.time_ and arg_120_1.time_ <= var_123_8 + arg_123_0 and not isNil(var_123_7) and arg_120_1.var_.actorSpriteComps1148 == nil then
				arg_120_1.var_.actorSpriteComps1148 = var_123_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_9 = 0.125

			if var_123_8 <= arg_120_1.time_ and arg_120_1.time_ < var_123_8 + var_123_9 and not isNil(var_123_7) then
				local var_123_10 = (arg_120_1.time_ - var_123_8) / var_123_9

				if arg_120_1.var_.actorSpriteComps1148 then
					for iter_123_1, iter_123_2 in pairs(arg_120_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_123_2 then
							if arg_120_1.isInRecall_ then
								local var_123_11 = Mathf.Lerp(iter_123_2.color.r, arg_120_1.hightColor1.r, var_123_10)
								local var_123_12 = Mathf.Lerp(iter_123_2.color.g, arg_120_1.hightColor1.g, var_123_10)
								local var_123_13 = Mathf.Lerp(iter_123_2.color.b, arg_120_1.hightColor1.b, var_123_10)

								iter_123_2.color = Color.New(var_123_11, var_123_12, var_123_13)
							else
								local var_123_14 = Mathf.Lerp(iter_123_2.color.r, 1, var_123_10)

								iter_123_2.color = Color.New(var_123_14, var_123_14, var_123_14)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= var_123_8 + var_123_9 and arg_120_1.time_ < var_123_8 + var_123_9 + arg_123_0 and not isNil(var_123_7) and arg_120_1.var_.actorSpriteComps1148 then
				for iter_123_3, iter_123_4 in pairs(arg_120_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_123_4 then
						if arg_120_1.isInRecall_ then
							iter_123_4.color = arg_120_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_123_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_120_1.var_.actorSpriteComps1148 = nil
			end

			local var_123_15 = 0
			local var_123_16 = 0.775

			if var_123_15 < arg_120_1.time_ and arg_120_1.time_ <= var_123_15 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_17 = arg_120_1:FormatText(StoryNameCfg[8].name)

				arg_120_1.leftNameTxt_.text = var_123_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_18 = arg_120_1:GetWordFromCfg(416091028)
				local var_123_19 = arg_120_1:FormatText(var_123_18.content)

				arg_120_1.text_.text = var_123_19

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_20 = 31
				local var_123_21 = utf8.len(var_123_19)
				local var_123_22 = var_123_20 <= 0 and var_123_16 or var_123_16 * (var_123_21 / var_123_20)

				if var_123_22 > 0 and var_123_16 < var_123_22 then
					arg_120_1.talkMaxDuration = var_123_22

					if var_123_22 + var_123_15 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_22 + var_123_15
					end
				end

				arg_120_1.text_.text = var_123_19
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091028", "story_v_out_416091.awb") ~= 0 then
					local var_123_23 = manager.audio:GetVoiceLength("story_v_out_416091", "416091028", "story_v_out_416091.awb") / 1000

					if var_123_23 + var_123_15 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_23 + var_123_15
					end

					if var_123_18.prefab_name ~= "" and arg_120_1.actors_[var_123_18.prefab_name] ~= nil then
						local var_123_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_18.prefab_name].transform, "story_v_out_416091", "416091028", "story_v_out_416091.awb")

						arg_120_1:RecordAudio("416091028", var_123_24)
						arg_120_1:RecordAudio("416091028", var_123_24)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_416091", "416091028", "story_v_out_416091.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_416091", "416091028", "story_v_out_416091.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_25 = math.max(var_123_16, arg_120_1.talkMaxDuration)

			if var_123_15 <= arg_120_1.time_ and arg_120_1.time_ < var_123_15 + var_123_25 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_15) / var_123_25

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_15 + var_123_25 and arg_120_1.time_ < var_123_15 + var_123_25 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play416091029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 416091029
		arg_124_1.duration_ = 4.77

		local var_124_0 = {
			zh = 3.866,
			ja = 4.766
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play416091030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.475

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[8].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_3 = arg_124_1:GetWordFromCfg(416091029)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 19
				local var_127_6 = utf8.len(var_127_4)
				local var_127_7 = var_127_5 <= 0 and var_127_1 or var_127_1 * (var_127_6 / var_127_5)

				if var_127_7 > 0 and var_127_1 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091029", "story_v_out_416091.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091029", "story_v_out_416091.awb") / 1000

					if var_127_8 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_0
					end

					if var_127_3.prefab_name ~= "" and arg_124_1.actors_[var_127_3.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_3.prefab_name].transform, "story_v_out_416091", "416091029", "story_v_out_416091.awb")

						arg_124_1:RecordAudio("416091029", var_127_9)
						arg_124_1:RecordAudio("416091029", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_416091", "416091029", "story_v_out_416091.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_416091", "416091029", "story_v_out_416091.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_10 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_10 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_10

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_10 and arg_124_1.time_ < var_127_0 + var_127_10 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play416091030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 416091030
		arg_128_1.duration_ = 8.4

		local var_128_0 = {
			zh = 5.5,
			ja = 8.4
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play416091031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1148"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.actorSpriteComps1148 == nil then
				arg_128_1.var_.actorSpriteComps1148 = var_131_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_2 = 0.125

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.actorSpriteComps1148 then
					for iter_131_0, iter_131_1 in pairs(arg_128_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_131_1 then
							if arg_128_1.isInRecall_ then
								local var_131_4 = Mathf.Lerp(iter_131_1.color.r, arg_128_1.hightColor2.r, var_131_3)
								local var_131_5 = Mathf.Lerp(iter_131_1.color.g, arg_128_1.hightColor2.g, var_131_3)
								local var_131_6 = Mathf.Lerp(iter_131_1.color.b, arg_128_1.hightColor2.b, var_131_3)

								iter_131_1.color = Color.New(var_131_4, var_131_5, var_131_6)
							else
								local var_131_7 = Mathf.Lerp(iter_131_1.color.r, 0.5, var_131_3)

								iter_131_1.color = Color.New(var_131_7, var_131_7, var_131_7)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.actorSpriteComps1148 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_131_3 then
						if arg_128_1.isInRecall_ then
							iter_131_3.color = arg_128_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_131_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_128_1.var_.actorSpriteComps1148 = nil
			end

			local var_131_8 = arg_128_1.actors_["10108"]
			local var_131_9 = 0

			if var_131_9 < arg_128_1.time_ and arg_128_1.time_ <= var_131_9 + arg_131_0 and not isNil(var_131_8) and arg_128_1.var_.actorSpriteComps10108 == nil then
				arg_128_1.var_.actorSpriteComps10108 = var_131_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_10 = 0.125

			if var_131_9 <= arg_128_1.time_ and arg_128_1.time_ < var_131_9 + var_131_10 and not isNil(var_131_8) then
				local var_131_11 = (arg_128_1.time_ - var_131_9) / var_131_10

				if arg_128_1.var_.actorSpriteComps10108 then
					for iter_131_4, iter_131_5 in pairs(arg_128_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_131_5 then
							if arg_128_1.isInRecall_ then
								local var_131_12 = Mathf.Lerp(iter_131_5.color.r, arg_128_1.hightColor1.r, var_131_11)
								local var_131_13 = Mathf.Lerp(iter_131_5.color.g, arg_128_1.hightColor1.g, var_131_11)
								local var_131_14 = Mathf.Lerp(iter_131_5.color.b, arg_128_1.hightColor1.b, var_131_11)

								iter_131_5.color = Color.New(var_131_12, var_131_13, var_131_14)
							else
								local var_131_15 = Mathf.Lerp(iter_131_5.color.r, 1, var_131_11)

								iter_131_5.color = Color.New(var_131_15, var_131_15, var_131_15)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= var_131_9 + var_131_10 and arg_128_1.time_ < var_131_9 + var_131_10 + arg_131_0 and not isNil(var_131_8) and arg_128_1.var_.actorSpriteComps10108 then
				for iter_131_6, iter_131_7 in pairs(arg_128_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_131_7 then
						if arg_128_1.isInRecall_ then
							iter_131_7.color = arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_131_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_128_1.var_.actorSpriteComps10108 = nil
			end

			local var_131_16 = arg_128_1.actors_["1148"].transform
			local var_131_17 = 0

			if var_131_17 < arg_128_1.time_ and arg_128_1.time_ <= var_131_17 + arg_131_0 then
				arg_128_1.var_.moveOldPos1148 = var_131_16.localPosition
				var_131_16.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("1148", 2)

				local var_131_18 = var_131_16.childCount

				for iter_131_8 = 0, var_131_18 - 1 do
					local var_131_19 = var_131_16:GetChild(iter_131_8)

					if var_131_19.name == "" or not string.find(var_131_19.name, "split") then
						var_131_19.gameObject:SetActive(true)
					else
						var_131_19.gameObject:SetActive(false)
					end
				end
			end

			local var_131_20 = 0.001

			if var_131_17 <= arg_128_1.time_ and arg_128_1.time_ < var_131_17 + var_131_20 then
				local var_131_21 = (arg_128_1.time_ - var_131_17) / var_131_20
				local var_131_22 = Vector3.New(-390, -429, -180)

				var_131_16.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1148, var_131_22, var_131_21)
			end

			if arg_128_1.time_ >= var_131_17 + var_131_20 and arg_128_1.time_ < var_131_17 + var_131_20 + arg_131_0 then
				var_131_16.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_131_23 = arg_128_1.actors_["10108"].transform
			local var_131_24 = 0

			if var_131_24 < arg_128_1.time_ and arg_128_1.time_ <= var_131_24 + arg_131_0 then
				arg_128_1.var_.moveOldPos10108 = var_131_23.localPosition
				var_131_23.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("10108", 4)

				local var_131_25 = var_131_23.childCount

				for iter_131_9 = 0, var_131_25 - 1 do
					local var_131_26 = var_131_23:GetChild(iter_131_9)

					if var_131_26.name == "" or not string.find(var_131_26.name, "split") then
						var_131_26.gameObject:SetActive(true)
					else
						var_131_26.gameObject:SetActive(false)
					end
				end
			end

			local var_131_27 = 0.001

			if var_131_24 <= arg_128_1.time_ and arg_128_1.time_ < var_131_24 + var_131_27 then
				local var_131_28 = (arg_128_1.time_ - var_131_24) / var_131_27
				local var_131_29 = Vector3.New(390, -399.6, -130)

				var_131_23.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10108, var_131_29, var_131_28)
			end

			if arg_128_1.time_ >= var_131_24 + var_131_27 and arg_128_1.time_ < var_131_24 + var_131_27 + arg_131_0 then
				var_131_23.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_131_30 = 0
			local var_131_31 = 0.575

			if var_131_30 < arg_128_1.time_ and arg_128_1.time_ <= var_131_30 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_32 = arg_128_1:FormatText(StoryNameCfg[1083].name)

				arg_128_1.leftNameTxt_.text = var_131_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_33 = arg_128_1:GetWordFromCfg(416091030)
				local var_131_34 = arg_128_1:FormatText(var_131_33.content)

				arg_128_1.text_.text = var_131_34

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_35 = 23
				local var_131_36 = utf8.len(var_131_34)
				local var_131_37 = var_131_35 <= 0 and var_131_31 or var_131_31 * (var_131_36 / var_131_35)

				if var_131_37 > 0 and var_131_31 < var_131_37 then
					arg_128_1.talkMaxDuration = var_131_37

					if var_131_37 + var_131_30 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_37 + var_131_30
					end
				end

				arg_128_1.text_.text = var_131_34
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091030", "story_v_out_416091.awb") ~= 0 then
					local var_131_38 = manager.audio:GetVoiceLength("story_v_out_416091", "416091030", "story_v_out_416091.awb") / 1000

					if var_131_38 + var_131_30 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_38 + var_131_30
					end

					if var_131_33.prefab_name ~= "" and arg_128_1.actors_[var_131_33.prefab_name] ~= nil then
						local var_131_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_33.prefab_name].transform, "story_v_out_416091", "416091030", "story_v_out_416091.awb")

						arg_128_1:RecordAudio("416091030", var_131_39)
						arg_128_1:RecordAudio("416091030", var_131_39)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_416091", "416091030", "story_v_out_416091.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_416091", "416091030", "story_v_out_416091.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_40 = math.max(var_131_31, arg_128_1.talkMaxDuration)

			if var_131_30 <= arg_128_1.time_ and arg_128_1.time_ < var_131_30 + var_131_40 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_30) / var_131_40

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_30 + var_131_40 and arg_128_1.time_ < var_131_30 + var_131_40 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play416091031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 416091031
		arg_132_1.duration_ = 4.7

		local var_132_0 = {
			zh = 4.7,
			ja = 3.366
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play416091032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1148"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps1148 == nil then
				arg_132_1.var_.actorSpriteComps1148 = var_135_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_2 = 0.125

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.actorSpriteComps1148 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_135_1 then
							if arg_132_1.isInRecall_ then
								local var_135_4 = Mathf.Lerp(iter_135_1.color.r, arg_132_1.hightColor1.r, var_135_3)
								local var_135_5 = Mathf.Lerp(iter_135_1.color.g, arg_132_1.hightColor1.g, var_135_3)
								local var_135_6 = Mathf.Lerp(iter_135_1.color.b, arg_132_1.hightColor1.b, var_135_3)

								iter_135_1.color = Color.New(var_135_4, var_135_5, var_135_6)
							else
								local var_135_7 = Mathf.Lerp(iter_135_1.color.r, 1, var_135_3)

								iter_135_1.color = Color.New(var_135_7, var_135_7, var_135_7)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps1148 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_135_3 then
						if arg_132_1.isInRecall_ then
							iter_135_3.color = arg_132_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_135_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps1148 = nil
			end

			local var_135_8 = arg_132_1.actors_["10108"]
			local var_135_9 = 0

			if var_135_9 < arg_132_1.time_ and arg_132_1.time_ <= var_135_9 + arg_135_0 and not isNil(var_135_8) and arg_132_1.var_.actorSpriteComps10108 == nil then
				arg_132_1.var_.actorSpriteComps10108 = var_135_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_10 = 0.125

			if var_135_9 <= arg_132_1.time_ and arg_132_1.time_ < var_135_9 + var_135_10 and not isNil(var_135_8) then
				local var_135_11 = (arg_132_1.time_ - var_135_9) / var_135_10

				if arg_132_1.var_.actorSpriteComps10108 then
					for iter_135_4, iter_135_5 in pairs(arg_132_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_135_5 then
							if arg_132_1.isInRecall_ then
								local var_135_12 = Mathf.Lerp(iter_135_5.color.r, arg_132_1.hightColor2.r, var_135_11)
								local var_135_13 = Mathf.Lerp(iter_135_5.color.g, arg_132_1.hightColor2.g, var_135_11)
								local var_135_14 = Mathf.Lerp(iter_135_5.color.b, arg_132_1.hightColor2.b, var_135_11)

								iter_135_5.color = Color.New(var_135_12, var_135_13, var_135_14)
							else
								local var_135_15 = Mathf.Lerp(iter_135_5.color.r, 0.5, var_135_11)

								iter_135_5.color = Color.New(var_135_15, var_135_15, var_135_15)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= var_135_9 + var_135_10 and arg_132_1.time_ < var_135_9 + var_135_10 + arg_135_0 and not isNil(var_135_8) and arg_132_1.var_.actorSpriteComps10108 then
				for iter_135_6, iter_135_7 in pairs(arg_132_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_135_7 then
						if arg_132_1.isInRecall_ then
							iter_135_7.color = arg_132_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_135_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps10108 = nil
			end

			local var_135_16 = 0
			local var_135_17 = 0.525

			if var_135_16 < arg_132_1.time_ and arg_132_1.time_ <= var_135_16 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_18 = arg_132_1:FormatText(StoryNameCfg[8].name)

				arg_132_1.leftNameTxt_.text = var_135_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_19 = arg_132_1:GetWordFromCfg(416091031)
				local var_135_20 = arg_132_1:FormatText(var_135_19.content)

				arg_132_1.text_.text = var_135_20

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_21 = 21
				local var_135_22 = utf8.len(var_135_20)
				local var_135_23 = var_135_21 <= 0 and var_135_17 or var_135_17 * (var_135_22 / var_135_21)

				if var_135_23 > 0 and var_135_17 < var_135_23 then
					arg_132_1.talkMaxDuration = var_135_23

					if var_135_23 + var_135_16 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_23 + var_135_16
					end
				end

				arg_132_1.text_.text = var_135_20
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091031", "story_v_out_416091.awb") ~= 0 then
					local var_135_24 = manager.audio:GetVoiceLength("story_v_out_416091", "416091031", "story_v_out_416091.awb") / 1000

					if var_135_24 + var_135_16 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_24 + var_135_16
					end

					if var_135_19.prefab_name ~= "" and arg_132_1.actors_[var_135_19.prefab_name] ~= nil then
						local var_135_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_19.prefab_name].transform, "story_v_out_416091", "416091031", "story_v_out_416091.awb")

						arg_132_1:RecordAudio("416091031", var_135_25)
						arg_132_1:RecordAudio("416091031", var_135_25)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_416091", "416091031", "story_v_out_416091.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_416091", "416091031", "story_v_out_416091.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_26 = math.max(var_135_17, arg_132_1.talkMaxDuration)

			if var_135_16 <= arg_132_1.time_ and arg_132_1.time_ < var_135_16 + var_135_26 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_16) / var_135_26

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_16 + var_135_26 and arg_132_1.time_ < var_135_16 + var_135_26 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play416091032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 416091032
		arg_136_1.duration_ = 6.03

		local var_136_0 = {
			zh = 3.466,
			ja = 6.033
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play416091033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 0.4

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_2 = arg_136_1:FormatText(StoryNameCfg[8].name)

				arg_136_1.leftNameTxt_.text = var_139_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_3 = arg_136_1:GetWordFromCfg(416091032)
				local var_139_4 = arg_136_1:FormatText(var_139_3.content)

				arg_136_1.text_.text = var_139_4

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 16
				local var_139_6 = utf8.len(var_139_4)
				local var_139_7 = var_139_5 <= 0 and var_139_1 or var_139_1 * (var_139_6 / var_139_5)

				if var_139_7 > 0 and var_139_1 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_0
					end
				end

				arg_136_1.text_.text = var_139_4
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091032", "story_v_out_416091.awb") ~= 0 then
					local var_139_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091032", "story_v_out_416091.awb") / 1000

					if var_139_8 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_8 + var_139_0
					end

					if var_139_3.prefab_name ~= "" and arg_136_1.actors_[var_139_3.prefab_name] ~= nil then
						local var_139_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_3.prefab_name].transform, "story_v_out_416091", "416091032", "story_v_out_416091.awb")

						arg_136_1:RecordAudio("416091032", var_139_9)
						arg_136_1:RecordAudio("416091032", var_139_9)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_416091", "416091032", "story_v_out_416091.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_416091", "416091032", "story_v_out_416091.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_10 = math.max(var_139_1, arg_136_1.talkMaxDuration)

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_10 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_0) / var_139_10

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_0 + var_139_10 and arg_136_1.time_ < var_139_0 + var_139_10 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play416091033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 416091033
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play416091034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["10108"].transform
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.var_.moveOldPos10108 = var_143_0.localPosition
				var_143_0.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("10108", 7)

				local var_143_2 = var_143_0.childCount

				for iter_143_0 = 0, var_143_2 - 1 do
					local var_143_3 = var_143_0:GetChild(iter_143_0)

					if var_143_3.name == "" or not string.find(var_143_3.name, "split") then
						var_143_3.gameObject:SetActive(true)
					else
						var_143_3.gameObject:SetActive(false)
					end
				end
			end

			local var_143_4 = 0.001

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_4 then
				local var_143_5 = (arg_140_1.time_ - var_143_1) / var_143_4
				local var_143_6 = Vector3.New(0, -2000, 0)

				var_143_0.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos10108, var_143_6, var_143_5)
			end

			if arg_140_1.time_ >= var_143_1 + var_143_4 and arg_140_1.time_ < var_143_1 + var_143_4 + arg_143_0 then
				var_143_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_143_7 = arg_140_1.actors_["1148"].transform
			local var_143_8 = 0

			if var_143_8 < arg_140_1.time_ and arg_140_1.time_ <= var_143_8 + arg_143_0 then
				arg_140_1.var_.moveOldPos1148 = var_143_7.localPosition
				var_143_7.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("1148", 7)

				local var_143_9 = var_143_7.childCount

				for iter_143_1 = 0, var_143_9 - 1 do
					local var_143_10 = var_143_7:GetChild(iter_143_1)

					if var_143_10.name == "" or not string.find(var_143_10.name, "split") then
						var_143_10.gameObject:SetActive(true)
					else
						var_143_10.gameObject:SetActive(false)
					end
				end
			end

			local var_143_11 = 0.001

			if var_143_8 <= arg_140_1.time_ and arg_140_1.time_ < var_143_8 + var_143_11 then
				local var_143_12 = (arg_140_1.time_ - var_143_8) / var_143_11
				local var_143_13 = Vector3.New(0, -2000, 0)

				var_143_7.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1148, var_143_13, var_143_12)
			end

			if arg_140_1.time_ >= var_143_8 + var_143_11 and arg_140_1.time_ < var_143_8 + var_143_11 + arg_143_0 then
				var_143_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_143_14 = 0
			local var_143_15 = 1.05

			if var_143_14 < arg_140_1.time_ and arg_140_1.time_ <= var_143_14 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_16 = arg_140_1:GetWordFromCfg(416091033)
				local var_143_17 = arg_140_1:FormatText(var_143_16.content)

				arg_140_1.text_.text = var_143_17

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_18 = 42
				local var_143_19 = utf8.len(var_143_17)
				local var_143_20 = var_143_18 <= 0 and var_143_15 or var_143_15 * (var_143_19 / var_143_18)

				if var_143_20 > 0 and var_143_15 < var_143_20 then
					arg_140_1.talkMaxDuration = var_143_20

					if var_143_20 + var_143_14 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_20 + var_143_14
					end
				end

				arg_140_1.text_.text = var_143_17
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_21 = math.max(var_143_15, arg_140_1.talkMaxDuration)

			if var_143_14 <= arg_140_1.time_ and arg_140_1.time_ < var_143_14 + var_143_21 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_14) / var_143_21

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_14 + var_143_21 and arg_140_1.time_ < var_143_14 + var_143_21 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play416091034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 416091034
		arg_144_1.duration_ = 11.8

		local var_144_0 = {
			zh = 8.533,
			ja = 11.8
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play416091035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 4

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.allBtn_.enabled = false
			end

			local var_147_1 = 0.3

			if arg_144_1.time_ >= var_147_0 + var_147_1 and arg_144_1.time_ < var_147_0 + var_147_1 + arg_147_0 then
				arg_144_1.allBtn_.enabled = true
			end

			local var_147_2 = "I14f"

			if arg_144_1.bgs_[var_147_2] == nil then
				local var_147_3 = Object.Instantiate(arg_144_1.paintGo_)

				var_147_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_147_2)
				var_147_3.name = var_147_2
				var_147_3.transform.parent = arg_144_1.stage_.transform
				var_147_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_144_1.bgs_[var_147_2] = var_147_3
			end

			local var_147_4 = 2

			if var_147_4 < arg_144_1.time_ and arg_144_1.time_ <= var_147_4 + arg_147_0 then
				local var_147_5 = manager.ui.mainCamera.transform.localPosition
				local var_147_6 = Vector3.New(0, 0, 10) + Vector3.New(var_147_5.x, var_147_5.y, 0)
				local var_147_7 = arg_144_1.bgs_.I14f

				var_147_7.transform.localPosition = var_147_6
				var_147_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_147_8 = var_147_7:GetComponent("SpriteRenderer")

				if var_147_8 and var_147_8.sprite then
					local var_147_9 = (var_147_7.transform.localPosition - var_147_5).z
					local var_147_10 = manager.ui.mainCameraCom_
					local var_147_11 = 2 * var_147_9 * Mathf.Tan(var_147_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_147_12 = var_147_11 * var_147_10.aspect
					local var_147_13 = var_147_8.sprite.bounds.size.x
					local var_147_14 = var_147_8.sprite.bounds.size.y
					local var_147_15 = var_147_12 / var_147_13
					local var_147_16 = var_147_11 / var_147_14
					local var_147_17 = var_147_16 < var_147_15 and var_147_15 or var_147_16

					var_147_7.transform.localScale = Vector3.New(var_147_17, var_147_17, 0)
				end

				for iter_147_0, iter_147_1 in pairs(arg_144_1.bgs_) do
					if iter_147_0 ~= "I14f" then
						iter_147_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_147_18 = 0

			if var_147_18 < arg_144_1.time_ and arg_144_1.time_ <= var_147_18 + arg_147_0 then
				arg_144_1.mask_.enabled = true
				arg_144_1.mask_.raycastTarget = true

				arg_144_1:SetGaussion(false)
			end

			local var_147_19 = 2

			if var_147_18 <= arg_144_1.time_ and arg_144_1.time_ < var_147_18 + var_147_19 then
				local var_147_20 = (arg_144_1.time_ - var_147_18) / var_147_19
				local var_147_21 = Color.New(0, 0, 0)

				var_147_21.a = Mathf.Lerp(0, 1, var_147_20)
				arg_144_1.mask_.color = var_147_21
			end

			if arg_144_1.time_ >= var_147_18 + var_147_19 and arg_144_1.time_ < var_147_18 + var_147_19 + arg_147_0 then
				local var_147_22 = Color.New(0, 0, 0)

				var_147_22.a = 1
				arg_144_1.mask_.color = var_147_22
			end

			local var_147_23 = 2

			if var_147_23 < arg_144_1.time_ and arg_144_1.time_ <= var_147_23 + arg_147_0 then
				arg_144_1.mask_.enabled = true
				arg_144_1.mask_.raycastTarget = true

				arg_144_1:SetGaussion(false)
			end

			local var_147_24 = 2

			if var_147_23 <= arg_144_1.time_ and arg_144_1.time_ < var_147_23 + var_147_24 then
				local var_147_25 = (arg_144_1.time_ - var_147_23) / var_147_24
				local var_147_26 = Color.New(0, 0, 0)

				var_147_26.a = Mathf.Lerp(1, 0, var_147_25)
				arg_144_1.mask_.color = var_147_26
			end

			if arg_144_1.time_ >= var_147_23 + var_147_24 and arg_144_1.time_ < var_147_23 + var_147_24 + arg_147_0 then
				local var_147_27 = Color.New(0, 0, 0)
				local var_147_28 = 0

				arg_144_1.mask_.enabled = false
				var_147_27.a = var_147_28
				arg_144_1.mask_.color = var_147_27
			end

			local var_147_29 = arg_144_1.actors_["1148"].transform
			local var_147_30 = 3.61733333333333

			if var_147_30 < arg_144_1.time_ and arg_144_1.time_ <= var_147_30 + arg_147_0 then
				arg_144_1.var_.moveOldPos1148 = var_147_29.localPosition
				var_147_29.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("1148", 3)

				local var_147_31 = var_147_29.childCount

				for iter_147_2 = 0, var_147_31 - 1 do
					local var_147_32 = var_147_29:GetChild(iter_147_2)

					if var_147_32.name == "split_6" or not string.find(var_147_32.name, "split") then
						var_147_32.gameObject:SetActive(true)
					else
						var_147_32.gameObject:SetActive(false)
					end
				end
			end

			local var_147_33 = 0.001

			if var_147_30 <= arg_144_1.time_ and arg_144_1.time_ < var_147_30 + var_147_33 then
				local var_147_34 = (arg_144_1.time_ - var_147_30) / var_147_33
				local var_147_35 = Vector3.New(0, -429, -180)

				var_147_29.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1148, var_147_35, var_147_34)
			end

			if arg_144_1.time_ >= var_147_30 + var_147_33 and arg_144_1.time_ < var_147_30 + var_147_33 + arg_147_0 then
				var_147_29.localPosition = Vector3.New(0, -429, -180)
			end

			local var_147_36 = arg_144_1.actors_["1148"]
			local var_147_37 = 3.61733333333333

			if var_147_37 < arg_144_1.time_ and arg_144_1.time_ <= var_147_37 + arg_147_0 and not isNil(var_147_36) and arg_144_1.var_.actorSpriteComps1148 == nil then
				arg_144_1.var_.actorSpriteComps1148 = var_147_36:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_38 = 0.125

			if var_147_37 <= arg_144_1.time_ and arg_144_1.time_ < var_147_37 + var_147_38 and not isNil(var_147_36) then
				local var_147_39 = (arg_144_1.time_ - var_147_37) / var_147_38

				if arg_144_1.var_.actorSpriteComps1148 then
					for iter_147_3, iter_147_4 in pairs(arg_144_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_147_4 then
							if arg_144_1.isInRecall_ then
								local var_147_40 = Mathf.Lerp(iter_147_4.color.r, arg_144_1.hightColor1.r, var_147_39)
								local var_147_41 = Mathf.Lerp(iter_147_4.color.g, arg_144_1.hightColor1.g, var_147_39)
								local var_147_42 = Mathf.Lerp(iter_147_4.color.b, arg_144_1.hightColor1.b, var_147_39)

								iter_147_4.color = Color.New(var_147_40, var_147_41, var_147_42)
							else
								local var_147_43 = Mathf.Lerp(iter_147_4.color.r, 1, var_147_39)

								iter_147_4.color = Color.New(var_147_43, var_147_43, var_147_43)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= var_147_37 + var_147_38 and arg_144_1.time_ < var_147_37 + var_147_38 + arg_147_0 and not isNil(var_147_36) and arg_144_1.var_.actorSpriteComps1148 then
				for iter_147_5, iter_147_6 in pairs(arg_144_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_147_6 then
						if arg_144_1.isInRecall_ then
							iter_147_6.color = arg_144_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_147_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_144_1.var_.actorSpriteComps1148 = nil
			end

			local var_147_44 = arg_144_1.actors_["1148"]
			local var_147_45 = 3.61733333333333

			if var_147_45 < arg_144_1.time_ and arg_144_1.time_ <= var_147_45 + arg_147_0 then
				local var_147_46 = var_147_44:GetComponentInChildren(typeof(CanvasGroup))

				if var_147_46 then
					arg_144_1.var_.alphaOldValue1148 = var_147_46.alpha
					arg_144_1.var_.characterEffect1148 = var_147_46
				end

				arg_144_1.var_.alphaOldValue1148 = 0
			end

			local var_147_47 = 0.416

			if var_147_45 <= arg_144_1.time_ and arg_144_1.time_ < var_147_45 + var_147_47 then
				local var_147_48 = (arg_144_1.time_ - var_147_45) / var_147_47
				local var_147_49 = Mathf.Lerp(arg_144_1.var_.alphaOldValue1148, 1, var_147_48)

				if arg_144_1.var_.characterEffect1148 then
					arg_144_1.var_.characterEffect1148.alpha = var_147_49
				end
			end

			if arg_144_1.time_ >= var_147_45 + var_147_47 and arg_144_1.time_ < var_147_45 + var_147_47 + arg_147_0 and arg_144_1.var_.characterEffect1148 then
				arg_144_1.var_.characterEffect1148.alpha = 1
			end

			if arg_144_1.frameCnt_ <= 1 then
				arg_144_1.dialog_:SetActive(false)
			end

			local var_147_50 = 4
			local var_147_51 = 0.475

			if var_147_50 < arg_144_1.time_ and arg_144_1.time_ <= var_147_50 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0

				arg_144_1.dialog_:SetActive(true)

				arg_144_1.dialogCg_.alpha = 0

				local var_147_52 = LeanTween.value(arg_144_1.dialog_, 0, 1, 0.3)

				var_147_52:setOnUpdate(LuaHelper.FloatAction(function(arg_148_0)
					arg_144_1.dialogCg_.alpha = arg_148_0
				end))
				var_147_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_144_1.dialog_)
					var_147_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_144_1.duration_ = arg_144_1.duration_ + 0.3

				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_53 = arg_144_1:FormatText(StoryNameCfg[8].name)

				arg_144_1.leftNameTxt_.text = var_147_53

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_54 = arg_144_1:GetWordFromCfg(416091034)
				local var_147_55 = arg_144_1:FormatText(var_147_54.content)

				arg_144_1.text_.text = var_147_55

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_56 = 15
				local var_147_57 = utf8.len(var_147_55)
				local var_147_58 = var_147_56 <= 0 and var_147_51 or var_147_51 * (var_147_57 / var_147_56)

				if var_147_58 > 0 and var_147_51 < var_147_58 then
					arg_144_1.talkMaxDuration = var_147_58
					var_147_50 = var_147_50 + 0.3

					if var_147_58 + var_147_50 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_58 + var_147_50
					end
				end

				arg_144_1.text_.text = var_147_55
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091034", "story_v_out_416091.awb") ~= 0 then
					local var_147_59 = manager.audio:GetVoiceLength("story_v_out_416091", "416091034", "story_v_out_416091.awb") / 1000

					if var_147_59 + var_147_50 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_59 + var_147_50
					end

					if var_147_54.prefab_name ~= "" and arg_144_1.actors_[var_147_54.prefab_name] ~= nil then
						local var_147_60 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_54.prefab_name].transform, "story_v_out_416091", "416091034", "story_v_out_416091.awb")

						arg_144_1:RecordAudio("416091034", var_147_60)
						arg_144_1:RecordAudio("416091034", var_147_60)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_416091", "416091034", "story_v_out_416091.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_416091", "416091034", "story_v_out_416091.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_61 = var_147_50 + 0.3
			local var_147_62 = math.max(var_147_51, arg_144_1.talkMaxDuration)

			if var_147_61 <= arg_144_1.time_ and arg_144_1.time_ < var_147_61 + var_147_62 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_61) / var_147_62

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_61 + var_147_62 and arg_144_1.time_ < var_147_61 + var_147_62 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.61733333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play416091035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 416091035
		arg_150_1.duration_ = 5.4

		local var_150_0 = {
			zh = 5.4,
			ja = 3.133
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play416091036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0
			local var_153_1 = 0.525

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_2 = arg_150_1:FormatText(StoryNameCfg[8].name)

				arg_150_1.leftNameTxt_.text = var_153_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_3 = arg_150_1:GetWordFromCfg(416091035)
				local var_153_4 = arg_150_1:FormatText(var_153_3.content)

				arg_150_1.text_.text = var_153_4

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 21
				local var_153_6 = utf8.len(var_153_4)
				local var_153_7 = var_153_5 <= 0 and var_153_1 or var_153_1 * (var_153_6 / var_153_5)

				if var_153_7 > 0 and var_153_1 < var_153_7 then
					arg_150_1.talkMaxDuration = var_153_7

					if var_153_7 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_7 + var_153_0
					end
				end

				arg_150_1.text_.text = var_153_4
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091035", "story_v_out_416091.awb") ~= 0 then
					local var_153_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091035", "story_v_out_416091.awb") / 1000

					if var_153_8 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_8 + var_153_0
					end

					if var_153_3.prefab_name ~= "" and arg_150_1.actors_[var_153_3.prefab_name] ~= nil then
						local var_153_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_3.prefab_name].transform, "story_v_out_416091", "416091035", "story_v_out_416091.awb")

						arg_150_1:RecordAudio("416091035", var_153_9)
						arg_150_1:RecordAudio("416091035", var_153_9)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_416091", "416091035", "story_v_out_416091.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_416091", "416091035", "story_v_out_416091.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_10 = math.max(var_153_1, arg_150_1.talkMaxDuration)

			if var_153_0 <= arg_150_1.time_ and arg_150_1.time_ < var_153_0 + var_153_10 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_0) / var_153_10

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_0 + var_153_10 and arg_150_1.time_ < var_153_0 + var_153_10 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play416091036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 416091036
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play416091037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1148"].transform
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.var_.moveOldPos1148 = var_157_0.localPosition
				var_157_0.localScale = Vector3.New(1, 1, 1)

				arg_154_1:CheckSpriteTmpPos("1148", 7)

				local var_157_2 = var_157_0.childCount

				for iter_157_0 = 0, var_157_2 - 1 do
					local var_157_3 = var_157_0:GetChild(iter_157_0)

					if var_157_3.name == "" or not string.find(var_157_3.name, "split") then
						var_157_3.gameObject:SetActive(true)
					else
						var_157_3.gameObject:SetActive(false)
					end
				end
			end

			local var_157_4 = 0.001

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_4 then
				local var_157_5 = (arg_154_1.time_ - var_157_1) / var_157_4
				local var_157_6 = Vector3.New(0, -2000, 0)

				var_157_0.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1148, var_157_6, var_157_5)
			end

			if arg_154_1.time_ >= var_157_1 + var_157_4 and arg_154_1.time_ < var_157_1 + var_157_4 + arg_157_0 then
				var_157_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_157_7 = 1.43333333333333
			local var_157_8 = 0.3

			if var_157_7 < arg_154_1.time_ and arg_154_1.time_ <= var_157_7 + arg_157_0 then
				local var_157_9 = "play"
				local var_157_10 = "effect"

				arg_154_1:AudioAction(var_157_9, var_157_10, "se_story_side_1068", "se_story_1068_footstep", "")
			end

			local var_157_11 = 0
			local var_157_12 = 1.9

			if var_157_11 < arg_154_1.time_ and arg_154_1.time_ <= var_157_11 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_13 = arg_154_1:GetWordFromCfg(416091036)
				local var_157_14 = arg_154_1:FormatText(var_157_13.content)

				arg_154_1.text_.text = var_157_14

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_15 = 76
				local var_157_16 = utf8.len(var_157_14)
				local var_157_17 = var_157_15 <= 0 and var_157_12 or var_157_12 * (var_157_16 / var_157_15)

				if var_157_17 > 0 and var_157_12 < var_157_17 then
					arg_154_1.talkMaxDuration = var_157_17

					if var_157_17 + var_157_11 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_17 + var_157_11
					end
				end

				arg_154_1.text_.text = var_157_14
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_18 = math.max(var_157_12, arg_154_1.talkMaxDuration)

			if var_157_11 <= arg_154_1.time_ and arg_154_1.time_ < var_157_11 + var_157_18 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_11) / var_157_18

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_11 + var_157_18 and arg_154_1.time_ < var_157_11 + var_157_18 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play416091037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 416091037
		arg_158_1.duration_ = 5.23

		local var_158_0 = {
			zh = 5,
			ja = 5.233
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play416091038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0
			local var_161_1 = 0.55

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_2 = arg_158_1:FormatText(StoryNameCfg[1082].name)

				arg_158_1.leftNameTxt_.text = var_161_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_3 = arg_158_1:GetWordFromCfg(416091037)
				local var_161_4 = arg_158_1:FormatText(var_161_3.content)

				arg_158_1.text_.text = var_161_4

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_5 = 22
				local var_161_6 = utf8.len(var_161_4)
				local var_161_7 = var_161_5 <= 0 and var_161_1 or var_161_1 * (var_161_6 / var_161_5)

				if var_161_7 > 0 and var_161_1 < var_161_7 then
					arg_158_1.talkMaxDuration = var_161_7

					if var_161_7 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_7 + var_161_0
					end
				end

				arg_158_1.text_.text = var_161_4
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091037", "story_v_out_416091.awb") ~= 0 then
					local var_161_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091037", "story_v_out_416091.awb") / 1000

					if var_161_8 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_8 + var_161_0
					end

					if var_161_3.prefab_name ~= "" and arg_158_1.actors_[var_161_3.prefab_name] ~= nil then
						local var_161_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_3.prefab_name].transform, "story_v_out_416091", "416091037", "story_v_out_416091.awb")

						arg_158_1:RecordAudio("416091037", var_161_9)
						arg_158_1:RecordAudio("416091037", var_161_9)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_416091", "416091037", "story_v_out_416091.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_416091", "416091037", "story_v_out_416091.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_10 = math.max(var_161_1, arg_158_1.talkMaxDuration)

			if var_161_0 <= arg_158_1.time_ and arg_158_1.time_ < var_161_0 + var_161_10 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_0) / var_161_10

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_0 + var_161_10 and arg_158_1.time_ < var_161_0 + var_161_10 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play416091038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 416091038
		arg_162_1.duration_ = 5.77

		local var_162_0 = {
			zh = 2.6,
			ja = 5.766
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play416091039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1148"].transform
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.var_.moveOldPos1148 = var_165_0.localPosition
				var_165_0.localScale = Vector3.New(1, 1, 1)

				arg_162_1:CheckSpriteTmpPos("1148", 3)

				local var_165_2 = var_165_0.childCount

				for iter_165_0 = 0, var_165_2 - 1 do
					local var_165_3 = var_165_0:GetChild(iter_165_0)

					if var_165_3.name == "" or not string.find(var_165_3.name, "split") then
						var_165_3.gameObject:SetActive(true)
					else
						var_165_3.gameObject:SetActive(false)
					end
				end
			end

			local var_165_4 = 0.001

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_4 then
				local var_165_5 = (arg_162_1.time_ - var_165_1) / var_165_4
				local var_165_6 = Vector3.New(0, -429, -180)

				var_165_0.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1148, var_165_6, var_165_5)
			end

			if arg_162_1.time_ >= var_165_1 + var_165_4 and arg_162_1.time_ < var_165_1 + var_165_4 + arg_165_0 then
				var_165_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_165_7 = arg_162_1.actors_["1148"]
			local var_165_8 = 0

			if var_165_8 < arg_162_1.time_ and arg_162_1.time_ <= var_165_8 + arg_165_0 and not isNil(var_165_7) and arg_162_1.var_.actorSpriteComps1148 == nil then
				arg_162_1.var_.actorSpriteComps1148 = var_165_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_165_9 = 0.125

			if var_165_8 <= arg_162_1.time_ and arg_162_1.time_ < var_165_8 + var_165_9 and not isNil(var_165_7) then
				local var_165_10 = (arg_162_1.time_ - var_165_8) / var_165_9

				if arg_162_1.var_.actorSpriteComps1148 then
					for iter_165_1, iter_165_2 in pairs(arg_162_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_165_2 then
							if arg_162_1.isInRecall_ then
								local var_165_11 = Mathf.Lerp(iter_165_2.color.r, arg_162_1.hightColor1.r, var_165_10)
								local var_165_12 = Mathf.Lerp(iter_165_2.color.g, arg_162_1.hightColor1.g, var_165_10)
								local var_165_13 = Mathf.Lerp(iter_165_2.color.b, arg_162_1.hightColor1.b, var_165_10)

								iter_165_2.color = Color.New(var_165_11, var_165_12, var_165_13)
							else
								local var_165_14 = Mathf.Lerp(iter_165_2.color.r, 1, var_165_10)

								iter_165_2.color = Color.New(var_165_14, var_165_14, var_165_14)
							end
						end
					end
				end
			end

			if arg_162_1.time_ >= var_165_8 + var_165_9 and arg_162_1.time_ < var_165_8 + var_165_9 + arg_165_0 and not isNil(var_165_7) and arg_162_1.var_.actorSpriteComps1148 then
				for iter_165_3, iter_165_4 in pairs(arg_162_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_165_4 then
						if arg_162_1.isInRecall_ then
							iter_165_4.color = arg_162_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_165_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_162_1.var_.actorSpriteComps1148 = nil
			end

			local var_165_15 = 0
			local var_165_16 = 0.325

			if var_165_15 < arg_162_1.time_ and arg_162_1.time_ <= var_165_15 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_17 = arg_162_1:FormatText(StoryNameCfg[8].name)

				arg_162_1.leftNameTxt_.text = var_165_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_18 = arg_162_1:GetWordFromCfg(416091038)
				local var_165_19 = arg_162_1:FormatText(var_165_18.content)

				arg_162_1.text_.text = var_165_19

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_20 = 13
				local var_165_21 = utf8.len(var_165_19)
				local var_165_22 = var_165_20 <= 0 and var_165_16 or var_165_16 * (var_165_21 / var_165_20)

				if var_165_22 > 0 and var_165_16 < var_165_22 then
					arg_162_1.talkMaxDuration = var_165_22

					if var_165_22 + var_165_15 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_22 + var_165_15
					end
				end

				arg_162_1.text_.text = var_165_19
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091038", "story_v_out_416091.awb") ~= 0 then
					local var_165_23 = manager.audio:GetVoiceLength("story_v_out_416091", "416091038", "story_v_out_416091.awb") / 1000

					if var_165_23 + var_165_15 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_23 + var_165_15
					end

					if var_165_18.prefab_name ~= "" and arg_162_1.actors_[var_165_18.prefab_name] ~= nil then
						local var_165_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_18.prefab_name].transform, "story_v_out_416091", "416091038", "story_v_out_416091.awb")

						arg_162_1:RecordAudio("416091038", var_165_24)
						arg_162_1:RecordAudio("416091038", var_165_24)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_416091", "416091038", "story_v_out_416091.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_416091", "416091038", "story_v_out_416091.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_25 = math.max(var_165_16, arg_162_1.talkMaxDuration)

			if var_165_15 <= arg_162_1.time_ and arg_162_1.time_ < var_165_15 + var_165_25 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_15) / var_165_25

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_15 + var_165_25 and arg_162_1.time_ < var_165_15 + var_165_25 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play416091039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 416091039
		arg_166_1.duration_ = 9.4

		local var_166_0 = {
			zh = 6.4,
			ja = 9.4
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play416091040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["1148"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.actorSpriteComps1148 == nil then
				arg_166_1.var_.actorSpriteComps1148 = var_169_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_2 = 0.125

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.actorSpriteComps1148 then
					for iter_169_0, iter_169_1 in pairs(arg_166_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_169_1 then
							if arg_166_1.isInRecall_ then
								local var_169_4 = Mathf.Lerp(iter_169_1.color.r, arg_166_1.hightColor2.r, var_169_3)
								local var_169_5 = Mathf.Lerp(iter_169_1.color.g, arg_166_1.hightColor2.g, var_169_3)
								local var_169_6 = Mathf.Lerp(iter_169_1.color.b, arg_166_1.hightColor2.b, var_169_3)

								iter_169_1.color = Color.New(var_169_4, var_169_5, var_169_6)
							else
								local var_169_7 = Mathf.Lerp(iter_169_1.color.r, 0.5, var_169_3)

								iter_169_1.color = Color.New(var_169_7, var_169_7, var_169_7)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.actorSpriteComps1148 then
				for iter_169_2, iter_169_3 in pairs(arg_166_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_169_3 then
						if arg_166_1.isInRecall_ then
							iter_169_3.color = arg_166_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_169_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_166_1.var_.actorSpriteComps1148 = nil
			end

			local var_169_8 = 0
			local var_169_9 = 0.875

			if var_169_8 < arg_166_1.time_ and arg_166_1.time_ <= var_169_8 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_10 = arg_166_1:FormatText(StoryNameCfg[1082].name)

				arg_166_1.leftNameTxt_.text = var_169_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_11 = arg_166_1:GetWordFromCfg(416091039)
				local var_169_12 = arg_166_1:FormatText(var_169_11.content)

				arg_166_1.text_.text = var_169_12

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_13 = 35
				local var_169_14 = utf8.len(var_169_12)
				local var_169_15 = var_169_13 <= 0 and var_169_9 or var_169_9 * (var_169_14 / var_169_13)

				if var_169_15 > 0 and var_169_9 < var_169_15 then
					arg_166_1.talkMaxDuration = var_169_15

					if var_169_15 + var_169_8 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_15 + var_169_8
					end
				end

				arg_166_1.text_.text = var_169_12
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091039", "story_v_out_416091.awb") ~= 0 then
					local var_169_16 = manager.audio:GetVoiceLength("story_v_out_416091", "416091039", "story_v_out_416091.awb") / 1000

					if var_169_16 + var_169_8 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_16 + var_169_8
					end

					if var_169_11.prefab_name ~= "" and arg_166_1.actors_[var_169_11.prefab_name] ~= nil then
						local var_169_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_11.prefab_name].transform, "story_v_out_416091", "416091039", "story_v_out_416091.awb")

						arg_166_1:RecordAudio("416091039", var_169_17)
						arg_166_1:RecordAudio("416091039", var_169_17)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_416091", "416091039", "story_v_out_416091.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_416091", "416091039", "story_v_out_416091.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_18 = math.max(var_169_9, arg_166_1.talkMaxDuration)

			if var_169_8 <= arg_166_1.time_ and arg_166_1.time_ < var_169_8 + var_169_18 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_8) / var_169_18

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_8 + var_169_18 and arg_166_1.time_ < var_169_8 + var_169_18 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play416091040 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 416091040
		arg_170_1.duration_ = 6.03

		local var_170_0 = {
			zh = 5.266,
			ja = 6.033
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play416091041(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["1148"]
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.actorSpriteComps1148 == nil then
				arg_170_1.var_.actorSpriteComps1148 = var_173_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_2 = 0.125

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 and not isNil(var_173_0) then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2

				if arg_170_1.var_.actorSpriteComps1148 then
					for iter_173_0, iter_173_1 in pairs(arg_170_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_173_1 then
							if arg_170_1.isInRecall_ then
								local var_173_4 = Mathf.Lerp(iter_173_1.color.r, arg_170_1.hightColor1.r, var_173_3)
								local var_173_5 = Mathf.Lerp(iter_173_1.color.g, arg_170_1.hightColor1.g, var_173_3)
								local var_173_6 = Mathf.Lerp(iter_173_1.color.b, arg_170_1.hightColor1.b, var_173_3)

								iter_173_1.color = Color.New(var_173_4, var_173_5, var_173_6)
							else
								local var_173_7 = Mathf.Lerp(iter_173_1.color.r, 1, var_173_3)

								iter_173_1.color = Color.New(var_173_7, var_173_7, var_173_7)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.actorSpriteComps1148 then
				for iter_173_2, iter_173_3 in pairs(arg_170_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_173_3 then
						if arg_170_1.isInRecall_ then
							iter_173_3.color = arg_170_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_173_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_170_1.var_.actorSpriteComps1148 = nil
			end

			local var_173_8 = 0
			local var_173_9 = 0.6

			if var_173_8 < arg_170_1.time_ and arg_170_1.time_ <= var_173_8 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_10 = arg_170_1:FormatText(StoryNameCfg[8].name)

				arg_170_1.leftNameTxt_.text = var_173_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_11 = arg_170_1:GetWordFromCfg(416091040)
				local var_173_12 = arg_170_1:FormatText(var_173_11.content)

				arg_170_1.text_.text = var_173_12

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_13 = 24
				local var_173_14 = utf8.len(var_173_12)
				local var_173_15 = var_173_13 <= 0 and var_173_9 or var_173_9 * (var_173_14 / var_173_13)

				if var_173_15 > 0 and var_173_9 < var_173_15 then
					arg_170_1.talkMaxDuration = var_173_15

					if var_173_15 + var_173_8 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_15 + var_173_8
					end
				end

				arg_170_1.text_.text = var_173_12
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091040", "story_v_out_416091.awb") ~= 0 then
					local var_173_16 = manager.audio:GetVoiceLength("story_v_out_416091", "416091040", "story_v_out_416091.awb") / 1000

					if var_173_16 + var_173_8 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_16 + var_173_8
					end

					if var_173_11.prefab_name ~= "" and arg_170_1.actors_[var_173_11.prefab_name] ~= nil then
						local var_173_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_11.prefab_name].transform, "story_v_out_416091", "416091040", "story_v_out_416091.awb")

						arg_170_1:RecordAudio("416091040", var_173_17)
						arg_170_1:RecordAudio("416091040", var_173_17)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_416091", "416091040", "story_v_out_416091.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_416091", "416091040", "story_v_out_416091.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_18 = math.max(var_173_9, arg_170_1.talkMaxDuration)

			if var_173_8 <= arg_170_1.time_ and arg_170_1.time_ < var_173_8 + var_173_18 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_8) / var_173_18

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_8 + var_173_18 and arg_170_1.time_ < var_173_8 + var_173_18 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play416091041 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 416091041
		arg_174_1.duration_ = 9.3

		local var_174_0 = {
			zh = 5.066,
			ja = 9.3
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play416091042(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["1148"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.actorSpriteComps1148 == nil then
				arg_174_1.var_.actorSpriteComps1148 = var_177_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_2 = 0.125

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 and not isNil(var_177_0) then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2

				if arg_174_1.var_.actorSpriteComps1148 then
					for iter_177_0, iter_177_1 in pairs(arg_174_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_177_1 then
							if arg_174_1.isInRecall_ then
								local var_177_4 = Mathf.Lerp(iter_177_1.color.r, arg_174_1.hightColor2.r, var_177_3)
								local var_177_5 = Mathf.Lerp(iter_177_1.color.g, arg_174_1.hightColor2.g, var_177_3)
								local var_177_6 = Mathf.Lerp(iter_177_1.color.b, arg_174_1.hightColor2.b, var_177_3)

								iter_177_1.color = Color.New(var_177_4, var_177_5, var_177_6)
							else
								local var_177_7 = Mathf.Lerp(iter_177_1.color.r, 0.5, var_177_3)

								iter_177_1.color = Color.New(var_177_7, var_177_7, var_177_7)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.actorSpriteComps1148 then
				for iter_177_2, iter_177_3 in pairs(arg_174_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_177_3 then
						if arg_174_1.isInRecall_ then
							iter_177_3.color = arg_174_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_177_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_174_1.var_.actorSpriteComps1148 = nil
			end

			local var_177_8 = 0
			local var_177_9 = 0.675

			if var_177_8 < arg_174_1.time_ and arg_174_1.time_ <= var_177_8 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_10 = arg_174_1:FormatText(StoryNameCfg[1082].name)

				arg_174_1.leftNameTxt_.text = var_177_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_11 = arg_174_1:GetWordFromCfg(416091041)
				local var_177_12 = arg_174_1:FormatText(var_177_11.content)

				arg_174_1.text_.text = var_177_12

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_13 = 27
				local var_177_14 = utf8.len(var_177_12)
				local var_177_15 = var_177_13 <= 0 and var_177_9 or var_177_9 * (var_177_14 / var_177_13)

				if var_177_15 > 0 and var_177_9 < var_177_15 then
					arg_174_1.talkMaxDuration = var_177_15

					if var_177_15 + var_177_8 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_15 + var_177_8
					end
				end

				arg_174_1.text_.text = var_177_12
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091041", "story_v_out_416091.awb") ~= 0 then
					local var_177_16 = manager.audio:GetVoiceLength("story_v_out_416091", "416091041", "story_v_out_416091.awb") / 1000

					if var_177_16 + var_177_8 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_16 + var_177_8
					end

					if var_177_11.prefab_name ~= "" and arg_174_1.actors_[var_177_11.prefab_name] ~= nil then
						local var_177_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_11.prefab_name].transform, "story_v_out_416091", "416091041", "story_v_out_416091.awb")

						arg_174_1:RecordAudio("416091041", var_177_17)
						arg_174_1:RecordAudio("416091041", var_177_17)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_416091", "416091041", "story_v_out_416091.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_416091", "416091041", "story_v_out_416091.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_18 = math.max(var_177_9, arg_174_1.talkMaxDuration)

			if var_177_8 <= arg_174_1.time_ and arg_174_1.time_ < var_177_8 + var_177_18 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_8) / var_177_18

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_8 + var_177_18 and arg_174_1.time_ < var_177_8 + var_177_18 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play416091042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 416091042
		arg_178_1.duration_ = 7.37

		local var_178_0 = {
			zh = 7.366,
			ja = 6.066
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play416091043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["1148"]
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.actorSpriteComps1148 == nil then
				arg_178_1.var_.actorSpriteComps1148 = var_181_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_2 = 0.125

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 and not isNil(var_181_0) then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2

				if arg_178_1.var_.actorSpriteComps1148 then
					for iter_181_0, iter_181_1 in pairs(arg_178_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_181_1 then
							if arg_178_1.isInRecall_ then
								local var_181_4 = Mathf.Lerp(iter_181_1.color.r, arg_178_1.hightColor1.r, var_181_3)
								local var_181_5 = Mathf.Lerp(iter_181_1.color.g, arg_178_1.hightColor1.g, var_181_3)
								local var_181_6 = Mathf.Lerp(iter_181_1.color.b, arg_178_1.hightColor1.b, var_181_3)

								iter_181_1.color = Color.New(var_181_4, var_181_5, var_181_6)
							else
								local var_181_7 = Mathf.Lerp(iter_181_1.color.r, 1, var_181_3)

								iter_181_1.color = Color.New(var_181_7, var_181_7, var_181_7)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.actorSpriteComps1148 then
				for iter_181_2, iter_181_3 in pairs(arg_178_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_181_3 then
						if arg_178_1.isInRecall_ then
							iter_181_3.color = arg_178_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_181_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_178_1.var_.actorSpriteComps1148 = nil
			end

			local var_181_8 = 0
			local var_181_9 = 0.75

			if var_181_8 < arg_178_1.time_ and arg_178_1.time_ <= var_181_8 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_10 = arg_178_1:FormatText(StoryNameCfg[8].name)

				arg_178_1.leftNameTxt_.text = var_181_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_11 = arg_178_1:GetWordFromCfg(416091042)
				local var_181_12 = arg_178_1:FormatText(var_181_11.content)

				arg_178_1.text_.text = var_181_12

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_13 = 30
				local var_181_14 = utf8.len(var_181_12)
				local var_181_15 = var_181_13 <= 0 and var_181_9 or var_181_9 * (var_181_14 / var_181_13)

				if var_181_15 > 0 and var_181_9 < var_181_15 then
					arg_178_1.talkMaxDuration = var_181_15

					if var_181_15 + var_181_8 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_15 + var_181_8
					end
				end

				arg_178_1.text_.text = var_181_12
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091042", "story_v_out_416091.awb") ~= 0 then
					local var_181_16 = manager.audio:GetVoiceLength("story_v_out_416091", "416091042", "story_v_out_416091.awb") / 1000

					if var_181_16 + var_181_8 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_16 + var_181_8
					end

					if var_181_11.prefab_name ~= "" and arg_178_1.actors_[var_181_11.prefab_name] ~= nil then
						local var_181_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_11.prefab_name].transform, "story_v_out_416091", "416091042", "story_v_out_416091.awb")

						arg_178_1:RecordAudio("416091042", var_181_17)
						arg_178_1:RecordAudio("416091042", var_181_17)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_416091", "416091042", "story_v_out_416091.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_416091", "416091042", "story_v_out_416091.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_18 = math.max(var_181_9, arg_178_1.talkMaxDuration)

			if var_181_8 <= arg_178_1.time_ and arg_178_1.time_ < var_181_8 + var_181_18 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_8) / var_181_18

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_8 + var_181_18 and arg_178_1.time_ < var_181_8 + var_181_18 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play416091043 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 416091043
		arg_182_1.duration_ = 5

		local var_182_0 = {
			zh = 2.733,
			ja = 5
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play416091044(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["1148"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.actorSpriteComps1148 == nil then
				arg_182_1.var_.actorSpriteComps1148 = var_185_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_2 = 0.125

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.actorSpriteComps1148 then
					for iter_185_0, iter_185_1 in pairs(arg_182_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_185_1 then
							if arg_182_1.isInRecall_ then
								local var_185_4 = Mathf.Lerp(iter_185_1.color.r, arg_182_1.hightColor2.r, var_185_3)
								local var_185_5 = Mathf.Lerp(iter_185_1.color.g, arg_182_1.hightColor2.g, var_185_3)
								local var_185_6 = Mathf.Lerp(iter_185_1.color.b, arg_182_1.hightColor2.b, var_185_3)

								iter_185_1.color = Color.New(var_185_4, var_185_5, var_185_6)
							else
								local var_185_7 = Mathf.Lerp(iter_185_1.color.r, 0.5, var_185_3)

								iter_185_1.color = Color.New(var_185_7, var_185_7, var_185_7)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.actorSpriteComps1148 then
				for iter_185_2, iter_185_3 in pairs(arg_182_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_185_3 then
						if arg_182_1.isInRecall_ then
							iter_185_3.color = arg_182_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_185_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_182_1.var_.actorSpriteComps1148 = nil
			end

			local var_185_8 = 0
			local var_185_9 = 0.325

			if var_185_8 < arg_182_1.time_ and arg_182_1.time_ <= var_185_8 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_10 = arg_182_1:FormatText(StoryNameCfg[1082].name)

				arg_182_1.leftNameTxt_.text = var_185_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_11 = arg_182_1:GetWordFromCfg(416091043)
				local var_185_12 = arg_182_1:FormatText(var_185_11.content)

				arg_182_1.text_.text = var_185_12

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_13 = 13
				local var_185_14 = utf8.len(var_185_12)
				local var_185_15 = var_185_13 <= 0 and var_185_9 or var_185_9 * (var_185_14 / var_185_13)

				if var_185_15 > 0 and var_185_9 < var_185_15 then
					arg_182_1.talkMaxDuration = var_185_15

					if var_185_15 + var_185_8 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_15 + var_185_8
					end
				end

				arg_182_1.text_.text = var_185_12
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091043", "story_v_out_416091.awb") ~= 0 then
					local var_185_16 = manager.audio:GetVoiceLength("story_v_out_416091", "416091043", "story_v_out_416091.awb") / 1000

					if var_185_16 + var_185_8 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_16 + var_185_8
					end

					if var_185_11.prefab_name ~= "" and arg_182_1.actors_[var_185_11.prefab_name] ~= nil then
						local var_185_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_11.prefab_name].transform, "story_v_out_416091", "416091043", "story_v_out_416091.awb")

						arg_182_1:RecordAudio("416091043", var_185_17)
						arg_182_1:RecordAudio("416091043", var_185_17)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_416091", "416091043", "story_v_out_416091.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_416091", "416091043", "story_v_out_416091.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_18 = math.max(var_185_9, arg_182_1.talkMaxDuration)

			if var_185_8 <= arg_182_1.time_ and arg_182_1.time_ < var_185_8 + var_185_18 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_8) / var_185_18

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_8 + var_185_18 and arg_182_1.time_ < var_185_8 + var_185_18 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play416091044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 416091044
		arg_186_1.duration_ = 7.03

		local var_186_0 = {
			zh = 7.033,
			ja = 6.466
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play416091045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["1148"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.actorSpriteComps1148 == nil then
				arg_186_1.var_.actorSpriteComps1148 = var_189_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_2 = 0.125

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.actorSpriteComps1148 then
					for iter_189_0, iter_189_1 in pairs(arg_186_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_189_1 then
							if arg_186_1.isInRecall_ then
								local var_189_4 = Mathf.Lerp(iter_189_1.color.r, arg_186_1.hightColor1.r, var_189_3)
								local var_189_5 = Mathf.Lerp(iter_189_1.color.g, arg_186_1.hightColor1.g, var_189_3)
								local var_189_6 = Mathf.Lerp(iter_189_1.color.b, arg_186_1.hightColor1.b, var_189_3)

								iter_189_1.color = Color.New(var_189_4, var_189_5, var_189_6)
							else
								local var_189_7 = Mathf.Lerp(iter_189_1.color.r, 1, var_189_3)

								iter_189_1.color = Color.New(var_189_7, var_189_7, var_189_7)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.actorSpriteComps1148 then
				for iter_189_2, iter_189_3 in pairs(arg_186_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_189_3 then
						if arg_186_1.isInRecall_ then
							iter_189_3.color = arg_186_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_189_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_186_1.var_.actorSpriteComps1148 = nil
			end

			local var_189_8 = 0
			local var_189_9 = 0.6

			if var_189_8 < arg_186_1.time_ and arg_186_1.time_ <= var_189_8 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_10 = arg_186_1:FormatText(StoryNameCfg[8].name)

				arg_186_1.leftNameTxt_.text = var_189_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_11 = arg_186_1:GetWordFromCfg(416091044)
				local var_189_12 = arg_186_1:FormatText(var_189_11.content)

				arg_186_1.text_.text = var_189_12

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_13 = 24
				local var_189_14 = utf8.len(var_189_12)
				local var_189_15 = var_189_13 <= 0 and var_189_9 or var_189_9 * (var_189_14 / var_189_13)

				if var_189_15 > 0 and var_189_9 < var_189_15 then
					arg_186_1.talkMaxDuration = var_189_15

					if var_189_15 + var_189_8 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_15 + var_189_8
					end
				end

				arg_186_1.text_.text = var_189_12
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091044", "story_v_out_416091.awb") ~= 0 then
					local var_189_16 = manager.audio:GetVoiceLength("story_v_out_416091", "416091044", "story_v_out_416091.awb") / 1000

					if var_189_16 + var_189_8 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_16 + var_189_8
					end

					if var_189_11.prefab_name ~= "" and arg_186_1.actors_[var_189_11.prefab_name] ~= nil then
						local var_189_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_11.prefab_name].transform, "story_v_out_416091", "416091044", "story_v_out_416091.awb")

						arg_186_1:RecordAudio("416091044", var_189_17)
						arg_186_1:RecordAudio("416091044", var_189_17)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_416091", "416091044", "story_v_out_416091.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_416091", "416091044", "story_v_out_416091.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_18 = math.max(var_189_9, arg_186_1.talkMaxDuration)

			if var_189_8 <= arg_186_1.time_ and arg_186_1.time_ < var_189_8 + var_189_18 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_8) / var_189_18

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_8 + var_189_18 and arg_186_1.time_ < var_189_8 + var_189_18 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play416091045 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 416091045
		arg_190_1.duration_ = 8.6

		local var_190_0 = {
			zh = 7.7,
			ja = 8.6
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play416091046(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 2

			if var_193_0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_0 + arg_193_0 then
				local var_193_1 = manager.ui.mainCamera.transform.localPosition
				local var_193_2 = Vector3.New(0, 0, 10) + Vector3.New(var_193_1.x, var_193_1.y, 0)
				local var_193_3 = arg_190_1.bgs_.I14f

				var_193_3.transform.localPosition = var_193_2
				var_193_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_193_4 = var_193_3:GetComponent("SpriteRenderer")

				if var_193_4 and var_193_4.sprite then
					local var_193_5 = (var_193_3.transform.localPosition - var_193_1).z
					local var_193_6 = manager.ui.mainCameraCom_
					local var_193_7 = 2 * var_193_5 * Mathf.Tan(var_193_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_193_8 = var_193_7 * var_193_6.aspect
					local var_193_9 = var_193_4.sprite.bounds.size.x
					local var_193_10 = var_193_4.sprite.bounds.size.y
					local var_193_11 = var_193_8 / var_193_9
					local var_193_12 = var_193_7 / var_193_10
					local var_193_13 = var_193_12 < var_193_11 and var_193_11 or var_193_12

					var_193_3.transform.localScale = Vector3.New(var_193_13, var_193_13, 0)
				end

				for iter_193_0, iter_193_1 in pairs(arg_190_1.bgs_) do
					if iter_193_0 ~= "I14f" then
						iter_193_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_193_14 = 4

			if var_193_14 < arg_190_1.time_ and arg_190_1.time_ <= var_193_14 + arg_193_0 then
				arg_190_1.allBtn_.enabled = false
			end

			local var_193_15 = 0.3

			if arg_190_1.time_ >= var_193_14 + var_193_15 and arg_190_1.time_ < var_193_14 + var_193_15 + arg_193_0 then
				arg_190_1.allBtn_.enabled = true
			end

			local var_193_16 = 0

			if var_193_16 < arg_190_1.time_ and arg_190_1.time_ <= var_193_16 + arg_193_0 then
				arg_190_1.mask_.enabled = true
				arg_190_1.mask_.raycastTarget = true

				arg_190_1:SetGaussion(false)
			end

			local var_193_17 = 2

			if var_193_16 <= arg_190_1.time_ and arg_190_1.time_ < var_193_16 + var_193_17 then
				local var_193_18 = (arg_190_1.time_ - var_193_16) / var_193_17
				local var_193_19 = Color.New(0, 0, 0)

				var_193_19.a = Mathf.Lerp(0, 1, var_193_18)
				arg_190_1.mask_.color = var_193_19
			end

			if arg_190_1.time_ >= var_193_16 + var_193_17 and arg_190_1.time_ < var_193_16 + var_193_17 + arg_193_0 then
				local var_193_20 = Color.New(0, 0, 0)

				var_193_20.a = 1
				arg_190_1.mask_.color = var_193_20
			end

			local var_193_21 = 2

			if var_193_21 < arg_190_1.time_ and arg_190_1.time_ <= var_193_21 + arg_193_0 then
				arg_190_1.mask_.enabled = true
				arg_190_1.mask_.raycastTarget = true

				arg_190_1:SetGaussion(false)
			end

			local var_193_22 = 2

			if var_193_21 <= arg_190_1.time_ and arg_190_1.time_ < var_193_21 + var_193_22 then
				local var_193_23 = (arg_190_1.time_ - var_193_21) / var_193_22
				local var_193_24 = Color.New(0, 0, 0)

				var_193_24.a = Mathf.Lerp(1, 0, var_193_23)
				arg_190_1.mask_.color = var_193_24
			end

			if arg_190_1.time_ >= var_193_21 + var_193_22 and arg_190_1.time_ < var_193_21 + var_193_22 + arg_193_0 then
				local var_193_25 = Color.New(0, 0, 0)
				local var_193_26 = 0

				arg_190_1.mask_.enabled = false
				var_193_25.a = var_193_26
				arg_190_1.mask_.color = var_193_25
			end

			local var_193_27 = arg_190_1.actors_["1148"].transform
			local var_193_28 = 1.96666666666667

			if var_193_28 < arg_190_1.time_ and arg_190_1.time_ <= var_193_28 + arg_193_0 then
				arg_190_1.var_.moveOldPos1148 = var_193_27.localPosition
				var_193_27.localScale = Vector3.New(1, 1, 1)

				arg_190_1:CheckSpriteTmpPos("1148", 7)

				local var_193_29 = var_193_27.childCount

				for iter_193_2 = 0, var_193_29 - 1 do
					local var_193_30 = var_193_27:GetChild(iter_193_2)

					if var_193_30.name == "" or not string.find(var_193_30.name, "split") then
						var_193_30.gameObject:SetActive(true)
					else
						var_193_30.gameObject:SetActive(false)
					end
				end
			end

			local var_193_31 = 0.001

			if var_193_28 <= arg_190_1.time_ and arg_190_1.time_ < var_193_28 + var_193_31 then
				local var_193_32 = (arg_190_1.time_ - var_193_28) / var_193_31
				local var_193_33 = Vector3.New(0, -2000, 0)

				var_193_27.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1148, var_193_33, var_193_32)
			end

			if arg_190_1.time_ >= var_193_28 + var_193_31 and arg_190_1.time_ < var_193_28 + var_193_31 + arg_193_0 then
				var_193_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_193_34 = arg_190_1.actors_["1148"].transform
			local var_193_35 = 3.66666666666667

			if var_193_35 < arg_190_1.time_ and arg_190_1.time_ <= var_193_35 + arg_193_0 then
				arg_190_1.var_.moveOldPos1148 = var_193_34.localPosition
				var_193_34.localScale = Vector3.New(1, 1, 1)

				arg_190_1:CheckSpriteTmpPos("1148", 3)

				local var_193_36 = var_193_34.childCount

				for iter_193_3 = 0, var_193_36 - 1 do
					local var_193_37 = var_193_34:GetChild(iter_193_3)

					if var_193_37.name == "split_6" or not string.find(var_193_37.name, "split") then
						var_193_37.gameObject:SetActive(true)
					else
						var_193_37.gameObject:SetActive(false)
					end
				end
			end

			local var_193_38 = 0.001

			if var_193_35 <= arg_190_1.time_ and arg_190_1.time_ < var_193_35 + var_193_38 then
				local var_193_39 = (arg_190_1.time_ - var_193_35) / var_193_38
				local var_193_40 = Vector3.New(0, -429, -180)

				var_193_34.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1148, var_193_40, var_193_39)
			end

			if arg_190_1.time_ >= var_193_35 + var_193_38 and arg_190_1.time_ < var_193_35 + var_193_38 + arg_193_0 then
				var_193_34.localPosition = Vector3.New(0, -429, -180)
			end

			local var_193_41 = arg_190_1.actors_["1148"]
			local var_193_42 = 3.66666666666667

			if var_193_42 < arg_190_1.time_ and arg_190_1.time_ <= var_193_42 + arg_193_0 and not isNil(var_193_41) and arg_190_1.var_.actorSpriteComps1148 == nil then
				arg_190_1.var_.actorSpriteComps1148 = var_193_41:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_43 = 0.125

			if var_193_42 <= arg_190_1.time_ and arg_190_1.time_ < var_193_42 + var_193_43 and not isNil(var_193_41) then
				local var_193_44 = (arg_190_1.time_ - var_193_42) / var_193_43

				if arg_190_1.var_.actorSpriteComps1148 then
					for iter_193_4, iter_193_5 in pairs(arg_190_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_193_5 then
							if arg_190_1.isInRecall_ then
								local var_193_45 = Mathf.Lerp(iter_193_5.color.r, arg_190_1.hightColor1.r, var_193_44)
								local var_193_46 = Mathf.Lerp(iter_193_5.color.g, arg_190_1.hightColor1.g, var_193_44)
								local var_193_47 = Mathf.Lerp(iter_193_5.color.b, arg_190_1.hightColor1.b, var_193_44)

								iter_193_5.color = Color.New(var_193_45, var_193_46, var_193_47)
							else
								local var_193_48 = Mathf.Lerp(iter_193_5.color.r, 1, var_193_44)

								iter_193_5.color = Color.New(var_193_48, var_193_48, var_193_48)
							end
						end
					end
				end
			end

			if arg_190_1.time_ >= var_193_42 + var_193_43 and arg_190_1.time_ < var_193_42 + var_193_43 + arg_193_0 and not isNil(var_193_41) and arg_190_1.var_.actorSpriteComps1148 then
				for iter_193_6, iter_193_7 in pairs(arg_190_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_193_7 then
						if arg_190_1.isInRecall_ then
							iter_193_7.color = arg_190_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_193_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_190_1.var_.actorSpriteComps1148 = nil
			end

			local var_193_49 = arg_190_1.actors_["1148"]
			local var_193_50 = 3.66666666666667

			if var_193_50 < arg_190_1.time_ and arg_190_1.time_ <= var_193_50 + arg_193_0 then
				local var_193_51 = var_193_49:GetComponentInChildren(typeof(CanvasGroup))

				if var_193_51 then
					arg_190_1.var_.alphaOldValue1148 = var_193_51.alpha
					arg_190_1.var_.characterEffect1148 = var_193_51
				end

				arg_190_1.var_.alphaOldValue1148 = 0
			end

			local var_193_52 = 0.857666666666667

			if var_193_50 <= arg_190_1.time_ and arg_190_1.time_ < var_193_50 + var_193_52 then
				local var_193_53 = (arg_190_1.time_ - var_193_50) / var_193_52
				local var_193_54 = Mathf.Lerp(arg_190_1.var_.alphaOldValue1148, 1, var_193_53)

				if arg_190_1.var_.characterEffect1148 then
					arg_190_1.var_.characterEffect1148.alpha = var_193_54
				end
			end

			if arg_190_1.time_ >= var_193_50 + var_193_52 and arg_190_1.time_ < var_193_50 + var_193_52 + arg_193_0 and arg_190_1.var_.characterEffect1148 then
				arg_190_1.var_.characterEffect1148.alpha = 1
			end

			if arg_190_1.frameCnt_ <= 1 then
				arg_190_1.dialog_:SetActive(false)
			end

			local var_193_55 = 4
			local var_193_56 = 0.325

			if var_193_55 < arg_190_1.time_ and arg_190_1.time_ <= var_193_55 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0

				arg_190_1.dialog_:SetActive(true)

				arg_190_1.dialogCg_.alpha = 0

				local var_193_57 = LeanTween.value(arg_190_1.dialog_, 0, 1, 0.3)

				var_193_57:setOnUpdate(LuaHelper.FloatAction(function(arg_194_0)
					arg_190_1.dialogCg_.alpha = arg_194_0
				end))
				var_193_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_190_1.dialog_)
					var_193_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_190_1.duration_ = arg_190_1.duration_ + 0.3

				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_58 = arg_190_1:FormatText(StoryNameCfg[8].name)

				arg_190_1.leftNameTxt_.text = var_193_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_59 = arg_190_1:GetWordFromCfg(416091045)
				local var_193_60 = arg_190_1:FormatText(var_193_59.content)

				arg_190_1.text_.text = var_193_60

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_61 = 13
				local var_193_62 = utf8.len(var_193_60)
				local var_193_63 = var_193_61 <= 0 and var_193_56 or var_193_56 * (var_193_62 / var_193_61)

				if var_193_63 > 0 and var_193_56 < var_193_63 then
					arg_190_1.talkMaxDuration = var_193_63
					var_193_55 = var_193_55 + 0.3

					if var_193_63 + var_193_55 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_63 + var_193_55
					end
				end

				arg_190_1.text_.text = var_193_60
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091045", "story_v_out_416091.awb") ~= 0 then
					local var_193_64 = manager.audio:GetVoiceLength("story_v_out_416091", "416091045", "story_v_out_416091.awb") / 1000

					if var_193_64 + var_193_55 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_64 + var_193_55
					end

					if var_193_59.prefab_name ~= "" and arg_190_1.actors_[var_193_59.prefab_name] ~= nil then
						local var_193_65 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_59.prefab_name].transform, "story_v_out_416091", "416091045", "story_v_out_416091.awb")

						arg_190_1:RecordAudio("416091045", var_193_65)
						arg_190_1:RecordAudio("416091045", var_193_65)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_416091", "416091045", "story_v_out_416091.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_416091", "416091045", "story_v_out_416091.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_66 = var_193_55 + 0.3
			local var_193_67 = math.max(var_193_56, arg_190_1.talkMaxDuration)

			if var_193_66 <= arg_190_1.time_ and arg_190_1.time_ < var_193_66 + var_193_67 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_66) / var_193_67

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_66 + var_193_67 and arg_190_1.time_ < var_193_66 + var_193_67 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play416091046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 416091046
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play416091047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["1148"].transform
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.var_.moveOldPos1148 = var_199_0.localPosition
				var_199_0.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("1148", 7)

				local var_199_2 = var_199_0.childCount

				for iter_199_0 = 0, var_199_2 - 1 do
					local var_199_3 = var_199_0:GetChild(iter_199_0)

					if var_199_3.name == "" or not string.find(var_199_3.name, "split") then
						var_199_3.gameObject:SetActive(true)
					else
						var_199_3.gameObject:SetActive(false)
					end
				end
			end

			local var_199_4 = 0.001

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_4 then
				local var_199_5 = (arg_196_1.time_ - var_199_1) / var_199_4
				local var_199_6 = Vector3.New(0, -2000, 0)

				var_199_0.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1148, var_199_6, var_199_5)
			end

			if arg_196_1.time_ >= var_199_1 + var_199_4 and arg_196_1.time_ < var_199_1 + var_199_4 + arg_199_0 then
				var_199_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_199_7 = 0
			local var_199_8 = 1.625

			if var_199_7 < arg_196_1.time_ and arg_196_1.time_ <= var_199_7 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_9 = arg_196_1:GetWordFromCfg(416091046)
				local var_199_10 = arg_196_1:FormatText(var_199_9.content)

				arg_196_1.text_.text = var_199_10

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_11 = 65
				local var_199_12 = utf8.len(var_199_10)
				local var_199_13 = var_199_11 <= 0 and var_199_8 or var_199_8 * (var_199_12 / var_199_11)

				if var_199_13 > 0 and var_199_8 < var_199_13 then
					arg_196_1.talkMaxDuration = var_199_13

					if var_199_13 + var_199_7 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_13 + var_199_7
					end
				end

				arg_196_1.text_.text = var_199_10
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_14 = math.max(var_199_8, arg_196_1.talkMaxDuration)

			if var_199_7 <= arg_196_1.time_ and arg_196_1.time_ < var_199_7 + var_199_14 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_7) / var_199_14

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_7 + var_199_14 and arg_196_1.time_ < var_199_7 + var_199_14 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play416091047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 416091047
		arg_200_1.duration_ = 5.17

		local var_200_0 = {
			zh = 5.166,
			ja = 4.3
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play416091048(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["1148"].transform
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1.var_.moveOldPos1148 = var_203_0.localPosition
				var_203_0.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("1148", 3)

				local var_203_2 = var_203_0.childCount

				for iter_203_0 = 0, var_203_2 - 1 do
					local var_203_3 = var_203_0:GetChild(iter_203_0)

					if var_203_3.name == "split_3" or not string.find(var_203_3.name, "split") then
						var_203_3.gameObject:SetActive(true)
					else
						var_203_3.gameObject:SetActive(false)
					end
				end
			end

			local var_203_4 = 0.001

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_4 then
				local var_203_5 = (arg_200_1.time_ - var_203_1) / var_203_4
				local var_203_6 = Vector3.New(0, -429, -180)

				var_203_0.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1148, var_203_6, var_203_5)
			end

			if arg_200_1.time_ >= var_203_1 + var_203_4 and arg_200_1.time_ < var_203_1 + var_203_4 + arg_203_0 then
				var_203_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_203_7 = arg_200_1.actors_["1148"]
			local var_203_8 = 0

			if var_203_8 < arg_200_1.time_ and arg_200_1.time_ <= var_203_8 + arg_203_0 and not isNil(var_203_7) and arg_200_1.var_.actorSpriteComps1148 == nil then
				arg_200_1.var_.actorSpriteComps1148 = var_203_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_9 = 0.125

			if var_203_8 <= arg_200_1.time_ and arg_200_1.time_ < var_203_8 + var_203_9 and not isNil(var_203_7) then
				local var_203_10 = (arg_200_1.time_ - var_203_8) / var_203_9

				if arg_200_1.var_.actorSpriteComps1148 then
					for iter_203_1, iter_203_2 in pairs(arg_200_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_203_2 then
							if arg_200_1.isInRecall_ then
								local var_203_11 = Mathf.Lerp(iter_203_2.color.r, arg_200_1.hightColor1.r, var_203_10)
								local var_203_12 = Mathf.Lerp(iter_203_2.color.g, arg_200_1.hightColor1.g, var_203_10)
								local var_203_13 = Mathf.Lerp(iter_203_2.color.b, arg_200_1.hightColor1.b, var_203_10)

								iter_203_2.color = Color.New(var_203_11, var_203_12, var_203_13)
							else
								local var_203_14 = Mathf.Lerp(iter_203_2.color.r, 1, var_203_10)

								iter_203_2.color = Color.New(var_203_14, var_203_14, var_203_14)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= var_203_8 + var_203_9 and arg_200_1.time_ < var_203_8 + var_203_9 + arg_203_0 and not isNil(var_203_7) and arg_200_1.var_.actorSpriteComps1148 then
				for iter_203_3, iter_203_4 in pairs(arg_200_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_203_4 then
						if arg_200_1.isInRecall_ then
							iter_203_4.color = arg_200_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_203_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_200_1.var_.actorSpriteComps1148 = nil
			end

			local var_203_15 = 0
			local var_203_16 = 0.4

			if var_203_15 < arg_200_1.time_ and arg_200_1.time_ <= var_203_15 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_17 = arg_200_1:FormatText(StoryNameCfg[8].name)

				arg_200_1.leftNameTxt_.text = var_203_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_18 = arg_200_1:GetWordFromCfg(416091047)
				local var_203_19 = arg_200_1:FormatText(var_203_18.content)

				arg_200_1.text_.text = var_203_19

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_20 = 16
				local var_203_21 = utf8.len(var_203_19)
				local var_203_22 = var_203_20 <= 0 and var_203_16 or var_203_16 * (var_203_21 / var_203_20)

				if var_203_22 > 0 and var_203_16 < var_203_22 then
					arg_200_1.talkMaxDuration = var_203_22

					if var_203_22 + var_203_15 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_22 + var_203_15
					end
				end

				arg_200_1.text_.text = var_203_19
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091047", "story_v_out_416091.awb") ~= 0 then
					local var_203_23 = manager.audio:GetVoiceLength("story_v_out_416091", "416091047", "story_v_out_416091.awb") / 1000

					if var_203_23 + var_203_15 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_23 + var_203_15
					end

					if var_203_18.prefab_name ~= "" and arg_200_1.actors_[var_203_18.prefab_name] ~= nil then
						local var_203_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_18.prefab_name].transform, "story_v_out_416091", "416091047", "story_v_out_416091.awb")

						arg_200_1:RecordAudio("416091047", var_203_24)
						arg_200_1:RecordAudio("416091047", var_203_24)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_416091", "416091047", "story_v_out_416091.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_416091", "416091047", "story_v_out_416091.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_25 = math.max(var_203_16, arg_200_1.talkMaxDuration)

			if var_203_15 <= arg_200_1.time_ and arg_200_1.time_ < var_203_15 + var_203_25 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_15) / var_203_25

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_15 + var_203_25 and arg_200_1.time_ < var_203_15 + var_203_25 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play416091048 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 416091048
		arg_204_1.duration_ = 4.07

		local var_204_0 = {
			zh = 2.1,
			ja = 4.066
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play416091049(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["1148"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.actorSpriteComps1148 == nil then
				arg_204_1.var_.actorSpriteComps1148 = var_207_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_2 = 0.125

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.actorSpriteComps1148 then
					for iter_207_0, iter_207_1 in pairs(arg_204_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_207_1 then
							if arg_204_1.isInRecall_ then
								local var_207_4 = Mathf.Lerp(iter_207_1.color.r, arg_204_1.hightColor2.r, var_207_3)
								local var_207_5 = Mathf.Lerp(iter_207_1.color.g, arg_204_1.hightColor2.g, var_207_3)
								local var_207_6 = Mathf.Lerp(iter_207_1.color.b, arg_204_1.hightColor2.b, var_207_3)

								iter_207_1.color = Color.New(var_207_4, var_207_5, var_207_6)
							else
								local var_207_7 = Mathf.Lerp(iter_207_1.color.r, 0.5, var_207_3)

								iter_207_1.color = Color.New(var_207_7, var_207_7, var_207_7)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.actorSpriteComps1148 then
				for iter_207_2, iter_207_3 in pairs(arg_204_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_207_3 then
						if arg_204_1.isInRecall_ then
							iter_207_3.color = arg_204_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_207_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_204_1.var_.actorSpriteComps1148 = nil
			end

			local var_207_8 = 0
			local var_207_9 = 0.225

			if var_207_8 < arg_204_1.time_ and arg_204_1.time_ <= var_207_8 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_10 = arg_204_1:FormatText(StoryNameCfg[1082].name)

				arg_204_1.leftNameTxt_.text = var_207_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_11 = arg_204_1:GetWordFromCfg(416091048)
				local var_207_12 = arg_204_1:FormatText(var_207_11.content)

				arg_204_1.text_.text = var_207_12

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_13 = 9
				local var_207_14 = utf8.len(var_207_12)
				local var_207_15 = var_207_13 <= 0 and var_207_9 or var_207_9 * (var_207_14 / var_207_13)

				if var_207_15 > 0 and var_207_9 < var_207_15 then
					arg_204_1.talkMaxDuration = var_207_15

					if var_207_15 + var_207_8 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_15 + var_207_8
					end
				end

				arg_204_1.text_.text = var_207_12
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091048", "story_v_out_416091.awb") ~= 0 then
					local var_207_16 = manager.audio:GetVoiceLength("story_v_out_416091", "416091048", "story_v_out_416091.awb") / 1000

					if var_207_16 + var_207_8 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_16 + var_207_8
					end

					if var_207_11.prefab_name ~= "" and arg_204_1.actors_[var_207_11.prefab_name] ~= nil then
						local var_207_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_11.prefab_name].transform, "story_v_out_416091", "416091048", "story_v_out_416091.awb")

						arg_204_1:RecordAudio("416091048", var_207_17)
						arg_204_1:RecordAudio("416091048", var_207_17)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_416091", "416091048", "story_v_out_416091.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_416091", "416091048", "story_v_out_416091.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_18 = math.max(var_207_9, arg_204_1.talkMaxDuration)

			if var_207_8 <= arg_204_1.time_ and arg_204_1.time_ < var_207_8 + var_207_18 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_8) / var_207_18

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_8 + var_207_18 and arg_204_1.time_ < var_207_8 + var_207_18 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play416091049 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 416091049
		arg_208_1.duration_ = 7.03

		local var_208_0 = {
			zh = 5.933,
			ja = 7.033
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play416091050(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["1148"]
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.actorSpriteComps1148 == nil then
				arg_208_1.var_.actorSpriteComps1148 = var_211_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_211_2 = 0.125

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 and not isNil(var_211_0) then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2

				if arg_208_1.var_.actorSpriteComps1148 then
					for iter_211_0, iter_211_1 in pairs(arg_208_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_211_1 then
							if arg_208_1.isInRecall_ then
								local var_211_4 = Mathf.Lerp(iter_211_1.color.r, arg_208_1.hightColor1.r, var_211_3)
								local var_211_5 = Mathf.Lerp(iter_211_1.color.g, arg_208_1.hightColor1.g, var_211_3)
								local var_211_6 = Mathf.Lerp(iter_211_1.color.b, arg_208_1.hightColor1.b, var_211_3)

								iter_211_1.color = Color.New(var_211_4, var_211_5, var_211_6)
							else
								local var_211_7 = Mathf.Lerp(iter_211_1.color.r, 1, var_211_3)

								iter_211_1.color = Color.New(var_211_7, var_211_7, var_211_7)
							end
						end
					end
				end
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.actorSpriteComps1148 then
				for iter_211_2, iter_211_3 in pairs(arg_208_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_211_3 then
						if arg_208_1.isInRecall_ then
							iter_211_3.color = arg_208_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_211_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_208_1.var_.actorSpriteComps1148 = nil
			end

			local var_211_8 = arg_208_1.actors_["1148"].transform
			local var_211_9 = 0

			if var_211_9 < arg_208_1.time_ and arg_208_1.time_ <= var_211_9 + arg_211_0 then
				arg_208_1.var_.moveOldPos1148 = var_211_8.localPosition
				var_211_8.localScale = Vector3.New(1, 1, 1)

				arg_208_1:CheckSpriteTmpPos("1148", 3)

				local var_211_10 = var_211_8.childCount

				for iter_211_4 = 0, var_211_10 - 1 do
					local var_211_11 = var_211_8:GetChild(iter_211_4)

					if var_211_11.name == "split_6" or not string.find(var_211_11.name, "split") then
						var_211_11.gameObject:SetActive(true)
					else
						var_211_11.gameObject:SetActive(false)
					end
				end
			end

			local var_211_12 = 0.001

			if var_211_9 <= arg_208_1.time_ and arg_208_1.time_ < var_211_9 + var_211_12 then
				local var_211_13 = (arg_208_1.time_ - var_211_9) / var_211_12
				local var_211_14 = Vector3.New(0, -429, -180)

				var_211_8.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos1148, var_211_14, var_211_13)
			end

			if arg_208_1.time_ >= var_211_9 + var_211_12 and arg_208_1.time_ < var_211_9 + var_211_12 + arg_211_0 then
				var_211_8.localPosition = Vector3.New(0, -429, -180)
			end

			local var_211_15 = 0
			local var_211_16 = 0.575

			if var_211_15 < arg_208_1.time_ and arg_208_1.time_ <= var_211_15 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_17 = arg_208_1:FormatText(StoryNameCfg[8].name)

				arg_208_1.leftNameTxt_.text = var_211_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_18 = arg_208_1:GetWordFromCfg(416091049)
				local var_211_19 = arg_208_1:FormatText(var_211_18.content)

				arg_208_1.text_.text = var_211_19

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_20 = 23
				local var_211_21 = utf8.len(var_211_19)
				local var_211_22 = var_211_20 <= 0 and var_211_16 or var_211_16 * (var_211_21 / var_211_20)

				if var_211_22 > 0 and var_211_16 < var_211_22 then
					arg_208_1.talkMaxDuration = var_211_22

					if var_211_22 + var_211_15 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_22 + var_211_15
					end
				end

				arg_208_1.text_.text = var_211_19
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091049", "story_v_out_416091.awb") ~= 0 then
					local var_211_23 = manager.audio:GetVoiceLength("story_v_out_416091", "416091049", "story_v_out_416091.awb") / 1000

					if var_211_23 + var_211_15 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_23 + var_211_15
					end

					if var_211_18.prefab_name ~= "" and arg_208_1.actors_[var_211_18.prefab_name] ~= nil then
						local var_211_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_18.prefab_name].transform, "story_v_out_416091", "416091049", "story_v_out_416091.awb")

						arg_208_1:RecordAudio("416091049", var_211_24)
						arg_208_1:RecordAudio("416091049", var_211_24)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_416091", "416091049", "story_v_out_416091.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_416091", "416091049", "story_v_out_416091.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_25 = math.max(var_211_16, arg_208_1.talkMaxDuration)

			if var_211_15 <= arg_208_1.time_ and arg_208_1.time_ < var_211_15 + var_211_25 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_15) / var_211_25

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_15 + var_211_25 and arg_208_1.time_ < var_211_15 + var_211_25 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play416091050 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 416091050
		arg_212_1.duration_ = 5.2

		local var_212_0 = {
			zh = 3,
			ja = 5.2
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play416091051(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0
			local var_215_1 = 0.375

			if var_215_0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_2 = arg_212_1:FormatText(StoryNameCfg[8].name)

				arg_212_1.leftNameTxt_.text = var_215_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_3 = arg_212_1:GetWordFromCfg(416091050)
				local var_215_4 = arg_212_1:FormatText(var_215_3.content)

				arg_212_1.text_.text = var_215_4

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_5 = 15
				local var_215_6 = utf8.len(var_215_4)
				local var_215_7 = var_215_5 <= 0 and var_215_1 or var_215_1 * (var_215_6 / var_215_5)

				if var_215_7 > 0 and var_215_1 < var_215_7 then
					arg_212_1.talkMaxDuration = var_215_7

					if var_215_7 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_7 + var_215_0
					end
				end

				arg_212_1.text_.text = var_215_4
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091050", "story_v_out_416091.awb") ~= 0 then
					local var_215_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091050", "story_v_out_416091.awb") / 1000

					if var_215_8 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_8 + var_215_0
					end

					if var_215_3.prefab_name ~= "" and arg_212_1.actors_[var_215_3.prefab_name] ~= nil then
						local var_215_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_3.prefab_name].transform, "story_v_out_416091", "416091050", "story_v_out_416091.awb")

						arg_212_1:RecordAudio("416091050", var_215_9)
						arg_212_1:RecordAudio("416091050", var_215_9)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_416091", "416091050", "story_v_out_416091.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_416091", "416091050", "story_v_out_416091.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_10 = math.max(var_215_1, arg_212_1.talkMaxDuration)

			if var_215_0 <= arg_212_1.time_ and arg_212_1.time_ < var_215_0 + var_215_10 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_0) / var_215_10

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_0 + var_215_10 and arg_212_1.time_ < var_215_0 + var_215_10 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play416091051 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 416091051
		arg_216_1.duration_ = 2.77

		local var_216_0 = {
			zh = 2.76633333333333,
			ja = 2.69933333333333
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play416091052(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1148"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.actorSpriteComps1148 == nil then
				arg_216_1.var_.actorSpriteComps1148 = var_219_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_2 = 0.125

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 and not isNil(var_219_0) then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2

				if arg_216_1.var_.actorSpriteComps1148 then
					for iter_219_0, iter_219_1 in pairs(arg_216_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_219_1 then
							if arg_216_1.isInRecall_ then
								local var_219_4 = Mathf.Lerp(iter_219_1.color.r, arg_216_1.hightColor2.r, var_219_3)
								local var_219_5 = Mathf.Lerp(iter_219_1.color.g, arg_216_1.hightColor2.g, var_219_3)
								local var_219_6 = Mathf.Lerp(iter_219_1.color.b, arg_216_1.hightColor2.b, var_219_3)

								iter_219_1.color = Color.New(var_219_4, var_219_5, var_219_6)
							else
								local var_219_7 = Mathf.Lerp(iter_219_1.color.r, 0.5, var_219_3)

								iter_219_1.color = Color.New(var_219_7, var_219_7, var_219_7)
							end
						end
					end
				end
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.actorSpriteComps1148 then
				for iter_219_2, iter_219_3 in pairs(arg_216_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_219_3 then
						if arg_216_1.isInRecall_ then
							iter_219_3.color = arg_216_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_219_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_216_1.var_.actorSpriteComps1148 = nil
			end

			if arg_216_1.frameCnt_ <= 1 then
				arg_216_1.dialog_:SetActive(false)
			end

			local var_219_8 = 0.633333333333333
			local var_219_9 = 0.3

			if var_219_8 < arg_216_1.time_ and arg_216_1.time_ <= var_219_8 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0

				arg_216_1.dialog_:SetActive(true)

				arg_216_1.dialogCg_.alpha = 0

				local var_219_10 = LeanTween.value(arg_216_1.dialog_, 0, 1, 0.3)

				var_219_10:setOnUpdate(LuaHelper.FloatAction(function(arg_220_0)
					arg_216_1.dialogCg_.alpha = arg_220_0
				end))
				var_219_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_216_1.dialog_)
					var_219_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_216_1.duration_ = arg_216_1.duration_ + 0.3

				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_11 = arg_216_1:FormatText(StoryNameCfg[1082].name)

				arg_216_1.leftNameTxt_.text = var_219_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, true)
				arg_216_1.iconController_:SetSelectedState("hero")

				arg_216_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_216_1.callingController_:SetSelectedState("normal")

				arg_216_1.keyicon_.color = Color.New(1, 1, 1)
				arg_216_1.icon_.color = Color.New(1, 1, 1)

				local var_219_12 = arg_216_1:GetWordFromCfg(416091051)
				local var_219_13 = arg_216_1:FormatText(var_219_12.content)

				arg_216_1.text_.text = var_219_13

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_14 = 12
				local var_219_15 = utf8.len(var_219_13)
				local var_219_16 = var_219_14 <= 0 and var_219_9 or var_219_9 * (var_219_15 / var_219_14)

				if var_219_16 > 0 and var_219_9 < var_219_16 then
					arg_216_1.talkMaxDuration = var_219_16
					var_219_8 = var_219_8 + 0.3

					if var_219_16 + var_219_8 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_16 + var_219_8
					end
				end

				arg_216_1.text_.text = var_219_13
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091051", "story_v_out_416091.awb") ~= 0 then
					local var_219_17 = manager.audio:GetVoiceLength("story_v_out_416091", "416091051", "story_v_out_416091.awb") / 1000

					if var_219_17 + var_219_8 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_17 + var_219_8
					end

					if var_219_12.prefab_name ~= "" and arg_216_1.actors_[var_219_12.prefab_name] ~= nil then
						local var_219_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_12.prefab_name].transform, "story_v_out_416091", "416091051", "story_v_out_416091.awb")

						arg_216_1:RecordAudio("416091051", var_219_18)
						arg_216_1:RecordAudio("416091051", var_219_18)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_416091", "416091051", "story_v_out_416091.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_416091", "416091051", "story_v_out_416091.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_19 = var_219_8 + 0.3
			local var_219_20 = math.max(var_219_9, arg_216_1.talkMaxDuration)

			if var_219_19 <= arg_216_1.time_ and arg_216_1.time_ < var_219_19 + var_219_20 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_19) / var_219_20

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_19 + var_219_20 and arg_216_1.time_ < var_219_19 + var_219_20 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play416091052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 416091052
		arg_222_1.duration_ = 6.37

		local var_222_0 = {
			zh = 4.9,
			ja = 6.366
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play416091053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["1148"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.actorSpriteComps1148 == nil then
				arg_222_1.var_.actorSpriteComps1148 = var_225_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_2 = 0.125

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.actorSpriteComps1148 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_225_1 then
							if arg_222_1.isInRecall_ then
								local var_225_4 = Mathf.Lerp(iter_225_1.color.r, arg_222_1.hightColor1.r, var_225_3)
								local var_225_5 = Mathf.Lerp(iter_225_1.color.g, arg_222_1.hightColor1.g, var_225_3)
								local var_225_6 = Mathf.Lerp(iter_225_1.color.b, arg_222_1.hightColor1.b, var_225_3)

								iter_225_1.color = Color.New(var_225_4, var_225_5, var_225_6)
							else
								local var_225_7 = Mathf.Lerp(iter_225_1.color.r, 1, var_225_3)

								iter_225_1.color = Color.New(var_225_7, var_225_7, var_225_7)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.actorSpriteComps1148 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_225_3 then
						if arg_222_1.isInRecall_ then
							iter_225_3.color = arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_225_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_222_1.var_.actorSpriteComps1148 = nil
			end

			local var_225_8 = 0
			local var_225_9 = 0.55

			if var_225_8 < arg_222_1.time_ and arg_222_1.time_ <= var_225_8 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_10 = arg_222_1:FormatText(StoryNameCfg[8].name)

				arg_222_1.leftNameTxt_.text = var_225_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_11 = arg_222_1:GetWordFromCfg(416091052)
				local var_225_12 = arg_222_1:FormatText(var_225_11.content)

				arg_222_1.text_.text = var_225_12

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_13 = 22
				local var_225_14 = utf8.len(var_225_12)
				local var_225_15 = var_225_13 <= 0 and var_225_9 or var_225_9 * (var_225_14 / var_225_13)

				if var_225_15 > 0 and var_225_9 < var_225_15 then
					arg_222_1.talkMaxDuration = var_225_15

					if var_225_15 + var_225_8 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_15 + var_225_8
					end
				end

				arg_222_1.text_.text = var_225_12
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091052", "story_v_out_416091.awb") ~= 0 then
					local var_225_16 = manager.audio:GetVoiceLength("story_v_out_416091", "416091052", "story_v_out_416091.awb") / 1000

					if var_225_16 + var_225_8 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_16 + var_225_8
					end

					if var_225_11.prefab_name ~= "" and arg_222_1.actors_[var_225_11.prefab_name] ~= nil then
						local var_225_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_11.prefab_name].transform, "story_v_out_416091", "416091052", "story_v_out_416091.awb")

						arg_222_1:RecordAudio("416091052", var_225_17)
						arg_222_1:RecordAudio("416091052", var_225_17)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_416091", "416091052", "story_v_out_416091.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_416091", "416091052", "story_v_out_416091.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_18 = math.max(var_225_9, arg_222_1.talkMaxDuration)

			if var_225_8 <= arg_222_1.time_ and arg_222_1.time_ < var_225_8 + var_225_18 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_8) / var_225_18

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_8 + var_225_18 and arg_222_1.time_ < var_225_8 + var_225_18 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play416091053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 416091053
		arg_226_1.duration_ = 5.13

		local var_226_0 = {
			zh = 3.333,
			ja = 5.133
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play416091054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["1148"]
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.actorSpriteComps1148 == nil then
				arg_226_1.var_.actorSpriteComps1148 = var_229_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_2 = 0.125

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 and not isNil(var_229_0) then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2

				if arg_226_1.var_.actorSpriteComps1148 then
					for iter_229_0, iter_229_1 in pairs(arg_226_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_229_1 then
							if arg_226_1.isInRecall_ then
								local var_229_4 = Mathf.Lerp(iter_229_1.color.r, arg_226_1.hightColor2.r, var_229_3)
								local var_229_5 = Mathf.Lerp(iter_229_1.color.g, arg_226_1.hightColor2.g, var_229_3)
								local var_229_6 = Mathf.Lerp(iter_229_1.color.b, arg_226_1.hightColor2.b, var_229_3)

								iter_229_1.color = Color.New(var_229_4, var_229_5, var_229_6)
							else
								local var_229_7 = Mathf.Lerp(iter_229_1.color.r, 0.5, var_229_3)

								iter_229_1.color = Color.New(var_229_7, var_229_7, var_229_7)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.actorSpriteComps1148 then
				for iter_229_2, iter_229_3 in pairs(arg_226_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_229_3 then
						if arg_226_1.isInRecall_ then
							iter_229_3.color = arg_226_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_229_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_226_1.var_.actorSpriteComps1148 = nil
			end

			local var_229_8 = 0
			local var_229_9 = 0.45

			if var_229_8 < arg_226_1.time_ and arg_226_1.time_ <= var_229_8 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_10 = arg_226_1:FormatText(StoryNameCfg[1082].name)

				arg_226_1.leftNameTxt_.text = var_229_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_11 = arg_226_1:GetWordFromCfg(416091053)
				local var_229_12 = arg_226_1:FormatText(var_229_11.content)

				arg_226_1.text_.text = var_229_12

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_13 = 18
				local var_229_14 = utf8.len(var_229_12)
				local var_229_15 = var_229_13 <= 0 and var_229_9 or var_229_9 * (var_229_14 / var_229_13)

				if var_229_15 > 0 and var_229_9 < var_229_15 then
					arg_226_1.talkMaxDuration = var_229_15

					if var_229_15 + var_229_8 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_15 + var_229_8
					end
				end

				arg_226_1.text_.text = var_229_12
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091053", "story_v_out_416091.awb") ~= 0 then
					local var_229_16 = manager.audio:GetVoiceLength("story_v_out_416091", "416091053", "story_v_out_416091.awb") / 1000

					if var_229_16 + var_229_8 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_16 + var_229_8
					end

					if var_229_11.prefab_name ~= "" and arg_226_1.actors_[var_229_11.prefab_name] ~= nil then
						local var_229_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_11.prefab_name].transform, "story_v_out_416091", "416091053", "story_v_out_416091.awb")

						arg_226_1:RecordAudio("416091053", var_229_17)
						arg_226_1:RecordAudio("416091053", var_229_17)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_416091", "416091053", "story_v_out_416091.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_416091", "416091053", "story_v_out_416091.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_18 = math.max(var_229_9, arg_226_1.talkMaxDuration)

			if var_229_8 <= arg_226_1.time_ and arg_226_1.time_ < var_229_8 + var_229_18 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_8) / var_229_18

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_8 + var_229_18 and arg_226_1.time_ < var_229_8 + var_229_18 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play416091054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 416091054
		arg_230_1.duration_ = 2.53

		local var_230_0 = {
			zh = 2.533,
			ja = 1.9
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play416091055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["1148"]
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.actorSpriteComps1148 == nil then
				arg_230_1.var_.actorSpriteComps1148 = var_233_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_2 = 0.125

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 and not isNil(var_233_0) then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2

				if arg_230_1.var_.actorSpriteComps1148 then
					for iter_233_0, iter_233_1 in pairs(arg_230_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_233_1 then
							if arg_230_1.isInRecall_ then
								local var_233_4 = Mathf.Lerp(iter_233_1.color.r, arg_230_1.hightColor1.r, var_233_3)
								local var_233_5 = Mathf.Lerp(iter_233_1.color.g, arg_230_1.hightColor1.g, var_233_3)
								local var_233_6 = Mathf.Lerp(iter_233_1.color.b, arg_230_1.hightColor1.b, var_233_3)

								iter_233_1.color = Color.New(var_233_4, var_233_5, var_233_6)
							else
								local var_233_7 = Mathf.Lerp(iter_233_1.color.r, 1, var_233_3)

								iter_233_1.color = Color.New(var_233_7, var_233_7, var_233_7)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.actorSpriteComps1148 then
				for iter_233_2, iter_233_3 in pairs(arg_230_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_233_3 then
						if arg_230_1.isInRecall_ then
							iter_233_3.color = arg_230_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_233_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_230_1.var_.actorSpriteComps1148 = nil
			end

			local var_233_8 = 0
			local var_233_9 = 0.125

			if var_233_8 < arg_230_1.time_ and arg_230_1.time_ <= var_233_8 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_10 = arg_230_1:FormatText(StoryNameCfg[8].name)

				arg_230_1.leftNameTxt_.text = var_233_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_11 = arg_230_1:GetWordFromCfg(416091054)
				local var_233_12 = arg_230_1:FormatText(var_233_11.content)

				arg_230_1.text_.text = var_233_12

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_13 = 5
				local var_233_14 = utf8.len(var_233_12)
				local var_233_15 = var_233_13 <= 0 and var_233_9 or var_233_9 * (var_233_14 / var_233_13)

				if var_233_15 > 0 and var_233_9 < var_233_15 then
					arg_230_1.talkMaxDuration = var_233_15

					if var_233_15 + var_233_8 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_15 + var_233_8
					end
				end

				arg_230_1.text_.text = var_233_12
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091054", "story_v_out_416091.awb") ~= 0 then
					local var_233_16 = manager.audio:GetVoiceLength("story_v_out_416091", "416091054", "story_v_out_416091.awb") / 1000

					if var_233_16 + var_233_8 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_16 + var_233_8
					end

					if var_233_11.prefab_name ~= "" and arg_230_1.actors_[var_233_11.prefab_name] ~= nil then
						local var_233_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_11.prefab_name].transform, "story_v_out_416091", "416091054", "story_v_out_416091.awb")

						arg_230_1:RecordAudio("416091054", var_233_17)
						arg_230_1:RecordAudio("416091054", var_233_17)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_416091", "416091054", "story_v_out_416091.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_416091", "416091054", "story_v_out_416091.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_18 = math.max(var_233_9, arg_230_1.talkMaxDuration)

			if var_233_8 <= arg_230_1.time_ and arg_230_1.time_ < var_233_8 + var_233_18 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_8) / var_233_18

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_8 + var_233_18 and arg_230_1.time_ < var_233_8 + var_233_18 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play416091055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 416091055
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play416091056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["1148"].transform
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 then
				arg_234_1.var_.moveOldPos1148 = var_237_0.localPosition
				var_237_0.localScale = Vector3.New(1, 1, 1)

				arg_234_1:CheckSpriteTmpPos("1148", 7)

				local var_237_2 = var_237_0.childCount

				for iter_237_0 = 0, var_237_2 - 1 do
					local var_237_3 = var_237_0:GetChild(iter_237_0)

					if var_237_3.name == "" or not string.find(var_237_3.name, "split") then
						var_237_3.gameObject:SetActive(true)
					else
						var_237_3.gameObject:SetActive(false)
					end
				end
			end

			local var_237_4 = 0.001

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_4 then
				local var_237_5 = (arg_234_1.time_ - var_237_1) / var_237_4
				local var_237_6 = Vector3.New(0, -2000, 0)

				var_237_0.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1148, var_237_6, var_237_5)
			end

			if arg_234_1.time_ >= var_237_1 + var_237_4 and arg_234_1.time_ < var_237_1 + var_237_4 + arg_237_0 then
				var_237_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_237_7 = 0
			local var_237_8 = 1.125

			if var_237_7 < arg_234_1.time_ and arg_234_1.time_ <= var_237_7 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_9 = arg_234_1:GetWordFromCfg(416091055)
				local var_237_10 = arg_234_1:FormatText(var_237_9.content)

				arg_234_1.text_.text = var_237_10

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_11 = 45
				local var_237_12 = utf8.len(var_237_10)
				local var_237_13 = var_237_11 <= 0 and var_237_8 or var_237_8 * (var_237_12 / var_237_11)

				if var_237_13 > 0 and var_237_8 < var_237_13 then
					arg_234_1.talkMaxDuration = var_237_13

					if var_237_13 + var_237_7 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_13 + var_237_7
					end
				end

				arg_234_1.text_.text = var_237_10
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_14 = math.max(var_237_8, arg_234_1.talkMaxDuration)

			if var_237_7 <= arg_234_1.time_ and arg_234_1.time_ < var_237_7 + var_237_14 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_7) / var_237_14

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_7 + var_237_14 and arg_234_1.time_ < var_237_7 + var_237_14 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play416091056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 416091056
		arg_238_1.duration_ = 4.8

		local var_238_0 = {
			zh = 4.133,
			ja = 4.8
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play416091057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["1148"].transform
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.var_.moveOldPos1148 = var_241_0.localPosition
				var_241_0.localScale = Vector3.New(1, 1, 1)

				arg_238_1:CheckSpriteTmpPos("1148", 3)

				local var_241_2 = var_241_0.childCount

				for iter_241_0 = 0, var_241_2 - 1 do
					local var_241_3 = var_241_0:GetChild(iter_241_0)

					if var_241_3.name == "split_6" or not string.find(var_241_3.name, "split") then
						var_241_3.gameObject:SetActive(true)
					else
						var_241_3.gameObject:SetActive(false)
					end
				end
			end

			local var_241_4 = 0.001

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_4 then
				local var_241_5 = (arg_238_1.time_ - var_241_1) / var_241_4
				local var_241_6 = Vector3.New(0, -429, -180)

				var_241_0.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1148, var_241_6, var_241_5)
			end

			if arg_238_1.time_ >= var_241_1 + var_241_4 and arg_238_1.time_ < var_241_1 + var_241_4 + arg_241_0 then
				var_241_0.localPosition = Vector3.New(0, -429, -180)
			end

			local var_241_7 = arg_238_1.actors_["1148"]
			local var_241_8 = 0

			if var_241_8 < arg_238_1.time_ and arg_238_1.time_ <= var_241_8 + arg_241_0 and not isNil(var_241_7) and arg_238_1.var_.actorSpriteComps1148 == nil then
				arg_238_1.var_.actorSpriteComps1148 = var_241_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_9 = 0.125

			if var_241_8 <= arg_238_1.time_ and arg_238_1.time_ < var_241_8 + var_241_9 and not isNil(var_241_7) then
				local var_241_10 = (arg_238_1.time_ - var_241_8) / var_241_9

				if arg_238_1.var_.actorSpriteComps1148 then
					for iter_241_1, iter_241_2 in pairs(arg_238_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_241_2 then
							if arg_238_1.isInRecall_ then
								local var_241_11 = Mathf.Lerp(iter_241_2.color.r, arg_238_1.hightColor1.r, var_241_10)
								local var_241_12 = Mathf.Lerp(iter_241_2.color.g, arg_238_1.hightColor1.g, var_241_10)
								local var_241_13 = Mathf.Lerp(iter_241_2.color.b, arg_238_1.hightColor1.b, var_241_10)

								iter_241_2.color = Color.New(var_241_11, var_241_12, var_241_13)
							else
								local var_241_14 = Mathf.Lerp(iter_241_2.color.r, 1, var_241_10)

								iter_241_2.color = Color.New(var_241_14, var_241_14, var_241_14)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= var_241_8 + var_241_9 and arg_238_1.time_ < var_241_8 + var_241_9 + arg_241_0 and not isNil(var_241_7) and arg_238_1.var_.actorSpriteComps1148 then
				for iter_241_3, iter_241_4 in pairs(arg_238_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_241_4 then
						if arg_238_1.isInRecall_ then
							iter_241_4.color = arg_238_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_241_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_238_1.var_.actorSpriteComps1148 = nil
			end

			local var_241_15 = 0
			local var_241_16 = 0.525

			if var_241_15 < arg_238_1.time_ and arg_238_1.time_ <= var_241_15 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_17 = arg_238_1:FormatText(StoryNameCfg[8].name)

				arg_238_1.leftNameTxt_.text = var_241_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_18 = arg_238_1:GetWordFromCfg(416091056)
				local var_241_19 = arg_238_1:FormatText(var_241_18.content)

				arg_238_1.text_.text = var_241_19

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_20 = 21
				local var_241_21 = utf8.len(var_241_19)
				local var_241_22 = var_241_20 <= 0 and var_241_16 or var_241_16 * (var_241_21 / var_241_20)

				if var_241_22 > 0 and var_241_16 < var_241_22 then
					arg_238_1.talkMaxDuration = var_241_22

					if var_241_22 + var_241_15 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_22 + var_241_15
					end
				end

				arg_238_1.text_.text = var_241_19
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091056", "story_v_out_416091.awb") ~= 0 then
					local var_241_23 = manager.audio:GetVoiceLength("story_v_out_416091", "416091056", "story_v_out_416091.awb") / 1000

					if var_241_23 + var_241_15 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_23 + var_241_15
					end

					if var_241_18.prefab_name ~= "" and arg_238_1.actors_[var_241_18.prefab_name] ~= nil then
						local var_241_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_18.prefab_name].transform, "story_v_out_416091", "416091056", "story_v_out_416091.awb")

						arg_238_1:RecordAudio("416091056", var_241_24)
						arg_238_1:RecordAudio("416091056", var_241_24)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_416091", "416091056", "story_v_out_416091.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_416091", "416091056", "story_v_out_416091.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_25 = math.max(var_241_16, arg_238_1.talkMaxDuration)

			if var_241_15 <= arg_238_1.time_ and arg_238_1.time_ < var_241_15 + var_241_25 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_15) / var_241_25

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_15 + var_241_25 and arg_238_1.time_ < var_241_15 + var_241_25 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play416091057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 416091057
		arg_242_1.duration_ = 7.7

		local var_242_0 = {
			zh = 7.7,
			ja = 6.4
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play416091058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 0
			local var_245_1 = 0.8

			if var_245_0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_2 = arg_242_1:FormatText(StoryNameCfg[8].name)

				arg_242_1.leftNameTxt_.text = var_245_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_3 = arg_242_1:GetWordFromCfg(416091057)
				local var_245_4 = arg_242_1:FormatText(var_245_3.content)

				arg_242_1.text_.text = var_245_4

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_5 = 32
				local var_245_6 = utf8.len(var_245_4)
				local var_245_7 = var_245_5 <= 0 and var_245_1 or var_245_1 * (var_245_6 / var_245_5)

				if var_245_7 > 0 and var_245_1 < var_245_7 then
					arg_242_1.talkMaxDuration = var_245_7

					if var_245_7 + var_245_0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_7 + var_245_0
					end
				end

				arg_242_1.text_.text = var_245_4
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091057", "story_v_out_416091.awb") ~= 0 then
					local var_245_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091057", "story_v_out_416091.awb") / 1000

					if var_245_8 + var_245_0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_8 + var_245_0
					end

					if var_245_3.prefab_name ~= "" and arg_242_1.actors_[var_245_3.prefab_name] ~= nil then
						local var_245_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_3.prefab_name].transform, "story_v_out_416091", "416091057", "story_v_out_416091.awb")

						arg_242_1:RecordAudio("416091057", var_245_9)
						arg_242_1:RecordAudio("416091057", var_245_9)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_416091", "416091057", "story_v_out_416091.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_416091", "416091057", "story_v_out_416091.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_10 = math.max(var_245_1, arg_242_1.talkMaxDuration)

			if var_245_0 <= arg_242_1.time_ and arg_242_1.time_ < var_245_0 + var_245_10 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_0) / var_245_10

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_0 + var_245_10 and arg_242_1.time_ < var_245_0 + var_245_10 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play416091058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 416091058
		arg_246_1.duration_ = 5.47

		local var_246_0 = {
			zh = 3.866,
			ja = 5.466
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play416091059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0
			local var_249_1 = 0.55

			if var_249_0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_2 = arg_246_1:FormatText(StoryNameCfg[8].name)

				arg_246_1.leftNameTxt_.text = var_249_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_3 = arg_246_1:GetWordFromCfg(416091058)
				local var_249_4 = arg_246_1:FormatText(var_249_3.content)

				arg_246_1.text_.text = var_249_4

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_5 = 22
				local var_249_6 = utf8.len(var_249_4)
				local var_249_7 = var_249_5 <= 0 and var_249_1 or var_249_1 * (var_249_6 / var_249_5)

				if var_249_7 > 0 and var_249_1 < var_249_7 then
					arg_246_1.talkMaxDuration = var_249_7

					if var_249_7 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_7 + var_249_0
					end
				end

				arg_246_1.text_.text = var_249_4
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091058", "story_v_out_416091.awb") ~= 0 then
					local var_249_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091058", "story_v_out_416091.awb") / 1000

					if var_249_8 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_8 + var_249_0
					end

					if var_249_3.prefab_name ~= "" and arg_246_1.actors_[var_249_3.prefab_name] ~= nil then
						local var_249_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_3.prefab_name].transform, "story_v_out_416091", "416091058", "story_v_out_416091.awb")

						arg_246_1:RecordAudio("416091058", var_249_9)
						arg_246_1:RecordAudio("416091058", var_249_9)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_416091", "416091058", "story_v_out_416091.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_416091", "416091058", "story_v_out_416091.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_10 = math.max(var_249_1, arg_246_1.talkMaxDuration)

			if var_249_0 <= arg_246_1.time_ and arg_246_1.time_ < var_249_0 + var_249_10 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_0) / var_249_10

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_0 + var_249_10 and arg_246_1.time_ < var_249_0 + var_249_10 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play416091059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 416091059
		arg_250_1.duration_ = 4.47

		local var_250_0 = {
			zh = 4.366,
			ja = 4.466
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play416091060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0
			local var_253_1 = 0.425

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_2 = arg_250_1:FormatText(StoryNameCfg[8].name)

				arg_250_1.leftNameTxt_.text = var_253_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_3 = arg_250_1:GetWordFromCfg(416091059)
				local var_253_4 = arg_250_1:FormatText(var_253_3.content)

				arg_250_1.text_.text = var_253_4

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_5 = 17
				local var_253_6 = utf8.len(var_253_4)
				local var_253_7 = var_253_5 <= 0 and var_253_1 or var_253_1 * (var_253_6 / var_253_5)

				if var_253_7 > 0 and var_253_1 < var_253_7 then
					arg_250_1.talkMaxDuration = var_253_7

					if var_253_7 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_7 + var_253_0
					end
				end

				arg_250_1.text_.text = var_253_4
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091059", "story_v_out_416091.awb") ~= 0 then
					local var_253_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091059", "story_v_out_416091.awb") / 1000

					if var_253_8 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_8 + var_253_0
					end

					if var_253_3.prefab_name ~= "" and arg_250_1.actors_[var_253_3.prefab_name] ~= nil then
						local var_253_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_3.prefab_name].transform, "story_v_out_416091", "416091059", "story_v_out_416091.awb")

						arg_250_1:RecordAudio("416091059", var_253_9)
						arg_250_1:RecordAudio("416091059", var_253_9)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_416091", "416091059", "story_v_out_416091.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_416091", "416091059", "story_v_out_416091.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_10 = math.max(var_253_1, arg_250_1.talkMaxDuration)

			if var_253_0 <= arg_250_1.time_ and arg_250_1.time_ < var_253_0 + var_253_10 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_0) / var_253_10

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_0 + var_253_10 and arg_250_1.time_ < var_253_0 + var_253_10 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play416091060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 416091060
		arg_254_1.duration_ = 3.63

		local var_254_0 = {
			zh = 2.6,
			ja = 3.633
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play416091061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["1148"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.actorSpriteComps1148 == nil then
				arg_254_1.var_.actorSpriteComps1148 = var_257_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_2 = 0.125

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.actorSpriteComps1148 then
					for iter_257_0, iter_257_1 in pairs(arg_254_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_257_1 then
							if arg_254_1.isInRecall_ then
								local var_257_4 = Mathf.Lerp(iter_257_1.color.r, arg_254_1.hightColor2.r, var_257_3)
								local var_257_5 = Mathf.Lerp(iter_257_1.color.g, arg_254_1.hightColor2.g, var_257_3)
								local var_257_6 = Mathf.Lerp(iter_257_1.color.b, arg_254_1.hightColor2.b, var_257_3)

								iter_257_1.color = Color.New(var_257_4, var_257_5, var_257_6)
							else
								local var_257_7 = Mathf.Lerp(iter_257_1.color.r, 0.5, var_257_3)

								iter_257_1.color = Color.New(var_257_7, var_257_7, var_257_7)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.actorSpriteComps1148 then
				for iter_257_2, iter_257_3 in pairs(arg_254_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_257_3 then
						if arg_254_1.isInRecall_ then
							iter_257_3.color = arg_254_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_257_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_254_1.var_.actorSpriteComps1148 = nil
			end

			local var_257_8 = 0
			local var_257_9 = 0.325

			if var_257_8 < arg_254_1.time_ and arg_254_1.time_ <= var_257_8 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_10 = arg_254_1:FormatText(StoryNameCfg[1082].name)

				arg_254_1.leftNameTxt_.text = var_257_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, true)
				arg_254_1.iconController_:SetSelectedState("hero")

				arg_254_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_254_1.callingController_:SetSelectedState("normal")

				arg_254_1.keyicon_.color = Color.New(1, 1, 1)
				arg_254_1.icon_.color = Color.New(1, 1, 1)

				local var_257_11 = arg_254_1:GetWordFromCfg(416091060)
				local var_257_12 = arg_254_1:FormatText(var_257_11.content)

				arg_254_1.text_.text = var_257_12

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_13 = 13
				local var_257_14 = utf8.len(var_257_12)
				local var_257_15 = var_257_13 <= 0 and var_257_9 or var_257_9 * (var_257_14 / var_257_13)

				if var_257_15 > 0 and var_257_9 < var_257_15 then
					arg_254_1.talkMaxDuration = var_257_15

					if var_257_15 + var_257_8 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_15 + var_257_8
					end
				end

				arg_254_1.text_.text = var_257_12
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091060", "story_v_out_416091.awb") ~= 0 then
					local var_257_16 = manager.audio:GetVoiceLength("story_v_out_416091", "416091060", "story_v_out_416091.awb") / 1000

					if var_257_16 + var_257_8 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_16 + var_257_8
					end

					if var_257_11.prefab_name ~= "" and arg_254_1.actors_[var_257_11.prefab_name] ~= nil then
						local var_257_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_11.prefab_name].transform, "story_v_out_416091", "416091060", "story_v_out_416091.awb")

						arg_254_1:RecordAudio("416091060", var_257_17)
						arg_254_1:RecordAudio("416091060", var_257_17)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_416091", "416091060", "story_v_out_416091.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_416091", "416091060", "story_v_out_416091.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_18 = math.max(var_257_9, arg_254_1.talkMaxDuration)

			if var_257_8 <= arg_254_1.time_ and arg_254_1.time_ < var_257_8 + var_257_18 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_8) / var_257_18

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_8 + var_257_18 and arg_254_1.time_ < var_257_8 + var_257_18 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play416091061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 416091061
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play416091062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["1148"].transform
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
				arg_258_1.var_.moveOldPos1148 = var_261_0.localPosition
				var_261_0.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("1148", 7)

				local var_261_2 = var_261_0.childCount

				for iter_261_0 = 0, var_261_2 - 1 do
					local var_261_3 = var_261_0:GetChild(iter_261_0)

					if var_261_3.name == "split_6" or not string.find(var_261_3.name, "split") then
						var_261_3.gameObject:SetActive(true)
					else
						var_261_3.gameObject:SetActive(false)
					end
				end
			end

			local var_261_4 = 0.001

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_4 then
				local var_261_5 = (arg_258_1.time_ - var_261_1) / var_261_4
				local var_261_6 = Vector3.New(0, -2000, 0)

				var_261_0.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1148, var_261_6, var_261_5)
			end

			if arg_258_1.time_ >= var_261_1 + var_261_4 and arg_258_1.time_ < var_261_1 + var_261_4 + arg_261_0 then
				var_261_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_261_7 = 0
			local var_261_8 = 1.075

			if var_261_7 < arg_258_1.time_ and arg_258_1.time_ <= var_261_7 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, false)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_9 = arg_258_1:GetWordFromCfg(416091061)
				local var_261_10 = arg_258_1:FormatText(var_261_9.content)

				arg_258_1.text_.text = var_261_10

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_11 = 43
				local var_261_12 = utf8.len(var_261_10)
				local var_261_13 = var_261_11 <= 0 and var_261_8 or var_261_8 * (var_261_12 / var_261_11)

				if var_261_13 > 0 and var_261_8 < var_261_13 then
					arg_258_1.talkMaxDuration = var_261_13

					if var_261_13 + var_261_7 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_13 + var_261_7
					end
				end

				arg_258_1.text_.text = var_261_10
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_14 = math.max(var_261_8, arg_258_1.talkMaxDuration)

			if var_261_7 <= arg_258_1.time_ and arg_258_1.time_ < var_261_7 + var_261_14 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_7) / var_261_14

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_7 + var_261_14 and arg_258_1.time_ < var_261_7 + var_261_14 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play416091062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 416091062
		arg_262_1.duration_ = 3.27

		local var_262_0 = {
			zh = 2.9,
			ja = 3.266
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play416091063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["1148"]
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.actorSpriteComps1148 == nil then
				arg_262_1.var_.actorSpriteComps1148 = var_265_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_2 = 0.125

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 and not isNil(var_265_0) then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2

				if arg_262_1.var_.actorSpriteComps1148 then
					for iter_265_0, iter_265_1 in pairs(arg_262_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_265_1 then
							if arg_262_1.isInRecall_ then
								local var_265_4 = Mathf.Lerp(iter_265_1.color.r, arg_262_1.hightColor1.r, var_265_3)
								local var_265_5 = Mathf.Lerp(iter_265_1.color.g, arg_262_1.hightColor1.g, var_265_3)
								local var_265_6 = Mathf.Lerp(iter_265_1.color.b, arg_262_1.hightColor1.b, var_265_3)

								iter_265_1.color = Color.New(var_265_4, var_265_5, var_265_6)
							else
								local var_265_7 = Mathf.Lerp(iter_265_1.color.r, 1, var_265_3)

								iter_265_1.color = Color.New(var_265_7, var_265_7, var_265_7)
							end
						end
					end
				end
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.actorSpriteComps1148 then
				for iter_265_2, iter_265_3 in pairs(arg_262_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_265_3 then
						if arg_262_1.isInRecall_ then
							iter_265_3.color = arg_262_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_265_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_262_1.var_.actorSpriteComps1148 = nil
			end

			local var_265_8 = arg_262_1.actors_["1148"].transform
			local var_265_9 = 0

			if var_265_9 < arg_262_1.time_ and arg_262_1.time_ <= var_265_9 + arg_265_0 then
				arg_262_1.var_.moveOldPos1148 = var_265_8.localPosition
				var_265_8.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("1148", 3)

				local var_265_10 = var_265_8.childCount

				for iter_265_4 = 0, var_265_10 - 1 do
					local var_265_11 = var_265_8:GetChild(iter_265_4)

					if var_265_11.name == "" or not string.find(var_265_11.name, "split") then
						var_265_11.gameObject:SetActive(true)
					else
						var_265_11.gameObject:SetActive(false)
					end
				end
			end

			local var_265_12 = 0.001

			if var_265_9 <= arg_262_1.time_ and arg_262_1.time_ < var_265_9 + var_265_12 then
				local var_265_13 = (arg_262_1.time_ - var_265_9) / var_265_12
				local var_265_14 = Vector3.New(0, -429, -180)

				var_265_8.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1148, var_265_14, var_265_13)
			end

			if arg_262_1.time_ >= var_265_9 + var_265_12 and arg_262_1.time_ < var_265_9 + var_265_12 + arg_265_0 then
				var_265_8.localPosition = Vector3.New(0, -429, -180)
			end

			local var_265_15 = 0
			local var_265_16 = 0.225

			if var_265_15 < arg_262_1.time_ and arg_262_1.time_ <= var_265_15 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_17 = arg_262_1:FormatText(StoryNameCfg[8].name)

				arg_262_1.leftNameTxt_.text = var_265_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_18 = arg_262_1:GetWordFromCfg(416091062)
				local var_265_19 = arg_262_1:FormatText(var_265_18.content)

				arg_262_1.text_.text = var_265_19

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_20 = 9
				local var_265_21 = utf8.len(var_265_19)
				local var_265_22 = var_265_20 <= 0 and var_265_16 or var_265_16 * (var_265_21 / var_265_20)

				if var_265_22 > 0 and var_265_16 < var_265_22 then
					arg_262_1.talkMaxDuration = var_265_22

					if var_265_22 + var_265_15 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_22 + var_265_15
					end
				end

				arg_262_1.text_.text = var_265_19
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091062", "story_v_out_416091.awb") ~= 0 then
					local var_265_23 = manager.audio:GetVoiceLength("story_v_out_416091", "416091062", "story_v_out_416091.awb") / 1000

					if var_265_23 + var_265_15 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_23 + var_265_15
					end

					if var_265_18.prefab_name ~= "" and arg_262_1.actors_[var_265_18.prefab_name] ~= nil then
						local var_265_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_18.prefab_name].transform, "story_v_out_416091", "416091062", "story_v_out_416091.awb")

						arg_262_1:RecordAudio("416091062", var_265_24)
						arg_262_1:RecordAudio("416091062", var_265_24)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_416091", "416091062", "story_v_out_416091.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_416091", "416091062", "story_v_out_416091.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_25 = math.max(var_265_16, arg_262_1.talkMaxDuration)

			if var_265_15 <= arg_262_1.time_ and arg_262_1.time_ < var_265_15 + var_265_25 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_15) / var_265_25

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_15 + var_265_25 and arg_262_1.time_ < var_265_15 + var_265_25 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play416091063 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 416091063
		arg_266_1.duration_ = 9.7

		local var_266_0 = {
			zh = 5.4,
			ja = 9.7
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play416091064(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0
			local var_269_1 = 0.675

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_2 = arg_266_1:FormatText(StoryNameCfg[8].name)

				arg_266_1.leftNameTxt_.text = var_269_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_3 = arg_266_1:GetWordFromCfg(416091063)
				local var_269_4 = arg_266_1:FormatText(var_269_3.content)

				arg_266_1.text_.text = var_269_4

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 27
				local var_269_6 = utf8.len(var_269_4)
				local var_269_7 = var_269_5 <= 0 and var_269_1 or var_269_1 * (var_269_6 / var_269_5)

				if var_269_7 > 0 and var_269_1 < var_269_7 then
					arg_266_1.talkMaxDuration = var_269_7

					if var_269_7 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_7 + var_269_0
					end
				end

				arg_266_1.text_.text = var_269_4
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091063", "story_v_out_416091.awb") ~= 0 then
					local var_269_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091063", "story_v_out_416091.awb") / 1000

					if var_269_8 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_8 + var_269_0
					end

					if var_269_3.prefab_name ~= "" and arg_266_1.actors_[var_269_3.prefab_name] ~= nil then
						local var_269_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_3.prefab_name].transform, "story_v_out_416091", "416091063", "story_v_out_416091.awb")

						arg_266_1:RecordAudio("416091063", var_269_9)
						arg_266_1:RecordAudio("416091063", var_269_9)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_416091", "416091063", "story_v_out_416091.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_416091", "416091063", "story_v_out_416091.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_10 = math.max(var_269_1, arg_266_1.talkMaxDuration)

			if var_269_0 <= arg_266_1.time_ and arg_266_1.time_ < var_269_0 + var_269_10 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_0) / var_269_10

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_0 + var_269_10 and arg_266_1.time_ < var_269_0 + var_269_10 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play416091064 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 416091064
		arg_270_1.duration_ = 7.67

		local var_270_0 = {
			zh = 4.966,
			ja = 7.666
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
			arg_270_1.auto_ = false
		end

		function arg_270_1.playNext_(arg_272_0)
			arg_270_1.onStoryFinished_()
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0
			local var_273_1 = 0.65

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_2 = arg_270_1:FormatText(StoryNameCfg[8].name)

				arg_270_1.leftNameTxt_.text = var_273_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_3 = arg_270_1:GetWordFromCfg(416091064)
				local var_273_4 = arg_270_1:FormatText(var_273_3.content)

				arg_270_1.text_.text = var_273_4

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 26
				local var_273_6 = utf8.len(var_273_4)
				local var_273_7 = var_273_5 <= 0 and var_273_1 or var_273_1 * (var_273_6 / var_273_5)

				if var_273_7 > 0 and var_273_1 < var_273_7 then
					arg_270_1.talkMaxDuration = var_273_7

					if var_273_7 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_7 + var_273_0
					end
				end

				arg_270_1.text_.text = var_273_4
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091064", "story_v_out_416091.awb") ~= 0 then
					local var_273_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091064", "story_v_out_416091.awb") / 1000

					if var_273_8 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_8 + var_273_0
					end

					if var_273_3.prefab_name ~= "" and arg_270_1.actors_[var_273_3.prefab_name] ~= nil then
						local var_273_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_3.prefab_name].transform, "story_v_out_416091", "416091064", "story_v_out_416091.awb")

						arg_270_1:RecordAudio("416091064", var_273_9)
						arg_270_1:RecordAudio("416091064", var_273_9)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_416091", "416091064", "story_v_out_416091.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_416091", "416091064", "story_v_out_416091.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_10 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_10 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_10

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_10 and arg_270_1.time_ < var_273_0 + var_273_10 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2101",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST0106",
		"TextureConfig/Background/I14f"
	},
	voices = {
		"story_v_out_416091.awb"
	}
}
