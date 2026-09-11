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
			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= 2 + 0.133333333333333 and arg_1_1.time_ < 2 + 0.133333333333333 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_0 = "ST2101"

			if arg_1_1.bgs_.ST2101 == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_2 = arg_1_1.bgs_.ST2101

				arg_1_1.bgs_.ST2101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_3 = var_4_2:GetComponent("SpriteRenderer")

				if var_4_3 and var_4_3.sprite then
					local var_4_4 = 2 * (var_4_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_2.transform.localScale = Vector3.New(var_4_4 / var_4_3.sprite.bounds.size.y < var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x and var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x or var_4_4 / var_4_3.sprite.bounds.size.y, var_4_4 / var_4_3.sprite.bounds.size.y < var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x and var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x or var_4_4 / var_4_3.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST2101" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			local var_4_9 = "1033"

			if arg_1_1.actors_["1033"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1033")

				if not isNil(var_4_10) then
					local var_4_11 = Object.Instantiate(var_4_10, arg_1_1.canvasGo_.transform)

					var_4_11.transform:SetSiblingIndex(1)

					var_4_11.name = var_4_9
					var_4_11.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_9] = var_4_11

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs((var_4_11:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_12 = arg_1_1.actors_["1033"]

			if 1.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.66666666666667 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps1033 == nil then
				arg_1_1.var_.actorSpriteComps1033 = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.125

			if 1.66666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.66666666666667 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps1033 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								iter_4_5.color = Color.New(Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 1.66666666666667) / var_4_13), Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 1.66666666666667) / var_4_13), (Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 1.66666666666667) / var_4_13)))
							else
								local var_4_14 = Mathf.Lerp(iter_4_5.color.r, 1, (arg_1_1.time_ - 1.66666666666667) / var_4_13)

								iter_4_5.color = Color.New(var_4_14, var_4_14, var_4_14)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 1.66666666666667 + var_4_13 and arg_1_1.time_ < 1.66666666666667 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps1033 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps1033 = nil
			end

			local var_4_15 = arg_1_1.actors_["1033"].transform

			if 1.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.66666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPos1033 = var_4_15.localPosition
				var_4_15.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1033", 3)

				for iter_4_8 = 0, var_4_15.childCount - 1 do
					local var_4_16 = var_4_15:GetChild(iter_4_8)

					if var_4_16.name == "split_6" or not string.find(var_4_16.name, "split") then
						var_4_16.gameObject:SetActive(true)
					else
						var_4_16.gameObject:SetActive(false)
					end
				end
			end

			local var_4_17 = 0.001

			if 1.66666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.66666666666667 + var_4_17 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_1_1.time_ - 1.66666666666667) / var_4_17)
			end

			if arg_1_1.time_ >= 1.66666666666667 + var_4_17 and arg_1_1.time_ < 1.66666666666667 + var_4_17 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(0, -420, 0)
			end

			if 1.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.66666666666667 + arg_4_0 then
				local var_4_18 = arg_1_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_18 then
					arg_1_1.var_.alphaOldValue1033 = var_4_18.alpha
					arg_1_1.var_.characterEffect1033 = var_4_18
				end

				arg_1_1.var_.alphaOldValue1033 = 0
			end

			local var_4_19 = 0.366666666666666

			if 1.66666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.66666666666667 + var_4_19 then
				if arg_1_1.var_.characterEffect1033 then
					arg_1_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue1033, 1, (arg_1_1.time_ - 1.66666666666667) / var_4_19)
				end
			end

			if arg_1_1.time_ >= 1.66666666666667 + var_4_19 and arg_1_1.time_ < 1.66666666666667 + var_4_19 + arg_4_0 and arg_1_1.var_.characterEffect1033 then
				arg_1_1.var_.characterEffect1033.alpha = 1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_22 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_22 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_22

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_22
						arg_1_1.bgmTxt2_.text = var_4_22
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

			if 0.466666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.466666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_8_story_corg", "bgm_activity_3_8_story_corg", "bgm_activity_3_8_story_corg.awb")

				local var_4_25 = manager.audio:GetAudioName("bgm_activity_3_8_story_corg", "bgm_activity_3_8_story_corg")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_25 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_25

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_25
						arg_1_1.bgmTxt2_.text = var_4_25
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

			local var_4_26 = 2
			local var_4_27 = 0.325

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_28 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_28:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_29 = arg_1_1:GetWordFromCfg(416091001)
				local var_4_30 = arg_1_1:FormatText(var_4_29.content)

				arg_1_1.text_.text = var_4_30

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_32 = 13 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 13)

				if (13 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 13)) > 0 and var_4_27 < var_4_32 then
					arg_1_1.talkMaxDuration = var_4_32
					var_4_26 = var_4_26 + 0.3

					if var_4_32 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_26
					end
				end

				arg_1_1.text_.text = var_4_30
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091001", "story_v_out_416091.awb") ~= 0 then
					local var_4_33 = manager.audio:GetVoiceLength("story_v_out_416091", "416091001", "story_v_out_416091.awb") / 1000

					if var_4_33 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_33 + var_4_26
					end

					if var_4_29.prefab_name ~= "" and arg_1_1.actors_[var_4_29.prefab_name] ~= nil then
						local var_4_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_29.prefab_name].transform, "story_v_out_416091", "416091001", "story_v_out_416091.awb")

						arg_1_1:RecordAudio("416091001", var_4_34)
						arg_1_1:RecordAudio("416091001", var_4_34)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416091", "416091001", "story_v_out_416091.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416091", "416091001", "story_v_out_416091.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_35 = var_4_26 + 0.3
			local var_4_36 = math.max(var_4_27, arg_1_1.talkMaxDuration)

			if var_4_26 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_35 + var_4_36 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_35) / var_4_36

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_35 + var_4_36 and arg_1_1.time_ < var_4_35 + var_4_36 + arg_4_0 then
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
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1033 = arg_9_1.actors_["1033"].transform.localPosition
				arg_9_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1033", 7)

				for iter_12_0 = 0, arg_9_1.actors_["1033"].transform.childCount - 1 do
					local var_12_0 = arg_9_1.actors_["1033"].transform:GetChild(iter_12_0)

					if var_12_0.name == "split_6" or not string.find(var_12_0.name, "split") then
						var_12_0.gameObject:SetActive(true)
					else
						var_12_0.gameObject:SetActive(false)
					end
				end
			end

			local var_12_1 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_1 then
				arg_9_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_9_1.time_ - 0) / var_12_1)
			end

			if arg_9_1.time_ >= 0 + var_12_1 and arg_9_1.time_ < 0 + var_12_1 + arg_12_0 then
				arg_9_1.actors_["1033"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_12_2 = 0
			local var_12_3 = 1.275

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_2 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_4 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(416091002).content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_6 = 51 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_4) / 51)

				if (51 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_4) / 51)) > 0 and var_12_3 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_2 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_2
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_3, arg_9_1.talkMaxDuration)

			if var_12_2 <= arg_9_1.time_ and arg_9_1.time_ < var_12_2 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_2) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_2 + var_12_7 and arg_9_1.time_ < var_12_2 + var_12_7 + arg_12_0 then
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
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1033 = arg_13_1.actors_["1033"].transform.localPosition
				arg_13_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1033", 3)

				for iter_16_0 = 0, arg_13_1.actors_["1033"].transform.childCount - 1 do
					local var_16_0 = arg_13_1.actors_["1033"].transform:GetChild(iter_16_0)

					if var_16_0.name == "split_6" or not string.find(var_16_0.name, "split") then
						var_16_0.gameObject:SetActive(true)
					else
						var_16_0.gameObject:SetActive(false)
					end
				end
			end

			local var_16_1 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_1 then
				arg_13_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_13_1.time_ - 0) / var_16_1)
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 then
				arg_13_1.actors_["1033"].transform.localPosition = Vector3.New(0, -420, 0)
			end

			local var_16_2 = arg_13_1.actors_["1033"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps1033 == nil then
				arg_13_1.var_.actorSpriteComps1033 = var_16_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_3 = 0.125

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_3 and not isNil(var_16_2) then
				if arg_13_1.var_.actorSpriteComps1033 then
					for iter_16_1, iter_16_2 in pairs(arg_13_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_16_2 then
							if arg_13_1.isInRecall_ then
								iter_16_2.color = Color.New(Mathf.Lerp(iter_16_2.color.r, arg_13_1.hightColor1.r, (arg_13_1.time_ - 0) / var_16_3), Mathf.Lerp(iter_16_2.color.g, arg_13_1.hightColor1.g, (arg_13_1.time_ - 0) / var_16_3), (Mathf.Lerp(iter_16_2.color.b, arg_13_1.hightColor1.b, (arg_13_1.time_ - 0) / var_16_3)))
							else
								local var_16_4 = Mathf.Lerp(iter_16_2.color.r, 1, (arg_13_1.time_ - 0) / var_16_3)

								iter_16_2.color = Color.New(var_16_4, var_16_4, var_16_4)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_3 and arg_13_1.time_ < 0 + var_16_3 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps1033 then
				for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_16_4 then
						iter_16_4.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps1033 = nil
			end

			local var_16_5 = 0
			local var_16_6 = 0.525

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_7 = arg_13_1:GetWordFromCfg(416091003)
				local var_16_8 = arg_13_1:FormatText(var_16_7.content)

				arg_13_1.text_.text = var_16_8

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_10 = 21 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 21)

				if (21 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 21)) > 0 and var_16_6 < var_16_10 then
					arg_13_1.talkMaxDuration = var_16_10

					if var_16_10 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_5
					end
				end

				arg_13_1.text_.text = var_16_8
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091003", "story_v_out_416091.awb") ~= 0 then
					local var_16_11 = manager.audio:GetVoiceLength("story_v_out_416091", "416091003", "story_v_out_416091.awb") / 1000

					if var_16_11 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_11 + var_16_5
					end

					if var_16_7.prefab_name ~= "" and arg_13_1.actors_[var_16_7.prefab_name] ~= nil then
						local var_16_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_7.prefab_name].transform, "story_v_out_416091", "416091003", "story_v_out_416091.awb")

						arg_13_1:RecordAudio("416091003", var_16_12)
						arg_13_1:RecordAudio("416091003", var_16_12)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_416091", "416091003", "story_v_out_416091.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_416091", "416091003", "story_v_out_416091.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_13 = math.max(var_16_6, arg_13_1.talkMaxDuration)

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_13 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_5) / var_16_13

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_5 + var_16_13 and arg_13_1.time_ < var_16_5 + var_16_13 + arg_16_0 then
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
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1033"]) and arg_17_1.var_.actorSpriteComps1033 == nil then
				arg_17_1.var_.actorSpriteComps1033 = arg_17_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_0 = 0.125

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1033"]) then
				if arg_17_1.var_.actorSpriteComps1033 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_20_1 then
							if arg_17_1.isInRecall_ then
								iter_20_1.color = Color.New(Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor2.r, (arg_17_1.time_ - 0) / var_20_0), Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor2.g, (arg_17_1.time_ - 0) / var_20_0), (Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor2.b, (arg_17_1.time_ - 0) / var_20_0)))
							else
								local var_20_1 = Mathf.Lerp(iter_20_1.color.r, 0.5, (arg_17_1.time_ - 0) / var_20_0)

								iter_20_1.color = Color.New(var_20_1, var_20_1, var_20_1)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1033"]) and arg_17_1.var_.actorSpriteComps1033 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_20_3 then
						iter_20_3.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_17_1.var_.actorSpriteComps1033 = nil
			end

			local var_20_2 = "10054"

			if arg_17_1.actors_["10054"] == nil then
				local var_20_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10054")

				if not isNil(var_20_3) then
					local var_20_4 = Object.Instantiate(var_20_3, arg_17_1.canvasGo_.transform)

					var_20_4.transform:SetSiblingIndex(1)

					var_20_4.name = var_20_2
					var_20_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_[var_20_2] = var_20_4

					if arg_17_1.isInRecall_ then
						for iter_20_4, iter_20_5 in ipairs((var_20_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_20_5.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_5 = arg_17_1.actors_["10054"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.actorSpriteComps10054 == nil then
				arg_17_1.var_.actorSpriteComps10054 = var_20_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_6 = 0.125

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.actorSpriteComps10054 then
					for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_20_7 then
							if arg_17_1.isInRecall_ then
								iter_20_7.color = Color.New(Mathf.Lerp(iter_20_7.color.r, arg_17_1.hightColor1.r, (arg_17_1.time_ - 0) / var_20_6), Mathf.Lerp(iter_20_7.color.g, arg_17_1.hightColor1.g, (arg_17_1.time_ - 0) / var_20_6), (Mathf.Lerp(iter_20_7.color.b, arg_17_1.hightColor1.b, (arg_17_1.time_ - 0) / var_20_6)))
							else
								local var_20_7 = Mathf.Lerp(iter_20_7.color.r, 1, (arg_17_1.time_ - 0) / var_20_6)

								iter_20_7.color = Color.New(var_20_7, var_20_7, var_20_7)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.actorSpriteComps10054 then
				for iter_20_8, iter_20_9 in pairs(arg_17_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_20_9 then
						iter_20_9.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps10054 = nil
			end

			local var_20_8 = arg_17_1.actors_["10054"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10054 = var_20_8.localPosition
				var_20_8.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10054", 4)

				for iter_20_10 = 0, var_20_8.childCount - 1 do
					local var_20_9 = var_20_8:GetChild(iter_20_10)

					if var_20_9.name == "" or not string.find(var_20_9.name, "split") then
						var_20_9.gameObject:SetActive(true)
					else
						var_20_9.gameObject:SetActive(false)
					end
				end
			end

			local var_20_10 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_10 then
				var_20_8.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10054, Vector3.New(390, -331.1, -274.72), (arg_17_1.time_ - 0) / var_20_10)
			end

			if arg_17_1.time_ >= 0 + var_20_10 and arg_17_1.time_ < 0 + var_20_10 + arg_20_0 then
				var_20_8.localPosition = Vector3.New(390, -331.1, -274.72)
			end

			local var_20_11 = arg_17_1.actors_["1033"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1033 = var_20_11.localPosition
				var_20_11.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1033", 2)

				for iter_20_11 = 0, var_20_11.childCount - 1 do
					local var_20_12 = var_20_11:GetChild(iter_20_11)

					if var_20_12.name == "split_6" or not string.find(var_20_12.name, "split") then
						var_20_12.gameObject:SetActive(true)
					else
						var_20_12.gameObject:SetActive(false)
					end
				end
			end

			local var_20_13 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_13 then
				var_20_11.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_17_1.time_ - 0) / var_20_13)
			end

			if arg_17_1.time_ >= 0 + var_20_13 and arg_17_1.time_ < 0 + var_20_13 + arg_20_0 then
				var_20_11.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_20_14 = 0
			local var_20_15 = 0.475

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_14 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_16 = arg_17_1:GetWordFromCfg(416091004)
				local var_20_17 = arg_17_1:FormatText(var_20_16.content)

				arg_17_1.text_.text = var_20_17

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_19 = 19 <= 0 and var_20_15 or var_20_15 * (utf8.len(var_20_17) / 19)

				if (19 <= 0 and var_20_15 or var_20_15 * (utf8.len(var_20_17) / 19)) > 0 and var_20_15 < var_20_19 then
					arg_17_1.talkMaxDuration = var_20_19

					if var_20_19 + var_20_14 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_19 + var_20_14
					end
				end

				arg_17_1.text_.text = var_20_17
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091004", "story_v_out_416091.awb") ~= 0 then
					local var_20_20 = manager.audio:GetVoiceLength("story_v_out_416091", "416091004", "story_v_out_416091.awb") / 1000

					if var_20_20 + var_20_14 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_20 + var_20_14
					end

					if var_20_16.prefab_name ~= "" and arg_17_1.actors_[var_20_16.prefab_name] ~= nil then
						local var_20_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_16.prefab_name].transform, "story_v_out_416091", "416091004", "story_v_out_416091.awb")

						arg_17_1:RecordAudio("416091004", var_20_21)
						arg_17_1:RecordAudio("416091004", var_20_21)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_416091", "416091004", "story_v_out_416091.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_416091", "416091004", "story_v_out_416091.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_22 = math.max(var_20_15, arg_17_1.talkMaxDuration)

			if var_20_14 <= arg_17_1.time_ and arg_17_1.time_ < var_20_14 + var_20_22 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_14) / var_20_22

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_14 + var_20_22 and arg_17_1.time_ < var_20_14 + var_20_22 + arg_20_0 then
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
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1033"]) and arg_21_1.var_.actorSpriteComps1033 == nil then
				arg_21_1.var_.actorSpriteComps1033 = arg_21_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_0 = 0.125

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1033"]) then
				if arg_21_1.var_.actorSpriteComps1033 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_24_1 then
							if arg_21_1.isInRecall_ then
								iter_24_1.color = Color.New(Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_0), Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_0), (Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_0)))
							else
								local var_24_1 = Mathf.Lerp(iter_24_1.color.r, 1, (arg_21_1.time_ - 0) / var_24_0)

								iter_24_1.color = Color.New(var_24_1, var_24_1, var_24_1)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1033"]) and arg_21_1.var_.actorSpriteComps1033 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_24_3 then
						iter_24_3.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps1033 = nil
			end

			local var_24_2 = arg_21_1.actors_["10054"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps10054 == nil then
				arg_21_1.var_.actorSpriteComps10054 = var_24_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_3 = 0.125

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.actorSpriteComps10054 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_24_5 then
							if arg_21_1.isInRecall_ then
								iter_24_5.color = Color.New(Mathf.Lerp(iter_24_5.color.r, arg_21_1.hightColor2.r, (arg_21_1.time_ - 0) / var_24_3), Mathf.Lerp(iter_24_5.color.g, arg_21_1.hightColor2.g, (arg_21_1.time_ - 0) / var_24_3), (Mathf.Lerp(iter_24_5.color.b, arg_21_1.hightColor2.b, (arg_21_1.time_ - 0) / var_24_3)))
							else
								local var_24_4 = Mathf.Lerp(iter_24_5.color.r, 0.5, (arg_21_1.time_ - 0) / var_24_3)

								iter_24_5.color = Color.New(var_24_4, var_24_4, var_24_4)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps10054 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_24_7 then
						iter_24_7.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps10054 = nil
			end

			local var_24_5 = 0
			local var_24_6 = 0.3

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_7 = arg_21_1:GetWordFromCfg(416091005)
				local var_24_8 = arg_21_1:FormatText(var_24_7.content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 12 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 12)

				if (12 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 12)) > 0 and var_24_6 < var_24_10 then
					arg_21_1.talkMaxDuration = var_24_10

					if var_24_10 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_8
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091005", "story_v_out_416091.awb") ~= 0 then
					local var_24_11 = manager.audio:GetVoiceLength("story_v_out_416091", "416091005", "story_v_out_416091.awb") / 1000

					if var_24_11 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_5
					end

					if var_24_7.prefab_name ~= "" and arg_21_1.actors_[var_24_7.prefab_name] ~= nil then
						local var_24_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_7.prefab_name].transform, "story_v_out_416091", "416091005", "story_v_out_416091.awb")

						arg_21_1:RecordAudio("416091005", var_24_12)
						arg_21_1:RecordAudio("416091005", var_24_12)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_416091", "416091005", "story_v_out_416091.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_416091", "416091005", "story_v_out_416091.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_13 = math.max(var_24_6, arg_21_1.talkMaxDuration)

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_13 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_5) / var_24_13

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_5 + var_24_13 and arg_21_1.time_ < var_24_5 + var_24_13 + arg_24_0 then
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
			local var_28_0 = 0.825

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:GetWordFromCfg(416091006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 33 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 33)

				if (33 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 33)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091006", "story_v_out_416091.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_416091", "416091006", "story_v_out_416091.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_416091", "416091006", "story_v_out_416091.awb")

						arg_25_1:RecordAudio("416091006", var_28_6)
						arg_25_1:RecordAudio("416091006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_416091", "416091006", "story_v_out_416091.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_416091", "416091006", "story_v_out_416091.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
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
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1033"]) and arg_29_1.var_.actorSpriteComps1033 == nil then
				arg_29_1.var_.actorSpriteComps1033 = arg_29_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_0 = 0.125

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1033"]) then
				if arg_29_1.var_.actorSpriteComps1033 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_32_1 then
							if arg_29_1.isInRecall_ then
								iter_32_1.color = Color.New(Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor2.r, (arg_29_1.time_ - 0) / var_32_0), Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor2.g, (arg_29_1.time_ - 0) / var_32_0), (Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor2.b, (arg_29_1.time_ - 0) / var_32_0)))
							else
								local var_32_1 = Mathf.Lerp(iter_32_1.color.r, 0.5, (arg_29_1.time_ - 0) / var_32_0)

								iter_32_1.color = Color.New(var_32_1, var_32_1, var_32_1)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1033"]) and arg_29_1.var_.actorSpriteComps1033 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_32_3 then
						iter_32_3.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps1033 = nil
			end

			local var_32_2 = arg_29_1.actors_["10054"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10054 == nil then
				arg_29_1.var_.actorSpriteComps10054 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 0.125

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps10054 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_32_5 then
							if arg_29_1.isInRecall_ then
								iter_32_5.color = Color.New(Mathf.Lerp(iter_32_5.color.r, arg_29_1.hightColor1.r, (arg_29_1.time_ - 0) / var_32_3), Mathf.Lerp(iter_32_5.color.g, arg_29_1.hightColor1.g, (arg_29_1.time_ - 0) / var_32_3), (Mathf.Lerp(iter_32_5.color.b, arg_29_1.hightColor1.b, (arg_29_1.time_ - 0) / var_32_3)))
							else
								local var_32_4 = Mathf.Lerp(iter_32_5.color.r, 1, (arg_29_1.time_ - 0) / var_32_3)

								iter_32_5.color = Color.New(var_32_4, var_32_4, var_32_4)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10054 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_32_7 then
						iter_32_7.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps10054 = nil
			end

			local var_32_5 = 0
			local var_32_6 = 0.65

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_7 = arg_29_1:GetWordFromCfg(416091007)
				local var_32_8 = arg_29_1:FormatText(var_32_7.content)

				arg_29_1.text_.text = var_32_8

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 26 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 26)

				if (26 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 26)) > 0 and var_32_6 < var_32_10 then
					arg_29_1.talkMaxDuration = var_32_10

					if var_32_10 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_5
					end
				end

				arg_29_1.text_.text = var_32_8
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091007", "story_v_out_416091.awb") ~= 0 then
					local var_32_11 = manager.audio:GetVoiceLength("story_v_out_416091", "416091007", "story_v_out_416091.awb") / 1000

					if var_32_11 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_5
					end

					if var_32_7.prefab_name ~= "" and arg_29_1.actors_[var_32_7.prefab_name] ~= nil then
						local var_32_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_7.prefab_name].transform, "story_v_out_416091", "416091007", "story_v_out_416091.awb")

						arg_29_1:RecordAudio("416091007", var_32_12)
						arg_29_1:RecordAudio("416091007", var_32_12)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_416091", "416091007", "story_v_out_416091.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_416091", "416091007", "story_v_out_416091.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_13 = math.max(var_32_6, arg_29_1.talkMaxDuration)

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_13 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_5) / var_32_13

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_5 + var_32_13 and arg_29_1.time_ < var_32_5 + var_32_13 + arg_32_0 then
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
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1033"]) and arg_33_1.var_.actorSpriteComps1033 == nil then
				arg_33_1.var_.actorSpriteComps1033 = arg_33_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 0.125

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1033"]) then
				if arg_33_1.var_.actorSpriteComps1033 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_36_1 then
							if arg_33_1.isInRecall_ then
								iter_36_1.color = Color.New(Mathf.Lerp(iter_36_1.color.r, arg_33_1.hightColor1.r, (arg_33_1.time_ - 0) / var_36_0), Mathf.Lerp(iter_36_1.color.g, arg_33_1.hightColor1.g, (arg_33_1.time_ - 0) / var_36_0), (Mathf.Lerp(iter_36_1.color.b, arg_33_1.hightColor1.b, (arg_33_1.time_ - 0) / var_36_0)))
							else
								local var_36_1 = Mathf.Lerp(iter_36_1.color.r, 1, (arg_33_1.time_ - 0) / var_36_0)

								iter_36_1.color = Color.New(var_36_1, var_36_1, var_36_1)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1033"]) and arg_33_1.var_.actorSpriteComps1033 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps1033 = nil
			end

			local var_36_2 = arg_33_1.actors_["10054"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps10054 == nil then
				arg_33_1.var_.actorSpriteComps10054 = var_36_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_3 = 0.125

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.actorSpriteComps10054 then
					for iter_36_4, iter_36_5 in pairs(arg_33_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_36_5 then
							if arg_33_1.isInRecall_ then
								iter_36_5.color = Color.New(Mathf.Lerp(iter_36_5.color.r, arg_33_1.hightColor2.r, (arg_33_1.time_ - 0) / var_36_3), Mathf.Lerp(iter_36_5.color.g, arg_33_1.hightColor2.g, (arg_33_1.time_ - 0) / var_36_3), (Mathf.Lerp(iter_36_5.color.b, arg_33_1.hightColor2.b, (arg_33_1.time_ - 0) / var_36_3)))
							else
								local var_36_4 = Mathf.Lerp(iter_36_5.color.r, 0.5, (arg_33_1.time_ - 0) / var_36_3)

								iter_36_5.color = Color.New(var_36_4, var_36_4, var_36_4)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps10054 then
				for iter_36_6, iter_36_7 in pairs(arg_33_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_36_7 then
						iter_36_7.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps10054 = nil
			end

			local var_36_5 = 0
			local var_36_6 = 0.875

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_7 = arg_33_1:GetWordFromCfg(416091008)
				local var_36_8 = arg_33_1:FormatText(var_36_7.content)

				arg_33_1.text_.text = var_36_8

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 35 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 35)

				if (35 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 35)) > 0 and var_36_6 < var_36_10 then
					arg_33_1.talkMaxDuration = var_36_10

					if var_36_10 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_8
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091008", "story_v_out_416091.awb") ~= 0 then
					local var_36_11 = manager.audio:GetVoiceLength("story_v_out_416091", "416091008", "story_v_out_416091.awb") / 1000

					if var_36_11 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_5
					end

					if var_36_7.prefab_name ~= "" and arg_33_1.actors_[var_36_7.prefab_name] ~= nil then
						local var_36_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_7.prefab_name].transform, "story_v_out_416091", "416091008", "story_v_out_416091.awb")

						arg_33_1:RecordAudio("416091008", var_36_12)
						arg_33_1:RecordAudio("416091008", var_36_12)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_416091", "416091008", "story_v_out_416091.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_416091", "416091008", "story_v_out_416091.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_13 = math.max(var_36_6, arg_33_1.talkMaxDuration)

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_13 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_5) / var_36_13

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_5 + var_36_13 and arg_33_1.time_ < var_36_5 + var_36_13 + arg_36_0 then
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
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1033"]) and arg_37_1.var_.actorSpriteComps1033 == nil then
				arg_37_1.var_.actorSpriteComps1033 = arg_37_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_0 = 0.125

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1033"]) then
				if arg_37_1.var_.actorSpriteComps1033 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_40_1 then
							if arg_37_1.isInRecall_ then
								iter_40_1.color = Color.New(Mathf.Lerp(iter_40_1.color.r, arg_37_1.hightColor2.r, (arg_37_1.time_ - 0) / var_40_0), Mathf.Lerp(iter_40_1.color.g, arg_37_1.hightColor2.g, (arg_37_1.time_ - 0) / var_40_0), (Mathf.Lerp(iter_40_1.color.b, arg_37_1.hightColor2.b, (arg_37_1.time_ - 0) / var_40_0)))
							else
								local var_40_1 = Mathf.Lerp(iter_40_1.color.r, 0.5, (arg_37_1.time_ - 0) / var_40_0)

								iter_40_1.color = Color.New(var_40_1, var_40_1, var_40_1)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1033"]) and arg_37_1.var_.actorSpriteComps1033 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_40_3 then
						iter_40_3.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_37_1.var_.actorSpriteComps1033 = nil
			end

			local var_40_2 = arg_37_1.actors_["10054"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps10054 == nil then
				arg_37_1.var_.actorSpriteComps10054 = var_40_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_3 = 0.125

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.actorSpriteComps10054 then
					for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_40_5 then
							if arg_37_1.isInRecall_ then
								iter_40_5.color = Color.New(Mathf.Lerp(iter_40_5.color.r, arg_37_1.hightColor1.r, (arg_37_1.time_ - 0) / var_40_3), Mathf.Lerp(iter_40_5.color.g, arg_37_1.hightColor1.g, (arg_37_1.time_ - 0) / var_40_3), (Mathf.Lerp(iter_40_5.color.b, arg_37_1.hightColor1.b, (arg_37_1.time_ - 0) / var_40_3)))
							else
								local var_40_4 = Mathf.Lerp(iter_40_5.color.r, 1, (arg_37_1.time_ - 0) / var_40_3)

								iter_40_5.color = Color.New(var_40_4, var_40_4, var_40_4)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps10054 then
				for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_40_7 then
						iter_40_7.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps10054 = nil
			end

			local var_40_5 = 0
			local var_40_6 = 0.05

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(416091009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 2 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 2)

				if (2 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 2)) > 0 and var_40_6 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10

					if var_40_10 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091009", "story_v_out_416091.awb") ~= 0 then
					local var_40_11 = manager.audio:GetVoiceLength("story_v_out_416091", "416091009", "story_v_out_416091.awb") / 1000

					if var_40_11 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_5
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_416091", "416091009", "story_v_out_416091.awb")

						arg_37_1:RecordAudio("416091009", var_40_12)
						arg_37_1:RecordAudio("416091009", var_40_12)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_416091", "416091009", "story_v_out_416091.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_416091", "416091009", "story_v_out_416091.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_13 = math.max(var_40_6, arg_37_1.talkMaxDuration)

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_13 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_5) / var_40_13

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_5 + var_40_13 and arg_37_1.time_ < var_40_5 + var_40_13 + arg_40_0 then
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
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1033"]) and arg_41_1.var_.actorSpriteComps1033 == nil then
				arg_41_1.var_.actorSpriteComps1033 = arg_41_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_0 = 0.125

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1033"]) then
				if arg_41_1.var_.actorSpriteComps1033 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								iter_44_1.color = Color.New(Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_0), Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_0), (Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_0)))
							else
								local var_44_1 = Mathf.Lerp(iter_44_1.color.r, 1, (arg_41_1.time_ - 0) / var_44_0)

								iter_44_1.color = Color.New(var_44_1, var_44_1, var_44_1)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1033"]) and arg_41_1.var_.actorSpriteComps1033 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_44_3 then
						iter_44_3.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps1033 = nil
			end

			local var_44_2 = arg_41_1.actors_["10054"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10054 == nil then
				arg_41_1.var_.actorSpriteComps10054 = var_44_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_3 = 0.125

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.actorSpriteComps10054 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_44_5 then
							if arg_41_1.isInRecall_ then
								iter_44_5.color = Color.New(Mathf.Lerp(iter_44_5.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_3), Mathf.Lerp(iter_44_5.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_3), (Mathf.Lerp(iter_44_5.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_3)))
							else
								local var_44_4 = Mathf.Lerp(iter_44_5.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_3)

								iter_44_5.color = Color.New(var_44_4, var_44_4, var_44_4)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10054 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_44_7 then
						iter_44_7.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps10054 = nil
			end

			local var_44_5 = 0
			local var_44_6 = 0.325

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_7 = arg_41_1:GetWordFromCfg(416091010)
				local var_44_8 = arg_41_1:FormatText(var_44_7.content)

				arg_41_1.text_.text = var_44_8

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_10 = 13 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 13)

				if (13 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 13)) > 0 and var_44_6 < var_44_10 then
					arg_41_1.talkMaxDuration = var_44_10

					if var_44_10 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_5
					end
				end

				arg_41_1.text_.text = var_44_8
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091010", "story_v_out_416091.awb") ~= 0 then
					local var_44_11 = manager.audio:GetVoiceLength("story_v_out_416091", "416091010", "story_v_out_416091.awb") / 1000

					if var_44_11 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_5
					end

					if var_44_7.prefab_name ~= "" and arg_41_1.actors_[var_44_7.prefab_name] ~= nil then
						local var_44_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_7.prefab_name].transform, "story_v_out_416091", "416091010", "story_v_out_416091.awb")

						arg_41_1:RecordAudio("416091010", var_44_12)
						arg_41_1:RecordAudio("416091010", var_44_12)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_416091", "416091010", "story_v_out_416091.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_416091", "416091010", "story_v_out_416091.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_13 = math.max(var_44_6, arg_41_1.talkMaxDuration)

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_13 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_5) / var_44_13

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_5 + var_44_13 and arg_41_1.time_ < var_44_5 + var_44_13 + arg_44_0 then
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
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1033"]) and arg_45_1.var_.actorSpriteComps1033 == nil then
				arg_45_1.var_.actorSpriteComps1033 = arg_45_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 0.125

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1033"]) then
				if arg_45_1.var_.actorSpriteComps1033 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								iter_48_1.color = Color.New(Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor2.r, (arg_45_1.time_ - 0) / var_48_0), Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor2.g, (arg_45_1.time_ - 0) / var_48_0), (Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor2.b, (arg_45_1.time_ - 0) / var_48_0)))
							else
								local var_48_1 = Mathf.Lerp(iter_48_1.color.r, 0.5, (arg_45_1.time_ - 0) / var_48_0)

								iter_48_1.color = Color.New(var_48_1, var_48_1, var_48_1)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1033"]) and arg_45_1.var_.actorSpriteComps1033 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps1033 = nil
			end

			local var_48_2 = arg_45_1.actors_["10054"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps10054 == nil then
				arg_45_1.var_.actorSpriteComps10054 = var_48_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_3 = 0.125

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.actorSpriteComps10054 then
					for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_48_5 then
							if arg_45_1.isInRecall_ then
								iter_48_5.color = Color.New(Mathf.Lerp(iter_48_5.color.r, arg_45_1.hightColor1.r, (arg_45_1.time_ - 0) / var_48_3), Mathf.Lerp(iter_48_5.color.g, arg_45_1.hightColor1.g, (arg_45_1.time_ - 0) / var_48_3), (Mathf.Lerp(iter_48_5.color.b, arg_45_1.hightColor1.b, (arg_45_1.time_ - 0) / var_48_3)))
							else
								local var_48_4 = Mathf.Lerp(iter_48_5.color.r, 1, (arg_45_1.time_ - 0) / var_48_3)

								iter_48_5.color = Color.New(var_48_4, var_48_4, var_48_4)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps10054 then
				for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_48_7 then
						iter_48_7.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps10054 = nil
			end

			local var_48_5 = 0
			local var_48_6 = 0.5

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_7 = arg_45_1:GetWordFromCfg(416091011)
				local var_48_8 = arg_45_1:FormatText(var_48_7.content)

				arg_45_1.text_.text = var_48_8

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_10 = 20 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_8) / 20)

				if (20 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_8) / 20)) > 0 and var_48_6 < var_48_10 then
					arg_45_1.talkMaxDuration = var_48_10

					if var_48_10 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_5
					end
				end

				arg_45_1.text_.text = var_48_8
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091011", "story_v_out_416091.awb") ~= 0 then
					local var_48_11 = manager.audio:GetVoiceLength("story_v_out_416091", "416091011", "story_v_out_416091.awb") / 1000

					if var_48_11 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_5
					end

					if var_48_7.prefab_name ~= "" and arg_45_1.actors_[var_48_7.prefab_name] ~= nil then
						local var_48_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_7.prefab_name].transform, "story_v_out_416091", "416091011", "story_v_out_416091.awb")

						arg_45_1:RecordAudio("416091011", var_48_12)
						arg_45_1:RecordAudio("416091011", var_48_12)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_416091", "416091011", "story_v_out_416091.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_416091", "416091011", "story_v_out_416091.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_13 = math.max(var_48_6, arg_45_1.talkMaxDuration)

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_13 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_5) / var_48_13

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_5 + var_48_13 and arg_45_1.time_ < var_48_5 + var_48_13 + arg_48_0 then
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
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1033"]) and arg_49_1.var_.actorSpriteComps1033 == nil then
				arg_49_1.var_.actorSpriteComps1033 = arg_49_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_0 = 0.125

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1033"]) then
				if arg_49_1.var_.actorSpriteComps1033 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								iter_52_1.color = Color.New(Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor1.r, (arg_49_1.time_ - 0) / var_52_0), Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor1.g, (arg_49_1.time_ - 0) / var_52_0), (Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor1.b, (arg_49_1.time_ - 0) / var_52_0)))
							else
								local var_52_1 = Mathf.Lerp(iter_52_1.color.r, 1, (arg_49_1.time_ - 0) / var_52_0)

								iter_52_1.color = Color.New(var_52_1, var_52_1, var_52_1)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1033"]) and arg_49_1.var_.actorSpriteComps1033 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_52_3 then
						iter_52_3.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps1033 = nil
			end

			local var_52_2 = arg_49_1.actors_["10054"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps10054 == nil then
				arg_49_1.var_.actorSpriteComps10054 = var_52_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_3 = 0.125

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.actorSpriteComps10054 then
					for iter_52_4, iter_52_5 in pairs(arg_49_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_52_5 then
							if arg_49_1.isInRecall_ then
								iter_52_5.color = Color.New(Mathf.Lerp(iter_52_5.color.r, arg_49_1.hightColor2.r, (arg_49_1.time_ - 0) / var_52_3), Mathf.Lerp(iter_52_5.color.g, arg_49_1.hightColor2.g, (arg_49_1.time_ - 0) / var_52_3), (Mathf.Lerp(iter_52_5.color.b, arg_49_1.hightColor2.b, (arg_49_1.time_ - 0) / var_52_3)))
							else
								local var_52_4 = Mathf.Lerp(iter_52_5.color.r, 0.5, (arg_49_1.time_ - 0) / var_52_3)

								iter_52_5.color = Color.New(var_52_4, var_52_4, var_52_4)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.actorSpriteComps10054 then
				for iter_52_6, iter_52_7 in pairs(arg_49_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_52_7 then
						iter_52_7.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_49_1.var_.actorSpriteComps10054 = nil
			end

			local var_52_5 = 0
			local var_52_6 = 0.825

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_7 = arg_49_1:GetWordFromCfg(416091012)
				local var_52_8 = arg_49_1:FormatText(var_52_7.content)

				arg_49_1.text_.text = var_52_8

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_10 = 33 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 33)

				if (33 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_8) / 33)) > 0 and var_52_6 < var_52_10 then
					arg_49_1.talkMaxDuration = var_52_10

					if var_52_10 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_5
					end
				end

				arg_49_1.text_.text = var_52_8
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091012", "story_v_out_416091.awb") ~= 0 then
					local var_52_11 = manager.audio:GetVoiceLength("story_v_out_416091", "416091012", "story_v_out_416091.awb") / 1000

					if var_52_11 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_5
					end

					if var_52_7.prefab_name ~= "" and arg_49_1.actors_[var_52_7.prefab_name] ~= nil then
						local var_52_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_7.prefab_name].transform, "story_v_out_416091", "416091012", "story_v_out_416091.awb")

						arg_49_1:RecordAudio("416091012", var_52_12)
						arg_49_1:RecordAudio("416091012", var_52_12)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_416091", "416091012", "story_v_out_416091.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_416091", "416091012", "story_v_out_416091.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_13 = math.max(var_52_6, arg_49_1.talkMaxDuration)

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_13 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_5) / var_52_13

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_5 + var_52_13 and arg_49_1.time_ < var_52_5 + var_52_13 + arg_52_0 then
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
			local var_56_0 = 0.625

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(416091013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 25 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 25)

				if (25 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 25)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091013", "story_v_out_416091.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_416091", "416091013", "story_v_out_416091.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_416091", "416091013", "story_v_out_416091.awb")

						arg_53_1:RecordAudio("416091013", var_56_6)
						arg_53_1:RecordAudio("416091013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_416091", "416091013", "story_v_out_416091.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_416091", "416091013", "story_v_out_416091.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
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
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1033"]) and arg_57_1.var_.actorSpriteComps1033 == nil then
				arg_57_1.var_.actorSpriteComps1033 = arg_57_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_0 = 0.125

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1033"]) then
				if arg_57_1.var_.actorSpriteComps1033 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								iter_60_1.color = Color.New(Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor2.r, (arg_57_1.time_ - 0) / var_60_0), Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor2.g, (arg_57_1.time_ - 0) / var_60_0), (Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor2.b, (arg_57_1.time_ - 0) / var_60_0)))
							else
								local var_60_1 = Mathf.Lerp(iter_60_1.color.r, 0.5, (arg_57_1.time_ - 0) / var_60_0)

								iter_60_1.color = Color.New(var_60_1, var_60_1, var_60_1)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1033"]) and arg_57_1.var_.actorSpriteComps1033 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_60_3 then
						iter_60_3.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_57_1.var_.actorSpriteComps1033 = nil
			end

			local var_60_2 = arg_57_1.actors_["10054"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps10054 == nil then
				arg_57_1.var_.actorSpriteComps10054 = var_60_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_3 = 0.125

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.actorSpriteComps10054 then
					for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_60_5 then
							if arg_57_1.isInRecall_ then
								iter_60_5.color = Color.New(Mathf.Lerp(iter_60_5.color.r, arg_57_1.hightColor1.r, (arg_57_1.time_ - 0) / var_60_3), Mathf.Lerp(iter_60_5.color.g, arg_57_1.hightColor1.g, (arg_57_1.time_ - 0) / var_60_3), (Mathf.Lerp(iter_60_5.color.b, arg_57_1.hightColor1.b, (arg_57_1.time_ - 0) / var_60_3)))
							else
								local var_60_4 = Mathf.Lerp(iter_60_5.color.r, 1, (arg_57_1.time_ - 0) / var_60_3)

								iter_60_5.color = Color.New(var_60_4, var_60_4, var_60_4)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps10054 then
				for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_60_7 then
						iter_60_7.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_57_1.var_.actorSpriteComps10054 = nil
			end

			local var_60_5 = 0
			local var_60_6 = 0.725

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_7 = arg_57_1:GetWordFromCfg(416091014)
				local var_60_8 = arg_57_1:FormatText(var_60_7.content)

				arg_57_1.text_.text = var_60_8

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_10 = 29 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 29)

				if (29 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 29)) > 0 and var_60_6 < var_60_10 then
					arg_57_1.talkMaxDuration = var_60_10

					if var_60_10 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_5
					end
				end

				arg_57_1.text_.text = var_60_8
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091014", "story_v_out_416091.awb") ~= 0 then
					local var_60_11 = manager.audio:GetVoiceLength("story_v_out_416091", "416091014", "story_v_out_416091.awb") / 1000

					if var_60_11 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_5
					end

					if var_60_7.prefab_name ~= "" and arg_57_1.actors_[var_60_7.prefab_name] ~= nil then
						local var_60_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_7.prefab_name].transform, "story_v_out_416091", "416091014", "story_v_out_416091.awb")

						arg_57_1:RecordAudio("416091014", var_60_12)
						arg_57_1:RecordAudio("416091014", var_60_12)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_416091", "416091014", "story_v_out_416091.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_416091", "416091014", "story_v_out_416091.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_13 = math.max(var_60_6, arg_57_1.talkMaxDuration)

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_13 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_5) / var_60_13

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_5 + var_60_13 and arg_57_1.time_ < var_60_5 + var_60_13 + arg_60_0 then
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
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1033"]) and arg_61_1.var_.actorSpriteComps1033 == nil then
				arg_61_1.var_.actorSpriteComps1033 = arg_61_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_0 = 0.125

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1033"]) then
				if arg_61_1.var_.actorSpriteComps1033 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								iter_64_1.color = Color.New(Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor1.r, (arg_61_1.time_ - 0) / var_64_0), Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor1.g, (arg_61_1.time_ - 0) / var_64_0), (Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor1.b, (arg_61_1.time_ - 0) / var_64_0)))
							else
								local var_64_1 = Mathf.Lerp(iter_64_1.color.r, 1, (arg_61_1.time_ - 0) / var_64_0)

								iter_64_1.color = Color.New(var_64_1, var_64_1, var_64_1)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1033"]) and arg_61_1.var_.actorSpriteComps1033 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_64_3 then
						iter_64_3.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps1033 = nil
			end

			local var_64_2 = arg_61_1.actors_["10054"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps10054 == nil then
				arg_61_1.var_.actorSpriteComps10054 = var_64_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_3 = 0.125

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.actorSpriteComps10054 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_64_5 then
							if arg_61_1.isInRecall_ then
								iter_64_5.color = Color.New(Mathf.Lerp(iter_64_5.color.r, arg_61_1.hightColor2.r, (arg_61_1.time_ - 0) / var_64_3), Mathf.Lerp(iter_64_5.color.g, arg_61_1.hightColor2.g, (arg_61_1.time_ - 0) / var_64_3), (Mathf.Lerp(iter_64_5.color.b, arg_61_1.hightColor2.b, (arg_61_1.time_ - 0) / var_64_3)))
							else
								local var_64_4 = Mathf.Lerp(iter_64_5.color.r, 0.5, (arg_61_1.time_ - 0) / var_64_3)

								iter_64_5.color = Color.New(var_64_4, var_64_4, var_64_4)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps10054 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_64_7 then
						iter_64_7.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_61_1.var_.actorSpriteComps10054 = nil
			end

			local var_64_5 = 0
			local var_64_6 = 0.625

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_7 = arg_61_1:GetWordFromCfg(416091015)
				local var_64_8 = arg_61_1:FormatText(var_64_7.content)

				arg_61_1.text_.text = var_64_8

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_10 = 25 <= 0 and var_64_6 or var_64_6 * (utf8.len(var_64_8) / 25)

				if (25 <= 0 and var_64_6 or var_64_6 * (utf8.len(var_64_8) / 25)) > 0 and var_64_6 < var_64_10 then
					arg_61_1.talkMaxDuration = var_64_10

					if var_64_10 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_5
					end
				end

				arg_61_1.text_.text = var_64_8
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091015", "story_v_out_416091.awb") ~= 0 then
					local var_64_11 = manager.audio:GetVoiceLength("story_v_out_416091", "416091015", "story_v_out_416091.awb") / 1000

					if var_64_11 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_5
					end

					if var_64_7.prefab_name ~= "" and arg_61_1.actors_[var_64_7.prefab_name] ~= nil then
						local var_64_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_7.prefab_name].transform, "story_v_out_416091", "416091015", "story_v_out_416091.awb")

						arg_61_1:RecordAudio("416091015", var_64_12)
						arg_61_1:RecordAudio("416091015", var_64_12)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_416091", "416091015", "story_v_out_416091.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_416091", "416091015", "story_v_out_416091.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_13 = math.max(var_64_6, arg_61_1.talkMaxDuration)

			if var_64_5 <= arg_61_1.time_ and arg_61_1.time_ < var_64_5 + var_64_13 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_5) / var_64_13

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_5 + var_64_13 and arg_61_1.time_ < var_64_5 + var_64_13 + arg_64_0 then
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
			local var_68_0 = 0.3

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_1 = arg_65_1:GetWordFromCfg(416091016)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 12 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 12)

				if (12 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 12)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091016", "story_v_out_416091.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_416091", "416091016", "story_v_out_416091.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_416091", "416091016", "story_v_out_416091.awb")

						arg_65_1:RecordAudio("416091016", var_68_6)
						arg_65_1:RecordAudio("416091016", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_416091", "416091016", "story_v_out_416091.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_416091", "416091016", "story_v_out_416091.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
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
			if arg_69_1.bgs_.STblack == nil then
				local var_72_0 = Object.Instantiate(arg_69_1.paintGo_)

				var_72_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_72_0.name = "STblack"
				var_72_0.transform.parent = arg_69_1.stage_.transform
				var_72_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_.STblack = var_72_0
			end

			if 2 < arg_69_1.time_ and arg_69_1.time_ <= 2 + arg_72_0 then
				local var_72_1 = arg_69_1.bgs_.STblack

				arg_69_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_72_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_2 = var_72_1:GetComponent("SpriteRenderer")

				if var_72_2 and var_72_2.sprite then
					local var_72_3 = 2 * (var_72_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_72_1.transform.localScale = Vector3.New(var_72_3 / var_72_2.sprite.bounds.size.y < var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x and var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x or var_72_3 / var_72_2.sprite.bounds.size.y, var_72_3 / var_72_2.sprite.bounds.size.y < var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x and var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x or var_72_3 / var_72_2.sprite.bounds.size.y, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "STblack" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_4 = 4

			if 4 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.allBtn_.enabled = false
			end

			if arg_69_1.time_ >= var_72_4 + 0.3 and arg_69_1.time_ < var_72_4 + 0.3 + arg_72_0 then
				arg_69_1.allBtn_.enabled = true
			end

			local var_72_5 = 0

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_6 = 2

			if var_72_5 <= arg_69_1.time_ and arg_69_1.time_ < var_72_5 + var_72_6 then
				local var_72_7 = Color.New(0, 0, 0)

				var_72_7.a = Mathf.Lerp(0, 1, (arg_69_1.time_ - var_72_5) / var_72_6)
				arg_69_1.mask_.color = var_72_7
			end

			if arg_69_1.time_ >= var_72_5 + var_72_6 and arg_69_1.time_ < var_72_5 + var_72_6 + arg_72_0 then
				local var_72_8 = Color.New(0, 0, 0)

				var_72_8.a = 1
				arg_69_1.mask_.color = var_72_8
			end

			local var_72_9 = 2

			if 2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_10 = 2

			if var_72_9 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_10 then
				local var_72_11 = Color.New(0, 0, 0)

				var_72_11.a = Mathf.Lerp(1, 0, (arg_69_1.time_ - var_72_9) / var_72_10)
				arg_69_1.mask_.color = var_72_11
			end

			if arg_69_1.time_ >= var_72_9 + var_72_10 and arg_69_1.time_ < var_72_9 + var_72_10 + arg_72_0 then
				local var_72_12 = Color.New(0, 0, 0)

				arg_69_1.mask_.enabled = false
				var_72_12.a = 0
				arg_69_1.mask_.color = var_72_12
			end

			local var_72_13 = arg_69_1.actors_["10054"].transform

			if 1.966 < arg_69_1.time_ and arg_69_1.time_ <= 1.966 + arg_72_0 then
				arg_69_1.var_.moveOldPos10054 = var_72_13.localPosition
				var_72_13.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10054", 7)

				for iter_72_2 = 0, var_72_13.childCount - 1 do
					local var_72_14 = var_72_13:GetChild(iter_72_2)

					if var_72_14.name == "" or not string.find(var_72_14.name, "split") then
						var_72_14.gameObject:SetActive(true)
					else
						var_72_14.gameObject:SetActive(false)
					end
				end
			end

			local var_72_15 = 0.001

			if 1.966 <= arg_69_1.time_ and arg_69_1.time_ < 1.966 + var_72_15 then
				var_72_13.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10054, Vector3.New(0, -2000, 0), (arg_69_1.time_ - 1.966) / var_72_15)
			end

			if arg_69_1.time_ >= 1.966 + var_72_15 and arg_69_1.time_ < 1.966 + var_72_15 + arg_72_0 then
				var_72_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_72_16 = arg_69_1.actors_["1033"].transform

			if 1.966 < arg_69_1.time_ and arg_69_1.time_ <= 1.966 + arg_72_0 then
				arg_69_1.var_.moveOldPos1033 = var_72_16.localPosition
				var_72_16.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1033", 7)

				for iter_72_3 = 0, var_72_16.childCount - 1 do
					local var_72_17 = var_72_16:GetChild(iter_72_3)

					if var_72_17.name == "" or not string.find(var_72_17.name, "split") then
						var_72_17.gameObject:SetActive(true)
					else
						var_72_17.gameObject:SetActive(false)
					end
				end
			end

			local var_72_18 = 0.001

			if 1.966 <= arg_69_1.time_ and arg_69_1.time_ < 1.966 + var_72_18 then
				var_72_16.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_69_1.time_ - 1.966) / var_72_18)
			end

			if arg_69_1.time_ >= 1.966 + var_72_18 and arg_69_1.time_ < 1.966 + var_72_18 + arg_72_0 then
				var_72_16.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1.73333333333333 < arg_69_1.time_ and arg_69_1.time_ <= 1.73333333333333 + arg_72_0 then
				arg_69_1:AudioAction("play", "effect", "se_story_138", "se_story_138_footstep", "")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_72_22 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_69_1.bgmTxt_.text ~= var_72_22 and arg_69_1.bgmTxt_.text ~= "" then
						if arg_69_1.bgmTxt2_.text ~= "" then
							arg_69_1.bgmTxt_.text = arg_69_1.bgmTxt2_.text
						end

						arg_69_1.bgmTxt2_.text = var_72_22

						arg_69_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_69_1.bgmTxt_.text = var_72_22
						arg_69_1.bgmTxt2_.text = var_72_22
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

			local var_72_23 = 4
			local var_72_24 = 1.425

			if 4 < arg_69_1.time_ and arg_69_1.time_ <= var_72_23 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_25 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_25:setOnUpdate(LuaHelper.FloatAction(function(arg_74_0)
					arg_69_1.dialogCg_.alpha = arg_74_0
				end))
				var_72_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_26 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(416091017).content)

				arg_69_1.text_.text = var_72_26

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_28 = 57 <= 0 and var_72_24 or var_72_24 * (utf8.len(var_72_26) / 57)

				if (57 <= 0 and var_72_24 or var_72_24 * (utf8.len(var_72_26) / 57)) > 0 and var_72_24 < var_72_28 then
					arg_69_1.talkMaxDuration = var_72_28
					var_72_23 = var_72_23 + 0.3

					if var_72_28 + var_72_23 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_28 + var_72_23
					end
				end

				arg_69_1.text_.text = var_72_26
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_29 = var_72_23 + 0.3
			local var_72_30 = math.max(var_72_24, arg_69_1.talkMaxDuration)

			if var_72_23 + 0.3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_29 + var_72_30 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_29) / var_72_30

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_29 + var_72_30 and arg_69_1.time_ < var_72_29 + var_72_30 + arg_72_0 then
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
			if arg_76_1.actors_["1148"] == nil then
				local var_79_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1148")

				if not isNil(var_79_0) then
					local var_79_1 = Object.Instantiate(var_79_0, arg_76_1.canvasGo_.transform)

					var_79_1.transform:SetSiblingIndex(1)

					var_79_1.name = "1148"
					var_79_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_76_1.actors_["1148"] = var_79_1

					if arg_76_1.isInRecall_ then
						for iter_79_0, iter_79_1 in ipairs((var_79_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_79_1.color = arg_76_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_79_2 = arg_76_1.actors_["1148"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.actorSpriteComps1148 == nil then
				arg_76_1.var_.actorSpriteComps1148 = var_79_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_3 = 0.125

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_3 and not isNil(var_79_2) then
				if arg_76_1.var_.actorSpriteComps1148 then
					for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_79_3 then
							if arg_76_1.isInRecall_ then
								iter_79_3.color = Color.New(Mathf.Lerp(iter_79_3.color.r, arg_76_1.hightColor1.r, (arg_76_1.time_ - 0) / var_79_3), Mathf.Lerp(iter_79_3.color.g, arg_76_1.hightColor1.g, (arg_76_1.time_ - 0) / var_79_3), (Mathf.Lerp(iter_79_3.color.b, arg_76_1.hightColor1.b, (arg_76_1.time_ - 0) / var_79_3)))
							else
								local var_79_4 = Mathf.Lerp(iter_79_3.color.r, 1, (arg_76_1.time_ - 0) / var_79_3)

								iter_79_3.color = Color.New(var_79_4, var_79_4, var_79_4)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= 0 + var_79_3 and arg_76_1.time_ < 0 + var_79_3 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.actorSpriteComps1148 then
				for iter_79_4, iter_79_5 in pairs(arg_76_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_79_5 then
						iter_79_5.color = arg_76_1.isInRecall_ and (arg_76_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_76_1.var_.actorSpriteComps1148 = nil
			end

			local var_79_5 = arg_76_1.actors_["1148"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1148 = var_79_5.localPosition
				var_79_5.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("1148", 3)

				for iter_79_6 = 0, var_79_5.childCount - 1 do
					local var_79_6 = var_79_5:GetChild(iter_79_6)

					if var_79_6.name == "" or not string.find(var_79_6.name, "split") then
						var_79_6.gameObject:SetActive(true)
					else
						var_79_6.gameObject:SetActive(false)
					end
				end
			end

			local var_79_7 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				var_79_5.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_76_1.time_ - 0) / var_79_7)
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				var_79_5.localPosition = Vector3.New(0, -429, -180)
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:AudioAction("play", "effect", "se_story_138", "se_story_138_footstep", "")
			end

			local var_79_9 = 0
			local var_79_10 = 0.375

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_9 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_11 = arg_76_1:GetWordFromCfg(416091018)
				local var_79_12 = arg_76_1:FormatText(var_79_11.content)

				arg_76_1.text_.text = var_79_12

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_14 = 15 <= 0 and var_79_10 or var_79_10 * (utf8.len(var_79_12) / 15)

				if (15 <= 0 and var_79_10 or var_79_10 * (utf8.len(var_79_12) / 15)) > 0 and var_79_10 < var_79_14 then
					arg_76_1.talkMaxDuration = var_79_14

					if var_79_14 + var_79_9 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_14 + var_79_9
					end
				end

				arg_76_1.text_.text = var_79_12
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091018", "story_v_out_416091.awb") ~= 0 then
					local var_79_15 = manager.audio:GetVoiceLength("story_v_out_416091", "416091018", "story_v_out_416091.awb") / 1000

					if var_79_15 + var_79_9 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_15 + var_79_9
					end

					if var_79_11.prefab_name ~= "" and arg_76_1.actors_[var_79_11.prefab_name] ~= nil then
						local var_79_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_11.prefab_name].transform, "story_v_out_416091", "416091018", "story_v_out_416091.awb")

						arg_76_1:RecordAudio("416091018", var_79_16)
						arg_76_1:RecordAudio("416091018", var_79_16)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_416091", "416091018", "story_v_out_416091.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_416091", "416091018", "story_v_out_416091.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_17 = math.max(var_79_10, arg_76_1.talkMaxDuration)

			if var_79_9 <= arg_76_1.time_ and arg_76_1.time_ < var_79_9 + var_79_17 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_9) / var_79_17

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_9 + var_79_17 and arg_76_1.time_ < var_79_9 + var_79_17 + arg_79_0 then
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
			if 0.225 < arg_80_1.time_ and arg_80_1.time_ <= 0.225 + arg_83_0 then
				arg_80_1:AudioAction("play", "effect", "se_story_138", "se_story_138_footstep", "")
			end

			local var_83_1 = 0
			local var_83_2 = 0.225

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_3 = arg_80_1:GetWordFromCfg(416091019)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_6 = 9 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_4) / 9)

				if (9 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_4) / 9)) > 0 and var_83_2 < var_83_6 then
					arg_80_1.talkMaxDuration = var_83_6

					if var_83_6 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_6 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091019", "story_v_out_416091.awb") ~= 0 then
					local var_83_7 = manager.audio:GetVoiceLength("story_v_out_416091", "416091019", "story_v_out_416091.awb") / 1000

					if var_83_7 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_1
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_out_416091", "416091019", "story_v_out_416091.awb")

						arg_80_1:RecordAudio("416091019", var_83_8)
						arg_80_1:RecordAudio("416091019", var_83_8)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_416091", "416091019", "story_v_out_416091.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_416091", "416091019", "story_v_out_416091.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_9 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_9 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_9

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_9 and arg_80_1.time_ < var_83_1 + var_83_9 + arg_83_0 then
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
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1148 = arg_84_1.actors_["1148"].transform.localPosition
				arg_84_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_84_1:CheckSpriteTmpPos("1148", 2)

				for iter_87_0 = 0, arg_84_1.actors_["1148"].transform.childCount - 1 do
					local var_87_0 = arg_84_1.actors_["1148"].transform:GetChild(iter_87_0)

					if var_87_0.name == "" or not string.find(var_87_0.name, "split") then
						var_87_0.gameObject:SetActive(true)
					else
						var_87_0.gameObject:SetActive(false)
					end
				end
			end

			local var_87_1 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_1 then
				arg_84_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1148, Vector3.New(-390, -429, -180), (arg_84_1.time_ - 0) / var_87_1)
			end

			if arg_84_1.time_ >= 0 + var_87_1 and arg_84_1.time_ < 0 + var_87_1 + arg_87_0 then
				arg_84_1.actors_["1148"].transform.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_87_2 = arg_84_1.actors_["1148"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_2) and arg_84_1.var_.actorSpriteComps1148 == nil then
				arg_84_1.var_.actorSpriteComps1148 = var_87_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_3 = 0.125

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_3 and not isNil(var_87_2) then
				if arg_84_1.var_.actorSpriteComps1148 then
					for iter_87_1, iter_87_2 in pairs(arg_84_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_87_2 then
							if arg_84_1.isInRecall_ then
								iter_87_2.color = Color.New(Mathf.Lerp(iter_87_2.color.r, arg_84_1.hightColor2.r, (arg_84_1.time_ - 0) / var_87_3), Mathf.Lerp(iter_87_2.color.g, arg_84_1.hightColor2.g, (arg_84_1.time_ - 0) / var_87_3), (Mathf.Lerp(iter_87_2.color.b, arg_84_1.hightColor2.b, (arg_84_1.time_ - 0) / var_87_3)))
							else
								local var_87_4 = Mathf.Lerp(iter_87_2.color.r, 0.5, (arg_84_1.time_ - 0) / var_87_3)

								iter_87_2.color = Color.New(var_87_4, var_87_4, var_87_4)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= 0 + var_87_3 and arg_84_1.time_ < 0 + var_87_3 + arg_87_0 and not isNil(var_87_2) and arg_84_1.var_.actorSpriteComps1148 then
				for iter_87_3, iter_87_4 in pairs(arg_84_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_87_4 then
						iter_87_4.color = arg_84_1.isInRecall_ and (arg_84_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_84_1.var_.actorSpriteComps1148 = nil
			end

			local var_87_5 = "10108"

			if arg_84_1.actors_["10108"] == nil then
				local var_87_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10108")

				if not isNil(var_87_6) then
					local var_87_7 = Object.Instantiate(var_87_6, arg_84_1.canvasGo_.transform)

					var_87_7.transform:SetSiblingIndex(1)

					var_87_7.name = var_87_5
					var_87_7.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_84_1.actors_[var_87_5] = var_87_7

					if arg_84_1.isInRecall_ then
						for iter_87_5, iter_87_6 in ipairs((var_87_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_87_6.color = arg_84_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_87_8 = arg_84_1.actors_["10108"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_8) and arg_84_1.var_.actorSpriteComps10108 == nil then
				arg_84_1.var_.actorSpriteComps10108 = var_87_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_9 = 0.125

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_9 and not isNil(var_87_8) then
				if arg_84_1.var_.actorSpriteComps10108 then
					for iter_87_7, iter_87_8 in pairs(arg_84_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_87_8 then
							if arg_84_1.isInRecall_ then
								iter_87_8.color = Color.New(Mathf.Lerp(iter_87_8.color.r, arg_84_1.hightColor1.r, (arg_84_1.time_ - 0) / var_87_9), Mathf.Lerp(iter_87_8.color.g, arg_84_1.hightColor1.g, (arg_84_1.time_ - 0) / var_87_9), (Mathf.Lerp(iter_87_8.color.b, arg_84_1.hightColor1.b, (arg_84_1.time_ - 0) / var_87_9)))
							else
								local var_87_10 = Mathf.Lerp(iter_87_8.color.r, 1, (arg_84_1.time_ - 0) / var_87_9)

								iter_87_8.color = Color.New(var_87_10, var_87_10, var_87_10)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= 0 + var_87_9 and arg_84_1.time_ < 0 + var_87_9 + arg_87_0 and not isNil(var_87_8) and arg_84_1.var_.actorSpriteComps10108 then
				for iter_87_9, iter_87_10 in pairs(arg_84_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_87_10 then
						iter_87_10.color = arg_84_1.isInRecall_ and (arg_84_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_84_1.var_.actorSpriteComps10108 = nil
			end

			local var_87_11 = arg_84_1.actors_["10108"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos10108 = var_87_11.localPosition
				var_87_11.localScale = Vector3.New(1, 1, 1)

				arg_84_1:CheckSpriteTmpPos("10108", 4)

				for iter_87_11 = 0, var_87_11.childCount - 1 do
					local var_87_12 = var_87_11:GetChild(iter_87_11)

					if var_87_12.name == "" or not string.find(var_87_12.name, "split") then
						var_87_12.gameObject:SetActive(true)
					else
						var_87_12.gameObject:SetActive(false)
					end
				end
			end

			local var_87_13 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_13 then
				var_87_11.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos10108, Vector3.New(390, -399.6, -130), (arg_84_1.time_ - 0) / var_87_13)
			end

			if arg_84_1.time_ >= 0 + var_87_13 and arg_84_1.time_ < 0 + var_87_13 + arg_87_0 then
				var_87_11.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_87_14 = 0
			local var_87_15 = 0.275

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_14 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_16 = arg_84_1:GetWordFromCfg(416091020)
				local var_87_17 = arg_84_1:FormatText(var_87_16.content)

				arg_84_1.text_.text = var_87_17

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_19 = 11 <= 0 and var_87_15 or var_87_15 * (utf8.len(var_87_17) / 11)

				if (11 <= 0 and var_87_15 or var_87_15 * (utf8.len(var_87_17) / 11)) > 0 and var_87_15 < var_87_19 then
					arg_84_1.talkMaxDuration = var_87_19

					if var_87_19 + var_87_14 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_19 + var_87_14
					end
				end

				arg_84_1.text_.text = var_87_17
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091020", "story_v_out_416091.awb") ~= 0 then
					local var_87_20 = manager.audio:GetVoiceLength("story_v_out_416091", "416091020", "story_v_out_416091.awb") / 1000

					if var_87_20 + var_87_14 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_20 + var_87_14
					end

					if var_87_16.prefab_name ~= "" and arg_84_1.actors_[var_87_16.prefab_name] ~= nil then
						local var_87_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_16.prefab_name].transform, "story_v_out_416091", "416091020", "story_v_out_416091.awb")

						arg_84_1:RecordAudio("416091020", var_87_21)
						arg_84_1:RecordAudio("416091020", var_87_21)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_416091", "416091020", "story_v_out_416091.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_416091", "416091020", "story_v_out_416091.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_22 = math.max(var_87_15, arg_84_1.talkMaxDuration)

			if var_87_14 <= arg_84_1.time_ and arg_84_1.time_ < var_87_14 + var_87_22 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_14) / var_87_22

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_14 + var_87_22 and arg_84_1.time_ < var_87_14 + var_87_22 + arg_87_0 then
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
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1148"]) and arg_88_1.var_.actorSpriteComps1148 == nil then
				arg_88_1.var_.actorSpriteComps1148 = arg_88_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_0 = 0.125

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["1148"]) then
				if arg_88_1.var_.actorSpriteComps1148 then
					for iter_91_0, iter_91_1 in pairs(arg_88_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_91_1 then
							if arg_88_1.isInRecall_ then
								iter_91_1.color = Color.New(Mathf.Lerp(iter_91_1.color.r, arg_88_1.hightColor1.r, (arg_88_1.time_ - 0) / var_91_0), Mathf.Lerp(iter_91_1.color.g, arg_88_1.hightColor1.g, (arg_88_1.time_ - 0) / var_91_0), (Mathf.Lerp(iter_91_1.color.b, arg_88_1.hightColor1.b, (arg_88_1.time_ - 0) / var_91_0)))
							else
								local var_91_1 = Mathf.Lerp(iter_91_1.color.r, 1, (arg_88_1.time_ - 0) / var_91_0)

								iter_91_1.color = Color.New(var_91_1, var_91_1, var_91_1)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["1148"]) and arg_88_1.var_.actorSpriteComps1148 then
				for iter_91_2, iter_91_3 in pairs(arg_88_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_91_3 then
						iter_91_3.color = arg_88_1.isInRecall_ and (arg_88_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_88_1.var_.actorSpriteComps1148 = nil
			end

			local var_91_2 = arg_88_1.actors_["10108"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_2) and arg_88_1.var_.actorSpriteComps10108 == nil then
				arg_88_1.var_.actorSpriteComps10108 = var_91_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_3 = 0.125

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_3 and not isNil(var_91_2) then
				if arg_88_1.var_.actorSpriteComps10108 then
					for iter_91_4, iter_91_5 in pairs(arg_88_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_91_5 then
							if arg_88_1.isInRecall_ then
								iter_91_5.color = Color.New(Mathf.Lerp(iter_91_5.color.r, arg_88_1.hightColor2.r, (arg_88_1.time_ - 0) / var_91_3), Mathf.Lerp(iter_91_5.color.g, arg_88_1.hightColor2.g, (arg_88_1.time_ - 0) / var_91_3), (Mathf.Lerp(iter_91_5.color.b, arg_88_1.hightColor2.b, (arg_88_1.time_ - 0) / var_91_3)))
							else
								local var_91_4 = Mathf.Lerp(iter_91_5.color.r, 0.5, (arg_88_1.time_ - 0) / var_91_3)

								iter_91_5.color = Color.New(var_91_4, var_91_4, var_91_4)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= 0 + var_91_3 and arg_88_1.time_ < 0 + var_91_3 + arg_91_0 and not isNil(var_91_2) and arg_88_1.var_.actorSpriteComps10108 then
				for iter_91_6, iter_91_7 in pairs(arg_88_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_91_7 then
						iter_91_7.color = arg_88_1.isInRecall_ and (arg_88_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_88_1.var_.actorSpriteComps10108 = nil
			end

			local var_91_5 = 0
			local var_91_6 = 0.4

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_7 = arg_88_1:GetWordFromCfg(416091021)
				local var_91_8 = arg_88_1:FormatText(var_91_7.content)

				arg_88_1.text_.text = var_91_8

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_10 = 16 <= 0 and var_91_6 or var_91_6 * (utf8.len(var_91_8) / 16)

				if (16 <= 0 and var_91_6 or var_91_6 * (utf8.len(var_91_8) / 16)) > 0 and var_91_6 < var_91_10 then
					arg_88_1.talkMaxDuration = var_91_10

					if var_91_10 + var_91_5 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_5
					end
				end

				arg_88_1.text_.text = var_91_8
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091021", "story_v_out_416091.awb") ~= 0 then
					local var_91_11 = manager.audio:GetVoiceLength("story_v_out_416091", "416091021", "story_v_out_416091.awb") / 1000

					if var_91_11 + var_91_5 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_11 + var_91_5
					end

					if var_91_7.prefab_name ~= "" and arg_88_1.actors_[var_91_7.prefab_name] ~= nil then
						local var_91_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_7.prefab_name].transform, "story_v_out_416091", "416091021", "story_v_out_416091.awb")

						arg_88_1:RecordAudio("416091021", var_91_12)
						arg_88_1:RecordAudio("416091021", var_91_12)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_416091", "416091021", "story_v_out_416091.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_416091", "416091021", "story_v_out_416091.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_13 = math.max(var_91_6, arg_88_1.talkMaxDuration)

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_13 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_5) / var_91_13

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_5 + var_91_13 and arg_88_1.time_ < var_91_5 + var_91_13 + arg_91_0 then
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
			if 4 < arg_92_1.time_ and arg_92_1.time_ <= 4 + arg_95_0 then
				arg_92_1.allBtn_.enabled = false
			end

			if arg_92_1.time_ >= 4 + 0.3 and arg_92_1.time_ < 4 + 0.3 + arg_95_0 then
				arg_92_1.allBtn_.enabled = true
			end

			local var_95_0 = "ST0106"

			if arg_92_1.bgs_.ST0106 == nil then
				local var_95_1 = Object.Instantiate(arg_92_1.paintGo_)

				var_95_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_95_0)
				var_95_1.name = var_95_0
				var_95_1.transform.parent = arg_92_1.stage_.transform
				var_95_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.bgs_[var_95_0] = var_95_1
			end

			if 2 < arg_92_1.time_ and arg_92_1.time_ <= 2 + arg_95_0 then
				local var_95_2 = arg_92_1.bgs_.ST0106

				arg_92_1.bgs_.ST0106.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_95_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_95_3 = var_95_2:GetComponent("SpriteRenderer")

				if var_95_3 and var_95_3.sprite then
					local var_95_4 = 2 * (var_95_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_95_2.transform.localScale = Vector3.New(var_95_4 / var_95_3.sprite.bounds.size.y < var_95_4 * manager.ui.mainCameraCom_.aspect / var_95_3.sprite.bounds.size.x and var_95_4 * manager.ui.mainCameraCom_.aspect / var_95_3.sprite.bounds.size.x or var_95_4 / var_95_3.sprite.bounds.size.y, var_95_4 / var_95_3.sprite.bounds.size.y < var_95_4 * manager.ui.mainCameraCom_.aspect / var_95_3.sprite.bounds.size.x and var_95_4 * manager.ui.mainCameraCom_.aspect / var_95_3.sprite.bounds.size.x or var_95_4 / var_95_3.sprite.bounds.size.y, 0)
				end

				for iter_95_0, iter_95_1 in pairs(arg_92_1.bgs_) do
					if iter_95_0 ~= "ST0106" then
						iter_95_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_95_5 = 0

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 then
				arg_92_1.mask_.enabled = true
				arg_92_1.mask_.raycastTarget = true

				arg_92_1:SetGaussion(false)
			end

			local var_95_6 = 2

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_6 then
				local var_95_7 = Color.New(0, 0, 0)

				var_95_7.a = Mathf.Lerp(0, 1, (arg_92_1.time_ - var_95_5) / var_95_6)
				arg_92_1.mask_.color = var_95_7
			end

			if arg_92_1.time_ >= var_95_5 + var_95_6 and arg_92_1.time_ < var_95_5 + var_95_6 + arg_95_0 then
				local var_95_8 = Color.New(0, 0, 0)

				var_95_8.a = 1
				arg_92_1.mask_.color = var_95_8
			end

			local var_95_9 = 2

			if 2 < arg_92_1.time_ and arg_92_1.time_ <= var_95_9 + arg_95_0 then
				arg_92_1.mask_.enabled = true
				arg_92_1.mask_.raycastTarget = true

				arg_92_1:SetGaussion(false)
			end

			local var_95_10 = 2

			if var_95_9 <= arg_92_1.time_ and arg_92_1.time_ < var_95_9 + var_95_10 then
				local var_95_11 = Color.New(0, 0, 0)

				var_95_11.a = Mathf.Lerp(1, 0, (arg_92_1.time_ - var_95_9) / var_95_10)
				arg_92_1.mask_.color = var_95_11
			end

			if arg_92_1.time_ >= var_95_9 + var_95_10 and arg_92_1.time_ < var_95_9 + var_95_10 + arg_95_0 then
				local var_95_12 = Color.New(0, 0, 0)

				arg_92_1.mask_.enabled = false
				var_95_12.a = 0
				arg_92_1.mask_.color = var_95_12
			end

			local var_95_13 = arg_92_1.actors_["1148"].transform

			if 1.966 < arg_92_1.time_ and arg_92_1.time_ <= 1.966 + arg_95_0 then
				arg_92_1.var_.moveOldPos1148 = var_95_13.localPosition
				var_95_13.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("1148", 7)

				for iter_95_2 = 0, var_95_13.childCount - 1 do
					local var_95_14 = var_95_13:GetChild(iter_95_2)

					if var_95_14.name == "" or not string.find(var_95_14.name, "split") then
						var_95_14.gameObject:SetActive(true)
					else
						var_95_14.gameObject:SetActive(false)
					end
				end
			end

			local var_95_15 = 0.001

			if 1.966 <= arg_92_1.time_ and arg_92_1.time_ < 1.966 + var_95_15 then
				var_95_13.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_92_1.time_ - 1.966) / var_95_15)
			end

			if arg_92_1.time_ >= 1.966 + var_95_15 and arg_92_1.time_ < 1.966 + var_95_15 + arg_95_0 then
				var_95_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_95_16 = arg_92_1.actors_["10108"].transform

			if 1.966 < arg_92_1.time_ and arg_92_1.time_ <= 1.966 + arg_95_0 then
				arg_92_1.var_.moveOldPos10108 = var_95_16.localPosition
				var_95_16.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("10108", 7)

				for iter_95_3 = 0, var_95_16.childCount - 1 do
					local var_95_17 = var_95_16:GetChild(iter_95_3)

					if var_95_17.name == "" or not string.find(var_95_17.name, "split") then
						var_95_17.gameObject:SetActive(true)
					else
						var_95_17.gameObject:SetActive(false)
					end
				end
			end

			local var_95_18 = 0.001

			if 1.966 <= arg_92_1.time_ and arg_92_1.time_ < 1.966 + var_95_18 then
				var_95_16.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10108, Vector3.New(0, -2000, 0), (arg_92_1.time_ - 1.966) / var_95_18)
			end

			if arg_92_1.time_ >= 1.966 + var_95_18 and arg_92_1.time_ < 1.966 + var_95_18 + arg_95_0 then
				var_95_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_95_19 = arg_92_1.actors_["1148"]

			if 3.96666666666667 < arg_92_1.time_ and arg_92_1.time_ <= 3.96666666666667 + arg_95_0 and not isNil(var_95_19) and arg_92_1.var_.actorSpriteComps1148 == nil then
				arg_92_1.var_.actorSpriteComps1148 = var_95_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_20 = 0.125

			if 3.96666666666667 <= arg_92_1.time_ and arg_92_1.time_ < 3.96666666666667 + var_95_20 and not isNil(var_95_19) then
				if arg_92_1.var_.actorSpriteComps1148 then
					for iter_95_4, iter_95_5 in pairs(arg_92_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_95_5 then
							if arg_92_1.isInRecall_ then
								iter_95_5.color = Color.New(Mathf.Lerp(iter_95_5.color.r, arg_92_1.hightColor1.r, (arg_92_1.time_ - 3.96666666666667) / var_95_20), Mathf.Lerp(iter_95_5.color.g, arg_92_1.hightColor1.g, (arg_92_1.time_ - 3.96666666666667) / var_95_20), (Mathf.Lerp(iter_95_5.color.b, arg_92_1.hightColor1.b, (arg_92_1.time_ - 3.96666666666667) / var_95_20)))
							else
								local var_95_21 = Mathf.Lerp(iter_95_5.color.r, 1, (arg_92_1.time_ - 3.96666666666667) / var_95_20)

								iter_95_5.color = Color.New(var_95_21, var_95_21, var_95_21)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= 3.96666666666667 + var_95_20 and arg_92_1.time_ < 3.96666666666667 + var_95_20 + arg_95_0 and not isNil(var_95_19) and arg_92_1.var_.actorSpriteComps1148 then
				for iter_95_6, iter_95_7 in pairs(arg_92_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_95_7 then
						iter_95_7.color = arg_92_1.isInRecall_ and (arg_92_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_92_1.var_.actorSpriteComps1148 = nil
			end

			local var_95_22 = arg_92_1.actors_["1148"].transform

			if 3.96666666666667 < arg_92_1.time_ and arg_92_1.time_ <= 3.96666666666667 + arg_95_0 then
				arg_92_1.var_.moveOldPos1148 = var_95_22.localPosition
				var_95_22.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("1148", 3)

				for iter_95_8 = 0, var_95_22.childCount - 1 do
					local var_95_23 = var_95_22:GetChild(iter_95_8)

					if var_95_23.name == "" or not string.find(var_95_23.name, "split") then
						var_95_23.gameObject:SetActive(true)
					else
						var_95_23.gameObject:SetActive(false)
					end
				end
			end

			local var_95_24 = 0.001

			if 3.96666666666667 <= arg_92_1.time_ and arg_92_1.time_ < 3.96666666666667 + var_95_24 then
				var_95_22.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_92_1.time_ - 3.96666666666667) / var_95_24)
			end

			if arg_92_1.time_ >= 3.96666666666667 + var_95_24 and arg_92_1.time_ < 3.96666666666667 + var_95_24 + arg_95_0 then
				var_95_22.localPosition = Vector3.New(0, -429, -180)
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_95_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_92_1.bgmTxt_.text ~= var_95_27 and arg_92_1.bgmTxt_.text ~= "" then
						if arg_92_1.bgmTxt2_.text ~= "" then
							arg_92_1.bgmTxt_.text = arg_92_1.bgmTxt2_.text
						end

						arg_92_1.bgmTxt2_.text = var_95_27

						arg_92_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_92_1.bgmTxt_.text = var_95_27
						arg_92_1.bgmTxt2_.text = var_95_27
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

			if 1.23333333333333 < arg_92_1.time_ and arg_92_1.time_ <= 1.23333333333333 + arg_95_0 then
				arg_92_1:AudioAction("play", "music", "bgm_activity_3_8_story_tide", "bgm_activity_3_8_story_tide", "bgm_activity_3_8_story_tide.awb")

				local var_95_30 = manager.audio:GetAudioName("bgm_activity_3_8_story_tide", "bgm_activity_3_8_story_tide")

				if "" ~= "" then
					if arg_92_1.bgmTxt_.text ~= var_95_30 and arg_92_1.bgmTxt_.text ~= "" then
						if arg_92_1.bgmTxt2_.text ~= "" then
							arg_92_1.bgmTxt_.text = arg_92_1.bgmTxt2_.text
						end

						arg_92_1.bgmTxt2_.text = var_95_30

						arg_92_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_92_1.bgmTxt_.text = var_95_30
						arg_92_1.bgmTxt2_.text = var_95_30
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

			local var_95_31 = 4
			local var_95_32 = 0.525

			if 4 < arg_92_1.time_ and arg_92_1.time_ <= var_95_31 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0

				arg_92_1.dialog_:SetActive(true)

				arg_92_1.dialogCg_.alpha = 0

				local var_95_33 = LeanTween.value(arg_92_1.dialog_, 0, 1, 0.3)

				var_95_33:setOnUpdate(LuaHelper.FloatAction(function(arg_98_0)
					arg_92_1.dialogCg_.alpha = arg_98_0
				end))
				var_95_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_92_1.dialog_)
					var_95_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_92_1.duration_ = arg_92_1.duration_ + 0.3

				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_34 = arg_92_1:GetWordFromCfg(416091022)
				local var_95_35 = arg_92_1:FormatText(var_95_34.content)

				arg_92_1.text_.text = var_95_35

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_37 = 21 <= 0 and var_95_32 or var_95_32 * (utf8.len(var_95_35) / 21)

				if (21 <= 0 and var_95_32 or var_95_32 * (utf8.len(var_95_35) / 21)) > 0 and var_95_32 < var_95_37 then
					arg_92_1.talkMaxDuration = var_95_37
					var_95_31 = var_95_31 + 0.3

					if var_95_37 + var_95_31 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_37 + var_95_31
					end
				end

				arg_92_1.text_.text = var_95_35
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091022", "story_v_out_416091.awb") ~= 0 then
					local var_95_38 = manager.audio:GetVoiceLength("story_v_out_416091", "416091022", "story_v_out_416091.awb") / 1000

					if var_95_38 + var_95_31 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_38 + var_95_31
					end

					if var_95_34.prefab_name ~= "" and arg_92_1.actors_[var_95_34.prefab_name] ~= nil then
						local var_95_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_34.prefab_name].transform, "story_v_out_416091", "416091022", "story_v_out_416091.awb")

						arg_92_1:RecordAudio("416091022", var_95_39)
						arg_92_1:RecordAudio("416091022", var_95_39)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_416091", "416091022", "story_v_out_416091.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_416091", "416091022", "story_v_out_416091.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_40 = var_95_31 + 0.3
			local var_95_41 = math.max(var_95_32, arg_92_1.talkMaxDuration)

			if var_95_31 + 0.3 <= arg_92_1.time_ and arg_92_1.time_ < var_95_40 + var_95_41 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_40) / var_95_41

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_40 + var_95_41 and arg_92_1.time_ < var_95_40 + var_95_41 + arg_95_0 then
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
			local var_103_0 = 0.425

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_1 = arg_100_1:GetWordFromCfg(416091023)
				local var_103_2 = arg_100_1:FormatText(var_103_1.content)

				arg_100_1.text_.text = var_103_2

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_4 = 17 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_2) / 17)

				if (17 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_2) / 17)) > 0 and var_103_0 < var_103_4 then
					arg_100_1.talkMaxDuration = var_103_4

					if var_103_4 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_4 + 0
					end
				end

				arg_100_1.text_.text = var_103_2
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091023", "story_v_out_416091.awb") ~= 0 then
					local var_103_5 = manager.audio:GetVoiceLength("story_v_out_416091", "416091023", "story_v_out_416091.awb") / 1000

					if var_103_5 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + 0
					end

					if var_103_1.prefab_name ~= "" and arg_100_1.actors_[var_103_1.prefab_name] ~= nil then
						local var_103_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_1.prefab_name].transform, "story_v_out_416091", "416091023", "story_v_out_416091.awb")

						arg_100_1:RecordAudio("416091023", var_103_6)
						arg_100_1:RecordAudio("416091023", var_103_6)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_416091", "416091023", "story_v_out_416091.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_416091", "416091023", "story_v_out_416091.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_7 = math.max(var_103_0, arg_100_1.talkMaxDuration)

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_7 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - 0) / var_103_7

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= 0 + var_103_7 and arg_100_1.time_ < 0 + var_103_7 + arg_103_0 then
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
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["1148"]) and arg_104_1.var_.actorSpriteComps1148 == nil then
				arg_104_1.var_.actorSpriteComps1148 = arg_104_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_0 = 0.125

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["1148"]) then
				if arg_104_1.var_.actorSpriteComps1148 then
					for iter_107_0, iter_107_1 in pairs(arg_104_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_107_1 then
							if arg_104_1.isInRecall_ then
								iter_107_1.color = Color.New(Mathf.Lerp(iter_107_1.color.r, arg_104_1.hightColor2.r, (arg_104_1.time_ - 0) / var_107_0), Mathf.Lerp(iter_107_1.color.g, arg_104_1.hightColor2.g, (arg_104_1.time_ - 0) / var_107_0), (Mathf.Lerp(iter_107_1.color.b, arg_104_1.hightColor2.b, (arg_104_1.time_ - 0) / var_107_0)))
							else
								local var_107_1 = Mathf.Lerp(iter_107_1.color.r, 0.5, (arg_104_1.time_ - 0) / var_107_0)

								iter_107_1.color = Color.New(var_107_1, var_107_1, var_107_1)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["1148"]) and arg_104_1.var_.actorSpriteComps1148 then
				for iter_107_2, iter_107_3 in pairs(arg_104_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_107_3 then
						iter_107_3.color = arg_104_1.isInRecall_ and (arg_104_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_104_1.var_.actorSpriteComps1148 = nil
			end

			local var_107_2 = arg_104_1.actors_["10108"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.actorSpriteComps10108 == nil then
				arg_104_1.var_.actorSpriteComps10108 = var_107_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_3 = 0.125

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_3 and not isNil(var_107_2) then
				if arg_104_1.var_.actorSpriteComps10108 then
					for iter_107_4, iter_107_5 in pairs(arg_104_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_107_5 then
							if arg_104_1.isInRecall_ then
								iter_107_5.color = Color.New(Mathf.Lerp(iter_107_5.color.r, arg_104_1.hightColor1.r, (arg_104_1.time_ - 0) / var_107_3), Mathf.Lerp(iter_107_5.color.g, arg_104_1.hightColor1.g, (arg_104_1.time_ - 0) / var_107_3), (Mathf.Lerp(iter_107_5.color.b, arg_104_1.hightColor1.b, (arg_104_1.time_ - 0) / var_107_3)))
							else
								local var_107_4 = Mathf.Lerp(iter_107_5.color.r, 1, (arg_104_1.time_ - 0) / var_107_3)

								iter_107_5.color = Color.New(var_107_4, var_107_4, var_107_4)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= 0 + var_107_3 and arg_104_1.time_ < 0 + var_107_3 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.actorSpriteComps10108 then
				for iter_107_6, iter_107_7 in pairs(arg_104_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_107_7 then
						iter_107_7.color = arg_104_1.isInRecall_ and (arg_104_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_104_1.var_.actorSpriteComps10108 = nil
			end

			local var_107_5 = arg_104_1.actors_["1148"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1148 = var_107_5.localPosition
				var_107_5.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("1148", 2)

				for iter_107_8 = 0, var_107_5.childCount - 1 do
					local var_107_6 = var_107_5:GetChild(iter_107_8)

					if var_107_6.name == "" or not string.find(var_107_6.name, "split") then
						var_107_6.gameObject:SetActive(true)
					else
						var_107_6.gameObject:SetActive(false)
					end
				end
			end

			local var_107_7 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_7 then
				var_107_5.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1148, Vector3.New(-390, -429, -180), (arg_104_1.time_ - 0) / var_107_7)
			end

			if arg_104_1.time_ >= 0 + var_107_7 and arg_104_1.time_ < 0 + var_107_7 + arg_107_0 then
				var_107_5.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_107_8 = arg_104_1.actors_["10108"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos10108 = var_107_8.localPosition
				var_107_8.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("10108", 4)

				for iter_107_9 = 0, var_107_8.childCount - 1 do
					local var_107_9 = var_107_8:GetChild(iter_107_9)

					if var_107_9.name == "" or not string.find(var_107_9.name, "split") then
						var_107_9.gameObject:SetActive(true)
					else
						var_107_9.gameObject:SetActive(false)
					end
				end
			end

			local var_107_10 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_10 then
				var_107_8.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos10108, Vector3.New(390, -399.6, -130), (arg_104_1.time_ - 0) / var_107_10)
			end

			if arg_104_1.time_ >= 0 + var_107_10 and arg_104_1.time_ < 0 + var_107_10 + arg_107_0 then
				var_107_8.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_107_11 = 0
			local var_107_12 = 0.4

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_11 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_13 = arg_104_1:GetWordFromCfg(416091024)
				local var_107_14 = arg_104_1:FormatText(var_107_13.content)

				arg_104_1.text_.text = var_107_14

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_16 = 16 <= 0 and var_107_12 or var_107_12 * (utf8.len(var_107_14) / 16)

				if (16 <= 0 and var_107_12 or var_107_12 * (utf8.len(var_107_14) / 16)) > 0 and var_107_12 < var_107_16 then
					arg_104_1.talkMaxDuration = var_107_16

					if var_107_16 + var_107_11 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_16 + var_107_11
					end
				end

				arg_104_1.text_.text = var_107_14
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091024", "story_v_out_416091.awb") ~= 0 then
					local var_107_17 = manager.audio:GetVoiceLength("story_v_out_416091", "416091024", "story_v_out_416091.awb") / 1000

					if var_107_17 + var_107_11 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_17 + var_107_11
					end

					if var_107_13.prefab_name ~= "" and arg_104_1.actors_[var_107_13.prefab_name] ~= nil then
						local var_107_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_13.prefab_name].transform, "story_v_out_416091", "416091024", "story_v_out_416091.awb")

						arg_104_1:RecordAudio("416091024", var_107_18)
						arg_104_1:RecordAudio("416091024", var_107_18)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_416091", "416091024", "story_v_out_416091.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_416091", "416091024", "story_v_out_416091.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_19 = math.max(var_107_12, arg_104_1.talkMaxDuration)

			if var_107_11 <= arg_104_1.time_ and arg_104_1.time_ < var_107_11 + var_107_19 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_11) / var_107_19

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_11 + var_107_19 and arg_104_1.time_ < var_107_11 + var_107_19 + arg_107_0 then
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
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["1148"]) and arg_108_1.var_.actorSpriteComps1148 == nil then
				arg_108_1.var_.actorSpriteComps1148 = arg_108_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_0 = 0.125

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["1148"]) then
				if arg_108_1.var_.actorSpriteComps1148 then
					for iter_111_0, iter_111_1 in pairs(arg_108_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_111_1 then
							if arg_108_1.isInRecall_ then
								iter_111_1.color = Color.New(Mathf.Lerp(iter_111_1.color.r, arg_108_1.hightColor1.r, (arg_108_1.time_ - 0) / var_111_0), Mathf.Lerp(iter_111_1.color.g, arg_108_1.hightColor1.g, (arg_108_1.time_ - 0) / var_111_0), (Mathf.Lerp(iter_111_1.color.b, arg_108_1.hightColor1.b, (arg_108_1.time_ - 0) / var_111_0)))
							else
								local var_111_1 = Mathf.Lerp(iter_111_1.color.r, 1, (arg_108_1.time_ - 0) / var_111_0)

								iter_111_1.color = Color.New(var_111_1, var_111_1, var_111_1)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1148"]) and arg_108_1.var_.actorSpriteComps1148 then
				for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_111_3 then
						iter_111_3.color = arg_108_1.isInRecall_ and (arg_108_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_108_1.var_.actorSpriteComps1148 = nil
			end

			local var_111_2 = arg_108_1.actors_["10108"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.actorSpriteComps10108 == nil then
				arg_108_1.var_.actorSpriteComps10108 = var_111_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_3 = 0.125

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_3 and not isNil(var_111_2) then
				if arg_108_1.var_.actorSpriteComps10108 then
					for iter_111_4, iter_111_5 in pairs(arg_108_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_111_5 then
							if arg_108_1.isInRecall_ then
								iter_111_5.color = Color.New(Mathf.Lerp(iter_111_5.color.r, arg_108_1.hightColor2.r, (arg_108_1.time_ - 0) / var_111_3), Mathf.Lerp(iter_111_5.color.g, arg_108_1.hightColor2.g, (arg_108_1.time_ - 0) / var_111_3), (Mathf.Lerp(iter_111_5.color.b, arg_108_1.hightColor2.b, (arg_108_1.time_ - 0) / var_111_3)))
							else
								local var_111_4 = Mathf.Lerp(iter_111_5.color.r, 0.5, (arg_108_1.time_ - 0) / var_111_3)

								iter_111_5.color = Color.New(var_111_4, var_111_4, var_111_4)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= 0 + var_111_3 and arg_108_1.time_ < 0 + var_111_3 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.actorSpriteComps10108 then
				for iter_111_6, iter_111_7 in pairs(arg_108_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_111_7 then
						iter_111_7.color = arg_108_1.isInRecall_ and (arg_108_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_108_1.var_.actorSpriteComps10108 = nil
			end

			local var_111_5 = 0
			local var_111_6 = 0.4

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_7 = arg_108_1:GetWordFromCfg(416091025)
				local var_111_8 = arg_108_1:FormatText(var_111_7.content)

				arg_108_1.text_.text = var_111_8

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_10 = 16 <= 0 and var_111_6 or var_111_6 * (utf8.len(var_111_8) / 16)

				if (16 <= 0 and var_111_6 or var_111_6 * (utf8.len(var_111_8) / 16)) > 0 and var_111_6 < var_111_10 then
					arg_108_1.talkMaxDuration = var_111_10

					if var_111_10 + var_111_5 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_10 + var_111_5
					end
				end

				arg_108_1.text_.text = var_111_8
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091025", "story_v_out_416091.awb") ~= 0 then
					local var_111_11 = manager.audio:GetVoiceLength("story_v_out_416091", "416091025", "story_v_out_416091.awb") / 1000

					if var_111_11 + var_111_5 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_11 + var_111_5
					end

					if var_111_7.prefab_name ~= "" and arg_108_1.actors_[var_111_7.prefab_name] ~= nil then
						local var_111_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_7.prefab_name].transform, "story_v_out_416091", "416091025", "story_v_out_416091.awb")

						arg_108_1:RecordAudio("416091025", var_111_12)
						arg_108_1:RecordAudio("416091025", var_111_12)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_416091", "416091025", "story_v_out_416091.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_416091", "416091025", "story_v_out_416091.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_13 = math.max(var_111_6, arg_108_1.talkMaxDuration)

			if var_111_5 <= arg_108_1.time_ and arg_108_1.time_ < var_111_5 + var_111_13 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_5) / var_111_13

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_5 + var_111_13 and arg_108_1.time_ < var_111_5 + var_111_13 + arg_111_0 then
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
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1148"]) and arg_112_1.var_.actorSpriteComps1148 == nil then
				arg_112_1.var_.actorSpriteComps1148 = arg_112_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_0 = 0.125

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1148"]) then
				if arg_112_1.var_.actorSpriteComps1148 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_115_1 then
							if arg_112_1.isInRecall_ then
								iter_115_1.color = Color.New(Mathf.Lerp(iter_115_1.color.r, arg_112_1.hightColor2.r, (arg_112_1.time_ - 0) / var_115_0), Mathf.Lerp(iter_115_1.color.g, arg_112_1.hightColor2.g, (arg_112_1.time_ - 0) / var_115_0), (Mathf.Lerp(iter_115_1.color.b, arg_112_1.hightColor2.b, (arg_112_1.time_ - 0) / var_115_0)))
							else
								local var_115_1 = Mathf.Lerp(iter_115_1.color.r, 0.5, (arg_112_1.time_ - 0) / var_115_0)

								iter_115_1.color = Color.New(var_115_1, var_115_1, var_115_1)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1148"]) and arg_112_1.var_.actorSpriteComps1148 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_115_3 then
						iter_115_3.color = arg_112_1.isInRecall_ and (arg_112_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_112_1.var_.actorSpriteComps1148 = nil
			end

			local var_115_2 = arg_112_1.actors_["10108"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.actorSpriteComps10108 == nil then
				arg_112_1.var_.actorSpriteComps10108 = var_115_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_3 = 0.125

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_3 and not isNil(var_115_2) then
				if arg_112_1.var_.actorSpriteComps10108 then
					for iter_115_4, iter_115_5 in pairs(arg_112_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_115_5 then
							if arg_112_1.isInRecall_ then
								iter_115_5.color = Color.New(Mathf.Lerp(iter_115_5.color.r, arg_112_1.hightColor1.r, (arg_112_1.time_ - 0) / var_115_3), Mathf.Lerp(iter_115_5.color.g, arg_112_1.hightColor1.g, (arg_112_1.time_ - 0) / var_115_3), (Mathf.Lerp(iter_115_5.color.b, arg_112_1.hightColor1.b, (arg_112_1.time_ - 0) / var_115_3)))
							else
								local var_115_4 = Mathf.Lerp(iter_115_5.color.r, 1, (arg_112_1.time_ - 0) / var_115_3)

								iter_115_5.color = Color.New(var_115_4, var_115_4, var_115_4)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= 0 + var_115_3 and arg_112_1.time_ < 0 + var_115_3 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.actorSpriteComps10108 then
				for iter_115_6, iter_115_7 in pairs(arg_112_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_115_7 then
						iter_115_7.color = arg_112_1.isInRecall_ and (arg_112_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_112_1.var_.actorSpriteComps10108 = nil
			end

			local var_115_5 = 0
			local var_115_6 = 0.425

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_5 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_7 = arg_112_1:GetWordFromCfg(416091026)
				local var_115_8 = arg_112_1:FormatText(var_115_7.content)

				arg_112_1.text_.text = var_115_8

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_10 = 17 <= 0 and var_115_6 or var_115_6 * (utf8.len(var_115_8) / 17)

				if (17 <= 0 and var_115_6 or var_115_6 * (utf8.len(var_115_8) / 17)) > 0 and var_115_6 < var_115_10 then
					arg_112_1.talkMaxDuration = var_115_10

					if var_115_10 + var_115_5 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_10 + var_115_5
					end
				end

				arg_112_1.text_.text = var_115_8
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091026", "story_v_out_416091.awb") ~= 0 then
					local var_115_11 = manager.audio:GetVoiceLength("story_v_out_416091", "416091026", "story_v_out_416091.awb") / 1000

					if var_115_11 + var_115_5 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_11 + var_115_5
					end

					if var_115_7.prefab_name ~= "" and arg_112_1.actors_[var_115_7.prefab_name] ~= nil then
						local var_115_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_7.prefab_name].transform, "story_v_out_416091", "416091026", "story_v_out_416091.awb")

						arg_112_1:RecordAudio("416091026", var_115_12)
						arg_112_1:RecordAudio("416091026", var_115_12)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_416091", "416091026", "story_v_out_416091.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_416091", "416091026", "story_v_out_416091.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_13 = math.max(var_115_6, arg_112_1.talkMaxDuration)

			if var_115_5 <= arg_112_1.time_ and arg_112_1.time_ < var_115_5 + var_115_13 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_5) / var_115_13

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_5 + var_115_13 and arg_112_1.time_ < var_115_5 + var_115_13 + arg_115_0 then
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
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos10108 = arg_116_1.actors_["10108"].transform.localPosition
				arg_116_1.actors_["10108"].transform.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("10108", 7)

				for iter_119_0 = 0, arg_116_1.actors_["10108"].transform.childCount - 1 do
					local var_119_0 = arg_116_1.actors_["10108"].transform:GetChild(iter_119_0)

					if var_119_0.name == "" or not string.find(var_119_0.name, "split") then
						var_119_0.gameObject:SetActive(true)
					else
						var_119_0.gameObject:SetActive(false)
					end
				end
			end

			local var_119_1 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_1 then
				arg_116_1.actors_["10108"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos10108, Vector3.New(0, -2000, 0), (arg_116_1.time_ - 0) / var_119_1)
			end

			if arg_116_1.time_ >= 0 + var_119_1 and arg_116_1.time_ < 0 + var_119_1 + arg_119_0 then
				arg_116_1.actors_["10108"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_119_2 = arg_116_1.actors_["1148"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1148 = var_119_2.localPosition
				var_119_2.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("1148", 7)

				for iter_119_1 = 0, var_119_2.childCount - 1 do
					local var_119_3 = var_119_2:GetChild(iter_119_1)

					if var_119_3.name == "" or not string.find(var_119_3.name, "split") then
						var_119_3.gameObject:SetActive(true)
					else
						var_119_3.gameObject:SetActive(false)
					end
				end
			end

			local var_119_4 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 then
				var_119_2.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_116_1.time_ - 0) / var_119_4)
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 then
				var_119_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_gunready", "")
			end

			local var_119_6 = 0
			local var_119_7 = 1.3

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_8 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(416091027).content)

				arg_116_1.text_.text = var_119_8

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_10 = 52 <= 0 and var_119_7 or var_119_7 * (utf8.len(var_119_8) / 52)

				if (52 <= 0 and var_119_7 or var_119_7 * (utf8.len(var_119_8) / 52)) > 0 and var_119_7 < var_119_10 then
					arg_116_1.talkMaxDuration = var_119_10

					if var_119_10 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_10 + var_119_6
					end
				end

				arg_116_1.text_.text = var_119_8
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_11 = math.max(var_119_7, arg_116_1.talkMaxDuration)

			if var_119_6 <= arg_116_1.time_ and arg_116_1.time_ < var_119_6 + var_119_11 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_6) / var_119_11

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_6 + var_119_11 and arg_116_1.time_ < var_119_6 + var_119_11 + arg_119_0 then
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
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos1148 = arg_120_1.actors_["1148"].transform.localPosition
				arg_120_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_120_1:CheckSpriteTmpPos("1148", 3)

				for iter_123_0 = 0, arg_120_1.actors_["1148"].transform.childCount - 1 do
					local var_123_0 = arg_120_1.actors_["1148"].transform:GetChild(iter_123_0)

					if var_123_0.name == "split_6" or not string.find(var_123_0.name, "split") then
						var_123_0.gameObject:SetActive(true)
					else
						var_123_0.gameObject:SetActive(false)
					end
				end
			end

			local var_123_1 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_1 then
				arg_120_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_120_1.time_ - 0) / var_123_1)
			end

			if arg_120_1.time_ >= 0 + var_123_1 and arg_120_1.time_ < 0 + var_123_1 + arg_123_0 then
				arg_120_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_123_2 = arg_120_1.actors_["1148"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.actorSpriteComps1148 == nil then
				arg_120_1.var_.actorSpriteComps1148 = var_123_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_3 = 0.125

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_3 and not isNil(var_123_2) then
				if arg_120_1.var_.actorSpriteComps1148 then
					for iter_123_1, iter_123_2 in pairs(arg_120_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_123_2 then
							if arg_120_1.isInRecall_ then
								iter_123_2.color = Color.New(Mathf.Lerp(iter_123_2.color.r, arg_120_1.hightColor1.r, (arg_120_1.time_ - 0) / var_123_3), Mathf.Lerp(iter_123_2.color.g, arg_120_1.hightColor1.g, (arg_120_1.time_ - 0) / var_123_3), (Mathf.Lerp(iter_123_2.color.b, arg_120_1.hightColor1.b, (arg_120_1.time_ - 0) / var_123_3)))
							else
								local var_123_4 = Mathf.Lerp(iter_123_2.color.r, 1, (arg_120_1.time_ - 0) / var_123_3)

								iter_123_2.color = Color.New(var_123_4, var_123_4, var_123_4)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= 0 + var_123_3 and arg_120_1.time_ < 0 + var_123_3 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.actorSpriteComps1148 then
				for iter_123_3, iter_123_4 in pairs(arg_120_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_123_4 then
						iter_123_4.color = arg_120_1.isInRecall_ and (arg_120_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_120_1.var_.actorSpriteComps1148 = nil
			end

			local var_123_5 = 0
			local var_123_6 = 0.775

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_7 = arg_120_1:GetWordFromCfg(416091028)
				local var_123_8 = arg_120_1:FormatText(var_123_7.content)

				arg_120_1.text_.text = var_123_8

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_10 = 31 <= 0 and var_123_6 or var_123_6 * (utf8.len(var_123_8) / 31)

				if (31 <= 0 and var_123_6 or var_123_6 * (utf8.len(var_123_8) / 31)) > 0 and var_123_6 < var_123_10 then
					arg_120_1.talkMaxDuration = var_123_10

					if var_123_10 + var_123_5 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_10 + var_123_5
					end
				end

				arg_120_1.text_.text = var_123_8
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091028", "story_v_out_416091.awb") ~= 0 then
					local var_123_11 = manager.audio:GetVoiceLength("story_v_out_416091", "416091028", "story_v_out_416091.awb") / 1000

					if var_123_11 + var_123_5 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_11 + var_123_5
					end

					if var_123_7.prefab_name ~= "" and arg_120_1.actors_[var_123_7.prefab_name] ~= nil then
						local var_123_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_7.prefab_name].transform, "story_v_out_416091", "416091028", "story_v_out_416091.awb")

						arg_120_1:RecordAudio("416091028", var_123_12)
						arg_120_1:RecordAudio("416091028", var_123_12)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_416091", "416091028", "story_v_out_416091.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_416091", "416091028", "story_v_out_416091.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_13 = math.max(var_123_6, arg_120_1.talkMaxDuration)

			if var_123_5 <= arg_120_1.time_ and arg_120_1.time_ < var_123_5 + var_123_13 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_5) / var_123_13

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_5 + var_123_13 and arg_120_1.time_ < var_123_5 + var_123_13 + arg_123_0 then
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
			local var_127_0 = 0.475

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_1 = arg_124_1:GetWordFromCfg(416091029)
				local var_127_2 = arg_124_1:FormatText(var_127_1.content)

				arg_124_1.text_.text = var_127_2

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_4 = 19 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 19)

				if (19 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 19)) > 0 and var_127_0 < var_127_4 then
					arg_124_1.talkMaxDuration = var_127_4

					if var_127_4 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_4 + 0
					end
				end

				arg_124_1.text_.text = var_127_2
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091029", "story_v_out_416091.awb") ~= 0 then
					local var_127_5 = manager.audio:GetVoiceLength("story_v_out_416091", "416091029", "story_v_out_416091.awb") / 1000

					if var_127_5 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + 0
					end

					if var_127_1.prefab_name ~= "" and arg_124_1.actors_[var_127_1.prefab_name] ~= nil then
						local var_127_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_1.prefab_name].transform, "story_v_out_416091", "416091029", "story_v_out_416091.awb")

						arg_124_1:RecordAudio("416091029", var_127_6)
						arg_124_1:RecordAudio("416091029", var_127_6)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_416091", "416091029", "story_v_out_416091.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_416091", "416091029", "story_v_out_416091.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_7 = math.max(var_127_0, arg_124_1.talkMaxDuration)

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_7 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - 0) / var_127_7

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= 0 + var_127_7 and arg_124_1.time_ < 0 + var_127_7 + arg_127_0 then
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
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1148"]) and arg_128_1.var_.actorSpriteComps1148 == nil then
				arg_128_1.var_.actorSpriteComps1148 = arg_128_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_0 = 0.125

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1148"]) then
				if arg_128_1.var_.actorSpriteComps1148 then
					for iter_131_0, iter_131_1 in pairs(arg_128_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_131_1 then
							if arg_128_1.isInRecall_ then
								iter_131_1.color = Color.New(Mathf.Lerp(iter_131_1.color.r, arg_128_1.hightColor2.r, (arg_128_1.time_ - 0) / var_131_0), Mathf.Lerp(iter_131_1.color.g, arg_128_1.hightColor2.g, (arg_128_1.time_ - 0) / var_131_0), (Mathf.Lerp(iter_131_1.color.b, arg_128_1.hightColor2.b, (arg_128_1.time_ - 0) / var_131_0)))
							else
								local var_131_1 = Mathf.Lerp(iter_131_1.color.r, 0.5, (arg_128_1.time_ - 0) / var_131_0)

								iter_131_1.color = Color.New(var_131_1, var_131_1, var_131_1)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1148"]) and arg_128_1.var_.actorSpriteComps1148 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_131_3 then
						iter_131_3.color = arg_128_1.isInRecall_ and (arg_128_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_128_1.var_.actorSpriteComps1148 = nil
			end

			local var_131_2 = arg_128_1.actors_["10108"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.actorSpriteComps10108 == nil then
				arg_128_1.var_.actorSpriteComps10108 = var_131_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_3 = 0.125

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_3 and not isNil(var_131_2) then
				if arg_128_1.var_.actorSpriteComps10108 then
					for iter_131_4, iter_131_5 in pairs(arg_128_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_131_5 then
							if arg_128_1.isInRecall_ then
								iter_131_5.color = Color.New(Mathf.Lerp(iter_131_5.color.r, arg_128_1.hightColor1.r, (arg_128_1.time_ - 0) / var_131_3), Mathf.Lerp(iter_131_5.color.g, arg_128_1.hightColor1.g, (arg_128_1.time_ - 0) / var_131_3), (Mathf.Lerp(iter_131_5.color.b, arg_128_1.hightColor1.b, (arg_128_1.time_ - 0) / var_131_3)))
							else
								local var_131_4 = Mathf.Lerp(iter_131_5.color.r, 1, (arg_128_1.time_ - 0) / var_131_3)

								iter_131_5.color = Color.New(var_131_4, var_131_4, var_131_4)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= 0 + var_131_3 and arg_128_1.time_ < 0 + var_131_3 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.actorSpriteComps10108 then
				for iter_131_6, iter_131_7 in pairs(arg_128_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_131_7 then
						iter_131_7.color = arg_128_1.isInRecall_ and (arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_128_1.var_.actorSpriteComps10108 = nil
			end

			local var_131_5 = arg_128_1.actors_["1148"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1148 = var_131_5.localPosition
				var_131_5.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("1148", 2)

				for iter_131_8 = 0, var_131_5.childCount - 1 do
					local var_131_6 = var_131_5:GetChild(iter_131_8)

					if var_131_6.name == "" or not string.find(var_131_6.name, "split") then
						var_131_6.gameObject:SetActive(true)
					else
						var_131_6.gameObject:SetActive(false)
					end
				end
			end

			local var_131_7 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_7 then
				var_131_5.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1148, Vector3.New(-390, -429, -180), (arg_128_1.time_ - 0) / var_131_7)
			end

			if arg_128_1.time_ >= 0 + var_131_7 and arg_128_1.time_ < 0 + var_131_7 + arg_131_0 then
				var_131_5.localPosition = Vector3.New(-390, -429, -180)
			end

			local var_131_8 = arg_128_1.actors_["10108"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos10108 = var_131_8.localPosition
				var_131_8.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("10108", 4)

				for iter_131_9 = 0, var_131_8.childCount - 1 do
					local var_131_9 = var_131_8:GetChild(iter_131_9)

					if var_131_9.name == "" or not string.find(var_131_9.name, "split") then
						var_131_9.gameObject:SetActive(true)
					else
						var_131_9.gameObject:SetActive(false)
					end
				end
			end

			local var_131_10 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_10 then
				var_131_8.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10108, Vector3.New(390, -399.6, -130), (arg_128_1.time_ - 0) / var_131_10)
			end

			if arg_128_1.time_ >= 0 + var_131_10 and arg_128_1.time_ < 0 + var_131_10 + arg_131_0 then
				var_131_8.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_131_11 = 0
			local var_131_12 = 0.575

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_11 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_13 = arg_128_1:GetWordFromCfg(416091030)
				local var_131_14 = arg_128_1:FormatText(var_131_13.content)

				arg_128_1.text_.text = var_131_14

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_16 = 23 <= 0 and var_131_12 or var_131_12 * (utf8.len(var_131_14) / 23)

				if (23 <= 0 and var_131_12 or var_131_12 * (utf8.len(var_131_14) / 23)) > 0 and var_131_12 < var_131_16 then
					arg_128_1.talkMaxDuration = var_131_16

					if var_131_16 + var_131_11 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_16 + var_131_11
					end
				end

				arg_128_1.text_.text = var_131_14
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091030", "story_v_out_416091.awb") ~= 0 then
					local var_131_17 = manager.audio:GetVoiceLength("story_v_out_416091", "416091030", "story_v_out_416091.awb") / 1000

					if var_131_17 + var_131_11 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_17 + var_131_11
					end

					if var_131_13.prefab_name ~= "" and arg_128_1.actors_[var_131_13.prefab_name] ~= nil then
						local var_131_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_13.prefab_name].transform, "story_v_out_416091", "416091030", "story_v_out_416091.awb")

						arg_128_1:RecordAudio("416091030", var_131_18)
						arg_128_1:RecordAudio("416091030", var_131_18)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_416091", "416091030", "story_v_out_416091.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_416091", "416091030", "story_v_out_416091.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_19 = math.max(var_131_12, arg_128_1.talkMaxDuration)

			if var_131_11 <= arg_128_1.time_ and arg_128_1.time_ < var_131_11 + var_131_19 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_11) / var_131_19

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_11 + var_131_19 and arg_128_1.time_ < var_131_11 + var_131_19 + arg_131_0 then
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
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1148"]) and arg_132_1.var_.actorSpriteComps1148 == nil then
				arg_132_1.var_.actorSpriteComps1148 = arg_132_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_0 = 0.125

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1148"]) then
				if arg_132_1.var_.actorSpriteComps1148 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_135_1 then
							if arg_132_1.isInRecall_ then
								iter_135_1.color = Color.New(Mathf.Lerp(iter_135_1.color.r, arg_132_1.hightColor1.r, (arg_132_1.time_ - 0) / var_135_0), Mathf.Lerp(iter_135_1.color.g, arg_132_1.hightColor1.g, (arg_132_1.time_ - 0) / var_135_0), (Mathf.Lerp(iter_135_1.color.b, arg_132_1.hightColor1.b, (arg_132_1.time_ - 0) / var_135_0)))
							else
								local var_135_1 = Mathf.Lerp(iter_135_1.color.r, 1, (arg_132_1.time_ - 0) / var_135_0)

								iter_135_1.color = Color.New(var_135_1, var_135_1, var_135_1)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1148"]) and arg_132_1.var_.actorSpriteComps1148 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_135_3 then
						iter_135_3.color = arg_132_1.isInRecall_ and (arg_132_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_132_1.var_.actorSpriteComps1148 = nil
			end

			local var_135_2 = arg_132_1.actors_["10108"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.actorSpriteComps10108 == nil then
				arg_132_1.var_.actorSpriteComps10108 = var_135_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_3 = 0.125

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_3 and not isNil(var_135_2) then
				if arg_132_1.var_.actorSpriteComps10108 then
					for iter_135_4, iter_135_5 in pairs(arg_132_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_135_5 then
							if arg_132_1.isInRecall_ then
								iter_135_5.color = Color.New(Mathf.Lerp(iter_135_5.color.r, arg_132_1.hightColor2.r, (arg_132_1.time_ - 0) / var_135_3), Mathf.Lerp(iter_135_5.color.g, arg_132_1.hightColor2.g, (arg_132_1.time_ - 0) / var_135_3), (Mathf.Lerp(iter_135_5.color.b, arg_132_1.hightColor2.b, (arg_132_1.time_ - 0) / var_135_3)))
							else
								local var_135_4 = Mathf.Lerp(iter_135_5.color.r, 0.5, (arg_132_1.time_ - 0) / var_135_3)

								iter_135_5.color = Color.New(var_135_4, var_135_4, var_135_4)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= 0 + var_135_3 and arg_132_1.time_ < 0 + var_135_3 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.actorSpriteComps10108 then
				for iter_135_6, iter_135_7 in pairs(arg_132_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_135_7 then
						iter_135_7.color = arg_132_1.isInRecall_ and (arg_132_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_132_1.var_.actorSpriteComps10108 = nil
			end

			local var_135_5 = 0
			local var_135_6 = 0.525

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_5 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_7 = arg_132_1:GetWordFromCfg(416091031)
				local var_135_8 = arg_132_1:FormatText(var_135_7.content)

				arg_132_1.text_.text = var_135_8

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_10 = 21 <= 0 and var_135_6 or var_135_6 * (utf8.len(var_135_8) / 21)

				if (21 <= 0 and var_135_6 or var_135_6 * (utf8.len(var_135_8) / 21)) > 0 and var_135_6 < var_135_10 then
					arg_132_1.talkMaxDuration = var_135_10

					if var_135_10 + var_135_5 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_10 + var_135_5
					end
				end

				arg_132_1.text_.text = var_135_8
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091031", "story_v_out_416091.awb") ~= 0 then
					local var_135_11 = manager.audio:GetVoiceLength("story_v_out_416091", "416091031", "story_v_out_416091.awb") / 1000

					if var_135_11 + var_135_5 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_11 + var_135_5
					end

					if var_135_7.prefab_name ~= "" and arg_132_1.actors_[var_135_7.prefab_name] ~= nil then
						local var_135_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_7.prefab_name].transform, "story_v_out_416091", "416091031", "story_v_out_416091.awb")

						arg_132_1:RecordAudio("416091031", var_135_12)
						arg_132_1:RecordAudio("416091031", var_135_12)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_416091", "416091031", "story_v_out_416091.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_416091", "416091031", "story_v_out_416091.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_13 = math.max(var_135_6, arg_132_1.talkMaxDuration)

			if var_135_5 <= arg_132_1.time_ and arg_132_1.time_ < var_135_5 + var_135_13 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_5) / var_135_13

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_5 + var_135_13 and arg_132_1.time_ < var_135_5 + var_135_13 + arg_135_0 then
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
			local var_139_0 = 0.4

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_1 = arg_136_1:GetWordFromCfg(416091032)
				local var_139_2 = arg_136_1:FormatText(var_139_1.content)

				arg_136_1.text_.text = var_139_2

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_4 = 16 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 16)

				if (16 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 16)) > 0 and var_139_0 < var_139_4 then
					arg_136_1.talkMaxDuration = var_139_4

					if var_139_4 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_4 + 0
					end
				end

				arg_136_1.text_.text = var_139_2
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091032", "story_v_out_416091.awb") ~= 0 then
					local var_139_5 = manager.audio:GetVoiceLength("story_v_out_416091", "416091032", "story_v_out_416091.awb") / 1000

					if var_139_5 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + 0
					end

					if var_139_1.prefab_name ~= "" and arg_136_1.actors_[var_139_1.prefab_name] ~= nil then
						local var_139_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_1.prefab_name].transform, "story_v_out_416091", "416091032", "story_v_out_416091.awb")

						arg_136_1:RecordAudio("416091032", var_139_6)
						arg_136_1:RecordAudio("416091032", var_139_6)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_416091", "416091032", "story_v_out_416091.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_416091", "416091032", "story_v_out_416091.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_7 = math.max(var_139_0, arg_136_1.talkMaxDuration)

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_7 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - 0) / var_139_7

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= 0 + var_139_7 and arg_136_1.time_ < 0 + var_139_7 + arg_139_0 then
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
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos10108 = arg_140_1.actors_["10108"].transform.localPosition
				arg_140_1.actors_["10108"].transform.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("10108", 7)

				for iter_143_0 = 0, arg_140_1.actors_["10108"].transform.childCount - 1 do
					local var_143_0 = arg_140_1.actors_["10108"].transform:GetChild(iter_143_0)

					if var_143_0.name == "" or not string.find(var_143_0.name, "split") then
						var_143_0.gameObject:SetActive(true)
					else
						var_143_0.gameObject:SetActive(false)
					end
				end
			end

			local var_143_1 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_1 then
				arg_140_1.actors_["10108"].transform.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos10108, Vector3.New(0, -2000, 0), (arg_140_1.time_ - 0) / var_143_1)
			end

			if arg_140_1.time_ >= 0 + var_143_1 and arg_140_1.time_ < 0 + var_143_1 + arg_143_0 then
				arg_140_1.actors_["10108"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_143_2 = arg_140_1.actors_["1148"].transform

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1148 = var_143_2.localPosition
				var_143_2.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("1148", 7)

				for iter_143_1 = 0, var_143_2.childCount - 1 do
					local var_143_3 = var_143_2:GetChild(iter_143_1)

					if var_143_3.name == "" or not string.find(var_143_3.name, "split") then
						var_143_3.gameObject:SetActive(true)
					else
						var_143_3.gameObject:SetActive(false)
					end
				end
			end

			local var_143_4 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_4 then
				var_143_2.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_140_1.time_ - 0) / var_143_4)
			end

			if arg_140_1.time_ >= 0 + var_143_4 and arg_140_1.time_ < 0 + var_143_4 + arg_143_0 then
				var_143_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_143_5 = 0
			local var_143_6 = 1.05

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_7 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(416091033).content)

				arg_140_1.text_.text = var_143_7

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_9 = 42 <= 0 and var_143_6 or var_143_6 * (utf8.len(var_143_7) / 42)

				if (42 <= 0 and var_143_6 or var_143_6 * (utf8.len(var_143_7) / 42)) > 0 and var_143_6 < var_143_9 then
					arg_140_1.talkMaxDuration = var_143_9

					if var_143_9 + var_143_5 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_9 + var_143_5
					end
				end

				arg_140_1.text_.text = var_143_7
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_10 = math.max(var_143_6, arg_140_1.talkMaxDuration)

			if var_143_5 <= arg_140_1.time_ and arg_140_1.time_ < var_143_5 + var_143_10 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_5) / var_143_10

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_5 + var_143_10 and arg_140_1.time_ < var_143_5 + var_143_10 + arg_143_0 then
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
			if 4 < arg_144_1.time_ and arg_144_1.time_ <= 4 + arg_147_0 then
				arg_144_1.allBtn_.enabled = false
			end

			if arg_144_1.time_ >= 4 + 0.3 and arg_144_1.time_ < 4 + 0.3 + arg_147_0 then
				arg_144_1.allBtn_.enabled = true
			end

			local var_147_0 = "I14f"

			if arg_144_1.bgs_.I14f == nil then
				local var_147_1 = Object.Instantiate(arg_144_1.paintGo_)

				var_147_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_147_0)
				var_147_1.name = var_147_0
				var_147_1.transform.parent = arg_144_1.stage_.transform
				var_147_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_144_1.bgs_[var_147_0] = var_147_1
			end

			if 2 < arg_144_1.time_ and arg_144_1.time_ <= 2 + arg_147_0 then
				local var_147_2 = arg_144_1.bgs_.I14f

				arg_144_1.bgs_.I14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_147_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_147_3 = var_147_2:GetComponent("SpriteRenderer")

				if var_147_3 and var_147_3.sprite then
					local var_147_4 = 2 * (var_147_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_147_2.transform.localScale = Vector3.New(var_147_4 / var_147_3.sprite.bounds.size.y < var_147_4 * manager.ui.mainCameraCom_.aspect / var_147_3.sprite.bounds.size.x and var_147_4 * manager.ui.mainCameraCom_.aspect / var_147_3.sprite.bounds.size.x or var_147_4 / var_147_3.sprite.bounds.size.y, var_147_4 / var_147_3.sprite.bounds.size.y < var_147_4 * manager.ui.mainCameraCom_.aspect / var_147_3.sprite.bounds.size.x and var_147_4 * manager.ui.mainCameraCom_.aspect / var_147_3.sprite.bounds.size.x or var_147_4 / var_147_3.sprite.bounds.size.y, 0)
				end

				for iter_147_0, iter_147_1 in pairs(arg_144_1.bgs_) do
					if iter_147_0 ~= "I14f" then
						iter_147_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_147_5 = 0

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_5 + arg_147_0 then
				arg_144_1.mask_.enabled = true
				arg_144_1.mask_.raycastTarget = true

				arg_144_1:SetGaussion(false)
			end

			local var_147_6 = 2

			if var_147_5 <= arg_144_1.time_ and arg_144_1.time_ < var_147_5 + var_147_6 then
				local var_147_7 = Color.New(0, 0, 0)

				var_147_7.a = Mathf.Lerp(0, 1, (arg_144_1.time_ - var_147_5) / var_147_6)
				arg_144_1.mask_.color = var_147_7
			end

			if arg_144_1.time_ >= var_147_5 + var_147_6 and arg_144_1.time_ < var_147_5 + var_147_6 + arg_147_0 then
				local var_147_8 = Color.New(0, 0, 0)

				var_147_8.a = 1
				arg_144_1.mask_.color = var_147_8
			end

			local var_147_9 = 2

			if 2 < arg_144_1.time_ and arg_144_1.time_ <= var_147_9 + arg_147_0 then
				arg_144_1.mask_.enabled = true
				arg_144_1.mask_.raycastTarget = true

				arg_144_1:SetGaussion(false)
			end

			local var_147_10 = 2

			if var_147_9 <= arg_144_1.time_ and arg_144_1.time_ < var_147_9 + var_147_10 then
				local var_147_11 = Color.New(0, 0, 0)

				var_147_11.a = Mathf.Lerp(1, 0, (arg_144_1.time_ - var_147_9) / var_147_10)
				arg_144_1.mask_.color = var_147_11
			end

			if arg_144_1.time_ >= var_147_9 + var_147_10 and arg_144_1.time_ < var_147_9 + var_147_10 + arg_147_0 then
				local var_147_12 = Color.New(0, 0, 0)

				arg_144_1.mask_.enabled = false
				var_147_12.a = 0
				arg_144_1.mask_.color = var_147_12
			end

			local var_147_13 = arg_144_1.actors_["1148"].transform

			if 3.61733333333333 < arg_144_1.time_ and arg_144_1.time_ <= 3.61733333333333 + arg_147_0 then
				arg_144_1.var_.moveOldPos1148 = var_147_13.localPosition
				var_147_13.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("1148", 3)

				for iter_147_2 = 0, var_147_13.childCount - 1 do
					local var_147_14 = var_147_13:GetChild(iter_147_2)

					if var_147_14.name == "split_6" or not string.find(var_147_14.name, "split") then
						var_147_14.gameObject:SetActive(true)
					else
						var_147_14.gameObject:SetActive(false)
					end
				end
			end

			local var_147_15 = 0.001

			if 3.61733333333333 <= arg_144_1.time_ and arg_144_1.time_ < 3.61733333333333 + var_147_15 then
				var_147_13.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_144_1.time_ - 3.61733333333333) / var_147_15)
			end

			if arg_144_1.time_ >= 3.61733333333333 + var_147_15 and arg_144_1.time_ < 3.61733333333333 + var_147_15 + arg_147_0 then
				var_147_13.localPosition = Vector3.New(0, -429, -180)
			end

			local var_147_16 = arg_144_1.actors_["1148"]

			if 3.61733333333333 < arg_144_1.time_ and arg_144_1.time_ <= 3.61733333333333 + arg_147_0 and not isNil(var_147_16) and arg_144_1.var_.actorSpriteComps1148 == nil then
				arg_144_1.var_.actorSpriteComps1148 = var_147_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_17 = 0.125

			if 3.61733333333333 <= arg_144_1.time_ and arg_144_1.time_ < 3.61733333333333 + var_147_17 and not isNil(var_147_16) then
				if arg_144_1.var_.actorSpriteComps1148 then
					for iter_147_3, iter_147_4 in pairs(arg_144_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_147_4 then
							if arg_144_1.isInRecall_ then
								iter_147_4.color = Color.New(Mathf.Lerp(iter_147_4.color.r, arg_144_1.hightColor1.r, (arg_144_1.time_ - 3.61733333333333) / var_147_17), Mathf.Lerp(iter_147_4.color.g, arg_144_1.hightColor1.g, (arg_144_1.time_ - 3.61733333333333) / var_147_17), (Mathf.Lerp(iter_147_4.color.b, arg_144_1.hightColor1.b, (arg_144_1.time_ - 3.61733333333333) / var_147_17)))
							else
								local var_147_18 = Mathf.Lerp(iter_147_4.color.r, 1, (arg_144_1.time_ - 3.61733333333333) / var_147_17)

								iter_147_4.color = Color.New(var_147_18, var_147_18, var_147_18)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= 3.61733333333333 + var_147_17 and arg_144_1.time_ < 3.61733333333333 + var_147_17 + arg_147_0 and not isNil(var_147_16) and arg_144_1.var_.actorSpriteComps1148 then
				for iter_147_5, iter_147_6 in pairs(arg_144_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_147_6 then
						iter_147_6.color = arg_144_1.isInRecall_ and (arg_144_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_144_1.var_.actorSpriteComps1148 = nil
			end

			if 3.61733333333333 < arg_144_1.time_ and arg_144_1.time_ <= 3.61733333333333 + arg_147_0 then
				local var_147_19 = arg_144_1.actors_["1148"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_147_19 then
					arg_144_1.var_.alphaOldValue1148 = var_147_19.alpha
					arg_144_1.var_.characterEffect1148 = var_147_19
				end

				arg_144_1.var_.alphaOldValue1148 = 0
			end

			local var_147_20 = 0.416

			if 3.61733333333333 <= arg_144_1.time_ and arg_144_1.time_ < 3.61733333333333 + var_147_20 then
				if arg_144_1.var_.characterEffect1148 then
					arg_144_1.var_.characterEffect1148.alpha = Mathf.Lerp(arg_144_1.var_.alphaOldValue1148, 1, (arg_144_1.time_ - 3.61733333333333) / var_147_20)
				end
			end

			if arg_144_1.time_ >= 3.61733333333333 + var_147_20 and arg_144_1.time_ < 3.61733333333333 + var_147_20 + arg_147_0 and arg_144_1.var_.characterEffect1148 then
				arg_144_1.var_.characterEffect1148.alpha = 1
			end

			if arg_144_1.frameCnt_ <= 1 then
				arg_144_1.dialog_:SetActive(false)
			end

			local var_147_21 = 4
			local var_147_22 = 0.475

			if 4 < arg_144_1.time_ and arg_144_1.time_ <= var_147_21 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0

				arg_144_1.dialog_:SetActive(true)

				arg_144_1.dialogCg_.alpha = 0

				local var_147_23 = LeanTween.value(arg_144_1.dialog_, 0, 1, 0.3)

				var_147_23:setOnUpdate(LuaHelper.FloatAction(function(arg_148_0)
					arg_144_1.dialogCg_.alpha = arg_148_0
				end))
				var_147_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_144_1.dialog_)
					var_147_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_144_1.duration_ = arg_144_1.duration_ + 0.3

				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_24 = arg_144_1:GetWordFromCfg(416091034)
				local var_147_25 = arg_144_1:FormatText(var_147_24.content)

				arg_144_1.text_.text = var_147_25

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_27 = 15 <= 0 and var_147_22 or var_147_22 * (utf8.len(var_147_25) / 15)

				if (15 <= 0 and var_147_22 or var_147_22 * (utf8.len(var_147_25) / 15)) > 0 and var_147_22 < var_147_27 then
					arg_144_1.talkMaxDuration = var_147_27
					var_147_21 = var_147_21 + 0.3

					if var_147_27 + var_147_21 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_27 + var_147_21
					end
				end

				arg_144_1.text_.text = var_147_25
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091034", "story_v_out_416091.awb") ~= 0 then
					local var_147_28 = manager.audio:GetVoiceLength("story_v_out_416091", "416091034", "story_v_out_416091.awb") / 1000

					if var_147_28 + var_147_21 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_28 + var_147_21
					end

					if var_147_24.prefab_name ~= "" and arg_144_1.actors_[var_147_24.prefab_name] ~= nil then
						local var_147_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_24.prefab_name].transform, "story_v_out_416091", "416091034", "story_v_out_416091.awb")

						arg_144_1:RecordAudio("416091034", var_147_29)
						arg_144_1:RecordAudio("416091034", var_147_29)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_416091", "416091034", "story_v_out_416091.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_416091", "416091034", "story_v_out_416091.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_30 = var_147_21 + 0.3
			local var_147_31 = math.max(var_147_22, arg_144_1.talkMaxDuration)

			if var_147_21 + 0.3 <= arg_144_1.time_ and arg_144_1.time_ < var_147_30 + var_147_31 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_30) / var_147_31

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_30 + var_147_31 and arg_144_1.time_ < var_147_30 + var_147_31 + arg_147_0 then
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
			local var_153_0 = 0.525

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_1 = arg_150_1:GetWordFromCfg(416091035)
				local var_153_2 = arg_150_1:FormatText(var_153_1.content)

				arg_150_1.text_.text = var_153_2

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_4 = 21 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_2) / 21)

				if (21 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_2) / 21)) > 0 and var_153_0 < var_153_4 then
					arg_150_1.talkMaxDuration = var_153_4

					if var_153_4 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_4 + 0
					end
				end

				arg_150_1.text_.text = var_153_2
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091035", "story_v_out_416091.awb") ~= 0 then
					local var_153_5 = manager.audio:GetVoiceLength("story_v_out_416091", "416091035", "story_v_out_416091.awb") / 1000

					if var_153_5 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_5 + 0
					end

					if var_153_1.prefab_name ~= "" and arg_150_1.actors_[var_153_1.prefab_name] ~= nil then
						local var_153_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_1.prefab_name].transform, "story_v_out_416091", "416091035", "story_v_out_416091.awb")

						arg_150_1:RecordAudio("416091035", var_153_6)
						arg_150_1:RecordAudio("416091035", var_153_6)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_416091", "416091035", "story_v_out_416091.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_416091", "416091035", "story_v_out_416091.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_7 = math.max(var_153_0, arg_150_1.talkMaxDuration)

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_7 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - 0) / var_153_7

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= 0 + var_153_7 and arg_150_1.time_ < 0 + var_153_7 + arg_153_0 then
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
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1148 = arg_154_1.actors_["1148"].transform.localPosition
				arg_154_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_154_1:CheckSpriteTmpPos("1148", 7)

				for iter_157_0 = 0, arg_154_1.actors_["1148"].transform.childCount - 1 do
					local var_157_0 = arg_154_1.actors_["1148"].transform:GetChild(iter_157_0)

					if var_157_0.name == "" or not string.find(var_157_0.name, "split") then
						var_157_0.gameObject:SetActive(true)
					else
						var_157_0.gameObject:SetActive(false)
					end
				end
			end

			local var_157_1 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_1 then
				arg_154_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_154_1.time_ - 0) / var_157_1)
			end

			if arg_154_1.time_ >= 0 + var_157_1 and arg_154_1.time_ < 0 + var_157_1 + arg_157_0 then
				arg_154_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1.43333333333333 < arg_154_1.time_ and arg_154_1.time_ <= 1.43333333333333 + arg_157_0 then
				arg_154_1:AudioAction("play", "effect", "se_story_side_1068", "se_story_1068_footstep", "")
			end

			local var_157_3 = 0
			local var_157_4 = 1.9

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_3 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_5 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(416091036).content)

				arg_154_1.text_.text = var_157_5

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_7 = 76 <= 0 and var_157_4 or var_157_4 * (utf8.len(var_157_5) / 76)

				if (76 <= 0 and var_157_4 or var_157_4 * (utf8.len(var_157_5) / 76)) > 0 and var_157_4 < var_157_7 then
					arg_154_1.talkMaxDuration = var_157_7

					if var_157_7 + var_157_3 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_7 + var_157_3
					end
				end

				arg_154_1.text_.text = var_157_5
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_8 = math.max(var_157_4, arg_154_1.talkMaxDuration)

			if var_157_3 <= arg_154_1.time_ and arg_154_1.time_ < var_157_3 + var_157_8 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_3) / var_157_8

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_3 + var_157_8 and arg_154_1.time_ < var_157_3 + var_157_8 + arg_157_0 then
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
			local var_161_0 = 0.55

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[1082].name)

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

				local var_161_1 = arg_158_1:GetWordFromCfg(416091037)
				local var_161_2 = arg_158_1:FormatText(var_161_1.content)

				arg_158_1.text_.text = var_161_2

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_4 = 22 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_2) / 22)

				if (22 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_2) / 22)) > 0 and var_161_0 < var_161_4 then
					arg_158_1.talkMaxDuration = var_161_4

					if var_161_4 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_4 + 0
					end
				end

				arg_158_1.text_.text = var_161_2
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091037", "story_v_out_416091.awb") ~= 0 then
					local var_161_5 = manager.audio:GetVoiceLength("story_v_out_416091", "416091037", "story_v_out_416091.awb") / 1000

					if var_161_5 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_5 + 0
					end

					if var_161_1.prefab_name ~= "" and arg_158_1.actors_[var_161_1.prefab_name] ~= nil then
						local var_161_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_1.prefab_name].transform, "story_v_out_416091", "416091037", "story_v_out_416091.awb")

						arg_158_1:RecordAudio("416091037", var_161_6)
						arg_158_1:RecordAudio("416091037", var_161_6)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_416091", "416091037", "story_v_out_416091.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_416091", "416091037", "story_v_out_416091.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_7 = math.max(var_161_0, arg_158_1.talkMaxDuration)

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_7 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - 0) / var_161_7

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= 0 + var_161_7 and arg_158_1.time_ < 0 + var_161_7 + arg_161_0 then
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
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos1148 = arg_162_1.actors_["1148"].transform.localPosition
				arg_162_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_162_1:CheckSpriteTmpPos("1148", 3)

				for iter_165_0 = 0, arg_162_1.actors_["1148"].transform.childCount - 1 do
					local var_165_0 = arg_162_1.actors_["1148"].transform:GetChild(iter_165_0)

					if var_165_0.name == "" or not string.find(var_165_0.name, "split") then
						var_165_0.gameObject:SetActive(true)
					else
						var_165_0.gameObject:SetActive(false)
					end
				end
			end

			local var_165_1 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_1 then
				arg_162_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_162_1.time_ - 0) / var_165_1)
			end

			if arg_162_1.time_ >= 0 + var_165_1 and arg_162_1.time_ < 0 + var_165_1 + arg_165_0 then
				arg_162_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_165_2 = arg_162_1.actors_["1148"]

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(var_165_2) and arg_162_1.var_.actorSpriteComps1148 == nil then
				arg_162_1.var_.actorSpriteComps1148 = var_165_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_165_3 = 0.125

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_3 and not isNil(var_165_2) then
				if arg_162_1.var_.actorSpriteComps1148 then
					for iter_165_1, iter_165_2 in pairs(arg_162_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_165_2 then
							if arg_162_1.isInRecall_ then
								iter_165_2.color = Color.New(Mathf.Lerp(iter_165_2.color.r, arg_162_1.hightColor1.r, (arg_162_1.time_ - 0) / var_165_3), Mathf.Lerp(iter_165_2.color.g, arg_162_1.hightColor1.g, (arg_162_1.time_ - 0) / var_165_3), (Mathf.Lerp(iter_165_2.color.b, arg_162_1.hightColor1.b, (arg_162_1.time_ - 0) / var_165_3)))
							else
								local var_165_4 = Mathf.Lerp(iter_165_2.color.r, 1, (arg_162_1.time_ - 0) / var_165_3)

								iter_165_2.color = Color.New(var_165_4, var_165_4, var_165_4)
							end
						end
					end
				end
			end

			if arg_162_1.time_ >= 0 + var_165_3 and arg_162_1.time_ < 0 + var_165_3 + arg_165_0 and not isNil(var_165_2) and arg_162_1.var_.actorSpriteComps1148 then
				for iter_165_3, iter_165_4 in pairs(arg_162_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_165_4 then
						iter_165_4.color = arg_162_1.isInRecall_ and (arg_162_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_162_1.var_.actorSpriteComps1148 = nil
			end

			local var_165_5 = 0
			local var_165_6 = 0.325

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_5 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_7 = arg_162_1:GetWordFromCfg(416091038)
				local var_165_8 = arg_162_1:FormatText(var_165_7.content)

				arg_162_1.text_.text = var_165_8

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_10 = 13 <= 0 and var_165_6 or var_165_6 * (utf8.len(var_165_8) / 13)

				if (13 <= 0 and var_165_6 or var_165_6 * (utf8.len(var_165_8) / 13)) > 0 and var_165_6 < var_165_10 then
					arg_162_1.talkMaxDuration = var_165_10

					if var_165_10 + var_165_5 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_10 + var_165_5
					end
				end

				arg_162_1.text_.text = var_165_8
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091038", "story_v_out_416091.awb") ~= 0 then
					local var_165_11 = manager.audio:GetVoiceLength("story_v_out_416091", "416091038", "story_v_out_416091.awb") / 1000

					if var_165_11 + var_165_5 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_11 + var_165_5
					end

					if var_165_7.prefab_name ~= "" and arg_162_1.actors_[var_165_7.prefab_name] ~= nil then
						local var_165_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_7.prefab_name].transform, "story_v_out_416091", "416091038", "story_v_out_416091.awb")

						arg_162_1:RecordAudio("416091038", var_165_12)
						arg_162_1:RecordAudio("416091038", var_165_12)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_416091", "416091038", "story_v_out_416091.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_416091", "416091038", "story_v_out_416091.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_13 = math.max(var_165_6, arg_162_1.talkMaxDuration)

			if var_165_5 <= arg_162_1.time_ and arg_162_1.time_ < var_165_5 + var_165_13 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_5) / var_165_13

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_5 + var_165_13 and arg_162_1.time_ < var_165_5 + var_165_13 + arg_165_0 then
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
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["1148"]) and arg_166_1.var_.actorSpriteComps1148 == nil then
				arg_166_1.var_.actorSpriteComps1148 = arg_166_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_0 = 0.125

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["1148"]) then
				if arg_166_1.var_.actorSpriteComps1148 then
					for iter_169_0, iter_169_1 in pairs(arg_166_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_169_1 then
							if arg_166_1.isInRecall_ then
								iter_169_1.color = Color.New(Mathf.Lerp(iter_169_1.color.r, arg_166_1.hightColor2.r, (arg_166_1.time_ - 0) / var_169_0), Mathf.Lerp(iter_169_1.color.g, arg_166_1.hightColor2.g, (arg_166_1.time_ - 0) / var_169_0), (Mathf.Lerp(iter_169_1.color.b, arg_166_1.hightColor2.b, (arg_166_1.time_ - 0) / var_169_0)))
							else
								local var_169_1 = Mathf.Lerp(iter_169_1.color.r, 0.5, (arg_166_1.time_ - 0) / var_169_0)

								iter_169_1.color = Color.New(var_169_1, var_169_1, var_169_1)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["1148"]) and arg_166_1.var_.actorSpriteComps1148 then
				for iter_169_2, iter_169_3 in pairs(arg_166_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_169_3 then
						iter_169_3.color = arg_166_1.isInRecall_ and (arg_166_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_166_1.var_.actorSpriteComps1148 = nil
			end

			local var_169_2 = 0
			local var_169_3 = 0.875

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_2 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[1082].name)

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

				local var_169_4 = arg_166_1:GetWordFromCfg(416091039)
				local var_169_5 = arg_166_1:FormatText(var_169_4.content)

				arg_166_1.text_.text = var_169_5

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_7 = 35 <= 0 and var_169_3 or var_169_3 * (utf8.len(var_169_5) / 35)

				if (35 <= 0 and var_169_3 or var_169_3 * (utf8.len(var_169_5) / 35)) > 0 and var_169_3 < var_169_7 then
					arg_166_1.talkMaxDuration = var_169_7

					if var_169_7 + var_169_2 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_7 + var_169_2
					end
				end

				arg_166_1.text_.text = var_169_5
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091039", "story_v_out_416091.awb") ~= 0 then
					local var_169_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091039", "story_v_out_416091.awb") / 1000

					if var_169_8 + var_169_2 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_8 + var_169_2
					end

					if var_169_4.prefab_name ~= "" and arg_166_1.actors_[var_169_4.prefab_name] ~= nil then
						local var_169_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_4.prefab_name].transform, "story_v_out_416091", "416091039", "story_v_out_416091.awb")

						arg_166_1:RecordAudio("416091039", var_169_9)
						arg_166_1:RecordAudio("416091039", var_169_9)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_416091", "416091039", "story_v_out_416091.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_416091", "416091039", "story_v_out_416091.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_10 = math.max(var_169_3, arg_166_1.talkMaxDuration)

			if var_169_2 <= arg_166_1.time_ and arg_166_1.time_ < var_169_2 + var_169_10 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_2) / var_169_10

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_2 + var_169_10 and arg_166_1.time_ < var_169_2 + var_169_10 + arg_169_0 then
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
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["1148"]) and arg_170_1.var_.actorSpriteComps1148 == nil then
				arg_170_1.var_.actorSpriteComps1148 = arg_170_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_0 = 0.125

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["1148"]) then
				if arg_170_1.var_.actorSpriteComps1148 then
					for iter_173_0, iter_173_1 in pairs(arg_170_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_173_1 then
							if arg_170_1.isInRecall_ then
								iter_173_1.color = Color.New(Mathf.Lerp(iter_173_1.color.r, arg_170_1.hightColor1.r, (arg_170_1.time_ - 0) / var_173_0), Mathf.Lerp(iter_173_1.color.g, arg_170_1.hightColor1.g, (arg_170_1.time_ - 0) / var_173_0), (Mathf.Lerp(iter_173_1.color.b, arg_170_1.hightColor1.b, (arg_170_1.time_ - 0) / var_173_0)))
							else
								local var_173_1 = Mathf.Lerp(iter_173_1.color.r, 1, (arg_170_1.time_ - 0) / var_173_0)

								iter_173_1.color = Color.New(var_173_1, var_173_1, var_173_1)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["1148"]) and arg_170_1.var_.actorSpriteComps1148 then
				for iter_173_2, iter_173_3 in pairs(arg_170_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_173_3 then
						iter_173_3.color = arg_170_1.isInRecall_ and (arg_170_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_170_1.var_.actorSpriteComps1148 = nil
			end

			local var_173_2 = 0
			local var_173_3 = 0.6

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_2 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_4 = arg_170_1:GetWordFromCfg(416091040)
				local var_173_5 = arg_170_1:FormatText(var_173_4.content)

				arg_170_1.text_.text = var_173_5

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_7 = 24 <= 0 and var_173_3 or var_173_3 * (utf8.len(var_173_5) / 24)

				if (24 <= 0 and var_173_3 or var_173_3 * (utf8.len(var_173_5) / 24)) > 0 and var_173_3 < var_173_7 then
					arg_170_1.talkMaxDuration = var_173_7

					if var_173_7 + var_173_2 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_7 + var_173_2
					end
				end

				arg_170_1.text_.text = var_173_5
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091040", "story_v_out_416091.awb") ~= 0 then
					local var_173_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091040", "story_v_out_416091.awb") / 1000

					if var_173_8 + var_173_2 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_8 + var_173_2
					end

					if var_173_4.prefab_name ~= "" and arg_170_1.actors_[var_173_4.prefab_name] ~= nil then
						local var_173_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_4.prefab_name].transform, "story_v_out_416091", "416091040", "story_v_out_416091.awb")

						arg_170_1:RecordAudio("416091040", var_173_9)
						arg_170_1:RecordAudio("416091040", var_173_9)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_416091", "416091040", "story_v_out_416091.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_416091", "416091040", "story_v_out_416091.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_10 = math.max(var_173_3, arg_170_1.talkMaxDuration)

			if var_173_2 <= arg_170_1.time_ and arg_170_1.time_ < var_173_2 + var_173_10 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_2) / var_173_10

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_2 + var_173_10 and arg_170_1.time_ < var_173_2 + var_173_10 + arg_173_0 then
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
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["1148"]) and arg_174_1.var_.actorSpriteComps1148 == nil then
				arg_174_1.var_.actorSpriteComps1148 = arg_174_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_0 = 0.125

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["1148"]) then
				if arg_174_1.var_.actorSpriteComps1148 then
					for iter_177_0, iter_177_1 in pairs(arg_174_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_177_1 then
							if arg_174_1.isInRecall_ then
								iter_177_1.color = Color.New(Mathf.Lerp(iter_177_1.color.r, arg_174_1.hightColor2.r, (arg_174_1.time_ - 0) / var_177_0), Mathf.Lerp(iter_177_1.color.g, arg_174_1.hightColor2.g, (arg_174_1.time_ - 0) / var_177_0), (Mathf.Lerp(iter_177_1.color.b, arg_174_1.hightColor2.b, (arg_174_1.time_ - 0) / var_177_0)))
							else
								local var_177_1 = Mathf.Lerp(iter_177_1.color.r, 0.5, (arg_174_1.time_ - 0) / var_177_0)

								iter_177_1.color = Color.New(var_177_1, var_177_1, var_177_1)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["1148"]) and arg_174_1.var_.actorSpriteComps1148 then
				for iter_177_2, iter_177_3 in pairs(arg_174_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_177_3 then
						iter_177_3.color = arg_174_1.isInRecall_ and (arg_174_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_174_1.var_.actorSpriteComps1148 = nil
			end

			local var_177_2 = 0
			local var_177_3 = 0.675

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_2 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[1082].name)

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

				local var_177_4 = arg_174_1:GetWordFromCfg(416091041)
				local var_177_5 = arg_174_1:FormatText(var_177_4.content)

				arg_174_1.text_.text = var_177_5

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_7 = 27 <= 0 and var_177_3 or var_177_3 * (utf8.len(var_177_5) / 27)

				if (27 <= 0 and var_177_3 or var_177_3 * (utf8.len(var_177_5) / 27)) > 0 and var_177_3 < var_177_7 then
					arg_174_1.talkMaxDuration = var_177_7

					if var_177_7 + var_177_2 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_7 + var_177_2
					end
				end

				arg_174_1.text_.text = var_177_5
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091041", "story_v_out_416091.awb") ~= 0 then
					local var_177_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091041", "story_v_out_416091.awb") / 1000

					if var_177_8 + var_177_2 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_8 + var_177_2
					end

					if var_177_4.prefab_name ~= "" and arg_174_1.actors_[var_177_4.prefab_name] ~= nil then
						local var_177_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_4.prefab_name].transform, "story_v_out_416091", "416091041", "story_v_out_416091.awb")

						arg_174_1:RecordAudio("416091041", var_177_9)
						arg_174_1:RecordAudio("416091041", var_177_9)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_416091", "416091041", "story_v_out_416091.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_416091", "416091041", "story_v_out_416091.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_10 = math.max(var_177_3, arg_174_1.talkMaxDuration)

			if var_177_2 <= arg_174_1.time_ and arg_174_1.time_ < var_177_2 + var_177_10 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_2) / var_177_10

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_2 + var_177_10 and arg_174_1.time_ < var_177_2 + var_177_10 + arg_177_0 then
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
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["1148"]) and arg_178_1.var_.actorSpriteComps1148 == nil then
				arg_178_1.var_.actorSpriteComps1148 = arg_178_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_0 = 0.125

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["1148"]) then
				if arg_178_1.var_.actorSpriteComps1148 then
					for iter_181_0, iter_181_1 in pairs(arg_178_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_181_1 then
							if arg_178_1.isInRecall_ then
								iter_181_1.color = Color.New(Mathf.Lerp(iter_181_1.color.r, arg_178_1.hightColor1.r, (arg_178_1.time_ - 0) / var_181_0), Mathf.Lerp(iter_181_1.color.g, arg_178_1.hightColor1.g, (arg_178_1.time_ - 0) / var_181_0), (Mathf.Lerp(iter_181_1.color.b, arg_178_1.hightColor1.b, (arg_178_1.time_ - 0) / var_181_0)))
							else
								local var_181_1 = Mathf.Lerp(iter_181_1.color.r, 1, (arg_178_1.time_ - 0) / var_181_0)

								iter_181_1.color = Color.New(var_181_1, var_181_1, var_181_1)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["1148"]) and arg_178_1.var_.actorSpriteComps1148 then
				for iter_181_2, iter_181_3 in pairs(arg_178_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_181_3 then
						iter_181_3.color = arg_178_1.isInRecall_ and (arg_178_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_178_1.var_.actorSpriteComps1148 = nil
			end

			local var_181_2 = 0
			local var_181_3 = 0.75

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_2 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_4 = arg_178_1:GetWordFromCfg(416091042)
				local var_181_5 = arg_178_1:FormatText(var_181_4.content)

				arg_178_1.text_.text = var_181_5

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_7 = 30 <= 0 and var_181_3 or var_181_3 * (utf8.len(var_181_5) / 30)

				if (30 <= 0 and var_181_3 or var_181_3 * (utf8.len(var_181_5) / 30)) > 0 and var_181_3 < var_181_7 then
					arg_178_1.talkMaxDuration = var_181_7

					if var_181_7 + var_181_2 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_7 + var_181_2
					end
				end

				arg_178_1.text_.text = var_181_5
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091042", "story_v_out_416091.awb") ~= 0 then
					local var_181_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091042", "story_v_out_416091.awb") / 1000

					if var_181_8 + var_181_2 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_8 + var_181_2
					end

					if var_181_4.prefab_name ~= "" and arg_178_1.actors_[var_181_4.prefab_name] ~= nil then
						local var_181_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_4.prefab_name].transform, "story_v_out_416091", "416091042", "story_v_out_416091.awb")

						arg_178_1:RecordAudio("416091042", var_181_9)
						arg_178_1:RecordAudio("416091042", var_181_9)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_416091", "416091042", "story_v_out_416091.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_416091", "416091042", "story_v_out_416091.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_10 = math.max(var_181_3, arg_178_1.talkMaxDuration)

			if var_181_2 <= arg_178_1.time_ and arg_178_1.time_ < var_181_2 + var_181_10 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_2) / var_181_10

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_2 + var_181_10 and arg_178_1.time_ < var_181_2 + var_181_10 + arg_181_0 then
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
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["1148"]) and arg_182_1.var_.actorSpriteComps1148 == nil then
				arg_182_1.var_.actorSpriteComps1148 = arg_182_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_0 = 0.125

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["1148"]) then
				if arg_182_1.var_.actorSpriteComps1148 then
					for iter_185_0, iter_185_1 in pairs(arg_182_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_185_1 then
							if arg_182_1.isInRecall_ then
								iter_185_1.color = Color.New(Mathf.Lerp(iter_185_1.color.r, arg_182_1.hightColor2.r, (arg_182_1.time_ - 0) / var_185_0), Mathf.Lerp(iter_185_1.color.g, arg_182_1.hightColor2.g, (arg_182_1.time_ - 0) / var_185_0), (Mathf.Lerp(iter_185_1.color.b, arg_182_1.hightColor2.b, (arg_182_1.time_ - 0) / var_185_0)))
							else
								local var_185_1 = Mathf.Lerp(iter_185_1.color.r, 0.5, (arg_182_1.time_ - 0) / var_185_0)

								iter_185_1.color = Color.New(var_185_1, var_185_1, var_185_1)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["1148"]) and arg_182_1.var_.actorSpriteComps1148 then
				for iter_185_2, iter_185_3 in pairs(arg_182_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_185_3 then
						iter_185_3.color = arg_182_1.isInRecall_ and (arg_182_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_182_1.var_.actorSpriteComps1148 = nil
			end

			local var_185_2 = 0
			local var_185_3 = 0.325

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_2 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[1082].name)

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

				local var_185_4 = arg_182_1:GetWordFromCfg(416091043)
				local var_185_5 = arg_182_1:FormatText(var_185_4.content)

				arg_182_1.text_.text = var_185_5

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_7 = 13 <= 0 and var_185_3 or var_185_3 * (utf8.len(var_185_5) / 13)

				if (13 <= 0 and var_185_3 or var_185_3 * (utf8.len(var_185_5) / 13)) > 0 and var_185_3 < var_185_7 then
					arg_182_1.talkMaxDuration = var_185_7

					if var_185_7 + var_185_2 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_7 + var_185_2
					end
				end

				arg_182_1.text_.text = var_185_5
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091043", "story_v_out_416091.awb") ~= 0 then
					local var_185_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091043", "story_v_out_416091.awb") / 1000

					if var_185_8 + var_185_2 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_8 + var_185_2
					end

					if var_185_4.prefab_name ~= "" and arg_182_1.actors_[var_185_4.prefab_name] ~= nil then
						local var_185_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_4.prefab_name].transform, "story_v_out_416091", "416091043", "story_v_out_416091.awb")

						arg_182_1:RecordAudio("416091043", var_185_9)
						arg_182_1:RecordAudio("416091043", var_185_9)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_416091", "416091043", "story_v_out_416091.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_416091", "416091043", "story_v_out_416091.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_10 = math.max(var_185_3, arg_182_1.talkMaxDuration)

			if var_185_2 <= arg_182_1.time_ and arg_182_1.time_ < var_185_2 + var_185_10 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_2) / var_185_10

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_2 + var_185_10 and arg_182_1.time_ < var_185_2 + var_185_10 + arg_185_0 then
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
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["1148"]) and arg_186_1.var_.actorSpriteComps1148 == nil then
				arg_186_1.var_.actorSpriteComps1148 = arg_186_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_0 = 0.125

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["1148"]) then
				if arg_186_1.var_.actorSpriteComps1148 then
					for iter_189_0, iter_189_1 in pairs(arg_186_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_189_1 then
							if arg_186_1.isInRecall_ then
								iter_189_1.color = Color.New(Mathf.Lerp(iter_189_1.color.r, arg_186_1.hightColor1.r, (arg_186_1.time_ - 0) / var_189_0), Mathf.Lerp(iter_189_1.color.g, arg_186_1.hightColor1.g, (arg_186_1.time_ - 0) / var_189_0), (Mathf.Lerp(iter_189_1.color.b, arg_186_1.hightColor1.b, (arg_186_1.time_ - 0) / var_189_0)))
							else
								local var_189_1 = Mathf.Lerp(iter_189_1.color.r, 1, (arg_186_1.time_ - 0) / var_189_0)

								iter_189_1.color = Color.New(var_189_1, var_189_1, var_189_1)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["1148"]) and arg_186_1.var_.actorSpriteComps1148 then
				for iter_189_2, iter_189_3 in pairs(arg_186_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_189_3 then
						iter_189_3.color = arg_186_1.isInRecall_ and (arg_186_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_186_1.var_.actorSpriteComps1148 = nil
			end

			local var_189_2 = 0
			local var_189_3 = 0.6

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_2 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_4 = arg_186_1:GetWordFromCfg(416091044)
				local var_189_5 = arg_186_1:FormatText(var_189_4.content)

				arg_186_1.text_.text = var_189_5

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_7 = 24 <= 0 and var_189_3 or var_189_3 * (utf8.len(var_189_5) / 24)

				if (24 <= 0 and var_189_3 or var_189_3 * (utf8.len(var_189_5) / 24)) > 0 and var_189_3 < var_189_7 then
					arg_186_1.talkMaxDuration = var_189_7

					if var_189_7 + var_189_2 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_7 + var_189_2
					end
				end

				arg_186_1.text_.text = var_189_5
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091044", "story_v_out_416091.awb") ~= 0 then
					local var_189_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091044", "story_v_out_416091.awb") / 1000

					if var_189_8 + var_189_2 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_8 + var_189_2
					end

					if var_189_4.prefab_name ~= "" and arg_186_1.actors_[var_189_4.prefab_name] ~= nil then
						local var_189_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_4.prefab_name].transform, "story_v_out_416091", "416091044", "story_v_out_416091.awb")

						arg_186_1:RecordAudio("416091044", var_189_9)
						arg_186_1:RecordAudio("416091044", var_189_9)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_416091", "416091044", "story_v_out_416091.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_416091", "416091044", "story_v_out_416091.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_10 = math.max(var_189_3, arg_186_1.talkMaxDuration)

			if var_189_2 <= arg_186_1.time_ and arg_186_1.time_ < var_189_2 + var_189_10 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_2) / var_189_10

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_2 + var_189_10 and arg_186_1.time_ < var_189_2 + var_189_10 + arg_189_0 then
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
			if 2 < arg_190_1.time_ and arg_190_1.time_ <= 2 + arg_193_0 then
				local var_193_0 = arg_190_1.bgs_.I14f

				arg_190_1.bgs_.I14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_193_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_193_1 = var_193_0:GetComponent("SpriteRenderer")

				if var_193_1 and var_193_1.sprite then
					local var_193_2 = 2 * (var_193_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_193_0.transform.localScale = Vector3.New(var_193_2 / var_193_1.sprite.bounds.size.y < var_193_2 * manager.ui.mainCameraCom_.aspect / var_193_1.sprite.bounds.size.x and var_193_2 * manager.ui.mainCameraCom_.aspect / var_193_1.sprite.bounds.size.x or var_193_2 / var_193_1.sprite.bounds.size.y, var_193_2 / var_193_1.sprite.bounds.size.y < var_193_2 * manager.ui.mainCameraCom_.aspect / var_193_1.sprite.bounds.size.x and var_193_2 * manager.ui.mainCameraCom_.aspect / var_193_1.sprite.bounds.size.x or var_193_2 / var_193_1.sprite.bounds.size.y, 0)
				end

				for iter_193_0, iter_193_1 in pairs(arg_190_1.bgs_) do
					if iter_193_0 ~= "I14f" then
						iter_193_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_193_3 = 4

			if 4 < arg_190_1.time_ and arg_190_1.time_ <= var_193_3 + arg_193_0 then
				arg_190_1.allBtn_.enabled = false
			end

			if arg_190_1.time_ >= var_193_3 + 0.3 and arg_190_1.time_ < var_193_3 + 0.3 + arg_193_0 then
				arg_190_1.allBtn_.enabled = true
			end

			local var_193_4 = 0

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1.mask_.enabled = true
				arg_190_1.mask_.raycastTarget = true

				arg_190_1:SetGaussion(false)
			end

			local var_193_5 = 2

			if var_193_4 <= arg_190_1.time_ and arg_190_1.time_ < var_193_4 + var_193_5 then
				local var_193_6 = Color.New(0, 0, 0)

				var_193_6.a = Mathf.Lerp(0, 1, (arg_190_1.time_ - var_193_4) / var_193_5)
				arg_190_1.mask_.color = var_193_6
			end

			if arg_190_1.time_ >= var_193_4 + var_193_5 and arg_190_1.time_ < var_193_4 + var_193_5 + arg_193_0 then
				local var_193_7 = Color.New(0, 0, 0)

				var_193_7.a = 1
				arg_190_1.mask_.color = var_193_7
			end

			local var_193_8 = 2

			if 2 < arg_190_1.time_ and arg_190_1.time_ <= var_193_8 + arg_193_0 then
				arg_190_1.mask_.enabled = true
				arg_190_1.mask_.raycastTarget = true

				arg_190_1:SetGaussion(false)
			end

			local var_193_9 = 2

			if var_193_8 <= arg_190_1.time_ and arg_190_1.time_ < var_193_8 + var_193_9 then
				local var_193_10 = Color.New(0, 0, 0)

				var_193_10.a = Mathf.Lerp(1, 0, (arg_190_1.time_ - var_193_8) / var_193_9)
				arg_190_1.mask_.color = var_193_10
			end

			if arg_190_1.time_ >= var_193_8 + var_193_9 and arg_190_1.time_ < var_193_8 + var_193_9 + arg_193_0 then
				local var_193_11 = Color.New(0, 0, 0)

				arg_190_1.mask_.enabled = false
				var_193_11.a = 0
				arg_190_1.mask_.color = var_193_11
			end

			local var_193_12 = arg_190_1.actors_["1148"].transform

			if 1.96666666666667 < arg_190_1.time_ and arg_190_1.time_ <= 1.96666666666667 + arg_193_0 then
				arg_190_1.var_.moveOldPos1148 = var_193_12.localPosition
				var_193_12.localScale = Vector3.New(1, 1, 1)

				arg_190_1:CheckSpriteTmpPos("1148", 7)

				for iter_193_2 = 0, var_193_12.childCount - 1 do
					local var_193_13 = var_193_12:GetChild(iter_193_2)

					if var_193_13.name == "" or not string.find(var_193_13.name, "split") then
						var_193_13.gameObject:SetActive(true)
					else
						var_193_13.gameObject:SetActive(false)
					end
				end
			end

			local var_193_14 = 0.001

			if 1.96666666666667 <= arg_190_1.time_ and arg_190_1.time_ < 1.96666666666667 + var_193_14 then
				var_193_12.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_190_1.time_ - 1.96666666666667) / var_193_14)
			end

			if arg_190_1.time_ >= 1.96666666666667 + var_193_14 and arg_190_1.time_ < 1.96666666666667 + var_193_14 + arg_193_0 then
				var_193_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_193_15 = arg_190_1.actors_["1148"].transform

			if 3.66666666666667 < arg_190_1.time_ and arg_190_1.time_ <= 3.66666666666667 + arg_193_0 then
				arg_190_1.var_.moveOldPos1148 = var_193_15.localPosition
				var_193_15.localScale = Vector3.New(1, 1, 1)

				arg_190_1:CheckSpriteTmpPos("1148", 3)

				for iter_193_3 = 0, var_193_15.childCount - 1 do
					local var_193_16 = var_193_15:GetChild(iter_193_3)

					if var_193_16.name == "split_6" or not string.find(var_193_16.name, "split") then
						var_193_16.gameObject:SetActive(true)
					else
						var_193_16.gameObject:SetActive(false)
					end
				end
			end

			local var_193_17 = 0.001

			if 3.66666666666667 <= arg_190_1.time_ and arg_190_1.time_ < 3.66666666666667 + var_193_17 then
				var_193_15.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_190_1.time_ - 3.66666666666667) / var_193_17)
			end

			if arg_190_1.time_ >= 3.66666666666667 + var_193_17 and arg_190_1.time_ < 3.66666666666667 + var_193_17 + arg_193_0 then
				var_193_15.localPosition = Vector3.New(0, -429, -180)
			end

			local var_193_18 = arg_190_1.actors_["1148"]

			if 3.66666666666667 < arg_190_1.time_ and arg_190_1.time_ <= 3.66666666666667 + arg_193_0 and not isNil(var_193_18) and arg_190_1.var_.actorSpriteComps1148 == nil then
				arg_190_1.var_.actorSpriteComps1148 = var_193_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_19 = 0.125

			if 3.66666666666667 <= arg_190_1.time_ and arg_190_1.time_ < 3.66666666666667 + var_193_19 and not isNil(var_193_18) then
				if arg_190_1.var_.actorSpriteComps1148 then
					for iter_193_4, iter_193_5 in pairs(arg_190_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_193_5 then
							if arg_190_1.isInRecall_ then
								iter_193_5.color = Color.New(Mathf.Lerp(iter_193_5.color.r, arg_190_1.hightColor1.r, (arg_190_1.time_ - 3.66666666666667) / var_193_19), Mathf.Lerp(iter_193_5.color.g, arg_190_1.hightColor1.g, (arg_190_1.time_ - 3.66666666666667) / var_193_19), (Mathf.Lerp(iter_193_5.color.b, arg_190_1.hightColor1.b, (arg_190_1.time_ - 3.66666666666667) / var_193_19)))
							else
								local var_193_20 = Mathf.Lerp(iter_193_5.color.r, 1, (arg_190_1.time_ - 3.66666666666667) / var_193_19)

								iter_193_5.color = Color.New(var_193_20, var_193_20, var_193_20)
							end
						end
					end
				end
			end

			if arg_190_1.time_ >= 3.66666666666667 + var_193_19 and arg_190_1.time_ < 3.66666666666667 + var_193_19 + arg_193_0 and not isNil(var_193_18) and arg_190_1.var_.actorSpriteComps1148 then
				for iter_193_6, iter_193_7 in pairs(arg_190_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_193_7 then
						iter_193_7.color = arg_190_1.isInRecall_ and (arg_190_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_190_1.var_.actorSpriteComps1148 = nil
			end

			if 3.66666666666667 < arg_190_1.time_ and arg_190_1.time_ <= 3.66666666666667 + arg_193_0 then
				local var_193_21 = arg_190_1.actors_["1148"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_193_21 then
					arg_190_1.var_.alphaOldValue1148 = var_193_21.alpha
					arg_190_1.var_.characterEffect1148 = var_193_21
				end

				arg_190_1.var_.alphaOldValue1148 = 0
			end

			local var_193_22 = 0.857666666666667

			if 3.66666666666667 <= arg_190_1.time_ and arg_190_1.time_ < 3.66666666666667 + var_193_22 then
				if arg_190_1.var_.characterEffect1148 then
					arg_190_1.var_.characterEffect1148.alpha = Mathf.Lerp(arg_190_1.var_.alphaOldValue1148, 1, (arg_190_1.time_ - 3.66666666666667) / var_193_22)
				end
			end

			if arg_190_1.time_ >= 3.66666666666667 + var_193_22 and arg_190_1.time_ < 3.66666666666667 + var_193_22 + arg_193_0 and arg_190_1.var_.characterEffect1148 then
				arg_190_1.var_.characterEffect1148.alpha = 1
			end

			if arg_190_1.frameCnt_ <= 1 then
				arg_190_1.dialog_:SetActive(false)
			end

			local var_193_23 = 4
			local var_193_24 = 0.325

			if 4 < arg_190_1.time_ and arg_190_1.time_ <= var_193_23 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0

				arg_190_1.dialog_:SetActive(true)

				arg_190_1.dialogCg_.alpha = 0

				local var_193_25 = LeanTween.value(arg_190_1.dialog_, 0, 1, 0.3)

				var_193_25:setOnUpdate(LuaHelper.FloatAction(function(arg_194_0)
					arg_190_1.dialogCg_.alpha = arg_194_0
				end))
				var_193_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_190_1.dialog_)
					var_193_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_190_1.duration_ = arg_190_1.duration_ + 0.3

				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_26 = arg_190_1:GetWordFromCfg(416091045)
				local var_193_27 = arg_190_1:FormatText(var_193_26.content)

				arg_190_1.text_.text = var_193_27

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_29 = 13 <= 0 and var_193_24 or var_193_24 * (utf8.len(var_193_27) / 13)

				if (13 <= 0 and var_193_24 or var_193_24 * (utf8.len(var_193_27) / 13)) > 0 and var_193_24 < var_193_29 then
					arg_190_1.talkMaxDuration = var_193_29
					var_193_23 = var_193_23 + 0.3

					if var_193_29 + var_193_23 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_29 + var_193_23
					end
				end

				arg_190_1.text_.text = var_193_27
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091045", "story_v_out_416091.awb") ~= 0 then
					local var_193_30 = manager.audio:GetVoiceLength("story_v_out_416091", "416091045", "story_v_out_416091.awb") / 1000

					if var_193_30 + var_193_23 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_30 + var_193_23
					end

					if var_193_26.prefab_name ~= "" and arg_190_1.actors_[var_193_26.prefab_name] ~= nil then
						local var_193_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_26.prefab_name].transform, "story_v_out_416091", "416091045", "story_v_out_416091.awb")

						arg_190_1:RecordAudio("416091045", var_193_31)
						arg_190_1:RecordAudio("416091045", var_193_31)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_416091", "416091045", "story_v_out_416091.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_416091", "416091045", "story_v_out_416091.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_32 = var_193_23 + 0.3
			local var_193_33 = math.max(var_193_24, arg_190_1.talkMaxDuration)

			if var_193_23 + 0.3 <= arg_190_1.time_ and arg_190_1.time_ < var_193_32 + var_193_33 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_32) / var_193_33

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_32 + var_193_33 and arg_190_1.time_ < var_193_32 + var_193_33 + arg_193_0 then
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
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos1148 = arg_196_1.actors_["1148"].transform.localPosition
				arg_196_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("1148", 7)

				for iter_199_0 = 0, arg_196_1.actors_["1148"].transform.childCount - 1 do
					local var_199_0 = arg_196_1.actors_["1148"].transform:GetChild(iter_199_0)

					if var_199_0.name == "" or not string.find(var_199_0.name, "split") then
						var_199_0.gameObject:SetActive(true)
					else
						var_199_0.gameObject:SetActive(false)
					end
				end
			end

			local var_199_1 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_1 then
				arg_196_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_196_1.time_ - 0) / var_199_1)
			end

			if arg_196_1.time_ >= 0 + var_199_1 and arg_196_1.time_ < 0 + var_199_1 + arg_199_0 then
				arg_196_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_199_2 = 0
			local var_199_3 = 1.625

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_2 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_4 = arg_196_1:FormatText(arg_196_1:GetWordFromCfg(416091046).content)

				arg_196_1.text_.text = var_199_4

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_6 = 65 <= 0 and var_199_3 or var_199_3 * (utf8.len(var_199_4) / 65)

				if (65 <= 0 and var_199_3 or var_199_3 * (utf8.len(var_199_4) / 65)) > 0 and var_199_3 < var_199_6 then
					arg_196_1.talkMaxDuration = var_199_6

					if var_199_6 + var_199_2 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_6 + var_199_2
					end
				end

				arg_196_1.text_.text = var_199_4
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_7 = math.max(var_199_3, arg_196_1.talkMaxDuration)

			if var_199_2 <= arg_196_1.time_ and arg_196_1.time_ < var_199_2 + var_199_7 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_2) / var_199_7

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_2 + var_199_7 and arg_196_1.time_ < var_199_2 + var_199_7 + arg_199_0 then
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
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos1148 = arg_200_1.actors_["1148"].transform.localPosition
				arg_200_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("1148", 3)

				for iter_203_0 = 0, arg_200_1.actors_["1148"].transform.childCount - 1 do
					local var_203_0 = arg_200_1.actors_["1148"].transform:GetChild(iter_203_0)

					if var_203_0.name == "split_3" or not string.find(var_203_0.name, "split") then
						var_203_0.gameObject:SetActive(true)
					else
						var_203_0.gameObject:SetActive(false)
					end
				end
			end

			local var_203_1 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_1 then
				arg_200_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_200_1.time_ - 0) / var_203_1)
			end

			if arg_200_1.time_ >= 0 + var_203_1 and arg_200_1.time_ < 0 + var_203_1 + arg_203_0 then
				arg_200_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_203_2 = arg_200_1.actors_["1148"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.actorSpriteComps1148 == nil then
				arg_200_1.var_.actorSpriteComps1148 = var_203_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_3 = 0.125

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_3 and not isNil(var_203_2) then
				if arg_200_1.var_.actorSpriteComps1148 then
					for iter_203_1, iter_203_2 in pairs(arg_200_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_203_2 then
							if arg_200_1.isInRecall_ then
								iter_203_2.color = Color.New(Mathf.Lerp(iter_203_2.color.r, arg_200_1.hightColor1.r, (arg_200_1.time_ - 0) / var_203_3), Mathf.Lerp(iter_203_2.color.g, arg_200_1.hightColor1.g, (arg_200_1.time_ - 0) / var_203_3), (Mathf.Lerp(iter_203_2.color.b, arg_200_1.hightColor1.b, (arg_200_1.time_ - 0) / var_203_3)))
							else
								local var_203_4 = Mathf.Lerp(iter_203_2.color.r, 1, (arg_200_1.time_ - 0) / var_203_3)

								iter_203_2.color = Color.New(var_203_4, var_203_4, var_203_4)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= 0 + var_203_3 and arg_200_1.time_ < 0 + var_203_3 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.actorSpriteComps1148 then
				for iter_203_3, iter_203_4 in pairs(arg_200_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_203_4 then
						iter_203_4.color = arg_200_1.isInRecall_ and (arg_200_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_200_1.var_.actorSpriteComps1148 = nil
			end

			local var_203_5 = 0
			local var_203_6 = 0.4

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_5 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_7 = arg_200_1:GetWordFromCfg(416091047)
				local var_203_8 = arg_200_1:FormatText(var_203_7.content)

				arg_200_1.text_.text = var_203_8

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_10 = 16 <= 0 and var_203_6 or var_203_6 * (utf8.len(var_203_8) / 16)

				if (16 <= 0 and var_203_6 or var_203_6 * (utf8.len(var_203_8) / 16)) > 0 and var_203_6 < var_203_10 then
					arg_200_1.talkMaxDuration = var_203_10

					if var_203_10 + var_203_5 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_10 + var_203_5
					end
				end

				arg_200_1.text_.text = var_203_8
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091047", "story_v_out_416091.awb") ~= 0 then
					local var_203_11 = manager.audio:GetVoiceLength("story_v_out_416091", "416091047", "story_v_out_416091.awb") / 1000

					if var_203_11 + var_203_5 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_11 + var_203_5
					end

					if var_203_7.prefab_name ~= "" and arg_200_1.actors_[var_203_7.prefab_name] ~= nil then
						local var_203_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_7.prefab_name].transform, "story_v_out_416091", "416091047", "story_v_out_416091.awb")

						arg_200_1:RecordAudio("416091047", var_203_12)
						arg_200_1:RecordAudio("416091047", var_203_12)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_416091", "416091047", "story_v_out_416091.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_416091", "416091047", "story_v_out_416091.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_13 = math.max(var_203_6, arg_200_1.talkMaxDuration)

			if var_203_5 <= arg_200_1.time_ and arg_200_1.time_ < var_203_5 + var_203_13 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_5) / var_203_13

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_5 + var_203_13 and arg_200_1.time_ < var_203_5 + var_203_13 + arg_203_0 then
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
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["1148"]) and arg_204_1.var_.actorSpriteComps1148 == nil then
				arg_204_1.var_.actorSpriteComps1148 = arg_204_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_0 = 0.125

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["1148"]) then
				if arg_204_1.var_.actorSpriteComps1148 then
					for iter_207_0, iter_207_1 in pairs(arg_204_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_207_1 then
							if arg_204_1.isInRecall_ then
								iter_207_1.color = Color.New(Mathf.Lerp(iter_207_1.color.r, arg_204_1.hightColor2.r, (arg_204_1.time_ - 0) / var_207_0), Mathf.Lerp(iter_207_1.color.g, arg_204_1.hightColor2.g, (arg_204_1.time_ - 0) / var_207_0), (Mathf.Lerp(iter_207_1.color.b, arg_204_1.hightColor2.b, (arg_204_1.time_ - 0) / var_207_0)))
							else
								local var_207_1 = Mathf.Lerp(iter_207_1.color.r, 0.5, (arg_204_1.time_ - 0) / var_207_0)

								iter_207_1.color = Color.New(var_207_1, var_207_1, var_207_1)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["1148"]) and arg_204_1.var_.actorSpriteComps1148 then
				for iter_207_2, iter_207_3 in pairs(arg_204_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_207_3 then
						iter_207_3.color = arg_204_1.isInRecall_ and (arg_204_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_204_1.var_.actorSpriteComps1148 = nil
			end

			local var_207_2 = 0
			local var_207_3 = 0.225

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_2 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[1082].name)

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

				local var_207_4 = arg_204_1:GetWordFromCfg(416091048)
				local var_207_5 = arg_204_1:FormatText(var_207_4.content)

				arg_204_1.text_.text = var_207_5

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_7 = 9 <= 0 and var_207_3 or var_207_3 * (utf8.len(var_207_5) / 9)

				if (9 <= 0 and var_207_3 or var_207_3 * (utf8.len(var_207_5) / 9)) > 0 and var_207_3 < var_207_7 then
					arg_204_1.talkMaxDuration = var_207_7

					if var_207_7 + var_207_2 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_7 + var_207_2
					end
				end

				arg_204_1.text_.text = var_207_5
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091048", "story_v_out_416091.awb") ~= 0 then
					local var_207_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091048", "story_v_out_416091.awb") / 1000

					if var_207_8 + var_207_2 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_8 + var_207_2
					end

					if var_207_4.prefab_name ~= "" and arg_204_1.actors_[var_207_4.prefab_name] ~= nil then
						local var_207_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_4.prefab_name].transform, "story_v_out_416091", "416091048", "story_v_out_416091.awb")

						arg_204_1:RecordAudio("416091048", var_207_9)
						arg_204_1:RecordAudio("416091048", var_207_9)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_416091", "416091048", "story_v_out_416091.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_416091", "416091048", "story_v_out_416091.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_10 = math.max(var_207_3, arg_204_1.talkMaxDuration)

			if var_207_2 <= arg_204_1.time_ and arg_204_1.time_ < var_207_2 + var_207_10 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_2) / var_207_10

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_2 + var_207_10 and arg_204_1.time_ < var_207_2 + var_207_10 + arg_207_0 then
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
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["1148"]) and arg_208_1.var_.actorSpriteComps1148 == nil then
				arg_208_1.var_.actorSpriteComps1148 = arg_208_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_211_0 = 0.125

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["1148"]) then
				if arg_208_1.var_.actorSpriteComps1148 then
					for iter_211_0, iter_211_1 in pairs(arg_208_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_211_1 then
							if arg_208_1.isInRecall_ then
								iter_211_1.color = Color.New(Mathf.Lerp(iter_211_1.color.r, arg_208_1.hightColor1.r, (arg_208_1.time_ - 0) / var_211_0), Mathf.Lerp(iter_211_1.color.g, arg_208_1.hightColor1.g, (arg_208_1.time_ - 0) / var_211_0), (Mathf.Lerp(iter_211_1.color.b, arg_208_1.hightColor1.b, (arg_208_1.time_ - 0) / var_211_0)))
							else
								local var_211_1 = Mathf.Lerp(iter_211_1.color.r, 1, (arg_208_1.time_ - 0) / var_211_0)

								iter_211_1.color = Color.New(var_211_1, var_211_1, var_211_1)
							end
						end
					end
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["1148"]) and arg_208_1.var_.actorSpriteComps1148 then
				for iter_211_2, iter_211_3 in pairs(arg_208_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_211_3 then
						iter_211_3.color = arg_208_1.isInRecall_ and (arg_208_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_208_1.var_.actorSpriteComps1148 = nil
			end

			local var_211_2 = arg_208_1.actors_["1148"].transform

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.moveOldPos1148 = var_211_2.localPosition
				var_211_2.localScale = Vector3.New(1, 1, 1)

				arg_208_1:CheckSpriteTmpPos("1148", 3)

				for iter_211_4 = 0, var_211_2.childCount - 1 do
					local var_211_3 = var_211_2:GetChild(iter_211_4)

					if var_211_3.name == "split_6" or not string.find(var_211_3.name, "split") then
						var_211_3.gameObject:SetActive(true)
					else
						var_211_3.gameObject:SetActive(false)
					end
				end
			end

			local var_211_4 = 0.001

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_4 then
				var_211_2.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_208_1.time_ - 0) / var_211_4)
			end

			if arg_208_1.time_ >= 0 + var_211_4 and arg_208_1.time_ < 0 + var_211_4 + arg_211_0 then
				var_211_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_211_5 = 0
			local var_211_6 = 0.575

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_5 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_7 = arg_208_1:GetWordFromCfg(416091049)
				local var_211_8 = arg_208_1:FormatText(var_211_7.content)

				arg_208_1.text_.text = var_211_8

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_10 = 23 <= 0 and var_211_6 or var_211_6 * (utf8.len(var_211_8) / 23)

				if (23 <= 0 and var_211_6 or var_211_6 * (utf8.len(var_211_8) / 23)) > 0 and var_211_6 < var_211_10 then
					arg_208_1.talkMaxDuration = var_211_10

					if var_211_10 + var_211_5 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_10 + var_211_5
					end
				end

				arg_208_1.text_.text = var_211_8
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091049", "story_v_out_416091.awb") ~= 0 then
					local var_211_11 = manager.audio:GetVoiceLength("story_v_out_416091", "416091049", "story_v_out_416091.awb") / 1000

					if var_211_11 + var_211_5 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_11 + var_211_5
					end

					if var_211_7.prefab_name ~= "" and arg_208_1.actors_[var_211_7.prefab_name] ~= nil then
						local var_211_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_7.prefab_name].transform, "story_v_out_416091", "416091049", "story_v_out_416091.awb")

						arg_208_1:RecordAudio("416091049", var_211_12)
						arg_208_1:RecordAudio("416091049", var_211_12)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_416091", "416091049", "story_v_out_416091.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_416091", "416091049", "story_v_out_416091.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_13 = math.max(var_211_6, arg_208_1.talkMaxDuration)

			if var_211_5 <= arg_208_1.time_ and arg_208_1.time_ < var_211_5 + var_211_13 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_5) / var_211_13

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_5 + var_211_13 and arg_208_1.time_ < var_211_5 + var_211_13 + arg_211_0 then
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
			local var_215_0 = 0.375

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_1 = arg_212_1:GetWordFromCfg(416091050)
				local var_215_2 = arg_212_1:FormatText(var_215_1.content)

				arg_212_1.text_.text = var_215_2

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_4 = 15 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_2) / 15)

				if (15 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_2) / 15)) > 0 and var_215_0 < var_215_4 then
					arg_212_1.talkMaxDuration = var_215_4

					if var_215_4 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_4 + 0
					end
				end

				arg_212_1.text_.text = var_215_2
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091050", "story_v_out_416091.awb") ~= 0 then
					local var_215_5 = manager.audio:GetVoiceLength("story_v_out_416091", "416091050", "story_v_out_416091.awb") / 1000

					if var_215_5 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_5 + 0
					end

					if var_215_1.prefab_name ~= "" and arg_212_1.actors_[var_215_1.prefab_name] ~= nil then
						local var_215_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_1.prefab_name].transform, "story_v_out_416091", "416091050", "story_v_out_416091.awb")

						arg_212_1:RecordAudio("416091050", var_215_6)
						arg_212_1:RecordAudio("416091050", var_215_6)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_416091", "416091050", "story_v_out_416091.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_416091", "416091050", "story_v_out_416091.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_7 = math.max(var_215_0, arg_212_1.talkMaxDuration)

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_7 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - 0) / var_215_7

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= 0 + var_215_7 and arg_212_1.time_ < 0 + var_215_7 + arg_215_0 then
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
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(arg_216_1.actors_["1148"]) and arg_216_1.var_.actorSpriteComps1148 == nil then
				arg_216_1.var_.actorSpriteComps1148 = arg_216_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_0 = 0.125

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 and not isNil(arg_216_1.actors_["1148"]) then
				if arg_216_1.var_.actorSpriteComps1148 then
					for iter_219_0, iter_219_1 in pairs(arg_216_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_219_1 then
							if arg_216_1.isInRecall_ then
								iter_219_1.color = Color.New(Mathf.Lerp(iter_219_1.color.r, arg_216_1.hightColor2.r, (arg_216_1.time_ - 0) / var_219_0), Mathf.Lerp(iter_219_1.color.g, arg_216_1.hightColor2.g, (arg_216_1.time_ - 0) / var_219_0), (Mathf.Lerp(iter_219_1.color.b, arg_216_1.hightColor2.b, (arg_216_1.time_ - 0) / var_219_0)))
							else
								local var_219_1 = Mathf.Lerp(iter_219_1.color.r, 0.5, (arg_216_1.time_ - 0) / var_219_0)

								iter_219_1.color = Color.New(var_219_1, var_219_1, var_219_1)
							end
						end
					end
				end
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 and not isNil(arg_216_1.actors_["1148"]) and arg_216_1.var_.actorSpriteComps1148 then
				for iter_219_2, iter_219_3 in pairs(arg_216_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_219_3 then
						iter_219_3.color = arg_216_1.isInRecall_ and (arg_216_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_216_1.var_.actorSpriteComps1148 = nil
			end

			if arg_216_1.frameCnt_ <= 1 then
				arg_216_1.dialog_:SetActive(false)
			end

			local var_219_2 = 0.633333333333333
			local var_219_3 = 0.3

			if 0.633333333333333 < arg_216_1.time_ and arg_216_1.time_ <= var_219_2 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0

				arg_216_1.dialog_:SetActive(true)

				arg_216_1.dialogCg_.alpha = 0

				local var_219_4 = LeanTween.value(arg_216_1.dialog_, 0, 1, 0.3)

				var_219_4:setOnUpdate(LuaHelper.FloatAction(function(arg_220_0)
					arg_216_1.dialogCg_.alpha = arg_220_0
				end))
				var_219_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_216_1.dialog_)
					var_219_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_216_1.duration_ = arg_216_1.duration_ + 0.3

				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[1082].name)

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

				local var_219_5 = arg_216_1:GetWordFromCfg(416091051)
				local var_219_6 = arg_216_1:FormatText(var_219_5.content)

				arg_216_1.text_.text = var_219_6

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_8 = 12 <= 0 and var_219_3 or var_219_3 * (utf8.len(var_219_6) / 12)

				if (12 <= 0 and var_219_3 or var_219_3 * (utf8.len(var_219_6) / 12)) > 0 and var_219_3 < var_219_8 then
					arg_216_1.talkMaxDuration = var_219_8
					var_219_2 = var_219_2 + 0.3

					if var_219_8 + var_219_2 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_8 + var_219_2
					end
				end

				arg_216_1.text_.text = var_219_6
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091051", "story_v_out_416091.awb") ~= 0 then
					local var_219_9 = manager.audio:GetVoiceLength("story_v_out_416091", "416091051", "story_v_out_416091.awb") / 1000

					if var_219_9 + var_219_2 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_9 + var_219_2
					end

					if var_219_5.prefab_name ~= "" and arg_216_1.actors_[var_219_5.prefab_name] ~= nil then
						local var_219_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_5.prefab_name].transform, "story_v_out_416091", "416091051", "story_v_out_416091.awb")

						arg_216_1:RecordAudio("416091051", var_219_10)
						arg_216_1:RecordAudio("416091051", var_219_10)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_416091", "416091051", "story_v_out_416091.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_416091", "416091051", "story_v_out_416091.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_11 = var_219_2 + 0.3
			local var_219_12 = math.max(var_219_3, arg_216_1.talkMaxDuration)

			if var_219_2 + 0.3 <= arg_216_1.time_ and arg_216_1.time_ < var_219_11 + var_219_12 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_11) / var_219_12

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_11 + var_219_12 and arg_216_1.time_ < var_219_11 + var_219_12 + arg_219_0 then
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
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["1148"]) and arg_222_1.var_.actorSpriteComps1148 == nil then
				arg_222_1.var_.actorSpriteComps1148 = arg_222_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_0 = 0.125

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["1148"]) then
				if arg_222_1.var_.actorSpriteComps1148 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_225_1 then
							if arg_222_1.isInRecall_ then
								iter_225_1.color = Color.New(Mathf.Lerp(iter_225_1.color.r, arg_222_1.hightColor1.r, (arg_222_1.time_ - 0) / var_225_0), Mathf.Lerp(iter_225_1.color.g, arg_222_1.hightColor1.g, (arg_222_1.time_ - 0) / var_225_0), (Mathf.Lerp(iter_225_1.color.b, arg_222_1.hightColor1.b, (arg_222_1.time_ - 0) / var_225_0)))
							else
								local var_225_1 = Mathf.Lerp(iter_225_1.color.r, 1, (arg_222_1.time_ - 0) / var_225_0)

								iter_225_1.color = Color.New(var_225_1, var_225_1, var_225_1)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["1148"]) and arg_222_1.var_.actorSpriteComps1148 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_225_3 then
						iter_225_3.color = arg_222_1.isInRecall_ and (arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_222_1.var_.actorSpriteComps1148 = nil
			end

			local var_225_2 = 0
			local var_225_3 = 0.55

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_2 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_4 = arg_222_1:GetWordFromCfg(416091052)
				local var_225_5 = arg_222_1:FormatText(var_225_4.content)

				arg_222_1.text_.text = var_225_5

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_7 = 22 <= 0 and var_225_3 or var_225_3 * (utf8.len(var_225_5) / 22)

				if (22 <= 0 and var_225_3 or var_225_3 * (utf8.len(var_225_5) / 22)) > 0 and var_225_3 < var_225_7 then
					arg_222_1.talkMaxDuration = var_225_7

					if var_225_7 + var_225_2 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_7 + var_225_2
					end
				end

				arg_222_1.text_.text = var_225_5
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091052", "story_v_out_416091.awb") ~= 0 then
					local var_225_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091052", "story_v_out_416091.awb") / 1000

					if var_225_8 + var_225_2 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_8 + var_225_2
					end

					if var_225_4.prefab_name ~= "" and arg_222_1.actors_[var_225_4.prefab_name] ~= nil then
						local var_225_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_4.prefab_name].transform, "story_v_out_416091", "416091052", "story_v_out_416091.awb")

						arg_222_1:RecordAudio("416091052", var_225_9)
						arg_222_1:RecordAudio("416091052", var_225_9)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_416091", "416091052", "story_v_out_416091.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_416091", "416091052", "story_v_out_416091.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_10 = math.max(var_225_3, arg_222_1.talkMaxDuration)

			if var_225_2 <= arg_222_1.time_ and arg_222_1.time_ < var_225_2 + var_225_10 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_2) / var_225_10

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_2 + var_225_10 and arg_222_1.time_ < var_225_2 + var_225_10 + arg_225_0 then
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
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["1148"]) and arg_226_1.var_.actorSpriteComps1148 == nil then
				arg_226_1.var_.actorSpriteComps1148 = arg_226_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_0 = 0.125

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["1148"]) then
				if arg_226_1.var_.actorSpriteComps1148 then
					for iter_229_0, iter_229_1 in pairs(arg_226_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_229_1 then
							if arg_226_1.isInRecall_ then
								iter_229_1.color = Color.New(Mathf.Lerp(iter_229_1.color.r, arg_226_1.hightColor2.r, (arg_226_1.time_ - 0) / var_229_0), Mathf.Lerp(iter_229_1.color.g, arg_226_1.hightColor2.g, (arg_226_1.time_ - 0) / var_229_0), (Mathf.Lerp(iter_229_1.color.b, arg_226_1.hightColor2.b, (arg_226_1.time_ - 0) / var_229_0)))
							else
								local var_229_1 = Mathf.Lerp(iter_229_1.color.r, 0.5, (arg_226_1.time_ - 0) / var_229_0)

								iter_229_1.color = Color.New(var_229_1, var_229_1, var_229_1)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["1148"]) and arg_226_1.var_.actorSpriteComps1148 then
				for iter_229_2, iter_229_3 in pairs(arg_226_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_229_3 then
						iter_229_3.color = arg_226_1.isInRecall_ and (arg_226_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_226_1.var_.actorSpriteComps1148 = nil
			end

			local var_229_2 = 0
			local var_229_3 = 0.45

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_2 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[1082].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_4 = arg_226_1:GetWordFromCfg(416091053)
				local var_229_5 = arg_226_1:FormatText(var_229_4.content)

				arg_226_1.text_.text = var_229_5

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_7 = 18 <= 0 and var_229_3 or var_229_3 * (utf8.len(var_229_5) / 18)

				if (18 <= 0 and var_229_3 or var_229_3 * (utf8.len(var_229_5) / 18)) > 0 and var_229_3 < var_229_7 then
					arg_226_1.talkMaxDuration = var_229_7

					if var_229_7 + var_229_2 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_7 + var_229_2
					end
				end

				arg_226_1.text_.text = var_229_5
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091053", "story_v_out_416091.awb") ~= 0 then
					local var_229_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091053", "story_v_out_416091.awb") / 1000

					if var_229_8 + var_229_2 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_8 + var_229_2
					end

					if var_229_4.prefab_name ~= "" and arg_226_1.actors_[var_229_4.prefab_name] ~= nil then
						local var_229_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_4.prefab_name].transform, "story_v_out_416091", "416091053", "story_v_out_416091.awb")

						arg_226_1:RecordAudio("416091053", var_229_9)
						arg_226_1:RecordAudio("416091053", var_229_9)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_416091", "416091053", "story_v_out_416091.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_416091", "416091053", "story_v_out_416091.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_10 = math.max(var_229_3, arg_226_1.talkMaxDuration)

			if var_229_2 <= arg_226_1.time_ and arg_226_1.time_ < var_229_2 + var_229_10 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_2) / var_229_10

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_2 + var_229_10 and arg_226_1.time_ < var_229_2 + var_229_10 + arg_229_0 then
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
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["1148"]) and arg_230_1.var_.actorSpriteComps1148 == nil then
				arg_230_1.var_.actorSpriteComps1148 = arg_230_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_0 = 0.125

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["1148"]) then
				if arg_230_1.var_.actorSpriteComps1148 then
					for iter_233_0, iter_233_1 in pairs(arg_230_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_233_1 then
							if arg_230_1.isInRecall_ then
								iter_233_1.color = Color.New(Mathf.Lerp(iter_233_1.color.r, arg_230_1.hightColor1.r, (arg_230_1.time_ - 0) / var_233_0), Mathf.Lerp(iter_233_1.color.g, arg_230_1.hightColor1.g, (arg_230_1.time_ - 0) / var_233_0), (Mathf.Lerp(iter_233_1.color.b, arg_230_1.hightColor1.b, (arg_230_1.time_ - 0) / var_233_0)))
							else
								local var_233_1 = Mathf.Lerp(iter_233_1.color.r, 1, (arg_230_1.time_ - 0) / var_233_0)

								iter_233_1.color = Color.New(var_233_1, var_233_1, var_233_1)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["1148"]) and arg_230_1.var_.actorSpriteComps1148 then
				for iter_233_2, iter_233_3 in pairs(arg_230_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_233_3 then
						iter_233_3.color = arg_230_1.isInRecall_ and (arg_230_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_230_1.var_.actorSpriteComps1148 = nil
			end

			local var_233_2 = 0
			local var_233_3 = 0.125

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_2 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_4 = arg_230_1:GetWordFromCfg(416091054)
				local var_233_5 = arg_230_1:FormatText(var_233_4.content)

				arg_230_1.text_.text = var_233_5

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_7 = 5 <= 0 and var_233_3 or var_233_3 * (utf8.len(var_233_5) / 5)

				if (5 <= 0 and var_233_3 or var_233_3 * (utf8.len(var_233_5) / 5)) > 0 and var_233_3 < var_233_7 then
					arg_230_1.talkMaxDuration = var_233_7

					if var_233_7 + var_233_2 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_7 + var_233_2
					end
				end

				arg_230_1.text_.text = var_233_5
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091054", "story_v_out_416091.awb") ~= 0 then
					local var_233_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091054", "story_v_out_416091.awb") / 1000

					if var_233_8 + var_233_2 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_8 + var_233_2
					end

					if var_233_4.prefab_name ~= "" and arg_230_1.actors_[var_233_4.prefab_name] ~= nil then
						local var_233_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_4.prefab_name].transform, "story_v_out_416091", "416091054", "story_v_out_416091.awb")

						arg_230_1:RecordAudio("416091054", var_233_9)
						arg_230_1:RecordAudio("416091054", var_233_9)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_416091", "416091054", "story_v_out_416091.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_416091", "416091054", "story_v_out_416091.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_10 = math.max(var_233_3, arg_230_1.talkMaxDuration)

			if var_233_2 <= arg_230_1.time_ and arg_230_1.time_ < var_233_2 + var_233_10 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_2) / var_233_10

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_2 + var_233_10 and arg_230_1.time_ < var_233_2 + var_233_10 + arg_233_0 then
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
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos1148 = arg_234_1.actors_["1148"].transform.localPosition
				arg_234_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_234_1:CheckSpriteTmpPos("1148", 7)

				for iter_237_0 = 0, arg_234_1.actors_["1148"].transform.childCount - 1 do
					local var_237_0 = arg_234_1.actors_["1148"].transform:GetChild(iter_237_0)

					if var_237_0.name == "" or not string.find(var_237_0.name, "split") then
						var_237_0.gameObject:SetActive(true)
					else
						var_237_0.gameObject:SetActive(false)
					end
				end
			end

			local var_237_1 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_1 then
				arg_234_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_234_1.time_ - 0) / var_237_1)
			end

			if arg_234_1.time_ >= 0 + var_237_1 and arg_234_1.time_ < 0 + var_237_1 + arg_237_0 then
				arg_234_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_237_2 = 0
			local var_237_3 = 1.125

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_2 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_4 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(416091055).content)

				arg_234_1.text_.text = var_237_4

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_6 = 45 <= 0 and var_237_3 or var_237_3 * (utf8.len(var_237_4) / 45)

				if (45 <= 0 and var_237_3 or var_237_3 * (utf8.len(var_237_4) / 45)) > 0 and var_237_3 < var_237_6 then
					arg_234_1.talkMaxDuration = var_237_6

					if var_237_6 + var_237_2 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_6 + var_237_2
					end
				end

				arg_234_1.text_.text = var_237_4
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_7 = math.max(var_237_3, arg_234_1.talkMaxDuration)

			if var_237_2 <= arg_234_1.time_ and arg_234_1.time_ < var_237_2 + var_237_7 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_2) / var_237_7

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_2 + var_237_7 and arg_234_1.time_ < var_237_2 + var_237_7 + arg_237_0 then
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
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos1148 = arg_238_1.actors_["1148"].transform.localPosition
				arg_238_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_238_1:CheckSpriteTmpPos("1148", 3)

				for iter_241_0 = 0, arg_238_1.actors_["1148"].transform.childCount - 1 do
					local var_241_0 = arg_238_1.actors_["1148"].transform:GetChild(iter_241_0)

					if var_241_0.name == "split_6" or not string.find(var_241_0.name, "split") then
						var_241_0.gameObject:SetActive(true)
					else
						var_241_0.gameObject:SetActive(false)
					end
				end
			end

			local var_241_1 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_1 then
				arg_238_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_238_1.time_ - 0) / var_241_1)
			end

			if arg_238_1.time_ >= 0 + var_241_1 and arg_238_1.time_ < 0 + var_241_1 + arg_241_0 then
				arg_238_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_241_2 = arg_238_1.actors_["1148"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_2) and arg_238_1.var_.actorSpriteComps1148 == nil then
				arg_238_1.var_.actorSpriteComps1148 = var_241_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_3 = 0.125

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_3 and not isNil(var_241_2) then
				if arg_238_1.var_.actorSpriteComps1148 then
					for iter_241_1, iter_241_2 in pairs(arg_238_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_241_2 then
							if arg_238_1.isInRecall_ then
								iter_241_2.color = Color.New(Mathf.Lerp(iter_241_2.color.r, arg_238_1.hightColor1.r, (arg_238_1.time_ - 0) / var_241_3), Mathf.Lerp(iter_241_2.color.g, arg_238_1.hightColor1.g, (arg_238_1.time_ - 0) / var_241_3), (Mathf.Lerp(iter_241_2.color.b, arg_238_1.hightColor1.b, (arg_238_1.time_ - 0) / var_241_3)))
							else
								local var_241_4 = Mathf.Lerp(iter_241_2.color.r, 1, (arg_238_1.time_ - 0) / var_241_3)

								iter_241_2.color = Color.New(var_241_4, var_241_4, var_241_4)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= 0 + var_241_3 and arg_238_1.time_ < 0 + var_241_3 + arg_241_0 and not isNil(var_241_2) and arg_238_1.var_.actorSpriteComps1148 then
				for iter_241_3, iter_241_4 in pairs(arg_238_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_241_4 then
						iter_241_4.color = arg_238_1.isInRecall_ and (arg_238_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_238_1.var_.actorSpriteComps1148 = nil
			end

			local var_241_5 = 0
			local var_241_6 = 0.525

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_5 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_7 = arg_238_1:GetWordFromCfg(416091056)
				local var_241_8 = arg_238_1:FormatText(var_241_7.content)

				arg_238_1.text_.text = var_241_8

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_10 = 21 <= 0 and var_241_6 or var_241_6 * (utf8.len(var_241_8) / 21)

				if (21 <= 0 and var_241_6 or var_241_6 * (utf8.len(var_241_8) / 21)) > 0 and var_241_6 < var_241_10 then
					arg_238_1.talkMaxDuration = var_241_10

					if var_241_10 + var_241_5 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_10 + var_241_5
					end
				end

				arg_238_1.text_.text = var_241_8
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091056", "story_v_out_416091.awb") ~= 0 then
					local var_241_11 = manager.audio:GetVoiceLength("story_v_out_416091", "416091056", "story_v_out_416091.awb") / 1000

					if var_241_11 + var_241_5 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_11 + var_241_5
					end

					if var_241_7.prefab_name ~= "" and arg_238_1.actors_[var_241_7.prefab_name] ~= nil then
						local var_241_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_7.prefab_name].transform, "story_v_out_416091", "416091056", "story_v_out_416091.awb")

						arg_238_1:RecordAudio("416091056", var_241_12)
						arg_238_1:RecordAudio("416091056", var_241_12)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_416091", "416091056", "story_v_out_416091.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_416091", "416091056", "story_v_out_416091.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_13 = math.max(var_241_6, arg_238_1.talkMaxDuration)

			if var_241_5 <= arg_238_1.time_ and arg_238_1.time_ < var_241_5 + var_241_13 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_5) / var_241_13

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_5 + var_241_13 and arg_238_1.time_ < var_241_5 + var_241_13 + arg_241_0 then
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
			local var_245_0 = 0.8

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_1 = arg_242_1:GetWordFromCfg(416091057)
				local var_245_2 = arg_242_1:FormatText(var_245_1.content)

				arg_242_1.text_.text = var_245_2

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_4 = 32 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_2) / 32)

				if (32 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_2) / 32)) > 0 and var_245_0 < var_245_4 then
					arg_242_1.talkMaxDuration = var_245_4

					if var_245_4 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_4 + 0
					end
				end

				arg_242_1.text_.text = var_245_2
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091057", "story_v_out_416091.awb") ~= 0 then
					local var_245_5 = manager.audio:GetVoiceLength("story_v_out_416091", "416091057", "story_v_out_416091.awb") / 1000

					if var_245_5 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_5 + 0
					end

					if var_245_1.prefab_name ~= "" and arg_242_1.actors_[var_245_1.prefab_name] ~= nil then
						local var_245_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_1.prefab_name].transform, "story_v_out_416091", "416091057", "story_v_out_416091.awb")

						arg_242_1:RecordAudio("416091057", var_245_6)
						arg_242_1:RecordAudio("416091057", var_245_6)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_416091", "416091057", "story_v_out_416091.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_416091", "416091057", "story_v_out_416091.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_7 = math.max(var_245_0, arg_242_1.talkMaxDuration)

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_7 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - 0) / var_245_7

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= 0 + var_245_7 and arg_242_1.time_ < 0 + var_245_7 + arg_245_0 then
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
			local var_249_0 = 0.55

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_1 = arg_246_1:GetWordFromCfg(416091058)
				local var_249_2 = arg_246_1:FormatText(var_249_1.content)

				arg_246_1.text_.text = var_249_2

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_4 = 22 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_2) / 22)

				if (22 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_2) / 22)) > 0 and var_249_0 < var_249_4 then
					arg_246_1.talkMaxDuration = var_249_4

					if var_249_4 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_4 + 0
					end
				end

				arg_246_1.text_.text = var_249_2
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091058", "story_v_out_416091.awb") ~= 0 then
					local var_249_5 = manager.audio:GetVoiceLength("story_v_out_416091", "416091058", "story_v_out_416091.awb") / 1000

					if var_249_5 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_5 + 0
					end

					if var_249_1.prefab_name ~= "" and arg_246_1.actors_[var_249_1.prefab_name] ~= nil then
						local var_249_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_1.prefab_name].transform, "story_v_out_416091", "416091058", "story_v_out_416091.awb")

						arg_246_1:RecordAudio("416091058", var_249_6)
						arg_246_1:RecordAudio("416091058", var_249_6)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_416091", "416091058", "story_v_out_416091.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_416091", "416091058", "story_v_out_416091.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_7 = math.max(var_249_0, arg_246_1.talkMaxDuration)

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_7 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - 0) / var_249_7

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= 0 + var_249_7 and arg_246_1.time_ < 0 + var_249_7 + arg_249_0 then
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
			local var_253_0 = 0.425

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_1 = arg_250_1:GetWordFromCfg(416091059)
				local var_253_2 = arg_250_1:FormatText(var_253_1.content)

				arg_250_1.text_.text = var_253_2

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_4 = 17 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 17)

				if (17 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 17)) > 0 and var_253_0 < var_253_4 then
					arg_250_1.talkMaxDuration = var_253_4

					if var_253_4 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_4 + 0
					end
				end

				arg_250_1.text_.text = var_253_2
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091059", "story_v_out_416091.awb") ~= 0 then
					local var_253_5 = manager.audio:GetVoiceLength("story_v_out_416091", "416091059", "story_v_out_416091.awb") / 1000

					if var_253_5 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_5 + 0
					end

					if var_253_1.prefab_name ~= "" and arg_250_1.actors_[var_253_1.prefab_name] ~= nil then
						local var_253_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_1.prefab_name].transform, "story_v_out_416091", "416091059", "story_v_out_416091.awb")

						arg_250_1:RecordAudio("416091059", var_253_6)
						arg_250_1:RecordAudio("416091059", var_253_6)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_416091", "416091059", "story_v_out_416091.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_416091", "416091059", "story_v_out_416091.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_7 = math.max(var_253_0, arg_250_1.talkMaxDuration)

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_7 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - 0) / var_253_7

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= 0 + var_253_7 and arg_250_1.time_ < 0 + var_253_7 + arg_253_0 then
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
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["1148"]) and arg_254_1.var_.actorSpriteComps1148 == nil then
				arg_254_1.var_.actorSpriteComps1148 = arg_254_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_0 = 0.125

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["1148"]) then
				if arg_254_1.var_.actorSpriteComps1148 then
					for iter_257_0, iter_257_1 in pairs(arg_254_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_257_1 then
							if arg_254_1.isInRecall_ then
								iter_257_1.color = Color.New(Mathf.Lerp(iter_257_1.color.r, arg_254_1.hightColor2.r, (arg_254_1.time_ - 0) / var_257_0), Mathf.Lerp(iter_257_1.color.g, arg_254_1.hightColor2.g, (arg_254_1.time_ - 0) / var_257_0), (Mathf.Lerp(iter_257_1.color.b, arg_254_1.hightColor2.b, (arg_254_1.time_ - 0) / var_257_0)))
							else
								local var_257_1 = Mathf.Lerp(iter_257_1.color.r, 0.5, (arg_254_1.time_ - 0) / var_257_0)

								iter_257_1.color = Color.New(var_257_1, var_257_1, var_257_1)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["1148"]) and arg_254_1.var_.actorSpriteComps1148 then
				for iter_257_2, iter_257_3 in pairs(arg_254_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_257_3 then
						iter_257_3.color = arg_254_1.isInRecall_ and (arg_254_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_254_1.var_.actorSpriteComps1148 = nil
			end

			local var_257_2 = 0
			local var_257_3 = 0.325

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_2 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[1082].name)

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

				local var_257_4 = arg_254_1:GetWordFromCfg(416091060)
				local var_257_5 = arg_254_1:FormatText(var_257_4.content)

				arg_254_1.text_.text = var_257_5

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_7 = 13 <= 0 and var_257_3 or var_257_3 * (utf8.len(var_257_5) / 13)

				if (13 <= 0 and var_257_3 or var_257_3 * (utf8.len(var_257_5) / 13)) > 0 and var_257_3 < var_257_7 then
					arg_254_1.talkMaxDuration = var_257_7

					if var_257_7 + var_257_2 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_7 + var_257_2
					end
				end

				arg_254_1.text_.text = var_257_5
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091060", "story_v_out_416091.awb") ~= 0 then
					local var_257_8 = manager.audio:GetVoiceLength("story_v_out_416091", "416091060", "story_v_out_416091.awb") / 1000

					if var_257_8 + var_257_2 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_8 + var_257_2
					end

					if var_257_4.prefab_name ~= "" and arg_254_1.actors_[var_257_4.prefab_name] ~= nil then
						local var_257_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_4.prefab_name].transform, "story_v_out_416091", "416091060", "story_v_out_416091.awb")

						arg_254_1:RecordAudio("416091060", var_257_9)
						arg_254_1:RecordAudio("416091060", var_257_9)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_416091", "416091060", "story_v_out_416091.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_416091", "416091060", "story_v_out_416091.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_10 = math.max(var_257_3, arg_254_1.talkMaxDuration)

			if var_257_2 <= arg_254_1.time_ and arg_254_1.time_ < var_257_2 + var_257_10 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_2) / var_257_10

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_2 + var_257_10 and arg_254_1.time_ < var_257_2 + var_257_10 + arg_257_0 then
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
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1148 = arg_258_1.actors_["1148"].transform.localPosition
				arg_258_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("1148", 7)

				for iter_261_0 = 0, arg_258_1.actors_["1148"].transform.childCount - 1 do
					local var_261_0 = arg_258_1.actors_["1148"].transform:GetChild(iter_261_0)

					if var_261_0.name == "split_6" or not string.find(var_261_0.name, "split") then
						var_261_0.gameObject:SetActive(true)
					else
						var_261_0.gameObject:SetActive(false)
					end
				end
			end

			local var_261_1 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_1 then
				arg_258_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_258_1.time_ - 0) / var_261_1)
			end

			if arg_258_1.time_ >= 0 + var_261_1 and arg_258_1.time_ < 0 + var_261_1 + arg_261_0 then
				arg_258_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_261_2 = 0
			local var_261_3 = 1.075

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_2 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, false)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_4 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(416091061).content)

				arg_258_1.text_.text = var_261_4

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_6 = 43 <= 0 and var_261_3 or var_261_3 * (utf8.len(var_261_4) / 43)

				if (43 <= 0 and var_261_3 or var_261_3 * (utf8.len(var_261_4) / 43)) > 0 and var_261_3 < var_261_6 then
					arg_258_1.talkMaxDuration = var_261_6

					if var_261_6 + var_261_2 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_6 + var_261_2
					end
				end

				arg_258_1.text_.text = var_261_4
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_7 = math.max(var_261_3, arg_258_1.talkMaxDuration)

			if var_261_2 <= arg_258_1.time_ and arg_258_1.time_ < var_261_2 + var_261_7 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_2) / var_261_7

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_2 + var_261_7 and arg_258_1.time_ < var_261_2 + var_261_7 + arg_261_0 then
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
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(arg_262_1.actors_["1148"]) and arg_262_1.var_.actorSpriteComps1148 == nil then
				arg_262_1.var_.actorSpriteComps1148 = arg_262_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_0 = 0.125

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 and not isNil(arg_262_1.actors_["1148"]) then
				if arg_262_1.var_.actorSpriteComps1148 then
					for iter_265_0, iter_265_1 in pairs(arg_262_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_265_1 then
							if arg_262_1.isInRecall_ then
								iter_265_1.color = Color.New(Mathf.Lerp(iter_265_1.color.r, arg_262_1.hightColor1.r, (arg_262_1.time_ - 0) / var_265_0), Mathf.Lerp(iter_265_1.color.g, arg_262_1.hightColor1.g, (arg_262_1.time_ - 0) / var_265_0), (Mathf.Lerp(iter_265_1.color.b, arg_262_1.hightColor1.b, (arg_262_1.time_ - 0) / var_265_0)))
							else
								local var_265_1 = Mathf.Lerp(iter_265_1.color.r, 1, (arg_262_1.time_ - 0) / var_265_0)

								iter_265_1.color = Color.New(var_265_1, var_265_1, var_265_1)
							end
						end
					end
				end
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 and not isNil(arg_262_1.actors_["1148"]) and arg_262_1.var_.actorSpriteComps1148 then
				for iter_265_2, iter_265_3 in pairs(arg_262_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_265_3 then
						iter_265_3.color = arg_262_1.isInRecall_ and (arg_262_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_262_1.var_.actorSpriteComps1148 = nil
			end

			local var_265_2 = arg_262_1.actors_["1148"].transform

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos1148 = var_265_2.localPosition
				var_265_2.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("1148", 3)

				for iter_265_4 = 0, var_265_2.childCount - 1 do
					local var_265_3 = var_265_2:GetChild(iter_265_4)

					if var_265_3.name == "" or not string.find(var_265_3.name, "split") then
						var_265_3.gameObject:SetActive(true)
					else
						var_265_3.gameObject:SetActive(false)
					end
				end
			end

			local var_265_4 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_4 then
				var_265_2.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_262_1.time_ - 0) / var_265_4)
			end

			if arg_262_1.time_ >= 0 + var_265_4 and arg_262_1.time_ < 0 + var_265_4 + arg_265_0 then
				var_265_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_265_5 = 0
			local var_265_6 = 0.225

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_5 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_7 = arg_262_1:GetWordFromCfg(416091062)
				local var_265_8 = arg_262_1:FormatText(var_265_7.content)

				arg_262_1.text_.text = var_265_8

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_10 = 9 <= 0 and var_265_6 or var_265_6 * (utf8.len(var_265_8) / 9)

				if (9 <= 0 and var_265_6 or var_265_6 * (utf8.len(var_265_8) / 9)) > 0 and var_265_6 < var_265_10 then
					arg_262_1.talkMaxDuration = var_265_10

					if var_265_10 + var_265_5 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_10 + var_265_5
					end
				end

				arg_262_1.text_.text = var_265_8
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091062", "story_v_out_416091.awb") ~= 0 then
					local var_265_11 = manager.audio:GetVoiceLength("story_v_out_416091", "416091062", "story_v_out_416091.awb") / 1000

					if var_265_11 + var_265_5 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_11 + var_265_5
					end

					if var_265_7.prefab_name ~= "" and arg_262_1.actors_[var_265_7.prefab_name] ~= nil then
						local var_265_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_7.prefab_name].transform, "story_v_out_416091", "416091062", "story_v_out_416091.awb")

						arg_262_1:RecordAudio("416091062", var_265_12)
						arg_262_1:RecordAudio("416091062", var_265_12)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_416091", "416091062", "story_v_out_416091.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_416091", "416091062", "story_v_out_416091.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_13 = math.max(var_265_6, arg_262_1.talkMaxDuration)

			if var_265_5 <= arg_262_1.time_ and arg_262_1.time_ < var_265_5 + var_265_13 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_5) / var_265_13

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_5 + var_265_13 and arg_262_1.time_ < var_265_5 + var_265_13 + arg_265_0 then
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
			local var_269_0 = 0.675

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_1 = arg_266_1:GetWordFromCfg(416091063)
				local var_269_2 = arg_266_1:FormatText(var_269_1.content)

				arg_266_1.text_.text = var_269_2

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_4 = 27 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_2) / 27)

				if (27 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_2) / 27)) > 0 and var_269_0 < var_269_4 then
					arg_266_1.talkMaxDuration = var_269_4

					if var_269_4 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_4 + 0
					end
				end

				arg_266_1.text_.text = var_269_2
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091063", "story_v_out_416091.awb") ~= 0 then
					local var_269_5 = manager.audio:GetVoiceLength("story_v_out_416091", "416091063", "story_v_out_416091.awb") / 1000

					if var_269_5 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_5 + 0
					end

					if var_269_1.prefab_name ~= "" and arg_266_1.actors_[var_269_1.prefab_name] ~= nil then
						local var_269_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_1.prefab_name].transform, "story_v_out_416091", "416091063", "story_v_out_416091.awb")

						arg_266_1:RecordAudio("416091063", var_269_6)
						arg_266_1:RecordAudio("416091063", var_269_6)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_416091", "416091063", "story_v_out_416091.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_416091", "416091063", "story_v_out_416091.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_7 = math.max(var_269_0, arg_266_1.talkMaxDuration)

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_7 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - 0) / var_269_7

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= 0 + var_269_7 and arg_266_1.time_ < 0 + var_269_7 + arg_269_0 then
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
			local var_273_0 = 0.65

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_1 = arg_270_1:GetWordFromCfg(416091064)
				local var_273_2 = arg_270_1:FormatText(var_273_1.content)

				arg_270_1.text_.text = var_273_2

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_4 = 26 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_2) / 26)

				if (26 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_2) / 26)) > 0 and var_273_0 < var_273_4 then
					arg_270_1.talkMaxDuration = var_273_4

					if var_273_4 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_4 + 0
					end
				end

				arg_270_1.text_.text = var_273_2
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416091", "416091064", "story_v_out_416091.awb") ~= 0 then
					local var_273_5 = manager.audio:GetVoiceLength("story_v_out_416091", "416091064", "story_v_out_416091.awb") / 1000

					if var_273_5 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_5 + 0
					end

					if var_273_1.prefab_name ~= "" and arg_270_1.actors_[var_273_1.prefab_name] ~= nil then
						local var_273_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_1.prefab_name].transform, "story_v_out_416091", "416091064", "story_v_out_416091.awb")

						arg_270_1:RecordAudio("416091064", var_273_6)
						arg_270_1:RecordAudio("416091064", var_273_6)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_416091", "416091064", "story_v_out_416091.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_416091", "416091064", "story_v_out_416091.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_7 = math.max(var_273_0, arg_270_1.talkMaxDuration)

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_7 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - 0) / var_273_7

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= 0 + var_273_7 and arg_270_1.time_ < 0 + var_273_7 + arg_273_0 then
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
