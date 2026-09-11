return {
	Play121441001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 121441001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play121441002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST42 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST42")
				var_4_0.name = "ST42"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST42 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST42

				arg_1_1.bgs_.ST42.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST42" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			if 0.133333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.133333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_1_story_sifangyuan", "bgm_activity_2_1_story_sifangyuan", "bgm_activity_2_1_story_sifangyuan.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_1_story_sifangyuan", "bgm_activity_2_1_story_sifangyuan")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_walk02", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 2
			local var_4_16 = 0.15

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(121441001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 6 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 6)

				if (6 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 6)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play121441002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 121441002
		arg_9_1.duration_ = 3.6

		local var_9_0 = {
			ja = 3.6,
			ko = 1.8,
			zh = 1.8
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play121441003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.175

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[408].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifangw")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(121441002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 7 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 7)

				if (7 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 7)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441002", "story_v_out_121441.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441002", "story_v_out_121441.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_121441", "121441002", "story_v_out_121441.awb")

						arg_9_1:RecordAudio("121441002", var_12_6)
						arg_9_1:RecordAudio("121441002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_121441", "121441002", "story_v_out_121441.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_121441", "121441002", "story_v_out_121441.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play121441003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 121441003
		arg_13_1.duration_ = 10.17

		local var_13_0 = {
			ja = 10.166,
			ko = 3.066,
			zh = 3.066
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
				arg_13_0:Play121441004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1075ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1075ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1075ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1075ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1075ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1075ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1075ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1075ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0, -1.055, -6.16)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["1075ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1075ui_story == nil then
				arg_13_1.var_.characterEffect1075ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect1075ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1075ui_story then
				arg_13_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_16_8 = 0
			local var_16_9 = 0.275

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(121441003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 11 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 11)

				if (11 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 11)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441003", "story_v_out_121441.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_121441", "121441003", "story_v_out_121441.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_121441", "121441003", "story_v_out_121441.awb")

						arg_13_1:RecordAudio("121441003", var_16_15)
						arg_13_1:RecordAudio("121441003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_121441", "121441003", "story_v_out_121441.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_121441", "121441003", "story_v_out_121441.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_16 and arg_13_1.time_ < var_16_8 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play121441004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 121441004
		arg_17_1.duration_ = 11.83

		local var_17_0 = {
			ja = 11.833,
			ko = 8.3,
			zh = 8.3
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
				arg_17_0:Play121441005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1075ui_story"]) and arg_17_1.var_.characterEffect1075ui_story == nil then
				arg_17_1.var_.characterEffect1075ui_story = arg_17_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1075ui_story"]) then
				if arg_17_1.var_.characterEffect1075ui_story and not isNil(arg_17_1.actors_["1075ui_story"]) then
					arg_17_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1075ui_story"]) and arg_17_1.var_.characterEffect1075ui_story then
				arg_17_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 1.025

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[408].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifangw")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(121441004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_6 = 41 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_4) / 41)

				if (41 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_4) / 41)) > 0 and var_20_2 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441004", "story_v_out_121441.awb") ~= 0 then
					local var_20_7 = manager.audio:GetVoiceLength("story_v_out_121441", "121441004", "story_v_out_121441.awb") / 1000

					if var_20_7 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_1
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_121441", "121441004", "story_v_out_121441.awb")

						arg_17_1:RecordAudio("121441004", var_20_8)
						arg_17_1:RecordAudio("121441004", var_20_8)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_121441", "121441004", "story_v_out_121441.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_121441", "121441004", "story_v_out_121441.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_9 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_9 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_9

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_9 and arg_17_1.time_ < var_20_1 + var_20_9 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play121441005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 121441005
		arg_21_1.duration_ = 9.13

		local var_21_0 = {
			ja = 9.133,
			ko = 8.9,
			zh = 8.9
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
				arg_21_0:Play121441006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1075ui_story"]) and arg_21_1.var_.characterEffect1075ui_story == nil then
				arg_21_1.var_.characterEffect1075ui_story = arg_21_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1075ui_story"]) then
				if arg_21_1.var_.characterEffect1075ui_story and not isNil(arg_21_1.actors_["1075ui_story"]) then
					arg_21_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1075ui_story"]) and arg_21_1.var_.characterEffect1075ui_story then
				arg_21_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_24_2 = 0
			local var_24_3 = 0.8

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(121441005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 32 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 32)

				if (32 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 32)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441005", "story_v_out_121441.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_121441", "121441005", "story_v_out_121441.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_121441", "121441005", "story_v_out_121441.awb")

						arg_21_1:RecordAudio("121441005", var_24_9)
						arg_21_1:RecordAudio("121441005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_121441", "121441005", "story_v_out_121441.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_121441", "121441005", "story_v_out_121441.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_10 and arg_21_1.time_ < var_24_2 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play121441006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 121441006
		arg_25_1.duration_ = 7.5

		local var_25_0 = {
			ja = 7.5,
			ko = 2.933,
			zh = 2.933
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
				arg_25_0:Play121441007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1075ui_story"]) and arg_25_1.var_.characterEffect1075ui_story == nil then
				arg_25_1.var_.characterEffect1075ui_story = arg_25_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1075ui_story"]) then
				if arg_25_1.var_.characterEffect1075ui_story and not isNil(arg_25_1.actors_["1075ui_story"]) then
					arg_25_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1075ui_story"]) and arg_25_1.var_.characterEffect1075ui_story then
				arg_25_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 0.275

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[408].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifangw")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(121441006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_6 = 11 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_4) / 11)

				if (11 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_4) / 11)) > 0 and var_28_2 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441006", "story_v_out_121441.awb") ~= 0 then
					local var_28_7 = manager.audio:GetVoiceLength("story_v_out_121441", "121441006", "story_v_out_121441.awb") / 1000

					if var_28_7 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_1
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_121441", "121441006", "story_v_out_121441.awb")

						arg_25_1:RecordAudio("121441006", var_28_8)
						arg_25_1:RecordAudio("121441006", var_28_8)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_121441", "121441006", "story_v_out_121441.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_121441", "121441006", "story_v_out_121441.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_9 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_9 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_9

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_9 and arg_25_1.time_ < var_28_1 + var_28_9 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play121441007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 121441007
		arg_29_1.duration_ = 3.47

		local var_29_0 = {
			ja = 3.466,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_29_0:Play121441008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1075ui_story"]) and arg_29_1.var_.characterEffect1075ui_story == nil then
				arg_29_1.var_.characterEffect1075ui_story = arg_29_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1075ui_story"]) then
				if arg_29_1.var_.characterEffect1075ui_story and not isNil(arg_29_1.actors_["1075ui_story"]) then
					arg_29_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1075ui_story"]) and arg_29_1.var_.characterEffect1075ui_story then
				arg_29_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_32_2 = 0
			local var_32_3 = 0.1

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_4 = arg_29_1:GetWordFromCfg(121441007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 4 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 4)

				if (4 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 4)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441007", "story_v_out_121441.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_121441", "121441007", "story_v_out_121441.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_out_121441", "121441007", "story_v_out_121441.awb")

						arg_29_1:RecordAudio("121441007", var_32_9)
						arg_29_1:RecordAudio("121441007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_121441", "121441007", "story_v_out_121441.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_121441", "121441007", "story_v_out_121441.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_10 and arg_29_1.time_ < var_32_2 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play121441008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 121441008
		arg_33_1.duration_ = 10.43

		local var_33_0 = {
			ja = 10.433,
			ko = 7.033,
			zh = 7.033
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
				arg_33_0:Play121441009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1075ui_story"]) and arg_33_1.var_.characterEffect1075ui_story == nil then
				arg_33_1.var_.characterEffect1075ui_story = arg_33_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1075ui_story"]) then
				if arg_33_1.var_.characterEffect1075ui_story and not isNil(arg_33_1.actors_["1075ui_story"]) then
					arg_33_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1075ui_story"]) and arg_33_1.var_.characterEffect1075ui_story then
				arg_33_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.675

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[408].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifangw")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(121441008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 27 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 27)

				if (27 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 27)) > 0 and var_36_2 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441008", "story_v_out_121441.awb") ~= 0 then
					local var_36_7 = manager.audio:GetVoiceLength("story_v_out_121441", "121441008", "story_v_out_121441.awb") / 1000

					if var_36_7 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_1
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_121441", "121441008", "story_v_out_121441.awb")

						arg_33_1:RecordAudio("121441008", var_36_8)
						arg_33_1:RecordAudio("121441008", var_36_8)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_121441", "121441008", "story_v_out_121441.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_121441", "121441008", "story_v_out_121441.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_9 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_9 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_9

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_9 and arg_33_1.time_ < var_36_1 + var_36_9 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play121441009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 121441009
		arg_37_1.duration_ = 2

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play121441010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1075ui_story"]) and arg_37_1.var_.characterEffect1075ui_story == nil then
				arg_37_1.var_.characterEffect1075ui_story = arg_37_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1075ui_story"]) then
				if arg_37_1.var_.characterEffect1075ui_story and not isNil(arg_37_1.actors_["1075ui_story"]) then
					arg_37_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1075ui_story"]) and arg_37_1.var_.characterEffect1075ui_story then
				arg_37_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_40_2 = 0
			local var_40_3 = 0.125

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_4 = arg_37_1:GetWordFromCfg(121441009)
				local var_40_5 = arg_37_1:FormatText(var_40_4.content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 5 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 5)

				if (5 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 5)) > 0 and var_40_3 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441009", "story_v_out_121441.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_121441", "121441009", "story_v_out_121441.awb") / 1000

					if var_40_8 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_2
					end

					if var_40_4.prefab_name ~= "" and arg_37_1.actors_[var_40_4.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_4.prefab_name].transform, "story_v_out_121441", "121441009", "story_v_out_121441.awb")

						arg_37_1:RecordAudio("121441009", var_40_9)
						arg_37_1:RecordAudio("121441009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_121441", "121441009", "story_v_out_121441.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_121441", "121441009", "story_v_out_121441.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_3, arg_37_1.talkMaxDuration)

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_2) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_2 + var_40_10 and arg_37_1.time_ < var_40_2 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play121441010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 121441010
		arg_41_1.duration_ = 5.3

		local var_41_0 = {
			ja = 4.333,
			ko = 5.3,
			zh = 5.3
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
				arg_41_0:Play121441011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_44_0 = 0
			local var_44_1 = 0.4

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_2 = arg_41_1:GetWordFromCfg(121441010)
				local var_44_3 = arg_41_1:FormatText(var_44_2.content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 16 <= 0 and var_44_1 or var_44_1 * (utf8.len(var_44_3) / 16)

				if (16 <= 0 and var_44_1 or var_44_1 * (utf8.len(var_44_3) / 16)) > 0 and var_44_1 < var_44_5 then
					arg_41_1.talkMaxDuration = var_44_5

					if var_44_5 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441010", "story_v_out_121441.awb") ~= 0 then
					local var_44_6 = manager.audio:GetVoiceLength("story_v_out_121441", "121441010", "story_v_out_121441.awb") / 1000

					if var_44_6 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_0
					end

					if var_44_2.prefab_name ~= "" and arg_41_1.actors_[var_44_2.prefab_name] ~= nil then
						local var_44_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_2.prefab_name].transform, "story_v_out_121441", "121441010", "story_v_out_121441.awb")

						arg_41_1:RecordAudio("121441010", var_44_7)
						arg_41_1:RecordAudio("121441010", var_44_7)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_121441", "121441010", "story_v_out_121441.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_121441", "121441010", "story_v_out_121441.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_8 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_8 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_8

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_8 and arg_41_1.time_ < var_44_0 + var_44_8 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play121441011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 121441011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play121441012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1075ui_story"]) and arg_45_1.var_.characterEffect1075ui_story == nil then
				arg_45_1.var_.characterEffect1075ui_story = arg_45_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1075ui_story"]) then
				if arg_45_1.var_.characterEffect1075ui_story and not isNil(arg_45_1.actors_["1075ui_story"]) then
					arg_45_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1075ui_story"]) and arg_45_1.var_.characterEffect1075ui_story then
				arg_45_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_48_1 = arg_45_1.actors_["1075ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1075ui_story = var_48_1.localPosition
			end

			local var_48_2 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 then
				var_48_1.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_2)
				var_48_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_1.position).x, (manager.ui.mainCamera.transform.position - var_48_1.position).y, (manager.ui.mainCamera.transform.position - var_48_1.position).z)
				var_48_1.localEulerAngles.z = 0
				var_48_1.localEulerAngles.x = 0
				var_48_1.localEulerAngles = var_48_1.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 then
				var_48_1.localPosition = Vector3.New(0, 100, 0)
				var_48_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_1.position).x, (manager.ui.mainCamera.transform.position - var_48_1.position).y, (manager.ui.mainCamera.transform.position - var_48_1.position).z)
				var_48_1.localEulerAngles.z = 0
				var_48_1.localEulerAngles.x = 0
				var_48_1.localEulerAngles = var_48_1.localEulerAngles
			end

			local var_48_3 = 0
			local var_48_4 = 0.7

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_3 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_5 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(121441011).content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 28 <= 0 and var_48_4 or var_48_4 * (utf8.len(var_48_5) / 28)

				if (28 <= 0 and var_48_4 or var_48_4 * (utf8.len(var_48_5) / 28)) > 0 and var_48_4 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_3 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_3
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_8 = math.max(var_48_4, arg_45_1.talkMaxDuration)

			if var_48_3 <= arg_45_1.time_ and arg_45_1.time_ < var_48_3 + var_48_8 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_3) / var_48_8

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_3 + var_48_8 and arg_45_1.time_ < var_48_3 + var_48_8 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play121441012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 121441012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play121441013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 1.1

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(121441012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 44 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 44)

				if (44 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 44)) > 0 and var_52_0 < var_52_3 then
					arg_49_1.talkMaxDuration = var_52_3

					if var_52_3 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_3 + 0
					end
				end

				arg_49_1.text_.text = var_52_1
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_4 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_4

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play121441013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 121441013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play121441014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.625

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(121441013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 25 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 25)

				if (25 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 25)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play121441014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 121441014
		arg_57_1.duration_ = 2

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play121441015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1075ui_story = arg_57_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1075ui_story"].transform.position).z)
				arg_57_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1075ui_story"].transform.localEulerAngles = arg_57_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_57_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1075ui_story"].transform.position).z)
				arg_57_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1075ui_story"].transform.localEulerAngles = arg_57_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1075ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1075ui_story == nil then
				arg_57_1.var_.characterEffect1075ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1075ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1075ui_story then
				arg_57_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_60_4 = 0
			local var_60_5 = 0.1

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(121441014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 4 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 4)

				if (4 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 4)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441014", "story_v_out_121441.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_121441", "121441014", "story_v_out_121441.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_121441", "121441014", "story_v_out_121441.awb")

						arg_57_1:RecordAudio("121441014", var_60_11)
						arg_57_1:RecordAudio("121441014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_121441", "121441014", "story_v_out_121441.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_121441", "121441014", "story_v_out_121441.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_12 and arg_57_1.time_ < var_60_4 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play121441015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 121441015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play121441016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1075ui_story = arg_61_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1075ui_story"].transform.position).z)
				arg_61_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1075ui_story"].transform.localEulerAngles = arg_61_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1075ui_story"].transform.position).z)
				arg_61_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1075ui_story"].transform.localEulerAngles = arg_61_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1075ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1075ui_story == nil then
				arg_61_1.var_.characterEffect1075ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect1075ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_2)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1075ui_story then
				arg_61_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_64_3 = 0
			local var_64_4 = 0.6

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_5 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(121441015).content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 24 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_5) / 24)

				if (24 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_5) / 24)) > 0 and var_64_4 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_3 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_3
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_8 = math.max(var_64_4, arg_61_1.talkMaxDuration)

			if var_64_3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_3 + var_64_8 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_3) / var_64_8

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_3 + var_64_8 and arg_61_1.time_ < var_64_3 + var_64_8 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play121441016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 121441016
		arg_65_1.duration_ = 3.4

		local var_65_0 = {
			ja = 3.4,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_65_0:Play121441017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1075ui_story = arg_65_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1075ui_story, Vector3.New(-0.7, -1.055, -6.16), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1075ui_story"].transform.position).z)
				arg_65_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1075ui_story"].transform.localEulerAngles = arg_65_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.16)
				arg_65_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1075ui_story"].transform.position).z)
				arg_65_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1075ui_story"].transform.localEulerAngles = arg_65_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1075ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1075ui_story == nil then
				arg_65_1.var_.characterEffect1075ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1075ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1075ui_story then
				arg_65_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_68_4 = 0
			local var_68_5 = 0.125

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(121441016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 5 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 5)

				if (5 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 5)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441016", "story_v_out_121441.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_121441", "121441016", "story_v_out_121441.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_121441", "121441016", "story_v_out_121441.awb")

						arg_65_1:RecordAudio("121441016", var_68_11)
						arg_65_1:RecordAudio("121441016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_121441", "121441016", "story_v_out_121441.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_121441", "121441016", "story_v_out_121441.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_12 and arg_65_1.time_ < var_68_4 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play121441017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 121441017
		arg_69_1.duration_ = 4.1

		local var_69_0 = {
			ja = 4.1,
			ko = 2.866,
			zh = 2.866
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play121441018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if arg_69_1.actors_["1076ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1076ui_story"))) then
				local var_72_0 = Object.Instantiate(Asset.Load("Char/" .. "1076ui_story"), arg_69_1.stage_.transform)

				var_72_0.name = "1076ui_story"
				var_72_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_["1076ui_story"] = var_72_0

				local var_72_1 = var_72_0:GetComponentInChildren(typeof(CharacterEffect))

				var_72_1.enabled = true

				local var_72_2 = GameObjectTools.GetOrAddComponent(var_72_0, typeof(DynamicBoneHelper))

				if var_72_2 then
					var_72_2:EnableDynamicBone(false)
				end

				arg_69_1:ShowWeapon(var_72_1.transform, false)

				arg_69_1.var_["1076ui_story" .. "Animator"] = var_72_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_69_1.var_["1076ui_story" .. "Animator"].applyRootMotion = true
				arg_69_1.var_["1076ui_story" .. "LipSync"] = var_72_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_72_3 = arg_69_1.actors_["1076ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1076ui_story = var_72_3.localPosition
			end

			local var_72_4 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				var_72_3.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_69_1.time_ - 0) / var_72_4)
				var_72_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_3.position).x, (manager.ui.mainCamera.transform.position - var_72_3.position).y, (manager.ui.mainCamera.transform.position - var_72_3.position).z)
				var_72_3.localEulerAngles.z = 0
				var_72_3.localEulerAngles.x = 0
				var_72_3.localEulerAngles = var_72_3.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				var_72_3.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_72_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_3.position).x, (manager.ui.mainCamera.transform.position - var_72_3.position).y, (manager.ui.mainCamera.transform.position - var_72_3.position).z)
				var_72_3.localEulerAngles.z = 0
				var_72_3.localEulerAngles.x = 0
				var_72_3.localEulerAngles = var_72_3.localEulerAngles
			end

			local var_72_5 = arg_69_1.actors_["1076ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect1076ui_story == nil then
				arg_69_1.var_.characterEffect1076ui_story = var_72_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_6 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_6 and not isNil(var_72_5) then
				if arg_69_1.var_.characterEffect1076ui_story and not isNil(var_72_5) then
					arg_69_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_6 and arg_69_1.time_ < 0 + var_72_6 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect1076ui_story then
				arg_69_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_72_8 = arg_69_1.actors_["1075ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.characterEffect1075ui_story == nil then
				arg_69_1.var_.characterEffect1075ui_story = var_72_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_9 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_9 and not isNil(var_72_8) then
				if arg_69_1.var_.characterEffect1075ui_story and not isNil(var_72_8) then
					arg_69_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_9)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_9 and arg_69_1.time_ < 0 + var_72_9 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.characterEffect1075ui_story then
				arg_69_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action2_2")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_72_10 = 0
			local var_72_11 = 0.2

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_12 = arg_69_1:GetWordFromCfg(121441017)
				local var_72_13 = arg_69_1:FormatText(var_72_12.content)

				arg_69_1.text_.text = var_72_13

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_15 = 8 <= 0 and var_72_11 or var_72_11 * (utf8.len(var_72_13) / 8)

				if (8 <= 0 and var_72_11 or var_72_11 * (utf8.len(var_72_13) / 8)) > 0 and var_72_11 < var_72_15 then
					arg_69_1.talkMaxDuration = var_72_15

					if var_72_15 + var_72_10 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_15 + var_72_10
					end
				end

				arg_69_1.text_.text = var_72_13
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441017", "story_v_out_121441.awb") ~= 0 then
					local var_72_16 = manager.audio:GetVoiceLength("story_v_out_121441", "121441017", "story_v_out_121441.awb") / 1000

					if var_72_16 + var_72_10 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_16 + var_72_10
					end

					if var_72_12.prefab_name ~= "" and arg_69_1.actors_[var_72_12.prefab_name] ~= nil then
						local var_72_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_12.prefab_name].transform, "story_v_out_121441", "121441017", "story_v_out_121441.awb")

						arg_69_1:RecordAudio("121441017", var_72_17)
						arg_69_1:RecordAudio("121441017", var_72_17)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_121441", "121441017", "story_v_out_121441.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_121441", "121441017", "story_v_out_121441.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_18 = math.max(var_72_11, arg_69_1.talkMaxDuration)

			if var_72_10 <= arg_69_1.time_ and arg_69_1.time_ < var_72_10 + var_72_18 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_10) / var_72_18

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_10 + var_72_18 and arg_69_1.time_ < var_72_10 + var_72_18 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play121441018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 121441018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play121441019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1076ui_story"]) and arg_73_1.var_.characterEffect1076ui_story == nil then
				arg_73_1.var_.characterEffect1076ui_story = arg_73_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1076ui_story"]) then
				if arg_73_1.var_.characterEffect1076ui_story and not isNil(arg_73_1.actors_["1076ui_story"]) then
					arg_73_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1076ui_story"]) and arg_73_1.var_.characterEffect1076ui_story then
				arg_73_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if 0.025 < arg_73_1.time_ and arg_73_1.time_ <= 0.025 + arg_76_0 then
				arg_73_1:AudioAction("play", "effect", "se_story_17", "se_story_17_door_close02", "")
			end

			local var_76_2 = 0
			local var_76_3 = 0.725

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(121441018).content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 29 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_4) / 29)

				if (29 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_4) / 29)) > 0 and var_76_3 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_7 and arg_73_1.time_ < var_76_2 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play121441019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 121441019
		arg_77_1.duration_ = 4.9

		local var_77_0 = {
			ja = 4.9,
			ko = 4.233,
			zh = 4.233
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play121441020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1076ui_story"]) and arg_77_1.var_.characterEffect1076ui_story == nil then
				arg_77_1.var_.characterEffect1076ui_story = arg_77_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1076ui_story"]) then
				if arg_77_1.var_.characterEffect1076ui_story and not isNil(arg_77_1.actors_["1076ui_story"]) then
					arg_77_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1076ui_story"]) and arg_77_1.var_.characterEffect1076ui_story then
				arg_77_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action5_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_80_2 = 0
			local var_80_3 = 0.55

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_4 = arg_77_1:GetWordFromCfg(121441019)
				local var_80_5 = arg_77_1:FormatText(var_80_4.content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 22 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 22)

				if (22 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 22)) > 0 and var_80_3 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441019", "story_v_out_121441.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_121441", "121441019", "story_v_out_121441.awb") / 1000

					if var_80_8 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_2
					end

					if var_80_4.prefab_name ~= "" and arg_77_1.actors_[var_80_4.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_4.prefab_name].transform, "story_v_out_121441", "121441019", "story_v_out_121441.awb")

						arg_77_1:RecordAudio("121441019", var_80_9)
						arg_77_1:RecordAudio("121441019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_121441", "121441019", "story_v_out_121441.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_121441", "121441019", "story_v_out_121441.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_10 and arg_77_1.time_ < var_80_2 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play121441020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 121441020
		arg_81_1.duration_ = 15.1

		local var_81_0 = {
			ja = 15.1,
			ko = 8.3,
			zh = 8.3
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play121441021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1075ui_story"]) and arg_81_1.var_.characterEffect1075ui_story == nil then
				arg_81_1.var_.characterEffect1075ui_story = arg_81_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1075ui_story"]) then
				if arg_81_1.var_.characterEffect1075ui_story and not isNil(arg_81_1.actors_["1075ui_story"]) then
					arg_81_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1075ui_story"]) and arg_81_1.var_.characterEffect1075ui_story then
				arg_81_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action3_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_84_2 = arg_81_1.actors_["1076ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect1076ui_story == nil then
				arg_81_1.var_.characterEffect1076ui_story = var_84_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_3 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.characterEffect1076ui_story and not isNil(var_84_2) then
					arg_81_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_3)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect1076ui_story then
				arg_81_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action5_2")
			end

			local var_84_4 = 0
			local var_84_5 = 0.925

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(121441020)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 37 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 37)

				if (37 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 37)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441020", "story_v_out_121441.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_out_121441", "121441020", "story_v_out_121441.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_out_121441", "121441020", "story_v_out_121441.awb")

						arg_81_1:RecordAudio("121441020", var_84_11)
						arg_81_1:RecordAudio("121441020", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_121441", "121441020", "story_v_out_121441.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_121441", "121441020", "story_v_out_121441.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_12 = math.max(var_84_5, arg_81_1.talkMaxDuration)

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_12 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_4) / var_84_12

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_4 + var_84_12 and arg_81_1.time_ < var_84_4 + var_84_12 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play121441021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 121441021
		arg_85_1.duration_ = 12.9

		local var_85_0 = {
			ja = 12.9,
			ko = 6.7,
			zh = 6.7
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play121441022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1075ui_story = arg_85_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1075ui_story, Vector3.New(-0.7, -1.055, -6.16), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1075ui_story"].transform.position).z)
				arg_85_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1075ui_story"].transform.localEulerAngles = arg_85_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.16)
				arg_85_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1075ui_story"].transform.position).z)
				arg_85_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1075ui_story"].transform.localEulerAngles = arg_85_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action3_2")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_88_1 = 0
			local var_88_2 = 0.7

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:GetWordFromCfg(121441021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_6 = 28 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 28)

				if (28 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 28)) > 0 and var_88_2 < var_88_6 then
					arg_85_1.talkMaxDuration = var_88_6

					if var_88_6 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441021", "story_v_out_121441.awb") ~= 0 then
					local var_88_7 = manager.audio:GetVoiceLength("story_v_out_121441", "121441021", "story_v_out_121441.awb") / 1000

					if var_88_7 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_1
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_121441", "121441021", "story_v_out_121441.awb")

						arg_85_1:RecordAudio("121441021", var_88_8)
						arg_85_1:RecordAudio("121441021", var_88_8)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_121441", "121441021", "story_v_out_121441.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_121441", "121441021", "story_v_out_121441.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_9 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_9 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_9

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_9 and arg_85_1.time_ < var_88_1 + var_88_9 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play121441022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 121441022
		arg_89_1.duration_ = 4.27

		local var_89_0 = {
			ja = 4.266,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play121441023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1076ui_story"]) and arg_89_1.var_.characterEffect1076ui_story == nil then
				arg_89_1.var_.characterEffect1076ui_story = arg_89_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1076ui_story"]) then
				if arg_89_1.var_.characterEffect1076ui_story and not isNil(arg_89_1.actors_["1076ui_story"]) then
					arg_89_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1076ui_story"]) and arg_89_1.var_.characterEffect1076ui_story then
				arg_89_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_92_2 = arg_89_1.actors_["1075ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.characterEffect1075ui_story == nil then
				arg_89_1.var_.characterEffect1075ui_story = var_92_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_3 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.characterEffect1075ui_story and not isNil(var_92_2) then
					arg_89_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_3)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.characterEffect1075ui_story then
				arg_89_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_92_4 = 0
			local var_92_5 = 0.2

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(121441022)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 8 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 8)

				if (8 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 8)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441022", "story_v_out_121441.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_121441", "121441022", "story_v_out_121441.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_out_121441", "121441022", "story_v_out_121441.awb")

						arg_89_1:RecordAudio("121441022", var_92_11)
						arg_89_1:RecordAudio("121441022", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_121441", "121441022", "story_v_out_121441.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_121441", "121441022", "story_v_out_121441.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_12 and arg_89_1.time_ < var_92_4 + var_92_12 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play121441023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 121441023
		arg_93_1.duration_ = 14.53

		local var_93_0 = {
			ja = 14.533,
			ko = 10.833,
			zh = 10.833
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play121441024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1075ui_story"]) and arg_93_1.var_.characterEffect1075ui_story == nil then
				arg_93_1.var_.characterEffect1075ui_story = arg_93_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1075ui_story"]) then
				if arg_93_1.var_.characterEffect1075ui_story and not isNil(arg_93_1.actors_["1075ui_story"]) then
					arg_93_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1075ui_story"]) and arg_93_1.var_.characterEffect1075ui_story then
				arg_93_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_96_2 = arg_93_1.actors_["1076ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.characterEffect1076ui_story == nil then
				arg_93_1.var_.characterEffect1076ui_story = var_96_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_3 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_3 and not isNil(var_96_2) then
				if arg_93_1.var_.characterEffect1076ui_story and not isNil(var_96_2) then
					arg_93_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_3)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_3 and arg_93_1.time_ < 0 + var_96_3 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.characterEffect1076ui_story then
				arg_93_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_96_4 = 0
			local var_96_5 = 1.2

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(121441023)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 48 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 48)

				if (48 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 48)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441023", "story_v_out_121441.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_121441", "121441023", "story_v_out_121441.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_121441", "121441023", "story_v_out_121441.awb")

						arg_93_1:RecordAudio("121441023", var_96_11)
						arg_93_1:RecordAudio("121441023", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_121441", "121441023", "story_v_out_121441.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_121441", "121441023", "story_v_out_121441.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_5, arg_93_1.talkMaxDuration)

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_4) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_4 + var_96_12 and arg_93_1.time_ < var_96_4 + var_96_12 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play121441024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 121441024
		arg_97_1.duration_ = 14.67

		local var_97_0 = {
			ja = 9.833,
			ko = 14.666,
			zh = 14.666
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play121441025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 1.4

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:GetWordFromCfg(121441024)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 56 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 56)

				if (56 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 56)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441024", "story_v_out_121441.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441024", "story_v_out_121441.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_121441", "121441024", "story_v_out_121441.awb")

						arg_97_1:RecordAudio("121441024", var_100_6)
						arg_97_1:RecordAudio("121441024", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_121441", "121441024", "story_v_out_121441.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_121441", "121441024", "story_v_out_121441.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play121441025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 121441025
		arg_101_1.duration_ = 8.5

		local var_101_0 = {
			ja = 5.1,
			ko = 8.5,
			zh = 8.5
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play121441026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.7

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:GetWordFromCfg(121441025)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 28 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 28)

				if (28 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 28)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441025", "story_v_out_121441.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441025", "story_v_out_121441.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_121441", "121441025", "story_v_out_121441.awb")

						arg_101_1:RecordAudio("121441025", var_104_6)
						arg_101_1:RecordAudio("121441025", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_121441", "121441025", "story_v_out_121441.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_121441", "121441025", "story_v_out_121441.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play121441026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 121441026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play121441027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1075ui_story"]) and arg_105_1.var_.characterEffect1075ui_story == nil then
				arg_105_1.var_.characterEffect1075ui_story = arg_105_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1075ui_story"]) then
				if arg_105_1.var_.characterEffect1075ui_story and not isNil(arg_105_1.actors_["1075ui_story"]) then
					arg_105_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1075ui_story"]) and arg_105_1.var_.characterEffect1075ui_story then
				arg_105_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_108_1 = 0
			local var_108_2 = 0.75

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(121441026).content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 30 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 30)

				if (30 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 30)) > 0 and var_108_2 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_6 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_6 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_6

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_6 and arg_105_1.time_ < var_108_1 + var_108_6 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play121441027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 121441027
		arg_109_1.duration_ = 2

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play121441028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1076ui_story"]) and arg_109_1.var_.characterEffect1076ui_story == nil then
				arg_109_1.var_.characterEffect1076ui_story = arg_109_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1076ui_story"]) then
				if arg_109_1.var_.characterEffect1076ui_story and not isNil(arg_109_1.actors_["1076ui_story"]) then
					arg_109_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1076ui_story"]) and arg_109_1.var_.characterEffect1076ui_story then
				arg_109_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_112_2 = 0
			local var_112_3 = 0.1

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:GetWordFromCfg(121441027)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 4 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 4)

				if (4 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 4)) > 0 and var_112_3 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441027", "story_v_out_121441.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_121441", "121441027", "story_v_out_121441.awb") / 1000

					if var_112_8 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_2
					end

					if var_112_4.prefab_name ~= "" and arg_109_1.actors_[var_112_4.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_4.prefab_name].transform, "story_v_out_121441", "121441027", "story_v_out_121441.awb")

						arg_109_1:RecordAudio("121441027", var_112_9)
						arg_109_1:RecordAudio("121441027", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_121441", "121441027", "story_v_out_121441.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_121441", "121441027", "story_v_out_121441.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_10 and arg_109_1.time_ < var_112_2 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play121441028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 121441028
		arg_113_1.duration_ = 7.8

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play121441029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if arg_113_1.bgs_.STblack == nil then
				local var_116_0 = Object.Instantiate(arg_113_1.paintGo_)

				var_116_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_116_0.name = "STblack"
				var_116_0.transform.parent = arg_113_1.stage_.transform
				var_116_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.bgs_.STblack = var_116_0
			end

			if 2 < arg_113_1.time_ and arg_113_1.time_ <= 2 + arg_116_0 then
				local var_116_1 = arg_113_1.bgs_.STblack

				arg_113_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_116_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_116_2 = var_116_1:GetComponent("SpriteRenderer")

				if var_116_2 and var_116_2.sprite then
					local var_116_3 = 2 * (var_116_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_116_1.transform.localScale = Vector3.New(var_116_3 / var_116_2.sprite.bounds.size.y < var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x and var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x or var_116_3 / var_116_2.sprite.bounds.size.y, var_116_3 / var_116_2.sprite.bounds.size.y < var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x and var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x or var_116_3 / var_116_2.sprite.bounds.size.y, 0)
				end

				for iter_116_0, iter_116_1 in pairs(arg_113_1.bgs_) do
					if iter_116_0 ~= "STblack" then
						iter_116_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_116_4 = 0

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_5 = 2

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_5 then
				local var_116_6 = Color.New(0, 0, 0)

				var_116_6.a = Mathf.Lerp(0, 1, (arg_113_1.time_ - var_116_4) / var_116_5)
				arg_113_1.mask_.color = var_116_6
			end

			if arg_113_1.time_ >= var_116_4 + var_116_5 and arg_113_1.time_ < var_116_4 + var_116_5 + arg_116_0 then
				local var_116_7 = Color.New(0, 0, 0)

				var_116_7.a = 1
				arg_113_1.mask_.color = var_116_7
			end

			local var_116_8 = 2

			if 2 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_9 = 2

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_9 then
				local var_116_10 = Color.New(0, 0, 0)

				var_116_10.a = Mathf.Lerp(1, 0, (arg_113_1.time_ - var_116_8) / var_116_9)
				arg_113_1.mask_.color = var_116_10
			end

			if arg_113_1.time_ >= var_116_8 + var_116_9 and arg_113_1.time_ < var_116_8 + var_116_9 + arg_116_0 then
				local var_116_11 = Color.New(0, 0, 0)

				arg_113_1.mask_.enabled = false
				var_116_11.a = 0
				arg_113_1.mask_.color = var_116_11
			end

			local var_116_12 = arg_113_1.actors_["1076ui_story"]

			if 1.96599999815226 < arg_113_1.time_ and arg_113_1.time_ <= 1.96599999815226 + arg_116_0 and not isNil(var_116_12) and arg_113_1.var_.characterEffect1076ui_story == nil then
				arg_113_1.var_.characterEffect1076ui_story = var_116_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_13 = 0.034000001847744

			if 1.96599999815226 <= arg_113_1.time_ and arg_113_1.time_ < 1.96599999815226 + var_116_13 and not isNil(var_116_12) then
				if arg_113_1.var_.characterEffect1076ui_story and not isNil(var_116_12) then
					arg_113_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 1.96599999815226) / var_116_13)
				end
			end

			if arg_113_1.time_ >= 1.96599999815226 + var_116_13 and arg_113_1.time_ < 1.96599999815226 + var_116_13 + arg_116_0 and not isNil(var_116_12) and arg_113_1.var_.characterEffect1076ui_story then
				arg_113_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_116_14 = arg_113_1.actors_["1076ui_story"].transform

			if 1.96599999815226 < arg_113_1.time_ and arg_113_1.time_ <= 1.96599999815226 + arg_116_0 then
				arg_113_1.var_.moveOldPos1076ui_story = var_116_14.localPosition
			end

			local var_116_15 = 0.001

			if 1.96599999815226 <= arg_113_1.time_ and arg_113_1.time_ < 1.96599999815226 + var_116_15 then
				var_116_14.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 1.96599999815226) / var_116_15)
				var_116_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_14.position).x, (manager.ui.mainCamera.transform.position - var_116_14.position).y, (manager.ui.mainCamera.transform.position - var_116_14.position).z)
				var_116_14.localEulerAngles.z = 0
				var_116_14.localEulerAngles.x = 0
				var_116_14.localEulerAngles = var_116_14.localEulerAngles
			end

			if arg_113_1.time_ >= 1.96599999815226 + var_116_15 and arg_113_1.time_ < 1.96599999815226 + var_116_15 + arg_116_0 then
				var_116_14.localPosition = Vector3.New(0, 100, 0)
				var_116_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_14.position).x, (manager.ui.mainCamera.transform.position - var_116_14.position).y, (manager.ui.mainCamera.transform.position - var_116_14.position).z)
				var_116_14.localEulerAngles.z = 0
				var_116_14.localEulerAngles.x = 0
				var_116_14.localEulerAngles = var_116_14.localEulerAngles
			end

			local var_116_16 = arg_113_1.actors_["1075ui_story"].transform

			if 1.96599999815226 < arg_113_1.time_ and arg_113_1.time_ <= 1.96599999815226 + arg_116_0 then
				arg_113_1.var_.moveOldPos1075ui_story = var_116_16.localPosition
			end

			local var_116_17 = 0.001

			if 1.96599999815226 <= arg_113_1.time_ and arg_113_1.time_ < 1.96599999815226 + var_116_17 then
				var_116_16.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 1.96599999815226) / var_116_17)
				var_116_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_16.position).x, (manager.ui.mainCamera.transform.position - var_116_16.position).y, (manager.ui.mainCamera.transform.position - var_116_16.position).z)
				var_116_16.localEulerAngles.z = 0
				var_116_16.localEulerAngles.x = 0
				var_116_16.localEulerAngles = var_116_16.localEulerAngles
			end

			if arg_113_1.time_ >= 1.96599999815226 + var_116_17 and arg_113_1.time_ < 1.96599999815226 + var_116_17 + arg_116_0 then
				var_116_16.localPosition = Vector3.New(0, 100, 0)
				var_116_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_16.position).x, (manager.ui.mainCamera.transform.position - var_116_16.position).y, (manager.ui.mainCamera.transform.position - var_116_16.position).z)
				var_116_16.localEulerAngles.z = 0
				var_116_16.localEulerAngles.x = 0
				var_116_16.localEulerAngles = var_116_16.localEulerAngles
			end

			if 2.3 < arg_113_1.time_ and arg_113_1.time_ <= 2.3 + arg_116_0 then
				arg_113_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_curtain", "")
			end

			if arg_113_1.frameCnt_ <= 1 then
				arg_113_1.dialog_:SetActive(false)
			end

			local var_116_19 = 2.8
			local var_116_20 = 1.2

			if 2.8 < arg_113_1.time_ and arg_113_1.time_ <= var_116_19 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				arg_113_1.dialog_:SetActive(true)

				arg_113_1.dialogCg_.alpha = 0

				local var_116_21 = LeanTween.value(arg_113_1.dialog_, 0, 1, 0.3)

				var_116_21:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_113_1.dialogCg_.alpha = arg_117_0
				end))
				var_116_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_113_1.dialog_)
					var_116_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_113_1.duration_ = arg_113_1.duration_ + 0.3

				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_22 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(121441028).content)

				arg_113_1.text_.text = var_116_22

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_24 = 48 <= 0 and var_116_20 or var_116_20 * (utf8.len(var_116_22) / 48)

				if (48 <= 0 and var_116_20 or var_116_20 * (utf8.len(var_116_22) / 48)) > 0 and var_116_20 < var_116_24 then
					arg_113_1.talkMaxDuration = var_116_24
					var_116_19 = var_116_19 + 0.3

					if var_116_24 + var_116_19 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_24 + var_116_19
					end
				end

				arg_113_1.text_.text = var_116_22
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_25 = var_116_19 + 0.3
			local var_116_26 = math.max(var_116_20, arg_113_1.talkMaxDuration)

			if var_116_19 + 0.3 <= arg_113_1.time_ and arg_113_1.time_ < var_116_25 + var_116_26 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_25) / var_116_26

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_25 + var_116_26 and arg_113_1.time_ < var_116_25 + var_116_26 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play121441029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 121441029
		arg_119_1.duration_ = 12.17

		local var_119_0 = {
			ja = 12.166,
			ko = 7.5,
			zh = 7.5
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play121441030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.5

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1076")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_1 = arg_119_1:GetWordFromCfg(121441029)
				local var_122_2 = arg_119_1:FormatText(var_122_1.content)

				arg_119_1.text_.text = var_122_2

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 20 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 20)

				if (20 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 20)) > 0 and var_122_0 < var_122_4 then
					arg_119_1.talkMaxDuration = var_122_4

					if var_122_4 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_4 + 0
					end
				end

				arg_119_1.text_.text = var_122_2
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441029", "story_v_out_121441.awb") ~= 0 then
					local var_122_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441029", "story_v_out_121441.awb") / 1000

					if var_122_5 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + 0
					end

					if var_122_1.prefab_name ~= "" and arg_119_1.actors_[var_122_1.prefab_name] ~= nil then
						local var_122_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_1.prefab_name].transform, "story_v_out_121441", "121441029", "story_v_out_121441.awb")

						arg_119_1:RecordAudio("121441029", var_122_6)
						arg_119_1:RecordAudio("121441029", var_122_6)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_121441", "121441029", "story_v_out_121441.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_121441", "121441029", "story_v_out_121441.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_7 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_7 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_7

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_7 and arg_119_1.time_ < 0 + var_122_7 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play121441030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 121441030
		arg_123_1.duration_ = 6.03

		local var_123_0 = {
			ja = 6.033,
			ko = 3.6,
			zh = 3.6
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play121441031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0.4

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_1 = arg_123_1:GetWordFromCfg(121441030)
				local var_126_2 = arg_123_1:FormatText(var_126_1.content)

				arg_123_1.text_.text = var_126_2

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 16 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 16)

				if (16 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 16)) > 0 and var_126_0 < var_126_4 then
					arg_123_1.talkMaxDuration = var_126_4

					if var_126_4 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_4 + 0
					end
				end

				arg_123_1.text_.text = var_126_2
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441030", "story_v_out_121441.awb") ~= 0 then
					local var_126_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441030", "story_v_out_121441.awb") / 1000

					if var_126_5 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + 0
					end

					if var_126_1.prefab_name ~= "" and arg_123_1.actors_[var_126_1.prefab_name] ~= nil then
						local var_126_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_1.prefab_name].transform, "story_v_out_121441", "121441030", "story_v_out_121441.awb")

						arg_123_1:RecordAudio("121441030", var_126_6)
						arg_123_1:RecordAudio("121441030", var_126_6)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_121441", "121441030", "story_v_out_121441.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_121441", "121441030", "story_v_out_121441.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_7 and arg_123_1.time_ < 0 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play121441031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 121441031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play121441032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.6

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(121441031).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 24 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 24)

				if (24 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 24)) > 0 and var_130_0 < var_130_3 then
					arg_127_1.talkMaxDuration = var_130_3

					if var_130_3 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_3 + 0
					end
				end

				arg_127_1.text_.text = var_130_1
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_4 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_4

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play121441032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 121441032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play121441033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.975

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(121441032).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 39 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 39)

				if (39 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 39)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play121441033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 121441033
		arg_135_1.duration_ = 5.07

		local var_135_0 = {
			ja = 5.066,
			ko = 4.866,
			zh = 4.866
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play121441034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if arg_135_1.bgs_.XH0302 == nil then
				local var_138_0 = Object.Instantiate(arg_135_1.paintGo_)

				var_138_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0302")
				var_138_0.name = "XH0302"
				var_138_0.transform.parent = arg_135_1.stage_.transform
				var_138_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_135_1.bgs_.XH0302 = var_138_0
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				local var_138_1 = arg_135_1.bgs_.XH0302

				arg_135_1.bgs_.XH0302.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_138_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_138_2 = var_138_1:GetComponent("SpriteRenderer")

				if var_138_2 and var_138_2.sprite then
					local var_138_3 = 2 * (var_138_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_138_1.transform.localScale = Vector3.New(var_138_3 / var_138_2.sprite.bounds.size.y < var_138_3 * manager.ui.mainCameraCom_.aspect / var_138_2.sprite.bounds.size.x and var_138_3 * manager.ui.mainCameraCom_.aspect / var_138_2.sprite.bounds.size.x or var_138_3 / var_138_2.sprite.bounds.size.y, var_138_3 / var_138_2.sprite.bounds.size.y < var_138_3 * manager.ui.mainCameraCom_.aspect / var_138_2.sprite.bounds.size.x and var_138_3 * manager.ui.mainCameraCom_.aspect / var_138_2.sprite.bounds.size.x or var_138_3 / var_138_2.sprite.bounds.size.y, 0)
				end

				for iter_138_0, iter_138_1 in pairs(arg_135_1.bgs_) do
					if iter_138_0 ~= "XH0302" then
						iter_138_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_138_4 = 0

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = true

				arg_135_1:SetGaussion(false)
			end

			local var_138_5 = 2

			if var_138_4 <= arg_135_1.time_ and arg_135_1.time_ < var_138_4 + var_138_5 then
				local var_138_6 = Color.New(0, 0, 0)

				var_138_6.a = Mathf.Lerp(1, 0, (arg_135_1.time_ - var_138_4) / var_138_5)
				arg_135_1.mask_.color = var_138_6
			end

			if arg_135_1.time_ >= var_138_4 + var_138_5 and arg_135_1.time_ < var_138_4 + var_138_5 + arg_138_0 then
				local var_138_7 = Color.New(0, 0, 0)

				arg_135_1.mask_.enabled = false
				var_138_7.a = 0
				arg_135_1.mask_.color = var_138_7
			end

			if 0.233333333333333 < arg_135_1.time_ and arg_135_1.time_ <= 0.233333333333333 + arg_138_0 then
				arg_135_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_seal", "")
			end

			local var_138_9 = arg_135_1.bgs_.XH0302.transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPosXH0302 = var_138_9.localPosition
			end

			local var_138_10 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_10 then
				var_138_9.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPosXH0302, Vector3.New(1.2, 2, 0), (arg_135_1.time_ - 0) / var_138_10)
			end

			if arg_135_1.time_ >= 0 + var_138_10 and arg_135_1.time_ < 0 + var_138_10 + arg_138_0 then
				var_138_9.localPosition = Vector3.New(1.2, 2, 0)
			end

			local var_138_11 = arg_135_1.bgs_.XH0302.transform

			if 0.0166666666666667 < arg_135_1.time_ and arg_135_1.time_ <= 0.0166666666666667 + arg_138_0 then
				arg_135_1.var_.moveOldPosXH0302 = var_138_11.localPosition
			end

			local var_138_12 = 2.5

			if 0.0166666666666667 <= arg_135_1.time_ and arg_135_1.time_ < 0.0166666666666667 + var_138_12 then
				var_138_11.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPosXH0302, Vector3.New(1.2, 1.5, 0), (arg_135_1.time_ - 0.0166666666666667) / var_138_12)
			end

			if arg_135_1.time_ >= 0.0166666666666667 + var_138_12 and arg_135_1.time_ < 0.0166666666666667 + var_138_12 + arg_138_0 then
				var_138_11.localPosition = Vector3.New(1.2, 1.5, 0)
			end

			if arg_135_1.frameCnt_ <= 1 then
				arg_135_1.dialog_:SetActive(false)
			end

			local var_138_13 = 2
			local var_138_14 = 0.225

			if 2 < arg_135_1.time_ and arg_135_1.time_ <= var_138_13 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0

				arg_135_1.dialog_:SetActive(true)

				arg_135_1.dialogCg_.alpha = 0

				local var_138_15 = LeanTween.value(arg_135_1.dialog_, 0, 1, 0.3)

				var_138_15:setOnUpdate(LuaHelper.FloatAction(function(arg_139_0)
					arg_135_1.dialogCg_.alpha = arg_139_0
				end))
				var_138_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_135_1.dialog_)
					var_138_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_135_1.duration_ = arg_135_1.duration_ + 0.3

				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_16 = arg_135_1:GetWordFromCfg(121441033)
				local var_138_17 = arg_135_1:FormatText(var_138_16.content)

				arg_135_1.text_.text = var_138_17

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_19 = 9 <= 0 and var_138_14 or var_138_14 * (utf8.len(var_138_17) / 9)

				if (9 <= 0 and var_138_14 or var_138_14 * (utf8.len(var_138_17) / 9)) > 0 and var_138_14 < var_138_19 then
					arg_135_1.talkMaxDuration = var_138_19
					var_138_13 = var_138_13 + 0.3

					if var_138_19 + var_138_13 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_19 + var_138_13
					end
				end

				arg_135_1.text_.text = var_138_17
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441033", "story_v_out_121441.awb") ~= 0 then
					local var_138_20 = manager.audio:GetVoiceLength("story_v_out_121441", "121441033", "story_v_out_121441.awb") / 1000

					if var_138_20 + var_138_13 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_20 + var_138_13
					end

					if var_138_16.prefab_name ~= "" and arg_135_1.actors_[var_138_16.prefab_name] ~= nil then
						local var_138_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_16.prefab_name].transform, "story_v_out_121441", "121441033", "story_v_out_121441.awb")

						arg_135_1:RecordAudio("121441033", var_138_21)
						arg_135_1:RecordAudio("121441033", var_138_21)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_121441", "121441033", "story_v_out_121441.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_121441", "121441033", "story_v_out_121441.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_22 = var_138_13 + 0.3
			local var_138_23 = math.max(var_138_14, arg_135_1.talkMaxDuration)

			if var_138_13 + 0.3 <= arg_135_1.time_ and arg_135_1.time_ < var_138_22 + var_138_23 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_22) / var_138_23

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_22 + var_138_23 and arg_135_1.time_ < var_138_22 + var_138_23 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0302",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0302",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.5,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play121441034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 121441034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play121441035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.mask_.enabled = true
				arg_141_1.mask_.raycastTarget = true

				arg_141_1:SetGaussion(false)
			end

			local var_144_0 = 2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				local var_144_1 = Color.New(1, 1, 1)

				var_144_1.a = Mathf.Lerp(1, 0, (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.mask_.color = var_144_1
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				local var_144_2 = Color.New(1, 1, 1)

				arg_141_1.mask_.enabled = false
				var_144_2.a = 0
				arg_141_1.mask_.color = var_144_2
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				local var_144_3 = arg_141_1.bgs_.XH0302

				arg_141_1.bgs_.XH0302.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_144_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_144_4 = var_144_3:GetComponent("SpriteRenderer")

				if var_144_4 and var_144_4.sprite then
					local var_144_5 = 2 * (var_144_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_144_3.transform.localScale = Vector3.New(var_144_5 / var_144_4.sprite.bounds.size.y < var_144_5 * manager.ui.mainCameraCom_.aspect / var_144_4.sprite.bounds.size.x and var_144_5 * manager.ui.mainCameraCom_.aspect / var_144_4.sprite.bounds.size.x or var_144_5 / var_144_4.sprite.bounds.size.y, var_144_5 / var_144_4.sprite.bounds.size.y < var_144_5 * manager.ui.mainCameraCom_.aspect / var_144_4.sprite.bounds.size.x and var_144_5 * manager.ui.mainCameraCom_.aspect / var_144_4.sprite.bounds.size.x or var_144_5 / var_144_4.sprite.bounds.size.y, 0)
				end

				for iter_144_0, iter_144_1 in pairs(arg_141_1.bgs_) do
					if iter_144_0 ~= "XH0302" then
						iter_144_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_144_6 = 0
			local var_144_7 = 1.45

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				arg_141_1.dialog_:SetActive(true)

				arg_141_1.dialogCg_.alpha = 0

				local var_144_8 = LeanTween.value(arg_141_1.dialog_, 0, 1, 0.3)

				var_144_8:setOnUpdate(LuaHelper.FloatAction(function(arg_145_0)
					arg_141_1.dialogCg_.alpha = arg_145_0
				end))
				var_144_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_141_1.dialog_)
					var_144_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_141_1.duration_ = arg_141_1.duration_ + 0.3

				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_9 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(121441034).content)

				arg_141_1.text_.text = var_144_9

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_11 = 58 <= 0 and var_144_7 or var_144_7 * (utf8.len(var_144_9) / 58)

				if (58 <= 0 and var_144_7 or var_144_7 * (utf8.len(var_144_9) / 58)) > 0 and var_144_7 < var_144_11 then
					arg_141_1.talkMaxDuration = var_144_11
					var_144_6 = var_144_6 + 0.3

					if var_144_11 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_6
					end
				end

				arg_141_1.text_.text = var_144_9
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_12 = var_144_6 + 0.3
			local var_144_13 = math.max(var_144_7, arg_141_1.talkMaxDuration)

			if var_144_6 + 0.3 <= arg_141_1.time_ and arg_141_1.time_ < var_144_12 + var_144_13 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_12) / var_144_13

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_12 + var_144_13 and arg_141_1.time_ < var_144_12 + var_144_13 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play121441035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 121441035
		arg_147_1.duration_ = 3.77

		local var_147_0 = {
			ja = 3.766,
			ko = 2.166,
			zh = 2.166
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play121441036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.25

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_1 = arg_147_1:GetWordFromCfg(121441035)
				local var_150_2 = arg_147_1:FormatText(var_150_1.content)

				arg_147_1.text_.text = var_150_2

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 10 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 10)

				if (10 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 10)) > 0 and var_150_0 < var_150_4 then
					arg_147_1.talkMaxDuration = var_150_4

					if var_150_4 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_4 + 0
					end
				end

				arg_147_1.text_.text = var_150_2
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441035", "story_v_out_121441.awb") ~= 0 then
					local var_150_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441035", "story_v_out_121441.awb") / 1000

					if var_150_5 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + 0
					end

					if var_150_1.prefab_name ~= "" and arg_147_1.actors_[var_150_1.prefab_name] ~= nil then
						local var_150_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_1.prefab_name].transform, "story_v_out_121441", "121441035", "story_v_out_121441.awb")

						arg_147_1:RecordAudio("121441035", var_150_6)
						arg_147_1:RecordAudio("121441035", var_150_6)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_121441", "121441035", "story_v_out_121441.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_121441", "121441035", "story_v_out_121441.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play121441036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 121441036
		arg_151_1.duration_ = 2.97

		local var_151_0 = {
			ja = 2.966,
			ko = 1.466,
			zh = 1.466
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play121441037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.175

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:GetWordFromCfg(121441036)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 7 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 7)

				if (7 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 7)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441036", "story_v_out_121441.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441036", "story_v_out_121441.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_out_121441", "121441036", "story_v_out_121441.awb")

						arg_151_1:RecordAudio("121441036", var_154_6)
						arg_151_1:RecordAudio("121441036", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_121441", "121441036", "story_v_out_121441.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_121441", "121441036", "story_v_out_121441.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play121441037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 121441037
		arg_155_1.duration_ = 8.93

		local var_155_0 = {
			ja = 8.933,
			ko = 8.033,
			zh = 8.033
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play121441038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.725

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_1 = arg_155_1:GetWordFromCfg(121441037)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 29 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 29)

				if (29 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 29)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441037", "story_v_out_121441.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441037", "story_v_out_121441.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_out_121441", "121441037", "story_v_out_121441.awb")

						arg_155_1:RecordAudio("121441037", var_158_6)
						arg_155_1:RecordAudio("121441037", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_121441", "121441037", "story_v_out_121441.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_121441", "121441037", "story_v_out_121441.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_7 and arg_155_1.time_ < 0 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play121441038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 121441038
		arg_159_1.duration_ = 6.63

		local var_159_0 = {
			ja = 6.633,
			ko = 4.966,
			zh = 4.966
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play121441039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.45

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_1 = arg_159_1:GetWordFromCfg(121441038)
				local var_162_2 = arg_159_1:FormatText(var_162_1.content)

				arg_159_1.text_.text = var_162_2

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 18 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 18)

				if (18 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 18)) > 0 and var_162_0 < var_162_4 then
					arg_159_1.talkMaxDuration = var_162_4

					if var_162_4 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_4 + 0
					end
				end

				arg_159_1.text_.text = var_162_2
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441038", "story_v_out_121441.awb") ~= 0 then
					local var_162_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441038", "story_v_out_121441.awb") / 1000

					if var_162_5 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + 0
					end

					if var_162_1.prefab_name ~= "" and arg_159_1.actors_[var_162_1.prefab_name] ~= nil then
						local var_162_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_1.prefab_name].transform, "story_v_out_121441", "121441038", "story_v_out_121441.awb")

						arg_159_1:RecordAudio("121441038", var_162_6)
						arg_159_1:RecordAudio("121441038", var_162_6)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_121441", "121441038", "story_v_out_121441.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_121441", "121441038", "story_v_out_121441.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_7 and arg_159_1.time_ < 0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play121441039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 121441039
		arg_163_1.duration_ = 2.77

		local var_163_0 = {
			ja = 2.766,
			ko = 1.533,
			zh = 1.533
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play121441040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.1

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_1 = arg_163_1:GetWordFromCfg(121441039)
				local var_166_2 = arg_163_1:FormatText(var_166_1.content)

				arg_163_1.text_.text = var_166_2

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 4 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 4)

				if (4 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 4)) > 0 and var_166_0 < var_166_4 then
					arg_163_1.talkMaxDuration = var_166_4

					if var_166_4 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_4 + 0
					end
				end

				arg_163_1.text_.text = var_166_2
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441039", "story_v_out_121441.awb") ~= 0 then
					local var_166_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441039", "story_v_out_121441.awb") / 1000

					if var_166_5 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + 0
					end

					if var_166_1.prefab_name ~= "" and arg_163_1.actors_[var_166_1.prefab_name] ~= nil then
						local var_166_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_1.prefab_name].transform, "story_v_out_121441", "121441039", "story_v_out_121441.awb")

						arg_163_1:RecordAudio("121441039", var_166_6)
						arg_163_1:RecordAudio("121441039", var_166_6)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_121441", "121441039", "story_v_out_121441.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_121441", "121441039", "story_v_out_121441.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_7 and arg_163_1.time_ < 0 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play121441040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 121441040
		arg_167_1.duration_ = 13.27

		local var_167_0 = {
			ja = 12.166,
			ko = 13.266,
			zh = 13.266
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play121441041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 1.15

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_1 = arg_167_1:GetWordFromCfg(121441040)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 46 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 46)

				if (46 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 46)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441040", "story_v_out_121441.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441040", "story_v_out_121441.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_out_121441", "121441040", "story_v_out_121441.awb")

						arg_167_1:RecordAudio("121441040", var_170_6)
						arg_167_1:RecordAudio("121441040", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_121441", "121441040", "story_v_out_121441.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_121441", "121441040", "story_v_out_121441.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play121441041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 121441041
		arg_171_1.duration_ = 11.7

		local var_171_0 = {
			ja = 11.7,
			ko = 9.666,
			zh = 9.666
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play121441042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.875

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_1 = arg_171_1:GetWordFromCfg(121441041)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 35 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 35)

				if (35 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 35)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441041", "story_v_out_121441.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441041", "story_v_out_121441.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_out_121441", "121441041", "story_v_out_121441.awb")

						arg_171_1:RecordAudio("121441041", var_174_6)
						arg_171_1:RecordAudio("121441041", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_121441", "121441041", "story_v_out_121441.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_121441", "121441041", "story_v_out_121441.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play121441042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 121441042
		arg_175_1.duration_ = 11.9

		local var_175_0 = {
			ja = 11.9,
			ko = 7.866,
			zh = 7.866
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play121441043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.8

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:GetWordFromCfg(121441042)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 32 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 32)

				if (32 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 32)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441042", "story_v_out_121441.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441042", "story_v_out_121441.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_121441", "121441042", "story_v_out_121441.awb")

						arg_175_1:RecordAudio("121441042", var_178_6)
						arg_175_1:RecordAudio("121441042", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_121441", "121441042", "story_v_out_121441.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_121441", "121441042", "story_v_out_121441.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play121441043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 121441043
		arg_179_1.duration_ = 8.53

		local var_179_0 = {
			ja = 8.533,
			ko = 6.7,
			zh = 6.7
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play121441044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.525

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_1 = arg_179_1:GetWordFromCfg(121441043)
				local var_182_2 = arg_179_1:FormatText(var_182_1.content)

				arg_179_1.text_.text = var_182_2

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 21 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 21)

				if (21 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 21)) > 0 and var_182_0 < var_182_4 then
					arg_179_1.talkMaxDuration = var_182_4

					if var_182_4 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_4 + 0
					end
				end

				arg_179_1.text_.text = var_182_2
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441043", "story_v_out_121441.awb") ~= 0 then
					local var_182_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441043", "story_v_out_121441.awb") / 1000

					if var_182_5 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + 0
					end

					if var_182_1.prefab_name ~= "" and arg_179_1.actors_[var_182_1.prefab_name] ~= nil then
						local var_182_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_1.prefab_name].transform, "story_v_out_121441", "121441043", "story_v_out_121441.awb")

						arg_179_1:RecordAudio("121441043", var_182_6)
						arg_179_1:RecordAudio("121441043", var_182_6)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_121441", "121441043", "story_v_out_121441.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_121441", "121441043", "story_v_out_121441.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play121441044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 121441044
		arg_183_1.duration_ = 16.43

		local var_183_0 = {
			ja = 16.433,
			ko = 10.133,
			zh = 10.133
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play121441045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 1.075

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:GetWordFromCfg(121441044)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.text_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 43 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 43)

				if (43 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 43)) > 0 and var_186_0 < var_186_4 then
					arg_183_1.talkMaxDuration = var_186_4

					if var_186_4 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_4 + 0
					end
				end

				arg_183_1.text_.text = var_186_2
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441044", "story_v_out_121441.awb") ~= 0 then
					local var_186_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441044", "story_v_out_121441.awb") / 1000

					if var_186_5 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + 0
					end

					if var_186_1.prefab_name ~= "" and arg_183_1.actors_[var_186_1.prefab_name] ~= nil then
						local var_186_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_1.prefab_name].transform, "story_v_out_121441", "121441044", "story_v_out_121441.awb")

						arg_183_1:RecordAudio("121441044", var_186_6)
						arg_183_1:RecordAudio("121441044", var_186_6)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_121441", "121441044", "story_v_out_121441.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_121441", "121441044", "story_v_out_121441.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_7 and arg_183_1.time_ < 0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play121441045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 121441045
		arg_187_1.duration_ = 10.73

		local var_187_0 = {
			ja = 10.733,
			ko = 6.766,
			zh = 6.766
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play121441046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.8

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:GetWordFromCfg(121441045)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 32 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 32)

				if (32 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 32)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441045", "story_v_out_121441.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441045", "story_v_out_121441.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_out_121441", "121441045", "story_v_out_121441.awb")

						arg_187_1:RecordAudio("121441045", var_190_6)
						arg_187_1:RecordAudio("121441045", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_121441", "121441045", "story_v_out_121441.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_121441", "121441045", "story_v_out_121441.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play121441046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 121441046
		arg_191_1.duration_ = 8.4

		local var_191_0 = {
			ja = 8.4,
			ko = 5.6,
			zh = 5.6
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play121441047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.45

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_1 = arg_191_1:GetWordFromCfg(121441046)
				local var_194_2 = arg_191_1:FormatText(var_194_1.content)

				arg_191_1.text_.text = var_194_2

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 18 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 18)

				if (18 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 18)) > 0 and var_194_0 < var_194_4 then
					arg_191_1.talkMaxDuration = var_194_4

					if var_194_4 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_4 + 0
					end
				end

				arg_191_1.text_.text = var_194_2
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441046", "story_v_out_121441.awb") ~= 0 then
					local var_194_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441046", "story_v_out_121441.awb") / 1000

					if var_194_5 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + 0
					end

					if var_194_1.prefab_name ~= "" and arg_191_1.actors_[var_194_1.prefab_name] ~= nil then
						local var_194_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_1.prefab_name].transform, "story_v_out_121441", "121441046", "story_v_out_121441.awb")

						arg_191_1:RecordAudio("121441046", var_194_6)
						arg_191_1:RecordAudio("121441046", var_194_6)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_121441", "121441046", "story_v_out_121441.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_121441", "121441046", "story_v_out_121441.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_7 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_7 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_7

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_7 and arg_191_1.time_ < 0 + var_194_7 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play121441047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 121441047
		arg_195_1.duration_ = 9.87

		local var_195_0 = {
			ja = 9.866,
			ko = 7.133,
			zh = 7.133
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play121441048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.75

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:GetWordFromCfg(121441047)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 30 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 30)

				if (30 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 30)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441047", "story_v_out_121441.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441047", "story_v_out_121441.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_121441", "121441047", "story_v_out_121441.awb")

						arg_195_1:RecordAudio("121441047", var_198_6)
						arg_195_1:RecordAudio("121441047", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_121441", "121441047", "story_v_out_121441.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_121441", "121441047", "story_v_out_121441.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play121441048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 121441048
		arg_199_1.duration_ = 7.23

		local var_199_0 = {
			ja = 4.366,
			ko = 7.233,
			zh = 7.233
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play121441049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.675

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_1 = arg_199_1:GetWordFromCfg(121441048)
				local var_202_2 = arg_199_1:FormatText(var_202_1.content)

				arg_199_1.text_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 27 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 27)

				if (27 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 27)) > 0 and var_202_0 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + 0
					end
				end

				arg_199_1.text_.text = var_202_2
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441048", "story_v_out_121441.awb") ~= 0 then
					local var_202_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441048", "story_v_out_121441.awb") / 1000

					if var_202_5 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + 0
					end

					if var_202_1.prefab_name ~= "" and arg_199_1.actors_[var_202_1.prefab_name] ~= nil then
						local var_202_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_1.prefab_name].transform, "story_v_out_121441", "121441048", "story_v_out_121441.awb")

						arg_199_1:RecordAudio("121441048", var_202_6)
						arg_199_1:RecordAudio("121441048", var_202_6)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_121441", "121441048", "story_v_out_121441.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_121441", "121441048", "story_v_out_121441.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play121441049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 121441049
		arg_203_1.duration_ = 11.6

		local var_203_0 = {
			ja = 9.966,
			ko = 11.6,
			zh = 11.6
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play121441050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 1.05

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_1 = arg_203_1:GetWordFromCfg(121441049)
				local var_206_2 = arg_203_1:FormatText(var_206_1.content)

				arg_203_1.text_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 42 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 42)

				if (42 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 42)) > 0 and var_206_0 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + 0
					end
				end

				arg_203_1.text_.text = var_206_2
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441049", "story_v_out_121441.awb") ~= 0 then
					local var_206_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441049", "story_v_out_121441.awb") / 1000

					if var_206_5 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + 0
					end

					if var_206_1.prefab_name ~= "" and arg_203_1.actors_[var_206_1.prefab_name] ~= nil then
						local var_206_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_1.prefab_name].transform, "story_v_out_121441", "121441049", "story_v_out_121441.awb")

						arg_203_1:RecordAudio("121441049", var_206_6)
						arg_203_1:RecordAudio("121441049", var_206_6)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_121441", "121441049", "story_v_out_121441.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_121441", "121441049", "story_v_out_121441.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play121441050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 121441050
		arg_207_1.duration_ = 4.33

		local var_207_0 = {
			ja = 4.333,
			ko = 1.166,
			zh = 1.166
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play121441051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.1

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_1 = arg_207_1:GetWordFromCfg(121441050)
				local var_210_2 = arg_207_1:FormatText(var_210_1.content)

				arg_207_1.text_.text = var_210_2

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 4 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 4)

				if (4 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 4)) > 0 and var_210_0 < var_210_4 then
					arg_207_1.talkMaxDuration = var_210_4

					if var_210_4 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_4 + 0
					end
				end

				arg_207_1.text_.text = var_210_2
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441050", "story_v_out_121441.awb") ~= 0 then
					local var_210_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441050", "story_v_out_121441.awb") / 1000

					if var_210_5 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + 0
					end

					if var_210_1.prefab_name ~= "" and arg_207_1.actors_[var_210_1.prefab_name] ~= nil then
						local var_210_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_1.prefab_name].transform, "story_v_out_121441", "121441050", "story_v_out_121441.awb")

						arg_207_1:RecordAudio("121441050", var_210_6)
						arg_207_1:RecordAudio("121441050", var_210_6)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_121441", "121441050", "story_v_out_121441.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_121441", "121441050", "story_v_out_121441.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_7 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_7 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_7

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_7 and arg_207_1.time_ < 0 + var_210_7 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play121441051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 121441051
		arg_211_1.duration_ = 1.53

		local var_211_0 = {
			ja = 0.999999999999,
			ko = 1.533,
			zh = 1.533
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play121441052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0.2

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_1 = arg_211_1:GetWordFromCfg(121441051)
				local var_214_2 = arg_211_1:FormatText(var_214_1.content)

				arg_211_1.text_.text = var_214_2

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 8 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 8)

				if (8 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 8)) > 0 and var_214_0 < var_214_4 then
					arg_211_1.talkMaxDuration = var_214_4

					if var_214_4 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_4 + 0
					end
				end

				arg_211_1.text_.text = var_214_2
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441051", "story_v_out_121441.awb") ~= 0 then
					local var_214_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441051", "story_v_out_121441.awb") / 1000

					if var_214_5 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + 0
					end

					if var_214_1.prefab_name ~= "" and arg_211_1.actors_[var_214_1.prefab_name] ~= nil then
						local var_214_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_1.prefab_name].transform, "story_v_out_121441", "121441051", "story_v_out_121441.awb")

						arg_211_1:RecordAudio("121441051", var_214_6)
						arg_211_1:RecordAudio("121441051", var_214_6)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_121441", "121441051", "story_v_out_121441.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_121441", "121441051", "story_v_out_121441.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_7 and arg_211_1.time_ < 0 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play121441052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 121441052
		arg_215_1.duration_ = 9

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play121441053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if arg_215_1.bgs_.ST37 == nil then
				local var_218_0 = Object.Instantiate(arg_215_1.paintGo_)

				var_218_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST37")
				var_218_0.name = "ST37"
				var_218_0.transform.parent = arg_215_1.stage_.transform
				var_218_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_215_1.bgs_.ST37 = var_218_0
			end

			if 2 < arg_215_1.time_ and arg_215_1.time_ <= 2 + arg_218_0 then
				local var_218_1 = arg_215_1.bgs_.ST37

				arg_215_1.bgs_.ST37.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_218_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_218_2 = var_218_1:GetComponent("SpriteRenderer")

				if var_218_2 and var_218_2.sprite then
					local var_218_3 = 2 * (var_218_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_218_1.transform.localScale = Vector3.New(var_218_3 / var_218_2.sprite.bounds.size.y < var_218_3 * manager.ui.mainCameraCom_.aspect / var_218_2.sprite.bounds.size.x and var_218_3 * manager.ui.mainCameraCom_.aspect / var_218_2.sprite.bounds.size.x or var_218_3 / var_218_2.sprite.bounds.size.y, var_218_3 / var_218_2.sprite.bounds.size.y < var_218_3 * manager.ui.mainCameraCom_.aspect / var_218_2.sprite.bounds.size.x and var_218_3 * manager.ui.mainCameraCom_.aspect / var_218_2.sprite.bounds.size.x or var_218_3 / var_218_2.sprite.bounds.size.y, 0)
				end

				for iter_218_0, iter_218_1 in pairs(arg_215_1.bgs_) do
					if iter_218_0 ~= "ST37" then
						iter_218_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_218_4 = 0

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_5 = 2

			if var_218_4 <= arg_215_1.time_ and arg_215_1.time_ < var_218_4 + var_218_5 then
				local var_218_6 = Color.New(0, 0, 0)

				var_218_6.a = Mathf.Lerp(0, 1, (arg_215_1.time_ - var_218_4) / var_218_5)
				arg_215_1.mask_.color = var_218_6
			end

			if arg_215_1.time_ >= var_218_4 + var_218_5 and arg_215_1.time_ < var_218_4 + var_218_5 + arg_218_0 then
				local var_218_7 = Color.New(0, 0, 0)

				var_218_7.a = 1
				arg_215_1.mask_.color = var_218_7
			end

			local var_218_8 = 2

			if 2 < arg_215_1.time_ and arg_215_1.time_ <= var_218_8 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_9 = 2

			if var_218_8 <= arg_215_1.time_ and arg_215_1.time_ < var_218_8 + var_218_9 then
				local var_218_10 = Color.New(0, 0, 0)

				var_218_10.a = Mathf.Lerp(1, 0, (arg_215_1.time_ - var_218_8) / var_218_9)
				arg_215_1.mask_.color = var_218_10
			end

			if arg_215_1.time_ >= var_218_8 + var_218_9 and arg_215_1.time_ < var_218_8 + var_218_9 + arg_218_0 then
				local var_218_11 = Color.New(0, 0, 0)

				arg_215_1.mask_.enabled = false
				var_218_11.a = 0
				arg_215_1.mask_.color = var_218_11
			end

			if 1.6 < arg_215_1.time_ and arg_215_1.time_ <= 1.6 + arg_218_0 then
				arg_215_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_curtain", "")
			end

			if arg_215_1.frameCnt_ <= 1 then
				arg_215_1.dialog_:SetActive(false)
			end

			local var_218_13 = 4
			local var_218_14 = 1.05

			if 4 < arg_215_1.time_ and arg_215_1.time_ <= var_218_13 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0

				arg_215_1.dialog_:SetActive(true)

				arg_215_1.dialogCg_.alpha = 0

				local var_218_15 = LeanTween.value(arg_215_1.dialog_, 0, 1, 0.3)

				var_218_15:setOnUpdate(LuaHelper.FloatAction(function(arg_219_0)
					arg_215_1.dialogCg_.alpha = arg_219_0
				end))
				var_218_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_215_1.dialog_)
					var_218_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_215_1.duration_ = arg_215_1.duration_ + 0.3

				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_16 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(121441052).content)

				arg_215_1.text_.text = var_218_16

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_18 = 42 <= 0 and var_218_14 or var_218_14 * (utf8.len(var_218_16) / 42)

				if (42 <= 0 and var_218_14 or var_218_14 * (utf8.len(var_218_16) / 42)) > 0 and var_218_14 < var_218_18 then
					arg_215_1.talkMaxDuration = var_218_18
					var_218_13 = var_218_13 + 0.3

					if var_218_18 + var_218_13 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_18 + var_218_13
					end
				end

				arg_215_1.text_.text = var_218_16
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_19 = var_218_13 + 0.3
			local var_218_20 = math.max(var_218_14, arg_215_1.talkMaxDuration)

			if var_218_13 + 0.3 <= arg_215_1.time_ and arg_215_1.time_ < var_218_19 + var_218_20 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_19) / var_218_20

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_19 + var_218_20 and arg_215_1.time_ < var_218_19 + var_218_20 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play121441053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 121441053
		arg_221_1.duration_ = 5.97

		local var_221_0 = {
			ja = 5.2,
			ko = 5.966,
			zh = 5.966
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play121441054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1075ui_story = arg_221_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1075ui_story"].transform.position).z)
				arg_221_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1075ui_story"].transform.localEulerAngles = arg_221_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_221_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1075ui_story"].transform.position).z)
				arg_221_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1075ui_story"].transform.localEulerAngles = arg_221_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_224_1 = arg_221_1.actors_["1075ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1075ui_story == nil then
				arg_221_1.var_.characterEffect1075ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_2 and not isNil(var_224_1) then
				if arg_221_1.var_.characterEffect1075ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_2 and arg_221_1.time_ < 0 + var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1075ui_story then
				arg_221_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_224_4 = 0
			local var_224_5 = 0.3

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_6 = arg_221_1:GetWordFromCfg(121441053)
				local var_224_7 = arg_221_1:FormatText(var_224_6.content)

				arg_221_1.text_.text = var_224_7

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_9 = 12 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 12)

				if (12 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 12)) > 0 and var_224_5 < var_224_9 then
					arg_221_1.talkMaxDuration = var_224_9

					if var_224_9 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_9 + var_224_4
					end
				end

				arg_221_1.text_.text = var_224_7
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441053", "story_v_out_121441.awb") ~= 0 then
					local var_224_10 = manager.audio:GetVoiceLength("story_v_out_121441", "121441053", "story_v_out_121441.awb") / 1000

					if var_224_10 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_4
					end

					if var_224_6.prefab_name ~= "" and arg_221_1.actors_[var_224_6.prefab_name] ~= nil then
						local var_224_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_6.prefab_name].transform, "story_v_out_121441", "121441053", "story_v_out_121441.awb")

						arg_221_1:RecordAudio("121441053", var_224_11)
						arg_221_1:RecordAudio("121441053", var_224_11)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_121441", "121441053", "story_v_out_121441.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_121441", "121441053", "story_v_out_121441.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_12 = math.max(var_224_5, arg_221_1.talkMaxDuration)

			if var_224_4 <= arg_221_1.time_ and arg_221_1.time_ < var_224_4 + var_224_12 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_4) / var_224_12

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_4 + var_224_12 and arg_221_1.time_ < var_224_4 + var_224_12 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play121441054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 121441054
		arg_225_1.duration_ = 9.1

		local var_225_0 = {
			ja = 9.1,
			ko = 6.066,
			zh = 6.066
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play121441055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 2 < arg_225_1.time_ and arg_225_1.time_ <= 2 + arg_228_0 then
				local var_228_0 = arg_225_1.bgs_.ST42

				arg_225_1.bgs_.ST42.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_228_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_228_1 = var_228_0:GetComponent("SpriteRenderer")

				if var_228_1 and var_228_1.sprite then
					local var_228_2 = 2 * (var_228_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_228_0.transform.localScale = Vector3.New(var_228_2 / var_228_1.sprite.bounds.size.y < var_228_2 * manager.ui.mainCameraCom_.aspect / var_228_1.sprite.bounds.size.x and var_228_2 * manager.ui.mainCameraCom_.aspect / var_228_1.sprite.bounds.size.x or var_228_2 / var_228_1.sprite.bounds.size.y, var_228_2 / var_228_1.sprite.bounds.size.y < var_228_2 * manager.ui.mainCameraCom_.aspect / var_228_1.sprite.bounds.size.x and var_228_2 * manager.ui.mainCameraCom_.aspect / var_228_1.sprite.bounds.size.x or var_228_2 / var_228_1.sprite.bounds.size.y, 0)
				end

				for iter_228_0, iter_228_1 in pairs(arg_225_1.bgs_) do
					if iter_228_0 ~= "ST42" then
						iter_228_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_228_3 = 0

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_3 + arg_228_0 then
				arg_225_1.mask_.enabled = true
				arg_225_1.mask_.raycastTarget = true

				arg_225_1:SetGaussion(false)
			end

			local var_228_4 = 2

			if var_228_3 <= arg_225_1.time_ and arg_225_1.time_ < var_228_3 + var_228_4 then
				local var_228_5 = Color.New(0, 0, 0)

				var_228_5.a = Mathf.Lerp(0, 1, (arg_225_1.time_ - var_228_3) / var_228_4)
				arg_225_1.mask_.color = var_228_5
			end

			if arg_225_1.time_ >= var_228_3 + var_228_4 and arg_225_1.time_ < var_228_3 + var_228_4 + arg_228_0 then
				local var_228_6 = Color.New(0, 0, 0)

				var_228_6.a = 1
				arg_225_1.mask_.color = var_228_6
			end

			local var_228_7 = 2

			if 2 < arg_225_1.time_ and arg_225_1.time_ <= var_228_7 + arg_228_0 then
				arg_225_1.mask_.enabled = true
				arg_225_1.mask_.raycastTarget = true

				arg_225_1:SetGaussion(false)
			end

			local var_228_8 = 2

			if var_228_7 <= arg_225_1.time_ and arg_225_1.time_ < var_228_7 + var_228_8 then
				local var_228_9 = Color.New(0, 0, 0)

				var_228_9.a = Mathf.Lerp(1, 0, (arg_225_1.time_ - var_228_7) / var_228_8)
				arg_225_1.mask_.color = var_228_9
			end

			if arg_225_1.time_ >= var_228_7 + var_228_8 and arg_225_1.time_ < var_228_7 + var_228_8 + arg_228_0 then
				local var_228_10 = Color.New(0, 0, 0)

				arg_225_1.mask_.enabled = false
				var_228_10.a = 0
				arg_225_1.mask_.color = var_228_10
			end

			local var_228_11 = arg_225_1.actors_["1075ui_story"].transform

			if 1.96599999815226 < arg_225_1.time_ and arg_225_1.time_ <= 1.96599999815226 + arg_228_0 then
				arg_225_1.var_.moveOldPos1075ui_story = var_228_11.localPosition
			end

			local var_228_12 = 0.001

			if 1.96599999815226 <= arg_225_1.time_ and arg_225_1.time_ < 1.96599999815226 + var_228_12 then
				var_228_11.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_225_1.time_ - 1.96599999815226) / var_228_12)
				var_228_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_11.position).x, (manager.ui.mainCamera.transform.position - var_228_11.position).y, (manager.ui.mainCamera.transform.position - var_228_11.position).z)
				var_228_11.localEulerAngles.z = 0
				var_228_11.localEulerAngles.x = 0
				var_228_11.localEulerAngles = var_228_11.localEulerAngles
			end

			if arg_225_1.time_ >= 1.96599999815226 + var_228_12 and arg_225_1.time_ < 1.96599999815226 + var_228_12 + arg_228_0 then
				var_228_11.localPosition = Vector3.New(0, 100, 0)
				var_228_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_11.position).x, (manager.ui.mainCamera.transform.position - var_228_11.position).y, (manager.ui.mainCamera.transform.position - var_228_11.position).z)
				var_228_11.localEulerAngles.z = 0
				var_228_11.localEulerAngles.x = 0
				var_228_11.localEulerAngles = var_228_11.localEulerAngles
			end

			if arg_225_1.frameCnt_ <= 1 then
				arg_225_1.dialog_:SetActive(false)
			end

			local var_228_13 = 4
			local var_228_14 = 0.25

			if 4 < arg_225_1.time_ and arg_225_1.time_ <= var_228_13 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0

				arg_225_1.dialog_:SetActive(true)

				arg_225_1.dialogCg_.alpha = 0

				local var_228_15 = LeanTween.value(arg_225_1.dialog_, 0, 1, 0.3)

				var_228_15:setOnUpdate(LuaHelper.FloatAction(function(arg_229_0)
					arg_225_1.dialogCg_.alpha = arg_229_0
				end))
				var_228_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_225_1.dialog_)
					var_228_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_225_1.duration_ = arg_225_1.duration_ + 0.3

				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[407].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_16 = arg_225_1:GetWordFromCfg(121441054)
				local var_228_17 = arg_225_1:FormatText(var_228_16.content)

				arg_225_1.text_.text = var_228_17

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_19 = 10 <= 0 and var_228_14 or var_228_14 * (utf8.len(var_228_17) / 10)

				if (10 <= 0 and var_228_14 or var_228_14 * (utf8.len(var_228_17) / 10)) > 0 and var_228_14 < var_228_19 then
					arg_225_1.talkMaxDuration = var_228_19
					var_228_13 = var_228_13 + 0.3

					if var_228_19 + var_228_13 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_19 + var_228_13
					end
				end

				arg_225_1.text_.text = var_228_17
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441054", "story_v_out_121441.awb") ~= 0 then
					local var_228_20 = manager.audio:GetVoiceLength("story_v_out_121441", "121441054", "story_v_out_121441.awb") / 1000

					if var_228_20 + var_228_13 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_20 + var_228_13
					end

					if var_228_16.prefab_name ~= "" and arg_225_1.actors_[var_228_16.prefab_name] ~= nil then
						local var_228_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_16.prefab_name].transform, "story_v_out_121441", "121441054", "story_v_out_121441.awb")

						arg_225_1:RecordAudio("121441054", var_228_21)
						arg_225_1:RecordAudio("121441054", var_228_21)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_121441", "121441054", "story_v_out_121441.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_121441", "121441054", "story_v_out_121441.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_22 = var_228_13 + 0.3
			local var_228_23 = math.max(var_228_14, arg_225_1.talkMaxDuration)

			if var_228_13 + 0.3 <= arg_225_1.time_ and arg_225_1.time_ < var_228_22 + var_228_23 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_22) / var_228_23

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_22 + var_228_23 and arg_225_1.time_ < var_228_22 + var_228_23 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play121441055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 121441055
		arg_231_1.duration_ = 5.73

		local var_231_0 = {
			ja = 5.733,
			ko = 4.5,
			zh = 4.5
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play121441056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0.425

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[407].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_1 = arg_231_1:GetWordFromCfg(121441055)
				local var_234_2 = arg_231_1:FormatText(var_234_1.content)

				arg_231_1.text_.text = var_234_2

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_4 = 17 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 17)

				if (17 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 17)) > 0 and var_234_0 < var_234_4 then
					arg_231_1.talkMaxDuration = var_234_4

					if var_234_4 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_4 + 0
					end
				end

				arg_231_1.text_.text = var_234_2
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441055", "story_v_out_121441.awb") ~= 0 then
					local var_234_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441055", "story_v_out_121441.awb") / 1000

					if var_234_5 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + 0
					end

					if var_234_1.prefab_name ~= "" and arg_231_1.actors_[var_234_1.prefab_name] ~= nil then
						local var_234_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_1.prefab_name].transform, "story_v_out_121441", "121441055", "story_v_out_121441.awb")

						arg_231_1:RecordAudio("121441055", var_234_6)
						arg_231_1:RecordAudio("121441055", var_234_6)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_121441", "121441055", "story_v_out_121441.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_121441", "121441055", "story_v_out_121441.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_7 = math.max(var_234_0, arg_231_1.talkMaxDuration)

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_7 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - 0) / var_234_7

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= 0 + var_234_7 and arg_231_1.time_ < 0 + var_234_7 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play121441056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 121441056
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play121441057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.7

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_1 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(121441056).content)

				arg_235_1.text_.text = var_238_1

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_3 = 28 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 28)

				if (28 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 28)) > 0 and var_238_0 < var_238_3 then
					arg_235_1.talkMaxDuration = var_238_3

					if var_238_3 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_3 + 0
					end
				end

				arg_235_1.text_.text = var_238_1
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_4 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_4

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play121441057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 121441057
		arg_239_1.duration_ = 8.1

		local var_239_0 = {
			ja = 8.1,
			ko = 7.333,
			zh = 7.333
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play121441058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.75

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[407].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_1 = arg_239_1:GetWordFromCfg(121441057)
				local var_242_2 = arg_239_1:FormatText(var_242_1.content)

				arg_239_1.text_.text = var_242_2

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 30 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 30)

				if (30 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 30)) > 0 and var_242_0 < var_242_4 then
					arg_239_1.talkMaxDuration = var_242_4

					if var_242_4 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_4 + 0
					end
				end

				arg_239_1.text_.text = var_242_2
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441057", "story_v_out_121441.awb") ~= 0 then
					local var_242_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441057", "story_v_out_121441.awb") / 1000

					if var_242_5 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + 0
					end

					if var_242_1.prefab_name ~= "" and arg_239_1.actors_[var_242_1.prefab_name] ~= nil then
						local var_242_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_1.prefab_name].transform, "story_v_out_121441", "121441057", "story_v_out_121441.awb")

						arg_239_1:RecordAudio("121441057", var_242_6)
						arg_239_1:RecordAudio("121441057", var_242_6)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_121441", "121441057", "story_v_out_121441.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_121441", "121441057", "story_v_out_121441.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_7 and arg_239_1.time_ < 0 + var_242_7 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play121441058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 121441058
		arg_243_1.duration_ = 9.2

		local var_243_0 = {
			ja = 9.2,
			ko = 5.1,
			zh = 5.1
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play121441059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if arg_243_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_246_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_243_1.stage_.transform)

				var_246_0.name = "1084ui_story"
				var_246_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_243_1.actors_["1084ui_story"] = var_246_0

				local var_246_1 = var_246_0:GetComponentInChildren(typeof(CharacterEffect))

				var_246_1.enabled = true

				local var_246_2 = GameObjectTools.GetOrAddComponent(var_246_0, typeof(DynamicBoneHelper))

				if var_246_2 then
					var_246_2:EnableDynamicBone(false)
				end

				arg_243_1:ShowWeapon(var_246_1.transform, false)

				arg_243_1.var_["1084ui_story" .. "Animator"] = var_246_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_243_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_243_1.var_["1084ui_story" .. "LipSync"] = var_246_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_246_3 = arg_243_1.actors_["1084ui_story"].transform

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1084ui_story = var_246_3.localPosition
			end

			local var_246_4 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_4 then
				var_246_3.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_243_1.time_ - 0) / var_246_4)
				var_246_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_246_3.position).x, (manager.ui.mainCamera.transform.position - var_246_3.position).y, (manager.ui.mainCamera.transform.position - var_246_3.position).z)
				var_246_3.localEulerAngles.z = 0
				var_246_3.localEulerAngles.x = 0
				var_246_3.localEulerAngles = var_246_3.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_4 and arg_243_1.time_ < 0 + var_246_4 + arg_246_0 then
				var_246_3.localPosition = Vector3.New(0, -0.97, -6)
				var_246_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_246_3.position).x, (manager.ui.mainCamera.transform.position - var_246_3.position).y, (manager.ui.mainCamera.transform.position - var_246_3.position).z)
				var_246_3.localEulerAngles.z = 0
				var_246_3.localEulerAngles.x = 0
				var_246_3.localEulerAngles = var_246_3.localEulerAngles
			end

			local var_246_5 = arg_243_1.actors_["1084ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_5) and arg_243_1.var_.characterEffect1084ui_story == nil then
				arg_243_1.var_.characterEffect1084ui_story = var_246_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_6 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_6 and not isNil(var_246_5) then
				if arg_243_1.var_.characterEffect1084ui_story and not isNil(var_246_5) then
					arg_243_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_6 and arg_243_1.time_ < 0 + var_246_6 + arg_246_0 and not isNil(var_246_5) and arg_243_1.var_.characterEffect1084ui_story then
				arg_243_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_246_8 = 0
			local var_246_9 = 0.625

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_8 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_10 = arg_243_1:GetWordFromCfg(121441058)
				local var_246_11 = arg_243_1:FormatText(var_246_10.content)

				arg_243_1.text_.text = var_246_11

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_13 = 24 <= 0 and var_246_9 or var_246_9 * (utf8.len(var_246_11) / 24)

				if (24 <= 0 and var_246_9 or var_246_9 * (utf8.len(var_246_11) / 24)) > 0 and var_246_9 < var_246_13 then
					arg_243_1.talkMaxDuration = var_246_13

					if var_246_13 + var_246_8 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_13 + var_246_8
					end
				end

				arg_243_1.text_.text = var_246_11
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441058", "story_v_out_121441.awb") ~= 0 then
					local var_246_14 = manager.audio:GetVoiceLength("story_v_out_121441", "121441058", "story_v_out_121441.awb") / 1000

					if var_246_14 + var_246_8 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_14 + var_246_8
					end

					if var_246_10.prefab_name ~= "" and arg_243_1.actors_[var_246_10.prefab_name] ~= nil then
						local var_246_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_10.prefab_name].transform, "story_v_out_121441", "121441058", "story_v_out_121441.awb")

						arg_243_1:RecordAudio("121441058", var_246_15)
						arg_243_1:RecordAudio("121441058", var_246_15)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_121441", "121441058", "story_v_out_121441.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_121441", "121441058", "story_v_out_121441.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_16 = math.max(var_246_9, arg_243_1.talkMaxDuration)

			if var_246_8 <= arg_243_1.time_ and arg_243_1.time_ < var_246_8 + var_246_16 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_8) / var_246_16

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_8 + var_246_16 and arg_243_1.time_ < var_246_8 + var_246_16 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play121441059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 121441059
		arg_247_1.duration_ = 6.13

		local var_247_0 = {
			ja = 6.133,
			ko = 4.2,
			zh = 4.2
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play121441060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["1084ui_story"]) and arg_247_1.var_.characterEffect1084ui_story == nil then
				arg_247_1.var_.characterEffect1084ui_story = arg_247_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["1084ui_story"]) then
				if arg_247_1.var_.characterEffect1084ui_story and not isNil(arg_247_1.actors_["1084ui_story"]) then
					arg_247_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_0)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["1084ui_story"]) and arg_247_1.var_.characterEffect1084ui_story then
				arg_247_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_250_1 = 0
			local var_250_2 = 0.55

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[407].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_3 = arg_247_1:GetWordFromCfg(121441059)
				local var_250_4 = arg_247_1:FormatText(var_250_3.content)

				arg_247_1.text_.text = var_250_4

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_6 = 22 <= 0 and var_250_2 or var_250_2 * (utf8.len(var_250_4) / 22)

				if (22 <= 0 and var_250_2 or var_250_2 * (utf8.len(var_250_4) / 22)) > 0 and var_250_2 < var_250_6 then
					arg_247_1.talkMaxDuration = var_250_6

					if var_250_6 + var_250_1 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_6 + var_250_1
					end
				end

				arg_247_1.text_.text = var_250_4
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441059", "story_v_out_121441.awb") ~= 0 then
					local var_250_7 = manager.audio:GetVoiceLength("story_v_out_121441", "121441059", "story_v_out_121441.awb") / 1000

					if var_250_7 + var_250_1 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_1
					end

					if var_250_3.prefab_name ~= "" and arg_247_1.actors_[var_250_3.prefab_name] ~= nil then
						local var_250_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_3.prefab_name].transform, "story_v_out_121441", "121441059", "story_v_out_121441.awb")

						arg_247_1:RecordAudio("121441059", var_250_8)
						arg_247_1:RecordAudio("121441059", var_250_8)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_121441", "121441059", "story_v_out_121441.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_121441", "121441059", "story_v_out_121441.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_9 = math.max(var_250_2, arg_247_1.talkMaxDuration)

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_9 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_1) / var_250_9

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_1 + var_250_9 and arg_247_1.time_ < var_250_1 + var_250_9 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play121441060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 121441060
		arg_251_1.duration_ = 3.6

		local var_251_0 = {
			ja = 3.6,
			ko = 3.2,
			zh = 3.2
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play121441061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1076ui_story = arg_251_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_254_0 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 then
				arg_251_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_251_1.time_ - 0) / var_254_0)
				arg_251_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1076ui_story"].transform.position).z)
				arg_251_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1076ui_story"].transform.localEulerAngles = arg_251_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 then
				arg_251_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_251_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1076ui_story"].transform.position).z)
				arg_251_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1076ui_story"].transform.localEulerAngles = arg_251_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_254_1 = arg_251_1.actors_["1076ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect1076ui_story == nil then
				arg_251_1.var_.characterEffect1076ui_story = var_254_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_2 and not isNil(var_254_1) then
				if arg_251_1.var_.characterEffect1076ui_story and not isNil(var_254_1) then
					arg_251_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_2 and arg_251_1.time_ < 0 + var_254_2 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect1076ui_story then
				arg_251_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_254_4 = arg_251_1.actors_["1084ui_story"].transform

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1084ui_story = var_254_4.localPosition
			end

			local var_254_5 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_5 then
				var_254_4.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_251_1.time_ - 0) / var_254_5)
				var_254_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_254_4.position).x, (manager.ui.mainCamera.transform.position - var_254_4.position).y, (manager.ui.mainCamera.transform.position - var_254_4.position).z)
				var_254_4.localEulerAngles.z = 0
				var_254_4.localEulerAngles.x = 0
				var_254_4.localEulerAngles = var_254_4.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_5 and arg_251_1.time_ < 0 + var_254_5 + arg_254_0 then
				var_254_4.localPosition = Vector3.New(0, 100, 0)
				var_254_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_254_4.position).x, (manager.ui.mainCamera.transform.position - var_254_4.position).y, (manager.ui.mainCamera.transform.position - var_254_4.position).z)
				var_254_4.localEulerAngles.z = 0
				var_254_4.localEulerAngles.x = 0
				var_254_4.localEulerAngles = var_254_4.localEulerAngles
			end

			local var_254_6 = arg_251_1.actors_["1084ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_6) and arg_251_1.var_.characterEffect1084ui_story == nil then
				arg_251_1.var_.characterEffect1084ui_story = var_254_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_7 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_7 and not isNil(var_254_6) then
				if arg_251_1.var_.characterEffect1084ui_story and not isNil(var_254_6) then
					arg_251_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_7)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_7 and arg_251_1.time_ < 0 + var_254_7 + arg_254_0 and not isNil(var_254_6) and arg_251_1.var_.characterEffect1084ui_story then
				arg_251_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_254_8 = 0
			local var_254_9 = 0.375

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_8 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_10 = arg_251_1:GetWordFromCfg(121441060)
				local var_254_11 = arg_251_1:FormatText(var_254_10.content)

				arg_251_1.text_.text = var_254_11

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_13 = 15 <= 0 and var_254_9 or var_254_9 * (utf8.len(var_254_11) / 15)

				if (15 <= 0 and var_254_9 or var_254_9 * (utf8.len(var_254_11) / 15)) > 0 and var_254_9 < var_254_13 then
					arg_251_1.talkMaxDuration = var_254_13

					if var_254_13 + var_254_8 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_13 + var_254_8
					end
				end

				arg_251_1.text_.text = var_254_11
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441060", "story_v_out_121441.awb") ~= 0 then
					local var_254_14 = manager.audio:GetVoiceLength("story_v_out_121441", "121441060", "story_v_out_121441.awb") / 1000

					if var_254_14 + var_254_8 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_14 + var_254_8
					end

					if var_254_10.prefab_name ~= "" and arg_251_1.actors_[var_254_10.prefab_name] ~= nil then
						local var_254_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_10.prefab_name].transform, "story_v_out_121441", "121441060", "story_v_out_121441.awb")

						arg_251_1:RecordAudio("121441060", var_254_15)
						arg_251_1:RecordAudio("121441060", var_254_15)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_121441", "121441060", "story_v_out_121441.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_121441", "121441060", "story_v_out_121441.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_16 = math.max(var_254_9, arg_251_1.talkMaxDuration)

			if var_254_8 <= arg_251_1.time_ and arg_251_1.time_ < var_254_8 + var_254_16 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_8) / var_254_16

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_8 + var_254_16 and arg_251_1.time_ < var_254_8 + var_254_16 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play121441061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 121441061
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play121441062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos1076ui_story = arg_255_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_258_0 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 then
				arg_255_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_255_1.time_ - 0) / var_258_0)
				arg_255_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1076ui_story"].transform.position).z)
				arg_255_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["1076ui_story"].transform.localEulerAngles = arg_255_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 then
				arg_255_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_255_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1076ui_story"].transform.position).z)
				arg_255_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["1076ui_story"].transform.localEulerAngles = arg_255_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_258_1 = arg_255_1.actors_["1076ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect1076ui_story == nil then
				arg_255_1.var_.characterEffect1076ui_story = var_258_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_2 and not isNil(var_258_1) then
				if arg_255_1.var_.characterEffect1076ui_story and not isNil(var_258_1) then
					arg_255_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_2)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_2 and arg_255_1.time_ < 0 + var_258_2 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect1076ui_story then
				arg_255_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_258_3 = 0
			local var_258_4 = 0.9

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_3 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_5 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(121441061).content)

				arg_255_1.text_.text = var_258_5

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_7 = 36 <= 0 and var_258_4 or var_258_4 * (utf8.len(var_258_5) / 36)

				if (36 <= 0 and var_258_4 or var_258_4 * (utf8.len(var_258_5) / 36)) > 0 and var_258_4 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_3 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_3
					end
				end

				arg_255_1.text_.text = var_258_5
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_8 = math.max(var_258_4, arg_255_1.talkMaxDuration)

			if var_258_3 <= arg_255_1.time_ and arg_255_1.time_ < var_258_3 + var_258_8 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_3) / var_258_8

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_3 + var_258_8 and arg_255_1.time_ < var_258_3 + var_258_8 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play121441062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 121441062
		arg_259_1.duration_ = 3.33

		local var_259_0 = {
			ja = 3.333,
			ko = 2.366,
			zh = 2.366
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play121441063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.225

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[407].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_1 = arg_259_1:GetWordFromCfg(121441062)
				local var_262_2 = arg_259_1:FormatText(var_262_1.content)

				arg_259_1.text_.text = var_262_2

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_4 = 9 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 9)

				if (9 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 9)) > 0 and var_262_0 < var_262_4 then
					arg_259_1.talkMaxDuration = var_262_4

					if var_262_4 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_4 + 0
					end
				end

				arg_259_1.text_.text = var_262_2
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441062", "story_v_out_121441.awb") ~= 0 then
					local var_262_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441062", "story_v_out_121441.awb") / 1000

					if var_262_5 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + 0
					end

					if var_262_1.prefab_name ~= "" and arg_259_1.actors_[var_262_1.prefab_name] ~= nil then
						local var_262_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_1.prefab_name].transform, "story_v_out_121441", "121441062", "story_v_out_121441.awb")

						arg_259_1:RecordAudio("121441062", var_262_6)
						arg_259_1:RecordAudio("121441062", var_262_6)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_121441", "121441062", "story_v_out_121441.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_121441", "121441062", "story_v_out_121441.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_7 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_7 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_7

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_7 and arg_259_1.time_ < 0 + var_262_7 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play121441063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 121441063
		arg_263_1.duration_ = 10.17

		local var_263_0 = {
			ja = 10.166,
			ko = 5,
			zh = 5
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play121441064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1084ui_story = arg_263_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1084ui_story"].transform.position).z)
				arg_263_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1084ui_story"].transform.localEulerAngles = arg_263_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_263_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1084ui_story"].transform.position).z)
				arg_263_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1084ui_story"].transform.localEulerAngles = arg_263_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_266_1 = arg_263_1.actors_["1084ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1084ui_story == nil then
				arg_263_1.var_.characterEffect1084ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect1084ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1084ui_story then
				arg_263_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_266_4 = 0
			local var_266_5 = 0.625

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_6 = arg_263_1:GetWordFromCfg(121441063)
				local var_266_7 = arg_263_1:FormatText(var_266_6.content)

				arg_263_1.text_.text = var_266_7

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_9 = 25 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 25)

				if (25 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 25)) > 0 and var_266_5 < var_266_9 then
					arg_263_1.talkMaxDuration = var_266_9

					if var_266_9 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_9 + var_266_4
					end
				end

				arg_263_1.text_.text = var_266_7
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441063", "story_v_out_121441.awb") ~= 0 then
					local var_266_10 = manager.audio:GetVoiceLength("story_v_out_121441", "121441063", "story_v_out_121441.awb") / 1000

					if var_266_10 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_10 + var_266_4
					end

					if var_266_6.prefab_name ~= "" and arg_263_1.actors_[var_266_6.prefab_name] ~= nil then
						local var_266_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_6.prefab_name].transform, "story_v_out_121441", "121441063", "story_v_out_121441.awb")

						arg_263_1:RecordAudio("121441063", var_266_11)
						arg_263_1:RecordAudio("121441063", var_266_11)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_121441", "121441063", "story_v_out_121441.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_121441", "121441063", "story_v_out_121441.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_12 = math.max(var_266_5, arg_263_1.talkMaxDuration)

			if var_266_4 <= arg_263_1.time_ and arg_263_1.time_ < var_266_4 + var_266_12 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_4) / var_266_12

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_4 + var_266_12 and arg_263_1.time_ < var_266_4 + var_266_12 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play121441064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 121441064
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play121441065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["1084ui_story"]) and arg_267_1.var_.characterEffect1084ui_story == nil then
				arg_267_1.var_.characterEffect1084ui_story = arg_267_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_0 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["1084ui_story"]) then
				if arg_267_1.var_.characterEffect1084ui_story and not isNil(arg_267_1.actors_["1084ui_story"]) then
					arg_267_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_0)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["1084ui_story"]) and arg_267_1.var_.characterEffect1084ui_story then
				arg_267_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_270_1 = 0
			local var_270_2 = 0.8

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_3 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(121441064).content)

				arg_267_1.text_.text = var_270_3

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 32 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 32)

				if (32 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 32)) > 0 and var_270_2 < var_270_5 then
					arg_267_1.talkMaxDuration = var_270_5

					if var_270_5 + var_270_1 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + var_270_1
					end
				end

				arg_267_1.text_.text = var_270_3
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_6 = math.max(var_270_2, arg_267_1.talkMaxDuration)

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_6 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_1) / var_270_6

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_1 + var_270_6 and arg_267_1.time_ < var_270_1 + var_270_6 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play121441065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 121441065
		arg_271_1.duration_ = 4.77

		local var_271_0 = {
			ja = 4.766,
			ko = 3.533,
			zh = 3.533
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play121441066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1084ui_story = arg_271_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_274_0 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 then
				arg_271_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_271_1.time_ - 0) / var_274_0)
				arg_271_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1084ui_story"].transform.position).z)
				arg_271_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1084ui_story"].transform.localEulerAngles = arg_271_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 then
				arg_271_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_271_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1084ui_story"].transform.position).z)
				arg_271_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1084ui_story"].transform.localEulerAngles = arg_271_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_274_1 = arg_271_1.actors_["1084ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect1084ui_story == nil then
				arg_271_1.var_.characterEffect1084ui_story = var_274_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_2 and not isNil(var_274_1) then
				if arg_271_1.var_.characterEffect1084ui_story and not isNil(var_274_1) then
					arg_271_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_271_1.time_ - 0) / var_274_2)
				end
			end

			if arg_271_1.time_ >= 0 + var_274_2 and arg_271_1.time_ < 0 + var_274_2 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect1084ui_story then
				arg_271_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_274_3 = arg_271_1.actors_["1076ui_story"].transform

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1076ui_story = var_274_3.localPosition
			end

			local var_274_4 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				var_274_3.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_271_1.time_ - 0) / var_274_4)
				var_274_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_3.position).x, (manager.ui.mainCamera.transform.position - var_274_3.position).y, (manager.ui.mainCamera.transform.position - var_274_3.position).z)
				var_274_3.localEulerAngles.z = 0
				var_274_3.localEulerAngles.x = 0
				var_274_3.localEulerAngles = var_274_3.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				var_274_3.localPosition = Vector3.New(0, -1.06, -6.2)
				var_274_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_3.position).x, (manager.ui.mainCamera.transform.position - var_274_3.position).y, (manager.ui.mainCamera.transform.position - var_274_3.position).z)
				var_274_3.localEulerAngles.z = 0
				var_274_3.localEulerAngles.x = 0
				var_274_3.localEulerAngles = var_274_3.localEulerAngles
			end

			local var_274_5 = arg_271_1.actors_["1076ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_5) and arg_271_1.var_.characterEffect1076ui_story == nil then
				arg_271_1.var_.characterEffect1076ui_story = var_274_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_6 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_6 and not isNil(var_274_5) then
				if arg_271_1.var_.characterEffect1076ui_story and not isNil(var_274_5) then
					arg_271_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_6 and arg_271_1.time_ < 0 + var_274_6 + arg_274_0 and not isNil(var_274_5) and arg_271_1.var_.characterEffect1076ui_story then
				arg_271_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action5_1")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_274_8 = 0
			local var_274_9 = 0.375

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_8 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_10 = arg_271_1:GetWordFromCfg(121441065)
				local var_274_11 = arg_271_1:FormatText(var_274_10.content)

				arg_271_1.text_.text = var_274_11

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_13 = 15 <= 0 and var_274_9 or var_274_9 * (utf8.len(var_274_11) / 15)

				if (15 <= 0 and var_274_9 or var_274_9 * (utf8.len(var_274_11) / 15)) > 0 and var_274_9 < var_274_13 then
					arg_271_1.talkMaxDuration = var_274_13

					if var_274_13 + var_274_8 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_13 + var_274_8
					end
				end

				arg_271_1.text_.text = var_274_11
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441065", "story_v_out_121441.awb") ~= 0 then
					local var_274_14 = manager.audio:GetVoiceLength("story_v_out_121441", "121441065", "story_v_out_121441.awb") / 1000

					if var_274_14 + var_274_8 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_14 + var_274_8
					end

					if var_274_10.prefab_name ~= "" and arg_271_1.actors_[var_274_10.prefab_name] ~= nil then
						local var_274_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_10.prefab_name].transform, "story_v_out_121441", "121441065", "story_v_out_121441.awb")

						arg_271_1:RecordAudio("121441065", var_274_15)
						arg_271_1:RecordAudio("121441065", var_274_15)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_121441", "121441065", "story_v_out_121441.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_121441", "121441065", "story_v_out_121441.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_16 = math.max(var_274_9, arg_271_1.talkMaxDuration)

			if var_274_8 <= arg_271_1.time_ and arg_271_1.time_ < var_274_8 + var_274_16 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_8) / var_274_16

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_8 + var_274_16 and arg_271_1.time_ < var_274_8 + var_274_16 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play121441066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 121441066
		arg_275_1.duration_ = 6.97

		local var_275_0 = {
			ja = 6.966,
			ko = 5.066,
			zh = 5.066
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play121441067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos1076ui_story = arg_275_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_278_0 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 then
				arg_275_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_275_1.time_ - 0) / var_278_0)
				arg_275_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1076ui_story"].transform.position).z)
				arg_275_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1076ui_story"].transform.localEulerAngles = arg_275_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 then
				arg_275_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_275_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1076ui_story"].transform.position).z)
				arg_275_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1076ui_story"].transform.localEulerAngles = arg_275_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_278_1 = arg_275_1.actors_["1076ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1076ui_story == nil then
				arg_275_1.var_.characterEffect1076ui_story = var_278_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_2 and not isNil(var_278_1) then
				if arg_275_1.var_.characterEffect1076ui_story and not isNil(var_278_1) then
					arg_275_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_2)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_2 and arg_275_1.time_ < 0 + var_278_2 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1076ui_story then
				arg_275_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_278_3 = arg_275_1.actors_["1075ui_story"].transform

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos1075ui_story = var_278_3.localPosition
			end

			local var_278_4 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_4 then
				var_278_3.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_275_1.time_ - 0) / var_278_4)
				var_278_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_3.position).x, (manager.ui.mainCamera.transform.position - var_278_3.position).y, (manager.ui.mainCamera.transform.position - var_278_3.position).z)
				var_278_3.localEulerAngles.z = 0
				var_278_3.localEulerAngles.x = 0
				var_278_3.localEulerAngles = var_278_3.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_4 and arg_275_1.time_ < 0 + var_278_4 + arg_278_0 then
				var_278_3.localPosition = Vector3.New(0, -1.055, -6.16)
				var_278_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_3.position).x, (manager.ui.mainCamera.transform.position - var_278_3.position).y, (manager.ui.mainCamera.transform.position - var_278_3.position).z)
				var_278_3.localEulerAngles.z = 0
				var_278_3.localEulerAngles.x = 0
				var_278_3.localEulerAngles = var_278_3.localEulerAngles
			end

			local var_278_5 = arg_275_1.actors_["1075ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_5) and arg_275_1.var_.characterEffect1075ui_story == nil then
				arg_275_1.var_.characterEffect1075ui_story = var_278_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_6 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_6 and not isNil(var_278_5) then
				if arg_275_1.var_.characterEffect1075ui_story and not isNil(var_278_5) then
					arg_275_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_6 and arg_275_1.time_ < 0 + var_278_6 + arg_278_0 and not isNil(var_278_5) and arg_275_1.var_.characterEffect1075ui_story then
				arg_275_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_278_8 = 0
			local var_278_9 = 0.55

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_8 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_10 = arg_275_1:GetWordFromCfg(121441066)
				local var_278_11 = arg_275_1:FormatText(var_278_10.content)

				arg_275_1.text_.text = var_278_11

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_13 = 22 <= 0 and var_278_9 or var_278_9 * (utf8.len(var_278_11) / 22)

				if (22 <= 0 and var_278_9 or var_278_9 * (utf8.len(var_278_11) / 22)) > 0 and var_278_9 < var_278_13 then
					arg_275_1.talkMaxDuration = var_278_13

					if var_278_13 + var_278_8 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_13 + var_278_8
					end
				end

				arg_275_1.text_.text = var_278_11
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441066", "story_v_out_121441.awb") ~= 0 then
					local var_278_14 = manager.audio:GetVoiceLength("story_v_out_121441", "121441066", "story_v_out_121441.awb") / 1000

					if var_278_14 + var_278_8 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_14 + var_278_8
					end

					if var_278_10.prefab_name ~= "" and arg_275_1.actors_[var_278_10.prefab_name] ~= nil then
						local var_278_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_10.prefab_name].transform, "story_v_out_121441", "121441066", "story_v_out_121441.awb")

						arg_275_1:RecordAudio("121441066", var_278_15)
						arg_275_1:RecordAudio("121441066", var_278_15)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_121441", "121441066", "story_v_out_121441.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_121441", "121441066", "story_v_out_121441.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_16 = math.max(var_278_9, arg_275_1.talkMaxDuration)

			if var_278_8 <= arg_275_1.time_ and arg_275_1.time_ < var_278_8 + var_278_16 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_8) / var_278_16

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_8 + var_278_16 and arg_275_1.time_ < var_278_8 + var_278_16 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play121441067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 121441067
		arg_279_1.duration_ = 5.57

		local var_279_0 = {
			ja = 4.033,
			ko = 5.566,
			zh = 5.566
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play121441068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["1075ui_story"]) and arg_279_1.var_.characterEffect1075ui_story == nil then
				arg_279_1.var_.characterEffect1075ui_story = arg_279_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["1075ui_story"]) then
				if arg_279_1.var_.characterEffect1075ui_story and not isNil(arg_279_1.actors_["1075ui_story"]) then
					arg_279_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_0)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["1075ui_story"]) and arg_279_1.var_.characterEffect1075ui_story then
				arg_279_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_282_1 = 0
			local var_282_2 = 0.65

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[407].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_3 = arg_279_1:GetWordFromCfg(121441067)
				local var_282_4 = arg_279_1:FormatText(var_282_3.content)

				arg_279_1.text_.text = var_282_4

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_6 = 26 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_4) / 26)

				if (26 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_4) / 26)) > 0 and var_282_2 < var_282_6 then
					arg_279_1.talkMaxDuration = var_282_6

					if var_282_6 + var_282_1 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_6 + var_282_1
					end
				end

				arg_279_1.text_.text = var_282_4
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441067", "story_v_out_121441.awb") ~= 0 then
					local var_282_7 = manager.audio:GetVoiceLength("story_v_out_121441", "121441067", "story_v_out_121441.awb") / 1000

					if var_282_7 + var_282_1 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_7 + var_282_1
					end

					if var_282_3.prefab_name ~= "" and arg_279_1.actors_[var_282_3.prefab_name] ~= nil then
						local var_282_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_3.prefab_name].transform, "story_v_out_121441", "121441067", "story_v_out_121441.awb")

						arg_279_1:RecordAudio("121441067", var_282_8)
						arg_279_1:RecordAudio("121441067", var_282_8)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_121441", "121441067", "story_v_out_121441.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_121441", "121441067", "story_v_out_121441.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_9 = math.max(var_282_2, arg_279_1.talkMaxDuration)

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_9 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_1) / var_282_9

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_1 + var_282_9 and arg_279_1.time_ < var_282_1 + var_282_9 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play121441068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 121441068
		arg_283_1.duration_ = 7.33

		local var_283_0 = {
			ja = 7.333,
			ko = 3.533,
			zh = 3.533
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play121441069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["1075ui_story"]) and arg_283_1.var_.characterEffect1075ui_story == nil then
				arg_283_1.var_.characterEffect1075ui_story = arg_283_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["1075ui_story"]) then
				if arg_283_1.var_.characterEffect1075ui_story and not isNil(arg_283_1.actors_["1075ui_story"]) then
					arg_283_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["1075ui_story"]) and arg_283_1.var_.characterEffect1075ui_story then
				arg_283_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_286_2 = 0
			local var_286_3 = 0.375

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_2 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_4 = arg_283_1:GetWordFromCfg(121441068)
				local var_286_5 = arg_283_1:FormatText(var_286_4.content)

				arg_283_1.text_.text = var_286_5

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_7 = 15 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_5) / 15)

				if (15 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_5) / 15)) > 0 and var_286_3 < var_286_7 then
					arg_283_1.talkMaxDuration = var_286_7

					if var_286_7 + var_286_2 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_7 + var_286_2
					end
				end

				arg_283_1.text_.text = var_286_5
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441068", "story_v_out_121441.awb") ~= 0 then
					local var_286_8 = manager.audio:GetVoiceLength("story_v_out_121441", "121441068", "story_v_out_121441.awb") / 1000

					if var_286_8 + var_286_2 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_8 + var_286_2
					end

					if var_286_4.prefab_name ~= "" and arg_283_1.actors_[var_286_4.prefab_name] ~= nil then
						local var_286_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_4.prefab_name].transform, "story_v_out_121441", "121441068", "story_v_out_121441.awb")

						arg_283_1:RecordAudio("121441068", var_286_9)
						arg_283_1:RecordAudio("121441068", var_286_9)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_121441", "121441068", "story_v_out_121441.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_121441", "121441068", "story_v_out_121441.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_10 = math.max(var_286_3, arg_283_1.talkMaxDuration)

			if var_286_2 <= arg_283_1.time_ and arg_283_1.time_ < var_286_2 + var_286_10 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_2) / var_286_10

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_2 + var_286_10 and arg_283_1.time_ < var_286_2 + var_286_10 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play121441069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 121441069
		arg_287_1.duration_ = 6.57

		local var_287_0 = {
			ja = 6.566,
			ko = 5.5,
			zh = 5.5
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play121441070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["1075ui_story"]) and arg_287_1.var_.characterEffect1075ui_story == nil then
				arg_287_1.var_.characterEffect1075ui_story = arg_287_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_0 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["1075ui_story"]) then
				if arg_287_1.var_.characterEffect1075ui_story and not isNil(arg_287_1.actors_["1075ui_story"]) then
					arg_287_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_0)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["1075ui_story"]) and arg_287_1.var_.characterEffect1075ui_story then
				arg_287_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_290_1 = 0
			local var_290_2 = 0.475

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[407].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_3 = arg_287_1:GetWordFromCfg(121441069)
				local var_290_4 = arg_287_1:FormatText(var_290_3.content)

				arg_287_1.text_.text = var_290_4

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_6 = 19 <= 0 and var_290_2 or var_290_2 * (utf8.len(var_290_4) / 19)

				if (19 <= 0 and var_290_2 or var_290_2 * (utf8.len(var_290_4) / 19)) > 0 and var_290_2 < var_290_6 then
					arg_287_1.talkMaxDuration = var_290_6

					if var_290_6 + var_290_1 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_6 + var_290_1
					end
				end

				arg_287_1.text_.text = var_290_4
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441069", "story_v_out_121441.awb") ~= 0 then
					local var_290_7 = manager.audio:GetVoiceLength("story_v_out_121441", "121441069", "story_v_out_121441.awb") / 1000

					if var_290_7 + var_290_1 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_7 + var_290_1
					end

					if var_290_3.prefab_name ~= "" and arg_287_1.actors_[var_290_3.prefab_name] ~= nil then
						local var_290_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_3.prefab_name].transform, "story_v_out_121441", "121441069", "story_v_out_121441.awb")

						arg_287_1:RecordAudio("121441069", var_290_8)
						arg_287_1:RecordAudio("121441069", var_290_8)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_121441", "121441069", "story_v_out_121441.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_121441", "121441069", "story_v_out_121441.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_9 = math.max(var_290_2, arg_287_1.talkMaxDuration)

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_9 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_1) / var_290_9

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_1 + var_290_9 and arg_287_1.time_ < var_290_1 + var_290_9 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play121441070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 121441070
		arg_291_1.duration_ = 9

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play121441071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 2 < arg_291_1.time_ and arg_291_1.time_ <= 2 + arg_294_0 then
				local var_294_0 = arg_291_1.bgs_.ST42

				arg_291_1.bgs_.ST42.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_294_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_294_1 = var_294_0:GetComponent("SpriteRenderer")

				if var_294_1 and var_294_1.sprite then
					local var_294_2 = 2 * (var_294_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_294_0.transform.localScale = Vector3.New(var_294_2 / var_294_1.sprite.bounds.size.y < var_294_2 * manager.ui.mainCameraCom_.aspect / var_294_1.sprite.bounds.size.x and var_294_2 * manager.ui.mainCameraCom_.aspect / var_294_1.sprite.bounds.size.x or var_294_2 / var_294_1.sprite.bounds.size.y, var_294_2 / var_294_1.sprite.bounds.size.y < var_294_2 * manager.ui.mainCameraCom_.aspect / var_294_1.sprite.bounds.size.x and var_294_2 * manager.ui.mainCameraCom_.aspect / var_294_1.sprite.bounds.size.x or var_294_2 / var_294_1.sprite.bounds.size.y, 0)
				end

				for iter_294_0, iter_294_1 in pairs(arg_291_1.bgs_) do
					if iter_294_0 ~= "ST42" then
						iter_294_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_294_3 = arg_291_1.actors_["1075ui_story"].transform

			if 2 < arg_291_1.time_ and arg_291_1.time_ <= 2 + arg_294_0 then
				arg_291_1.var_.moveOldPos1075ui_story = var_294_3.localPosition
			end

			local var_294_4 = 0.001

			if 2 <= arg_291_1.time_ and arg_291_1.time_ < 2 + var_294_4 then
				var_294_3.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_291_1.time_ - 2) / var_294_4)
				var_294_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_3.position).x, (manager.ui.mainCamera.transform.position - var_294_3.position).y, (manager.ui.mainCamera.transform.position - var_294_3.position).z)
				var_294_3.localEulerAngles.z = 0
				var_294_3.localEulerAngles.x = 0
				var_294_3.localEulerAngles = var_294_3.localEulerAngles
			end

			if arg_291_1.time_ >= 2 + var_294_4 and arg_291_1.time_ < 2 + var_294_4 + arg_294_0 then
				var_294_3.localPosition = Vector3.New(0, 100, 0)
				var_294_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_3.position).x, (manager.ui.mainCamera.transform.position - var_294_3.position).y, (manager.ui.mainCamera.transform.position - var_294_3.position).z)
				var_294_3.localEulerAngles.z = 0
				var_294_3.localEulerAngles.x = 0
				var_294_3.localEulerAngles = var_294_3.localEulerAngles
			end

			local var_294_5 = arg_291_1.actors_["1075ui_story"]

			if 2 < arg_291_1.time_ and arg_291_1.time_ <= 2 + arg_294_0 and not isNil(var_294_5) and arg_291_1.var_.characterEffect1075ui_story == nil then
				arg_291_1.var_.characterEffect1075ui_story = var_294_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_6 = 0.200000002980232

			if 2 <= arg_291_1.time_ and arg_291_1.time_ < 2 + var_294_6 and not isNil(var_294_5) then
				if arg_291_1.var_.characterEffect1075ui_story and not isNil(var_294_5) then
					arg_291_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_291_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 2) / var_294_6)
				end
			end

			if arg_291_1.time_ >= 2 + var_294_6 and arg_291_1.time_ < 2 + var_294_6 + arg_294_0 and not isNil(var_294_5) and arg_291_1.var_.characterEffect1075ui_story then
				arg_291_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_291_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_294_7 = 0

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_7 + arg_294_0 then
				arg_291_1.mask_.enabled = true
				arg_291_1.mask_.raycastTarget = true

				arg_291_1:SetGaussion(false)
			end

			local var_294_8 = 2

			if var_294_7 <= arg_291_1.time_ and arg_291_1.time_ < var_294_7 + var_294_8 then
				local var_294_9 = Color.New(0, 0, 0)

				var_294_9.a = Mathf.Lerp(0, 1, (arg_291_1.time_ - var_294_7) / var_294_8)
				arg_291_1.mask_.color = var_294_9
			end

			if arg_291_1.time_ >= var_294_7 + var_294_8 and arg_291_1.time_ < var_294_7 + var_294_8 + arg_294_0 then
				local var_294_10 = Color.New(0, 0, 0)

				var_294_10.a = 1
				arg_291_1.mask_.color = var_294_10
			end

			local var_294_11 = 2

			if 2 < arg_291_1.time_ and arg_291_1.time_ <= var_294_11 + arg_294_0 then
				arg_291_1.mask_.enabled = true
				arg_291_1.mask_.raycastTarget = true

				arg_291_1:SetGaussion(false)
			end

			local var_294_12 = 2

			if var_294_11 <= arg_291_1.time_ and arg_291_1.time_ < var_294_11 + var_294_12 then
				local var_294_13 = Color.New(0, 0, 0)

				var_294_13.a = Mathf.Lerp(1, 0, (arg_291_1.time_ - var_294_11) / var_294_12)
				arg_291_1.mask_.color = var_294_13
			end

			if arg_291_1.time_ >= var_294_11 + var_294_12 and arg_291_1.time_ < var_294_11 + var_294_12 + arg_294_0 then
				local var_294_14 = Color.New(0, 0, 0)

				arg_291_1.mask_.enabled = false
				var_294_14.a = 0
				arg_291_1.mask_.color = var_294_14
			end

			if arg_291_1.frameCnt_ <= 1 then
				arg_291_1.dialog_:SetActive(false)
			end

			local var_294_15 = 4
			local var_294_16 = 1.475

			if 4 < arg_291_1.time_ and arg_291_1.time_ <= var_294_15 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0

				arg_291_1.dialog_:SetActive(true)

				arg_291_1.dialogCg_.alpha = 0

				local var_294_17 = LeanTween.value(arg_291_1.dialog_, 0, 1, 0.3)

				var_294_17:setOnUpdate(LuaHelper.FloatAction(function(arg_295_0)
					arg_291_1.dialogCg_.alpha = arg_295_0
				end))
				var_294_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_291_1.dialog_)
					var_294_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_291_1.duration_ = arg_291_1.duration_ + 0.3

				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_18 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(121441070).content)

				arg_291_1.text_.text = var_294_18

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_20 = 59 <= 0 and var_294_16 or var_294_16 * (utf8.len(var_294_18) / 59)

				if (59 <= 0 and var_294_16 or var_294_16 * (utf8.len(var_294_18) / 59)) > 0 and var_294_16 < var_294_20 then
					arg_291_1.talkMaxDuration = var_294_20
					var_294_15 = var_294_15 + 0.3

					if var_294_20 + var_294_15 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_20 + var_294_15
					end
				end

				arg_291_1.text_.text = var_294_18
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_21 = var_294_15 + 0.3
			local var_294_22 = math.max(var_294_16, arg_291_1.talkMaxDuration)

			if var_294_15 + 0.3 <= arg_291_1.time_ and arg_291_1.time_ < var_294_21 + var_294_22 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_21) / var_294_22

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_21 + var_294_22 and arg_291_1.time_ < var_294_21 + var_294_22 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play121441071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 121441071
		arg_297_1.duration_ = 3.93

		local var_297_0 = {
			ja = 3.933,
			ko = 2.766,
			zh = 2.766
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play121441072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1076ui_story = arg_297_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_300_0 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 then
				arg_297_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_297_1.time_ - 0) / var_300_0)
				arg_297_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1076ui_story"].transform.position).z)
				arg_297_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["1076ui_story"].transform.localEulerAngles = arg_297_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 then
				arg_297_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_297_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1076ui_story"].transform.position).z)
				arg_297_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["1076ui_story"].transform.localEulerAngles = arg_297_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_300_1 = arg_297_1.actors_["1076ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1076ui_story == nil then
				arg_297_1.var_.characterEffect1076ui_story = var_300_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_2 and not isNil(var_300_1) then
				if arg_297_1.var_.characterEffect1076ui_story and not isNil(var_300_1) then
					arg_297_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_2 and arg_297_1.time_ < 0 + var_300_2 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1076ui_story then
				arg_297_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_300_4 = 0
			local var_300_5 = 0.275

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_4 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_6 = arg_297_1:GetWordFromCfg(121441071)
				local var_300_7 = arg_297_1:FormatText(var_300_6.content)

				arg_297_1.text_.text = var_300_7

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_9 = 11 <= 0 and var_300_5 or var_300_5 * (utf8.len(var_300_7) / 11)

				if (11 <= 0 and var_300_5 or var_300_5 * (utf8.len(var_300_7) / 11)) > 0 and var_300_5 < var_300_9 then
					arg_297_1.talkMaxDuration = var_300_9

					if var_300_9 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_9 + var_300_4
					end
				end

				arg_297_1.text_.text = var_300_7
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441071", "story_v_out_121441.awb") ~= 0 then
					local var_300_10 = manager.audio:GetVoiceLength("story_v_out_121441", "121441071", "story_v_out_121441.awb") / 1000

					if var_300_10 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_10 + var_300_4
					end

					if var_300_6.prefab_name ~= "" and arg_297_1.actors_[var_300_6.prefab_name] ~= nil then
						local var_300_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_6.prefab_name].transform, "story_v_out_121441", "121441071", "story_v_out_121441.awb")

						arg_297_1:RecordAudio("121441071", var_300_11)
						arg_297_1:RecordAudio("121441071", var_300_11)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_121441", "121441071", "story_v_out_121441.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_121441", "121441071", "story_v_out_121441.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_12 = math.max(var_300_5, arg_297_1.talkMaxDuration)

			if var_300_4 <= arg_297_1.time_ and arg_297_1.time_ < var_300_4 + var_300_12 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_4) / var_300_12

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_4 + var_300_12 and arg_297_1.time_ < var_300_4 + var_300_12 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play121441072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 121441072
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play121441073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(arg_301_1.actors_["1076ui_story"]) and arg_301_1.var_.characterEffect1076ui_story == nil then
				arg_301_1.var_.characterEffect1076ui_story = arg_301_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_0 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 and not isNil(arg_301_1.actors_["1076ui_story"]) then
				if arg_301_1.var_.characterEffect1076ui_story and not isNil(arg_301_1.actors_["1076ui_story"]) then
					arg_301_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_301_1.time_ - 0) / var_304_0)
				end
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 and not isNil(arg_301_1.actors_["1076ui_story"]) and arg_301_1.var_.characterEffect1076ui_story then
				arg_301_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_304_1 = 0
			local var_304_2 = 0.85

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_3 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(121441072).content)

				arg_301_1.text_.text = var_304_3

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 34 <= 0 and var_304_2 or var_304_2 * (utf8.len(var_304_3) / 34)

				if (34 <= 0 and var_304_2 or var_304_2 * (utf8.len(var_304_3) / 34)) > 0 and var_304_2 < var_304_5 then
					arg_301_1.talkMaxDuration = var_304_5

					if var_304_5 + var_304_1 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + var_304_1
					end
				end

				arg_301_1.text_.text = var_304_3
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_6 = math.max(var_304_2, arg_301_1.talkMaxDuration)

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_6 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_1) / var_304_6

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_1 + var_304_6 and arg_301_1.time_ < var_304_1 + var_304_6 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play121441073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 121441073
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play121441074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos1076ui_story = arg_305_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_308_0 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 then
				arg_305_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_305_1.time_ - 0) / var_308_0)
				arg_305_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1076ui_story"].transform.position).z)
				arg_305_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["1076ui_story"].transform.localEulerAngles = arg_305_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 then
				arg_305_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_305_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1076ui_story"].transform.position).z)
				arg_305_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["1076ui_story"].transform.localEulerAngles = arg_305_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_308_1 = arg_305_1.actors_["1076ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect1076ui_story == nil then
				arg_305_1.var_.characterEffect1076ui_story = var_308_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_2 and not isNil(var_308_1) then
				if arg_305_1.var_.characterEffect1076ui_story and not isNil(var_308_1) then
					arg_305_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_2)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_2 and arg_305_1.time_ < 0 + var_308_2 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect1076ui_story then
				arg_305_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_308_3 = 0
			local var_308_4 = 0.675

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_3 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_5 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(121441073).content)

				arg_305_1.text_.text = var_308_5

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_7 = 27 <= 0 and var_308_4 or var_308_4 * (utf8.len(var_308_5) / 27)

				if (27 <= 0 and var_308_4 or var_308_4 * (utf8.len(var_308_5) / 27)) > 0 and var_308_4 < var_308_7 then
					arg_305_1.talkMaxDuration = var_308_7

					if var_308_7 + var_308_3 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_3
					end
				end

				arg_305_1.text_.text = var_308_5
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_8 = math.max(var_308_4, arg_305_1.talkMaxDuration)

			if var_308_3 <= arg_305_1.time_ and arg_305_1.time_ < var_308_3 + var_308_8 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_3) / var_308_8

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_3 + var_308_8 and arg_305_1.time_ < var_308_3 + var_308_8 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play121441074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 121441074
		arg_309_1.duration_ = 7.17

		local var_309_0 = {
			ja = 7.166,
			ko = 5.933,
			zh = 5.933
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play121441075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos1076ui_story = arg_309_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_312_0 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 then
				arg_309_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_309_1.time_ - 0) / var_312_0)
				arg_309_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1076ui_story"].transform.position).z)
				arg_309_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1076ui_story"].transform.localEulerAngles = arg_309_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 then
				arg_309_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_309_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1076ui_story"].transform.position).z)
				arg_309_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1076ui_story"].transform.localEulerAngles = arg_309_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_312_1 = arg_309_1.actors_["1076ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1076ui_story == nil then
				arg_309_1.var_.characterEffect1076ui_story = var_312_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_2 and not isNil(var_312_1) then
				if arg_309_1.var_.characterEffect1076ui_story and not isNil(var_312_1) then
					arg_309_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_2 and arg_309_1.time_ < 0 + var_312_2 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1076ui_story then
				arg_309_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_312_4 = 0
			local var_312_5 = 0.65

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_6 = arg_309_1:GetWordFromCfg(121441074)
				local var_312_7 = arg_309_1:FormatText(var_312_6.content)

				arg_309_1.text_.text = var_312_7

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_9 = 26 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 26)

				if (26 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 26)) > 0 and var_312_5 < var_312_9 then
					arg_309_1.talkMaxDuration = var_312_9

					if var_312_9 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_9 + var_312_4
					end
				end

				arg_309_1.text_.text = var_312_7
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441074", "story_v_out_121441.awb") ~= 0 then
					local var_312_10 = manager.audio:GetVoiceLength("story_v_out_121441", "121441074", "story_v_out_121441.awb") / 1000

					if var_312_10 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_10 + var_312_4
					end

					if var_312_6.prefab_name ~= "" and arg_309_1.actors_[var_312_6.prefab_name] ~= nil then
						local var_312_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_6.prefab_name].transform, "story_v_out_121441", "121441074", "story_v_out_121441.awb")

						arg_309_1:RecordAudio("121441074", var_312_11)
						arg_309_1:RecordAudio("121441074", var_312_11)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_121441", "121441074", "story_v_out_121441.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_121441", "121441074", "story_v_out_121441.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_12 = math.max(var_312_5, arg_309_1.talkMaxDuration)

			if var_312_4 <= arg_309_1.time_ and arg_309_1.time_ < var_312_4 + var_312_12 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_4) / var_312_12

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_4 + var_312_12 and arg_309_1.time_ < var_312_4 + var_312_12 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	Play121441075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 121441075
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play121441076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1076ui_story"]) and arg_313_1.var_.characterEffect1076ui_story == nil then
				arg_313_1.var_.characterEffect1076ui_story = arg_313_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_0 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1076ui_story"]) then
				if arg_313_1.var_.characterEffect1076ui_story and not isNil(arg_313_1.actors_["1076ui_story"]) then
					arg_313_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_0)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1076ui_story"]) and arg_313_1.var_.characterEffect1076ui_story then
				arg_313_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_316_1 = 0
			local var_316_2 = 0.1

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_3 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(121441075).content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 4 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 4)

				if (4 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 4)) > 0 and var_316_2 < var_316_5 then
					arg_313_1.talkMaxDuration = var_316_5

					if var_316_5 + var_316_1 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + var_316_1
					end
				end

				arg_313_1.text_.text = var_316_3
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_6 = math.max(var_316_2, arg_313_1.talkMaxDuration)

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_6 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_1) / var_316_6

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_1 + var_316_6 and arg_313_1.time_ < var_316_1 + var_316_6 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play121441076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 121441076
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play121441077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1076ui_story = arg_317_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_320_0 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 then
				arg_317_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_317_1.time_ - 0) / var_320_0)
				arg_317_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1076ui_story"].transform.position).z)
				arg_317_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1076ui_story"].transform.localEulerAngles = arg_317_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 then
				arg_317_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_317_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1076ui_story"].transform.position).z)
				arg_317_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1076ui_story"].transform.localEulerAngles = arg_317_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_320_1 = arg_317_1.actors_["1076ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1076ui_story == nil then
				arg_317_1.var_.characterEffect1076ui_story = var_320_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_2 and not isNil(var_320_1) then
				if arg_317_1.var_.characterEffect1076ui_story and not isNil(var_320_1) then
					arg_317_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_2)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_2 and arg_317_1.time_ < 0 + var_320_2 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1076ui_story then
				arg_317_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_320_3 = 0
			local var_320_4 = 0.875

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_3 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_5 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(121441076).content)

				arg_317_1.text_.text = var_320_5

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_7 = 35 <= 0 and var_320_4 or var_320_4 * (utf8.len(var_320_5) / 35)

				if (35 <= 0 and var_320_4 or var_320_4 * (utf8.len(var_320_5) / 35)) > 0 and var_320_4 < var_320_7 then
					arg_317_1.talkMaxDuration = var_320_7

					if var_320_7 + var_320_3 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_3
					end
				end

				arg_317_1.text_.text = var_320_5
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_8 = math.max(var_320_4, arg_317_1.talkMaxDuration)

			if var_320_3 <= arg_317_1.time_ and arg_317_1.time_ < var_320_3 + var_320_8 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_3) / var_320_8

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_3 + var_320_8 and arg_317_1.time_ < var_320_3 + var_320_8 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play121441077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 121441077
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play121441078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 1.8

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_1 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(121441077).content)

				arg_321_1.text_.text = var_324_1

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_3 = 72 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_1) / 72)

				if (72 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_1) / 72)) > 0 and var_324_0 < var_324_3 then
					arg_321_1.talkMaxDuration = var_324_3

					if var_324_3 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_3 + 0
					end
				end

				arg_321_1.text_.text = var_324_1
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_4 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_4 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_4

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_4 and arg_321_1.time_ < 0 + var_324_4 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play121441078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 121441078
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play121441079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0.7

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_1 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(121441078).content)

				arg_325_1.text_.text = var_328_1

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_3 = 28 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_1) / 28)

				if (28 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_1) / 28)) > 0 and var_328_0 < var_328_3 then
					arg_325_1.talkMaxDuration = var_328_3

					if var_328_3 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_3 + 0
					end
				end

				arg_325_1.text_.text = var_328_1
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_4 = math.max(var_328_0, arg_325_1.talkMaxDuration)

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_4 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - 0) / var_328_4

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= 0 + var_328_4 and arg_325_1.time_ < 0 + var_328_4 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play121441079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 121441079
		arg_329_1.duration_ = 7.63

		local var_329_0 = {
			ja = 6.766,
			ko = 7.633,
			zh = 7.633
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play121441080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1084ui_story = arg_329_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_332_0 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 then
				arg_329_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_329_1.time_ - 0) / var_332_0)
				arg_329_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1084ui_story"].transform.position).z)
				arg_329_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1084ui_story"].transform.localEulerAngles = arg_329_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 then
				arg_329_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_329_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1084ui_story"].transform.position).z)
				arg_329_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1084ui_story"].transform.localEulerAngles = arg_329_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_332_1 = arg_329_1.actors_["1084ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect1084ui_story == nil then
				arg_329_1.var_.characterEffect1084ui_story = var_332_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_2 and not isNil(var_332_1) then
				if arg_329_1.var_.characterEffect1084ui_story and not isNil(var_332_1) then
					arg_329_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 0 + var_332_2 and arg_329_1.time_ < 0 + var_332_2 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect1084ui_story then
				arg_329_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_332_4 = arg_329_1.actors_["1075ui_story"].transform

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1075ui_story = var_332_4.localPosition
			end

			local var_332_5 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_5 then
				var_332_4.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_329_1.time_ - 0) / var_332_5)
				var_332_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_4.position).x, (manager.ui.mainCamera.transform.position - var_332_4.position).y, (manager.ui.mainCamera.transform.position - var_332_4.position).z)
				var_332_4.localEulerAngles.z = 0
				var_332_4.localEulerAngles.x = 0
				var_332_4.localEulerAngles = var_332_4.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_5 and arg_329_1.time_ < 0 + var_332_5 + arg_332_0 then
				var_332_4.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_332_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_4.position).x, (manager.ui.mainCamera.transform.position - var_332_4.position).y, (manager.ui.mainCamera.transform.position - var_332_4.position).z)
				var_332_4.localEulerAngles.z = 0
				var_332_4.localEulerAngles.x = 0
				var_332_4.localEulerAngles = var_332_4.localEulerAngles
			end

			local var_332_6 = arg_329_1.actors_["1075ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_6) and arg_329_1.var_.characterEffect1075ui_story == nil then
				arg_329_1.var_.characterEffect1075ui_story = var_332_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_7 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_7 and not isNil(var_332_6) then
				if arg_329_1.var_.characterEffect1075ui_story and not isNil(var_332_6) then
					arg_329_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 0) / var_332_7)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_7 and arg_329_1.time_ < 0 + var_332_7 + arg_332_0 and not isNil(var_332_6) and arg_329_1.var_.characterEffect1075ui_story then
				arg_329_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_332_8 = 0
			local var_332_9 = 0.8

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_8 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_10 = arg_329_1:GetWordFromCfg(121441079)
				local var_332_11 = arg_329_1:FormatText(var_332_10.content)

				arg_329_1.text_.text = var_332_11

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_13 = 32 <= 0 and var_332_9 or var_332_9 * (utf8.len(var_332_11) / 32)

				if (32 <= 0 and var_332_9 or var_332_9 * (utf8.len(var_332_11) / 32)) > 0 and var_332_9 < var_332_13 then
					arg_329_1.talkMaxDuration = var_332_13

					if var_332_13 + var_332_8 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_13 + var_332_8
					end
				end

				arg_329_1.text_.text = var_332_11
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441079", "story_v_out_121441.awb") ~= 0 then
					local var_332_14 = manager.audio:GetVoiceLength("story_v_out_121441", "121441079", "story_v_out_121441.awb") / 1000

					if var_332_14 + var_332_8 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_14 + var_332_8
					end

					if var_332_10.prefab_name ~= "" and arg_329_1.actors_[var_332_10.prefab_name] ~= nil then
						local var_332_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_10.prefab_name].transform, "story_v_out_121441", "121441079", "story_v_out_121441.awb")

						arg_329_1:RecordAudio("121441079", var_332_15)
						arg_329_1:RecordAudio("121441079", var_332_15)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_121441", "121441079", "story_v_out_121441.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_121441", "121441079", "story_v_out_121441.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_16 = math.max(var_332_9, arg_329_1.talkMaxDuration)

			if var_332_8 <= arg_329_1.time_ and arg_329_1.time_ < var_332_8 + var_332_16 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_8) / var_332_16

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_8 + var_332_16 and arg_329_1.time_ < var_332_8 + var_332_16 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play121441080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 121441080
		arg_333_1.duration_ = 13.2

		local var_333_0 = {
			ja = 11.733,
			ko = 13.2,
			zh = 13.2
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play121441081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["1075ui_story"]) and arg_333_1.var_.characterEffect1075ui_story == nil then
				arg_333_1.var_.characterEffect1075ui_story = arg_333_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_0 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["1075ui_story"]) then
				if arg_333_1.var_.characterEffect1075ui_story and not isNil(arg_333_1.actors_["1075ui_story"]) then
					arg_333_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["1075ui_story"]) and arg_333_1.var_.characterEffect1075ui_story then
				arg_333_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_336_2 = arg_333_1.actors_["1084ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_2) and arg_333_1.var_.characterEffect1084ui_story == nil then
				arg_333_1.var_.characterEffect1084ui_story = var_336_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_3 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_3 and not isNil(var_336_2) then
				if arg_333_1.var_.characterEffect1084ui_story and not isNil(var_336_2) then
					arg_333_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 0) / var_336_3)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_3 and arg_333_1.time_ < 0 + var_336_3 + arg_336_0 and not isNil(var_336_2) and arg_333_1.var_.characterEffect1084ui_story then
				arg_333_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_336_4 = 0
			local var_336_5 = 1.55

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_4 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_6 = arg_333_1:GetWordFromCfg(121441080)
				local var_336_7 = arg_333_1:FormatText(var_336_6.content)

				arg_333_1.text_.text = var_336_7

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_9 = 62 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_7) / 62)

				if (62 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_7) / 62)) > 0 and var_336_5 < var_336_9 then
					arg_333_1.talkMaxDuration = var_336_9

					if var_336_9 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_9 + var_336_4
					end
				end

				arg_333_1.text_.text = var_336_7
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441080", "story_v_out_121441.awb") ~= 0 then
					local var_336_10 = manager.audio:GetVoiceLength("story_v_out_121441", "121441080", "story_v_out_121441.awb") / 1000

					if var_336_10 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_10 + var_336_4
					end

					if var_336_6.prefab_name ~= "" and arg_333_1.actors_[var_336_6.prefab_name] ~= nil then
						local var_336_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_6.prefab_name].transform, "story_v_out_121441", "121441080", "story_v_out_121441.awb")

						arg_333_1:RecordAudio("121441080", var_336_11)
						arg_333_1:RecordAudio("121441080", var_336_11)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_121441", "121441080", "story_v_out_121441.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_121441", "121441080", "story_v_out_121441.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_12 = math.max(var_336_5, arg_333_1.talkMaxDuration)

			if var_336_4 <= arg_333_1.time_ and arg_333_1.time_ < var_336_4 + var_336_12 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_4) / var_336_12

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_4 + var_336_12 and arg_333_1.time_ < var_336_4 + var_336_12 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play121441081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 121441081
		arg_337_1.duration_ = 8.1

		local var_337_0 = {
			ja = 8.1,
			ko = 2.366,
			zh = 2.366
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play121441082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1084ui_story"]) and arg_337_1.var_.characterEffect1084ui_story == nil then
				arg_337_1.var_.characterEffect1084ui_story = arg_337_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1084ui_story"]) then
				if arg_337_1.var_.characterEffect1084ui_story and not isNil(arg_337_1.actors_["1084ui_story"]) then
					arg_337_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1084ui_story"]) and arg_337_1.var_.characterEffect1084ui_story then
				arg_337_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_340_2 = arg_337_1.actors_["1075ui_story"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_2) and arg_337_1.var_.characterEffect1075ui_story == nil then
				arg_337_1.var_.characterEffect1075ui_story = var_340_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_3 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_3 and not isNil(var_340_2) then
				if arg_337_1.var_.characterEffect1075ui_story and not isNil(var_340_2) then
					arg_337_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_337_1.time_ - 0) / var_340_3)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_3 and arg_337_1.time_ < 0 + var_340_3 + arg_340_0 and not isNil(var_340_2) and arg_337_1.var_.characterEffect1075ui_story then
				arg_337_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_340_4 = 0
			local var_340_5 = 0.3

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_4 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_6 = arg_337_1:GetWordFromCfg(121441081)
				local var_340_7 = arg_337_1:FormatText(var_340_6.content)

				arg_337_1.text_.text = var_340_7

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_9 = 12 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_7) / 12)

				if (12 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_7) / 12)) > 0 and var_340_5 < var_340_9 then
					arg_337_1.talkMaxDuration = var_340_9

					if var_340_9 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_9 + var_340_4
					end
				end

				arg_337_1.text_.text = var_340_7
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441081", "story_v_out_121441.awb") ~= 0 then
					local var_340_10 = manager.audio:GetVoiceLength("story_v_out_121441", "121441081", "story_v_out_121441.awb") / 1000

					if var_340_10 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_10 + var_340_4
					end

					if var_340_6.prefab_name ~= "" and arg_337_1.actors_[var_340_6.prefab_name] ~= nil then
						local var_340_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_6.prefab_name].transform, "story_v_out_121441", "121441081", "story_v_out_121441.awb")

						arg_337_1:RecordAudio("121441081", var_340_11)
						arg_337_1:RecordAudio("121441081", var_340_11)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_121441", "121441081", "story_v_out_121441.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_121441", "121441081", "story_v_out_121441.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_12 = math.max(var_340_5, arg_337_1.talkMaxDuration)

			if var_340_4 <= arg_337_1.time_ and arg_337_1.time_ < var_340_4 + var_340_12 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_4) / var_340_12

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_4 + var_340_12 and arg_337_1.time_ < var_340_4 + var_340_12 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play121441082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 121441082
		arg_341_1.duration_ = 12.3

		local var_341_0 = {
			ja = 12.3,
			ko = 8.7,
			zh = 8.7
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play121441083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(arg_341_1.actors_["1075ui_story"]) and arg_341_1.var_.characterEffect1075ui_story == nil then
				arg_341_1.var_.characterEffect1075ui_story = arg_341_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_0 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 and not isNil(arg_341_1.actors_["1075ui_story"]) then
				if arg_341_1.var_.characterEffect1075ui_story and not isNil(arg_341_1.actors_["1075ui_story"]) then
					arg_341_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 and not isNil(arg_341_1.actors_["1075ui_story"]) and arg_341_1.var_.characterEffect1075ui_story then
				arg_341_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_344_2 = arg_341_1.actors_["1084ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_2) and arg_341_1.var_.characterEffect1084ui_story == nil then
				arg_341_1.var_.characterEffect1084ui_story = var_344_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_3 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_3 and not isNil(var_344_2) then
				if arg_341_1.var_.characterEffect1084ui_story and not isNil(var_344_2) then
					arg_341_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_341_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_341_1.time_ - 0) / var_344_3)
				end
			end

			if arg_341_1.time_ >= 0 + var_344_3 and arg_341_1.time_ < 0 + var_344_3 + arg_344_0 and not isNil(var_344_2) and arg_341_1.var_.characterEffect1084ui_story then
				arg_341_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_341_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_344_4 = 0
			local var_344_5 = 1

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_4 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_6 = arg_341_1:GetWordFromCfg(121441082)
				local var_344_7 = arg_341_1:FormatText(var_344_6.content)

				arg_341_1.text_.text = var_344_7

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_9 = 40 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 40)

				if (40 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 40)) > 0 and var_344_5 < var_344_9 then
					arg_341_1.talkMaxDuration = var_344_9

					if var_344_9 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_9 + var_344_4
					end
				end

				arg_341_1.text_.text = var_344_7
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441082", "story_v_out_121441.awb") ~= 0 then
					local var_344_10 = manager.audio:GetVoiceLength("story_v_out_121441", "121441082", "story_v_out_121441.awb") / 1000

					if var_344_10 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_10 + var_344_4
					end

					if var_344_6.prefab_name ~= "" and arg_341_1.actors_[var_344_6.prefab_name] ~= nil then
						local var_344_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_6.prefab_name].transform, "story_v_out_121441", "121441082", "story_v_out_121441.awb")

						arg_341_1:RecordAudio("121441082", var_344_11)
						arg_341_1:RecordAudio("121441082", var_344_11)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_121441", "121441082", "story_v_out_121441.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_121441", "121441082", "story_v_out_121441.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_12 = math.max(var_344_5, arg_341_1.talkMaxDuration)

			if var_344_4 <= arg_341_1.time_ and arg_341_1.time_ < var_344_4 + var_344_12 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_4) / var_344_12

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_4 + var_344_12 and arg_341_1.time_ < var_344_4 + var_344_12 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play121441083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 121441083
		arg_345_1.duration_ = 5.43

		local var_345_0 = {
			ja = 4.2,
			ko = 5.433,
			zh = 5.433
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play121441084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos1084ui_story = arg_345_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_348_0 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 then
				arg_345_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_345_1.time_ - 0) / var_348_0)
				arg_345_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1084ui_story"].transform.position).z)
				arg_345_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1084ui_story"].transform.localEulerAngles = arg_345_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 then
				arg_345_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_345_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1084ui_story"].transform.position).z)
				arg_345_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1084ui_story"].transform.localEulerAngles = arg_345_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_348_1 = arg_345_1.actors_["1084ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect1084ui_story == nil then
				arg_345_1.var_.characterEffect1084ui_story = var_348_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_2 and not isNil(var_348_1) then
				if arg_345_1.var_.characterEffect1084ui_story and not isNil(var_348_1) then
					arg_345_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_345_1.time_ - 0) / var_348_2)
				end
			end

			if arg_345_1.time_ >= 0 + var_348_2 and arg_345_1.time_ < 0 + var_348_2 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect1084ui_story then
				arg_345_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_348_3 = arg_345_1.actors_["1075ui_story"].transform

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos1075ui_story = var_348_3.localPosition
			end

			local var_348_4 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_4 then
				var_348_3.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_345_1.time_ - 0) / var_348_4)
				var_348_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_3.position).x, (manager.ui.mainCamera.transform.position - var_348_3.position).y, (manager.ui.mainCamera.transform.position - var_348_3.position).z)
				var_348_3.localEulerAngles.z = 0
				var_348_3.localEulerAngles.x = 0
				var_348_3.localEulerAngles = var_348_3.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_4 and arg_345_1.time_ < 0 + var_348_4 + arg_348_0 then
				var_348_3.localPosition = Vector3.New(0, 100, 0)
				var_348_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_3.position).x, (manager.ui.mainCamera.transform.position - var_348_3.position).y, (manager.ui.mainCamera.transform.position - var_348_3.position).z)
				var_348_3.localEulerAngles.z = 0
				var_348_3.localEulerAngles.x = 0
				var_348_3.localEulerAngles = var_348_3.localEulerAngles
			end

			local var_348_5 = arg_345_1.actors_["1075ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_5) and arg_345_1.var_.characterEffect1075ui_story == nil then
				arg_345_1.var_.characterEffect1075ui_story = var_348_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_6 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_6 and not isNil(var_348_5) then
				if arg_345_1.var_.characterEffect1075ui_story and not isNil(var_348_5) then
					arg_345_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_345_1.time_ - 0) / var_348_6)
				end
			end

			if arg_345_1.time_ >= 0 + var_348_6 and arg_345_1.time_ < 0 + var_348_6 + arg_348_0 and not isNil(var_348_5) and arg_345_1.var_.characterEffect1075ui_story then
				arg_345_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_348_7 = arg_345_1.actors_["1076ui_story"].transform

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos1076ui_story = var_348_7.localPosition
			end

			local var_348_8 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_8 then
				var_348_7.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_345_1.time_ - 0) / var_348_8)
				var_348_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_7.position).x, (manager.ui.mainCamera.transform.position - var_348_7.position).y, (manager.ui.mainCamera.transform.position - var_348_7.position).z)
				var_348_7.localEulerAngles.z = 0
				var_348_7.localEulerAngles.x = 0
				var_348_7.localEulerAngles = var_348_7.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_8 and arg_345_1.time_ < 0 + var_348_8 + arg_348_0 then
				var_348_7.localPosition = Vector3.New(0, -1.06, -6.2)
				var_348_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_7.position).x, (manager.ui.mainCamera.transform.position - var_348_7.position).y, (manager.ui.mainCamera.transform.position - var_348_7.position).z)
				var_348_7.localEulerAngles.z = 0
				var_348_7.localEulerAngles.x = 0
				var_348_7.localEulerAngles = var_348_7.localEulerAngles
			end

			local var_348_9 = arg_345_1.actors_["1076ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_9) and arg_345_1.var_.characterEffect1076ui_story == nil then
				arg_345_1.var_.characterEffect1076ui_story = var_348_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_10 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_10 and not isNil(var_348_9) then
				if arg_345_1.var_.characterEffect1076ui_story and not isNil(var_348_9) then
					arg_345_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= 0 + var_348_10 and arg_345_1.time_ < 0 + var_348_10 + arg_348_0 and not isNil(var_348_9) and arg_345_1.var_.characterEffect1076ui_story then
				arg_345_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_348_12 = 0
			local var_348_13 = 0.7

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_12 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_14 = arg_345_1:GetWordFromCfg(121441083)
				local var_348_15 = arg_345_1:FormatText(var_348_14.content)

				arg_345_1.text_.text = var_348_15

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_17 = 28 <= 0 and var_348_13 or var_348_13 * (utf8.len(var_348_15) / 28)

				if (28 <= 0 and var_348_13 or var_348_13 * (utf8.len(var_348_15) / 28)) > 0 and var_348_13 < var_348_17 then
					arg_345_1.talkMaxDuration = var_348_17

					if var_348_17 + var_348_12 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_17 + var_348_12
					end
				end

				arg_345_1.text_.text = var_348_15
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441083", "story_v_out_121441.awb") ~= 0 then
					local var_348_18 = manager.audio:GetVoiceLength("story_v_out_121441", "121441083", "story_v_out_121441.awb") / 1000

					if var_348_18 + var_348_12 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_18 + var_348_12
					end

					if var_348_14.prefab_name ~= "" and arg_345_1.actors_[var_348_14.prefab_name] ~= nil then
						local var_348_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_14.prefab_name].transform, "story_v_out_121441", "121441083", "story_v_out_121441.awb")

						arg_345_1:RecordAudio("121441083", var_348_19)
						arg_345_1:RecordAudio("121441083", var_348_19)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_121441", "121441083", "story_v_out_121441.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_121441", "121441083", "story_v_out_121441.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_20 = math.max(var_348_13, arg_345_1.talkMaxDuration)

			if var_348_12 <= arg_345_1.time_ and arg_345_1.time_ < var_348_12 + var_348_20 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_12) / var_348_20

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_12 + var_348_20 and arg_345_1.time_ < var_348_12 + var_348_20 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play121441084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 121441084
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play121441085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1084ui_story = arg_349_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_352_0 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 then
				arg_349_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_349_1.time_ - 0) / var_352_0)
				arg_349_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1084ui_story"].transform.position).z)
				arg_349_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1084ui_story"].transform.localEulerAngles = arg_349_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 then
				arg_349_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_349_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1084ui_story"].transform.position).z)
				arg_349_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1084ui_story"].transform.localEulerAngles = arg_349_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_352_1 = arg_349_1.actors_["1084ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect1084ui_story == nil then
				arg_349_1.var_.characterEffect1084ui_story = var_352_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_2 and not isNil(var_352_1) then
				if arg_349_1.var_.characterEffect1084ui_story and not isNil(var_352_1) then
					arg_349_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 0) / var_352_2)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_2 and arg_349_1.time_ < 0 + var_352_2 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect1084ui_story then
				arg_349_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_352_3 = arg_349_1.actors_["1076ui_story"].transform

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1076ui_story = var_352_3.localPosition
			end

			local var_352_4 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_4 then
				var_352_3.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_349_1.time_ - 0) / var_352_4)
				var_352_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_352_3.position).x, (manager.ui.mainCamera.transform.position - var_352_3.position).y, (manager.ui.mainCamera.transform.position - var_352_3.position).z)
				var_352_3.localEulerAngles.z = 0
				var_352_3.localEulerAngles.x = 0
				var_352_3.localEulerAngles = var_352_3.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_4 and arg_349_1.time_ < 0 + var_352_4 + arg_352_0 then
				var_352_3.localPosition = Vector3.New(0, 100, 0)
				var_352_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_352_3.position).x, (manager.ui.mainCamera.transform.position - var_352_3.position).y, (manager.ui.mainCamera.transform.position - var_352_3.position).z)
				var_352_3.localEulerAngles.z = 0
				var_352_3.localEulerAngles.x = 0
				var_352_3.localEulerAngles = var_352_3.localEulerAngles
			end

			local var_352_5 = arg_349_1.actors_["1076ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_5) and arg_349_1.var_.characterEffect1076ui_story == nil then
				arg_349_1.var_.characterEffect1076ui_story = var_352_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_6 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_6 and not isNil(var_352_5) then
				if arg_349_1.var_.characterEffect1076ui_story and not isNil(var_352_5) then
					arg_349_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 0) / var_352_6)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_6 and arg_349_1.time_ < 0 + var_352_6 + arg_352_0 and not isNil(var_352_5) and arg_349_1.var_.characterEffect1076ui_story then
				arg_349_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_352_7 = 0
			local var_352_8 = 0.975

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_7 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_9 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(121441084).content)

				arg_349_1.text_.text = var_352_9

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_11 = 39 <= 0 and var_352_8 or var_352_8 * (utf8.len(var_352_9) / 39)

				if (39 <= 0 and var_352_8 or var_352_8 * (utf8.len(var_352_9) / 39)) > 0 and var_352_8 < var_352_11 then
					arg_349_1.talkMaxDuration = var_352_11

					if var_352_11 + var_352_7 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_11 + var_352_7
					end
				end

				arg_349_1.text_.text = var_352_9
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_12 = math.max(var_352_8, arg_349_1.talkMaxDuration)

			if var_352_7 <= arg_349_1.time_ and arg_349_1.time_ < var_352_7 + var_352_12 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_7) / var_352_12

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_7 + var_352_12 and arg_349_1.time_ < var_352_7 + var_352_12 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play121441085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 121441085
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play121441086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 1.05

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_1 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(121441085).content)

				arg_353_1.text_.text = var_356_1

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_3 = 42 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_1) / 42)

				if (42 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_1) / 42)) > 0 and var_356_0 < var_356_3 then
					arg_353_1.talkMaxDuration = var_356_3

					if var_356_3 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_3 + 0
					end
				end

				arg_353_1.text_.text = var_356_1
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_4 = math.max(var_356_0, arg_353_1.talkMaxDuration)

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_4 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - 0) / var_356_4

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= 0 + var_356_4 and arg_353_1.time_ < 0 + var_356_4 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play121441086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 121441086
		arg_357_1.duration_ = 9

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play121441087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if arg_357_1.bgs_.ST41 == nil then
				local var_360_0 = Object.Instantiate(arg_357_1.paintGo_)

				var_360_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST41")
				var_360_0.name = "ST41"
				var_360_0.transform.parent = arg_357_1.stage_.transform
				var_360_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_357_1.bgs_.ST41 = var_360_0
			end

			if 2 < arg_357_1.time_ and arg_357_1.time_ <= 2 + arg_360_0 then
				local var_360_1 = arg_357_1.bgs_.ST41

				arg_357_1.bgs_.ST41.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_360_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_360_2 = var_360_1:GetComponent("SpriteRenderer")

				if var_360_2 and var_360_2.sprite then
					local var_360_3 = 2 * (var_360_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_360_1.transform.localScale = Vector3.New(var_360_3 / var_360_2.sprite.bounds.size.y < var_360_3 * manager.ui.mainCameraCom_.aspect / var_360_2.sprite.bounds.size.x and var_360_3 * manager.ui.mainCameraCom_.aspect / var_360_2.sprite.bounds.size.x or var_360_3 / var_360_2.sprite.bounds.size.y, var_360_3 / var_360_2.sprite.bounds.size.y < var_360_3 * manager.ui.mainCameraCom_.aspect / var_360_2.sprite.bounds.size.x and var_360_3 * manager.ui.mainCameraCom_.aspect / var_360_2.sprite.bounds.size.x or var_360_3 / var_360_2.sprite.bounds.size.y, 0)
				end

				for iter_360_0, iter_360_1 in pairs(arg_357_1.bgs_) do
					if iter_360_0 ~= "ST41" then
						iter_360_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_360_4 = 0

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_4 + arg_360_0 then
				arg_357_1.mask_.enabled = true
				arg_357_1.mask_.raycastTarget = true

				arg_357_1:SetGaussion(false)
			end

			local var_360_5 = 2

			if var_360_4 <= arg_357_1.time_ and arg_357_1.time_ < var_360_4 + var_360_5 then
				local var_360_6 = Color.New(0, 0, 0)

				var_360_6.a = Mathf.Lerp(0, 1, (arg_357_1.time_ - var_360_4) / var_360_5)
				arg_357_1.mask_.color = var_360_6
			end

			if arg_357_1.time_ >= var_360_4 + var_360_5 and arg_357_1.time_ < var_360_4 + var_360_5 + arg_360_0 then
				local var_360_7 = Color.New(0, 0, 0)

				var_360_7.a = 1
				arg_357_1.mask_.color = var_360_7
			end

			local var_360_8 = 2

			if 2 < arg_357_1.time_ and arg_357_1.time_ <= var_360_8 + arg_360_0 then
				arg_357_1.mask_.enabled = true
				arg_357_1.mask_.raycastTarget = true

				arg_357_1:SetGaussion(false)
			end

			local var_360_9 = 2

			if var_360_8 <= arg_357_1.time_ and arg_357_1.time_ < var_360_8 + var_360_9 then
				local var_360_10 = Color.New(0, 0, 0)

				var_360_10.a = Mathf.Lerp(1, 0, (arg_357_1.time_ - var_360_8) / var_360_9)
				arg_357_1.mask_.color = var_360_10
			end

			if arg_357_1.time_ >= var_360_8 + var_360_9 and arg_357_1.time_ < var_360_8 + var_360_9 + arg_360_0 then
				local var_360_11 = Color.New(0, 0, 0)

				arg_357_1.mask_.enabled = false
				var_360_11.a = 0
				arg_357_1.mask_.color = var_360_11
			end

			if arg_357_1.frameCnt_ <= 1 then
				arg_357_1.dialog_:SetActive(false)
			end

			local var_360_12 = 4
			local var_360_13 = 0.725

			if 4 < arg_357_1.time_ and arg_357_1.time_ <= var_360_12 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0

				arg_357_1.dialog_:SetActive(true)

				arg_357_1.dialogCg_.alpha = 0

				local var_360_14 = LeanTween.value(arg_357_1.dialog_, 0, 1, 0.3)

				var_360_14:setOnUpdate(LuaHelper.FloatAction(function(arg_361_0)
					arg_357_1.dialogCg_.alpha = arg_361_0
				end))
				var_360_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_357_1.dialog_)
					var_360_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_357_1.duration_ = arg_357_1.duration_ + 0.3

				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_15 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(121441086).content)

				arg_357_1.text_.text = var_360_15

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_17 = 29 <= 0 and var_360_13 or var_360_13 * (utf8.len(var_360_15) / 29)

				if (29 <= 0 and var_360_13 or var_360_13 * (utf8.len(var_360_15) / 29)) > 0 and var_360_13 < var_360_17 then
					arg_357_1.talkMaxDuration = var_360_17
					var_360_12 = var_360_12 + 0.3

					if var_360_17 + var_360_12 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_17 + var_360_12
					end
				end

				arg_357_1.text_.text = var_360_15
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_18 = var_360_12 + 0.3
			local var_360_19 = math.max(var_360_13, arg_357_1.talkMaxDuration)

			if var_360_12 + 0.3 <= arg_357_1.time_ and arg_357_1.time_ < var_360_18 + var_360_19 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_18) / var_360_19

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_18 + var_360_19 and arg_357_1.time_ < var_360_18 + var_360_19 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play121441087 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 121441087
		arg_363_1.duration_ = 11.43

		local var_363_0 = {
			ja = 11.433,
			ko = 8.866,
			zh = 8.866
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play121441088(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos1076ui_story = arg_363_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_366_0 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 then
				arg_363_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_363_1.time_ - 0) / var_366_0)
				arg_363_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1076ui_story"].transform.position).z)
				arg_363_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["1076ui_story"].transform.localEulerAngles = arg_363_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 then
				arg_363_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_363_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1076ui_story"].transform.position).z)
				arg_363_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["1076ui_story"].transform.localEulerAngles = arg_363_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_366_1 = arg_363_1.actors_["1076ui_story"]

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(var_366_1) and arg_363_1.var_.characterEffect1076ui_story == nil then
				arg_363_1.var_.characterEffect1076ui_story = var_366_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_2 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_2 and not isNil(var_366_1) then
				if arg_363_1.var_.characterEffect1076ui_story and not isNil(var_366_1) then
					arg_363_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= 0 + var_366_2 and arg_363_1.time_ < 0 + var_366_2 + arg_366_0 and not isNil(var_366_1) and arg_363_1.var_.characterEffect1076ui_story then
				arg_363_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_366_4 = arg_363_1.actors_["1075ui_story"].transform

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos1075ui_story = var_366_4.localPosition
			end

			local var_366_5 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_5 then
				var_366_4.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_363_1.time_ - 0) / var_366_5)
				var_366_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_366_4.position).x, (manager.ui.mainCamera.transform.position - var_366_4.position).y, (manager.ui.mainCamera.transform.position - var_366_4.position).z)
				var_366_4.localEulerAngles.z = 0
				var_366_4.localEulerAngles.x = 0
				var_366_4.localEulerAngles = var_366_4.localEulerAngles
			end

			if arg_363_1.time_ >= 0 + var_366_5 and arg_363_1.time_ < 0 + var_366_5 + arg_366_0 then
				var_366_4.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_366_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_366_4.position).x, (manager.ui.mainCamera.transform.position - var_366_4.position).y, (manager.ui.mainCamera.transform.position - var_366_4.position).z)
				var_366_4.localEulerAngles.z = 0
				var_366_4.localEulerAngles.x = 0
				var_366_4.localEulerAngles = var_366_4.localEulerAngles
			end

			local var_366_6 = arg_363_1.actors_["1075ui_story"]

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(var_366_6) and arg_363_1.var_.characterEffect1075ui_story == nil then
				arg_363_1.var_.characterEffect1075ui_story = var_366_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_7 = 0.0166666666666667

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_7 and not isNil(var_366_6) then
				if arg_363_1.var_.characterEffect1075ui_story and not isNil(var_366_6) then
					arg_363_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_363_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_363_1.time_ - 0) / var_366_7)
				end
			end

			if arg_363_1.time_ >= 0 + var_366_7 and arg_363_1.time_ < 0 + var_366_7 + arg_366_0 and not isNil(var_366_6) and arg_363_1.var_.characterEffect1075ui_story then
				arg_363_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_363_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_366_8 = 0
			local var_366_9 = 1

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_8 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_10 = arg_363_1:GetWordFromCfg(121441087)
				local var_366_11 = arg_363_1:FormatText(var_366_10.content)

				arg_363_1.text_.text = var_366_11

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_13 = 40 <= 0 and var_366_9 or var_366_9 * (utf8.len(var_366_11) / 40)

				if (40 <= 0 and var_366_9 or var_366_9 * (utf8.len(var_366_11) / 40)) > 0 and var_366_9 < var_366_13 then
					arg_363_1.talkMaxDuration = var_366_13

					if var_366_13 + var_366_8 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_13 + var_366_8
					end
				end

				arg_363_1.text_.text = var_366_11
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441087", "story_v_out_121441.awb") ~= 0 then
					local var_366_14 = manager.audio:GetVoiceLength("story_v_out_121441", "121441087", "story_v_out_121441.awb") / 1000

					if var_366_14 + var_366_8 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_14 + var_366_8
					end

					if var_366_10.prefab_name ~= "" and arg_363_1.actors_[var_366_10.prefab_name] ~= nil then
						local var_366_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_10.prefab_name].transform, "story_v_out_121441", "121441087", "story_v_out_121441.awb")

						arg_363_1:RecordAudio("121441087", var_366_15)
						arg_363_1:RecordAudio("121441087", var_366_15)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_121441", "121441087", "story_v_out_121441.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_121441", "121441087", "story_v_out_121441.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_16 = math.max(var_366_9, arg_363_1.talkMaxDuration)

			if var_366_8 <= arg_363_1.time_ and arg_363_1.time_ < var_366_8 + var_366_16 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_8) / var_366_16

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_8 + var_366_16 and arg_363_1.time_ < var_366_8 + var_366_16 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play121441088 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 121441088
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play121441089(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(arg_367_1.actors_["1076ui_story"]) and arg_367_1.var_.characterEffect1076ui_story == nil then
				arg_367_1.var_.characterEffect1076ui_story = arg_367_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_0 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 and not isNil(arg_367_1.actors_["1076ui_story"]) then
				if arg_367_1.var_.characterEffect1076ui_story and not isNil(arg_367_1.actors_["1076ui_story"]) then
					arg_367_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_367_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_367_1.time_ - 0) / var_370_0)
				end
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 and not isNil(arg_367_1.actors_["1076ui_story"]) and arg_367_1.var_.characterEffect1076ui_story then
				arg_367_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_367_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_370_1 = 0
			local var_370_2 = 0.5

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_3 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(121441088).content)

				arg_367_1.text_.text = var_370_3

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_5 = 20 <= 0 and var_370_2 or var_370_2 * (utf8.len(var_370_3) / 20)

				if (20 <= 0 and var_370_2 or var_370_2 * (utf8.len(var_370_3) / 20)) > 0 and var_370_2 < var_370_5 then
					arg_367_1.talkMaxDuration = var_370_5

					if var_370_5 + var_370_1 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_5 + var_370_1
					end
				end

				arg_367_1.text_.text = var_370_3
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_6 = math.max(var_370_2, arg_367_1.talkMaxDuration)

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_6 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_1) / var_370_6

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_1 + var_370_6 and arg_367_1.time_ < var_370_1 + var_370_6 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play121441089 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 121441089
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play121441090(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0.8

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_1 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(121441089).content)

				arg_371_1.text_.text = var_374_1

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_3 = 32 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 32)

				if (32 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 32)) > 0 and var_374_0 < var_374_3 then
					arg_371_1.talkMaxDuration = var_374_3

					if var_374_3 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_3 + 0
					end
				end

				arg_371_1.text_.text = var_374_1
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_4 = math.max(var_374_0, arg_371_1.talkMaxDuration)

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_4 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - 0) / var_374_4

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= 0 + var_374_4 and arg_371_1.time_ < 0 + var_374_4 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play121441090 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 121441090
		arg_375_1.duration_ = 5.27

		local var_375_0 = {
			ja = 2.833,
			ko = 5.266,
			zh = 5.266
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play121441091(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(arg_375_1.actors_["1075ui_story"]) and arg_375_1.var_.characterEffect1075ui_story == nil then
				arg_375_1.var_.characterEffect1075ui_story = arg_375_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_0 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 and not isNil(arg_375_1.actors_["1075ui_story"]) then
				if arg_375_1.var_.characterEffect1075ui_story and not isNil(arg_375_1.actors_["1075ui_story"]) then
					arg_375_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 and not isNil(arg_375_1.actors_["1075ui_story"]) and arg_375_1.var_.characterEffect1075ui_story then
				arg_375_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_378_2 = 0
			local var_378_3 = 0.4

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_2 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_4 = arg_375_1:GetWordFromCfg(121441090)
				local var_378_5 = arg_375_1:FormatText(var_378_4.content)

				arg_375_1.text_.text = var_378_5

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_7 = 16 <= 0 and var_378_3 or var_378_3 * (utf8.len(var_378_5) / 16)

				if (16 <= 0 and var_378_3 or var_378_3 * (utf8.len(var_378_5) / 16)) > 0 and var_378_3 < var_378_7 then
					arg_375_1.talkMaxDuration = var_378_7

					if var_378_7 + var_378_2 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_7 + var_378_2
					end
				end

				arg_375_1.text_.text = var_378_5
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441090", "story_v_out_121441.awb") ~= 0 then
					local var_378_8 = manager.audio:GetVoiceLength("story_v_out_121441", "121441090", "story_v_out_121441.awb") / 1000

					if var_378_8 + var_378_2 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_8 + var_378_2
					end

					if var_378_4.prefab_name ~= "" and arg_375_1.actors_[var_378_4.prefab_name] ~= nil then
						local var_378_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_4.prefab_name].transform, "story_v_out_121441", "121441090", "story_v_out_121441.awb")

						arg_375_1:RecordAudio("121441090", var_378_9)
						arg_375_1:RecordAudio("121441090", var_378_9)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_121441", "121441090", "story_v_out_121441.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_121441", "121441090", "story_v_out_121441.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_10 = math.max(var_378_3, arg_375_1.talkMaxDuration)

			if var_378_2 <= arg_375_1.time_ and arg_375_1.time_ < var_378_2 + var_378_10 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_2) / var_378_10

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_2 + var_378_10 and arg_375_1.time_ < var_378_2 + var_378_10 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play121441091 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 121441091
		arg_379_1.duration_ = 8.47

		local var_379_0 = {
			ja = 8.466,
			ko = 5.7,
			zh = 5.7
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play121441092(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(arg_379_1.actors_["1076ui_story"]) and arg_379_1.var_.characterEffect1076ui_story == nil then
				arg_379_1.var_.characterEffect1076ui_story = arg_379_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_0 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 and not isNil(arg_379_1.actors_["1076ui_story"]) then
				if arg_379_1.var_.characterEffect1076ui_story and not isNil(arg_379_1.actors_["1076ui_story"]) then
					arg_379_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 and not isNil(arg_379_1.actors_["1076ui_story"]) and arg_379_1.var_.characterEffect1076ui_story then
				arg_379_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_382_2 = arg_379_1.actors_["1075ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_2) and arg_379_1.var_.characterEffect1075ui_story == nil then
				arg_379_1.var_.characterEffect1075ui_story = var_382_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_3 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_3 and not isNil(var_382_2) then
				if arg_379_1.var_.characterEffect1075ui_story and not isNil(var_382_2) then
					arg_379_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_379_1.time_ - 0) / var_382_3)
				end
			end

			if arg_379_1.time_ >= 0 + var_382_3 and arg_379_1.time_ < 0 + var_382_3 + arg_382_0 and not isNil(var_382_2) and arg_379_1.var_.characterEffect1075ui_story then
				arg_379_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_382_4 = 0
			local var_382_5 = 0.625

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_4 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_6 = arg_379_1:GetWordFromCfg(121441091)
				local var_382_7 = arg_379_1:FormatText(var_382_6.content)

				arg_379_1.text_.text = var_382_7

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_9 = 25 <= 0 and var_382_5 or var_382_5 * (utf8.len(var_382_7) / 25)

				if (25 <= 0 and var_382_5 or var_382_5 * (utf8.len(var_382_7) / 25)) > 0 and var_382_5 < var_382_9 then
					arg_379_1.talkMaxDuration = var_382_9

					if var_382_9 + var_382_4 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_9 + var_382_4
					end
				end

				arg_379_1.text_.text = var_382_7
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441091", "story_v_out_121441.awb") ~= 0 then
					local var_382_10 = manager.audio:GetVoiceLength("story_v_out_121441", "121441091", "story_v_out_121441.awb") / 1000

					if var_382_10 + var_382_4 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_10 + var_382_4
					end

					if var_382_6.prefab_name ~= "" and arg_379_1.actors_[var_382_6.prefab_name] ~= nil then
						local var_382_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_6.prefab_name].transform, "story_v_out_121441", "121441091", "story_v_out_121441.awb")

						arg_379_1:RecordAudio("121441091", var_382_11)
						arg_379_1:RecordAudio("121441091", var_382_11)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_121441", "121441091", "story_v_out_121441.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_121441", "121441091", "story_v_out_121441.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_12 = math.max(var_382_5, arg_379_1.talkMaxDuration)

			if var_382_4 <= arg_379_1.time_ and arg_379_1.time_ < var_382_4 + var_382_12 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_4) / var_382_12

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_4 + var_382_12 and arg_379_1.time_ < var_382_4 + var_382_12 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play121441092 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 121441092
		arg_383_1.duration_ = 4.3

		local var_383_0 = {
			ja = 4.3,
			ko = 3.066,
			zh = 3.066
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play121441093(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos1076ui_story = arg_383_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_386_0 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 then
				arg_383_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_383_1.time_ - 0) / var_386_0)
				arg_383_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1076ui_story"].transform.position).z)
				arg_383_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["1076ui_story"].transform.localEulerAngles = arg_383_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 then
				arg_383_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_383_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1076ui_story"].transform.position).z)
				arg_383_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["1076ui_story"].transform.localEulerAngles = arg_383_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_386_1 = arg_383_1.actors_["1076ui_story"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_1) and arg_383_1.var_.characterEffect1076ui_story == nil then
				arg_383_1.var_.characterEffect1076ui_story = var_386_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_2 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_2 and not isNil(var_386_1) then
				if arg_383_1.var_.characterEffect1076ui_story and not isNil(var_386_1) then
					arg_383_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_383_1.time_ - 0) / var_386_2)
				end
			end

			if arg_383_1.time_ >= 0 + var_386_2 and arg_383_1.time_ < 0 + var_386_2 + arg_386_0 and not isNil(var_386_1) and arg_383_1.var_.characterEffect1076ui_story then
				arg_383_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_386_3 = arg_383_1.actors_["1075ui_story"].transform

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos1075ui_story = var_386_3.localPosition
			end

			local var_386_4 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_4 then
				var_386_3.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_383_1.time_ - 0) / var_386_4)
				var_386_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_386_3.position).x, (manager.ui.mainCamera.transform.position - var_386_3.position).y, (manager.ui.mainCamera.transform.position - var_386_3.position).z)
				var_386_3.localEulerAngles.z = 0
				var_386_3.localEulerAngles.x = 0
				var_386_3.localEulerAngles = var_386_3.localEulerAngles
			end

			if arg_383_1.time_ >= 0 + var_386_4 and arg_383_1.time_ < 0 + var_386_4 + arg_386_0 then
				var_386_3.localPosition = Vector3.New(0, 100, 0)
				var_386_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_386_3.position).x, (manager.ui.mainCamera.transform.position - var_386_3.position).y, (manager.ui.mainCamera.transform.position - var_386_3.position).z)
				var_386_3.localEulerAngles.z = 0
				var_386_3.localEulerAngles.x = 0
				var_386_3.localEulerAngles = var_386_3.localEulerAngles
			end

			local var_386_5 = arg_383_1.actors_["1075ui_story"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_5) and arg_383_1.var_.characterEffect1075ui_story == nil then
				arg_383_1.var_.characterEffect1075ui_story = var_386_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_6 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_6 and not isNil(var_386_5) then
				if arg_383_1.var_.characterEffect1075ui_story and not isNil(var_386_5) then
					arg_383_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_383_1.time_ - 0) / var_386_6)
				end
			end

			if arg_383_1.time_ >= 0 + var_386_6 and arg_383_1.time_ < 0 + var_386_6 + arg_386_0 and not isNil(var_386_5) and arg_383_1.var_.characterEffect1075ui_story then
				arg_383_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_386_7 = arg_383_1.actors_["1084ui_story"].transform

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos1084ui_story = var_386_7.localPosition
			end

			local var_386_8 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_8 then
				var_386_7.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_383_1.time_ - 0) / var_386_8)
				var_386_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_386_7.position).x, (manager.ui.mainCamera.transform.position - var_386_7.position).y, (manager.ui.mainCamera.transform.position - var_386_7.position).z)
				var_386_7.localEulerAngles.z = 0
				var_386_7.localEulerAngles.x = 0
				var_386_7.localEulerAngles = var_386_7.localEulerAngles
			end

			if arg_383_1.time_ >= 0 + var_386_8 and arg_383_1.time_ < 0 + var_386_8 + arg_386_0 then
				var_386_7.localPosition = Vector3.New(0, -0.97, -6)
				var_386_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_386_7.position).x, (manager.ui.mainCamera.transform.position - var_386_7.position).y, (manager.ui.mainCamera.transform.position - var_386_7.position).z)
				var_386_7.localEulerAngles.z = 0
				var_386_7.localEulerAngles.x = 0
				var_386_7.localEulerAngles = var_386_7.localEulerAngles
			end

			local var_386_9 = arg_383_1.actors_["1084ui_story"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_9) and arg_383_1.var_.characterEffect1084ui_story == nil then
				arg_383_1.var_.characterEffect1084ui_story = var_386_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_10 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_10 and not isNil(var_386_9) then
				if arg_383_1.var_.characterEffect1084ui_story and not isNil(var_386_9) then
					arg_383_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= 0 + var_386_10 and arg_383_1.time_ < 0 + var_386_10 + arg_386_0 and not isNil(var_386_9) and arg_383_1.var_.characterEffect1084ui_story then
				arg_383_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_386_12 = 0
			local var_386_13 = 0.25

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_12 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_14 = arg_383_1:GetWordFromCfg(121441092)
				local var_386_15 = arg_383_1:FormatText(var_386_14.content)

				arg_383_1.text_.text = var_386_15

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_17 = 10 <= 0 and var_386_13 or var_386_13 * (utf8.len(var_386_15) / 10)

				if (10 <= 0 and var_386_13 or var_386_13 * (utf8.len(var_386_15) / 10)) > 0 and var_386_13 < var_386_17 then
					arg_383_1.talkMaxDuration = var_386_17

					if var_386_17 + var_386_12 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_17 + var_386_12
					end
				end

				arg_383_1.text_.text = var_386_15
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441092", "story_v_out_121441.awb") ~= 0 then
					local var_386_18 = manager.audio:GetVoiceLength("story_v_out_121441", "121441092", "story_v_out_121441.awb") / 1000

					if var_386_18 + var_386_12 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_18 + var_386_12
					end

					if var_386_14.prefab_name ~= "" and arg_383_1.actors_[var_386_14.prefab_name] ~= nil then
						local var_386_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_14.prefab_name].transform, "story_v_out_121441", "121441092", "story_v_out_121441.awb")

						arg_383_1:RecordAudio("121441092", var_386_19)
						arg_383_1:RecordAudio("121441092", var_386_19)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_121441", "121441092", "story_v_out_121441.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_121441", "121441092", "story_v_out_121441.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_20 = math.max(var_386_13, arg_383_1.talkMaxDuration)

			if var_386_12 <= arg_383_1.time_ and arg_383_1.time_ < var_386_12 + var_386_20 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_12) / var_386_20

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_12 + var_386_20 and arg_383_1.time_ < var_386_12 + var_386_20 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play121441093 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 121441093
		arg_387_1.duration_ = 14.17

		local var_387_0 = {
			ja = 14.166,
			ko = 8.433,
			zh = 8.433
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play121441094(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(arg_387_1.actors_["1084ui_story"]) and arg_387_1.var_.characterEffect1084ui_story == nil then
				arg_387_1.var_.characterEffect1084ui_story = arg_387_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_0 = 0.200000002980232

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 and not isNil(arg_387_1.actors_["1084ui_story"]) then
				if arg_387_1.var_.characterEffect1084ui_story and not isNil(arg_387_1.actors_["1084ui_story"]) then
					arg_387_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_387_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_387_1.time_ - 0) / var_390_0)
				end
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 and not isNil(arg_387_1.actors_["1084ui_story"]) and arg_387_1.var_.characterEffect1084ui_story then
				arg_387_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_387_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_390_1 = arg_387_1.actors_["1076ui_story"]

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(var_390_1) and arg_387_1.var_.characterEffect1076ui_story == nil then
				arg_387_1.var_.characterEffect1076ui_story = var_390_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_2 = 0.200000002980232

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_2 and not isNil(var_390_1) then
				if arg_387_1.var_.characterEffect1076ui_story and not isNil(var_390_1) then
					arg_387_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= 0 + var_390_2 and arg_387_1.time_ < 0 + var_390_2 + arg_390_0 and not isNil(var_390_1) and arg_387_1.var_.characterEffect1076ui_story then
				arg_387_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_390_4 = arg_387_1.actors_["1075ui_story"].transform

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos1075ui_story = var_390_4.localPosition
			end

			local var_390_5 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_5 then
				var_390_4.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_387_1.time_ - 0) / var_390_5)
				var_390_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_390_4.position).x, (manager.ui.mainCamera.transform.position - var_390_4.position).y, (manager.ui.mainCamera.transform.position - var_390_4.position).z)
				var_390_4.localEulerAngles.z = 0
				var_390_4.localEulerAngles.x = 0
				var_390_4.localEulerAngles = var_390_4.localEulerAngles
			end

			if arg_387_1.time_ >= 0 + var_390_5 and arg_387_1.time_ < 0 + var_390_5 + arg_390_0 then
				var_390_4.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_390_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_390_4.position).x, (manager.ui.mainCamera.transform.position - var_390_4.position).y, (manager.ui.mainCamera.transform.position - var_390_4.position).z)
				var_390_4.localEulerAngles.z = 0
				var_390_4.localEulerAngles.x = 0
				var_390_4.localEulerAngles = var_390_4.localEulerAngles
			end

			local var_390_6 = arg_387_1.actors_["1075ui_story"]

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(var_390_6) and arg_387_1.var_.characterEffect1075ui_story == nil then
				arg_387_1.var_.characterEffect1075ui_story = var_390_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_7 = 0.200000002980232

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_7 and not isNil(var_390_6) then
				if arg_387_1.var_.characterEffect1075ui_story and not isNil(var_390_6) then
					arg_387_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_387_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_387_1.time_ - 0) / var_390_7)
				end
			end

			if arg_387_1.time_ >= 0 + var_390_7 and arg_387_1.time_ < 0 + var_390_7 + arg_390_0 and not isNil(var_390_6) and arg_387_1.var_.characterEffect1075ui_story then
				arg_387_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_387_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_390_8 = arg_387_1.actors_["1076ui_story"].transform

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos1076ui_story = var_390_8.localPosition
			end

			local var_390_9 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_9 then
				var_390_8.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_387_1.time_ - 0) / var_390_9)
				var_390_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_390_8.position).x, (manager.ui.mainCamera.transform.position - var_390_8.position).y, (manager.ui.mainCamera.transform.position - var_390_8.position).z)
				var_390_8.localEulerAngles.z = 0
				var_390_8.localEulerAngles.x = 0
				var_390_8.localEulerAngles = var_390_8.localEulerAngles
			end

			if arg_387_1.time_ >= 0 + var_390_9 and arg_387_1.time_ < 0 + var_390_9 + arg_390_0 then
				var_390_8.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_390_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_390_8.position).x, (manager.ui.mainCamera.transform.position - var_390_8.position).y, (manager.ui.mainCamera.transform.position - var_390_8.position).z)
				var_390_8.localEulerAngles.z = 0
				var_390_8.localEulerAngles.x = 0
				var_390_8.localEulerAngles = var_390_8.localEulerAngles
			end

			local var_390_10 = arg_387_1.actors_["1084ui_story"].transform

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos1084ui_story = var_390_10.localPosition
			end

			local var_390_11 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_11 then
				var_390_10.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_387_1.time_ - 0) / var_390_11)
				var_390_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_390_10.position).x, (manager.ui.mainCamera.transform.position - var_390_10.position).y, (manager.ui.mainCamera.transform.position - var_390_10.position).z)
				var_390_10.localEulerAngles.z = 0
				var_390_10.localEulerAngles.x = 0
				var_390_10.localEulerAngles = var_390_10.localEulerAngles
			end

			if arg_387_1.time_ >= 0 + var_390_11 and arg_387_1.time_ < 0 + var_390_11 + arg_390_0 then
				var_390_10.localPosition = Vector3.New(0, 100, 0)
				var_390_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_390_10.position).x, (manager.ui.mainCamera.transform.position - var_390_10.position).y, (manager.ui.mainCamera.transform.position - var_390_10.position).z)
				var_390_10.localEulerAngles.z = 0
				var_390_10.localEulerAngles.x = 0
				var_390_10.localEulerAngles = var_390_10.localEulerAngles
			end

			local var_390_12 = 0
			local var_390_13 = 1

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_12 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_14 = arg_387_1:GetWordFromCfg(121441093)
				local var_390_15 = arg_387_1:FormatText(var_390_14.content)

				arg_387_1.text_.text = var_390_15

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_17 = 40 <= 0 and var_390_13 or var_390_13 * (utf8.len(var_390_15) / 40)

				if (40 <= 0 and var_390_13 or var_390_13 * (utf8.len(var_390_15) / 40)) > 0 and var_390_13 < var_390_17 then
					arg_387_1.talkMaxDuration = var_390_17

					if var_390_17 + var_390_12 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_17 + var_390_12
					end
				end

				arg_387_1.text_.text = var_390_15
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441093", "story_v_out_121441.awb") ~= 0 then
					local var_390_18 = manager.audio:GetVoiceLength("story_v_out_121441", "121441093", "story_v_out_121441.awb") / 1000

					if var_390_18 + var_390_12 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_18 + var_390_12
					end

					if var_390_14.prefab_name ~= "" and arg_387_1.actors_[var_390_14.prefab_name] ~= nil then
						local var_390_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_14.prefab_name].transform, "story_v_out_121441", "121441093", "story_v_out_121441.awb")

						arg_387_1:RecordAudio("121441093", var_390_19)
						arg_387_1:RecordAudio("121441093", var_390_19)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_121441", "121441093", "story_v_out_121441.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_121441", "121441093", "story_v_out_121441.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_20 = math.max(var_390_13, arg_387_1.talkMaxDuration)

			if var_390_12 <= arg_387_1.time_ and arg_387_1.time_ < var_390_12 + var_390_20 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_12) / var_390_20

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_12 + var_390_20 and arg_387_1.time_ < var_390_12 + var_390_20 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_387_1:InitPlayNodeList()
	end,
	Play121441094 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 121441094
		arg_391_1.duration_ = 13.17

		local var_391_0 = {
			ja = 13.166,
			ko = 7.966,
			zh = 7.966
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play121441095(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(arg_391_1.actors_["1076ui_story"]) and arg_391_1.var_.characterEffect1076ui_story == nil then
				arg_391_1.var_.characterEffect1076ui_story = arg_391_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_0 = 0.200000002980232

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 and not isNil(arg_391_1.actors_["1076ui_story"]) then
				if arg_391_1.var_.characterEffect1076ui_story and not isNil(arg_391_1.actors_["1076ui_story"]) then
					arg_391_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 and not isNil(arg_391_1.actors_["1076ui_story"]) and arg_391_1.var_.characterEffect1076ui_story then
				arg_391_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_394_2 = 0
			local var_394_3 = 0.9

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_2 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_4 = arg_391_1:GetWordFromCfg(121441094)
				local var_394_5 = arg_391_1:FormatText(var_394_4.content)

				arg_391_1.text_.text = var_394_5

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_7 = 36 <= 0 and var_394_3 or var_394_3 * (utf8.len(var_394_5) / 36)

				if (36 <= 0 and var_394_3 or var_394_3 * (utf8.len(var_394_5) / 36)) > 0 and var_394_3 < var_394_7 then
					arg_391_1.talkMaxDuration = var_394_7

					if var_394_7 + var_394_2 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_7 + var_394_2
					end
				end

				arg_391_1.text_.text = var_394_5
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441094", "story_v_out_121441.awb") ~= 0 then
					local var_394_8 = manager.audio:GetVoiceLength("story_v_out_121441", "121441094", "story_v_out_121441.awb") / 1000

					if var_394_8 + var_394_2 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_8 + var_394_2
					end

					if var_394_4.prefab_name ~= "" and arg_391_1.actors_[var_394_4.prefab_name] ~= nil then
						local var_394_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_4.prefab_name].transform, "story_v_out_121441", "121441094", "story_v_out_121441.awb")

						arg_391_1:RecordAudio("121441094", var_394_9)
						arg_391_1:RecordAudio("121441094", var_394_9)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_121441", "121441094", "story_v_out_121441.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_121441", "121441094", "story_v_out_121441.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_10 = math.max(var_394_3, arg_391_1.talkMaxDuration)

			if var_394_2 <= arg_391_1.time_ and arg_391_1.time_ < var_394_2 + var_394_10 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_2) / var_394_10

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_2 + var_394_10 and arg_391_1.time_ < var_394_2 + var_394_10 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play121441095 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 121441095
		arg_395_1.duration_ = 12.1

		local var_395_0 = {
			ja = 12.1,
			ko = 10.366,
			zh = 10.366
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play121441096(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(arg_395_1.actors_["1075ui_story"]) and arg_395_1.var_.characterEffect1075ui_story == nil then
				arg_395_1.var_.characterEffect1075ui_story = arg_395_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_0 = 0.200000002980232

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 and not isNil(arg_395_1.actors_["1075ui_story"]) then
				if arg_395_1.var_.characterEffect1075ui_story and not isNil(arg_395_1.actors_["1075ui_story"]) then
					arg_395_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 and not isNil(arg_395_1.actors_["1075ui_story"]) and arg_395_1.var_.characterEffect1075ui_story then
				arg_395_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_398_2 = arg_395_1.actors_["1076ui_story"]

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(var_398_2) and arg_395_1.var_.characterEffect1076ui_story == nil then
				arg_395_1.var_.characterEffect1076ui_story = var_398_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_3 = 0.200000002980232

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_3 and not isNil(var_398_2) then
				if arg_395_1.var_.characterEffect1076ui_story and not isNil(var_398_2) then
					arg_395_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_395_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_395_1.time_ - 0) / var_398_3)
				end
			end

			if arg_395_1.time_ >= 0 + var_398_3 and arg_395_1.time_ < 0 + var_398_3 + arg_398_0 and not isNil(var_398_2) and arg_395_1.var_.characterEffect1076ui_story then
				arg_395_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_395_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_398_4 = 0
			local var_398_5 = 1.05

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_4 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_6 = arg_395_1:GetWordFromCfg(121441095)
				local var_398_7 = arg_395_1:FormatText(var_398_6.content)

				arg_395_1.text_.text = var_398_7

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_9 = 42 <= 0 and var_398_5 or var_398_5 * (utf8.len(var_398_7) / 42)

				if (42 <= 0 and var_398_5 or var_398_5 * (utf8.len(var_398_7) / 42)) > 0 and var_398_5 < var_398_9 then
					arg_395_1.talkMaxDuration = var_398_9

					if var_398_9 + var_398_4 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_9 + var_398_4
					end
				end

				arg_395_1.text_.text = var_398_7
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441095", "story_v_out_121441.awb") ~= 0 then
					local var_398_10 = manager.audio:GetVoiceLength("story_v_out_121441", "121441095", "story_v_out_121441.awb") / 1000

					if var_398_10 + var_398_4 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_10 + var_398_4
					end

					if var_398_6.prefab_name ~= "" and arg_395_1.actors_[var_398_6.prefab_name] ~= nil then
						local var_398_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_6.prefab_name].transform, "story_v_out_121441", "121441095", "story_v_out_121441.awb")

						arg_395_1:RecordAudio("121441095", var_398_11)
						arg_395_1:RecordAudio("121441095", var_398_11)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_121441", "121441095", "story_v_out_121441.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_121441", "121441095", "story_v_out_121441.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_12 = math.max(var_398_5, arg_395_1.talkMaxDuration)

			if var_398_4 <= arg_395_1.time_ and arg_395_1.time_ < var_398_4 + var_398_12 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_4) / var_398_12

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_4 + var_398_12 and arg_395_1.time_ < var_398_4 + var_398_12 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play121441096 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 121441096
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play121441097(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(arg_399_1.actors_["1075ui_story"]) and arg_399_1.var_.characterEffect1075ui_story == nil then
				arg_399_1.var_.characterEffect1075ui_story = arg_399_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_0 = 0.200000002980232

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 and not isNil(arg_399_1.actors_["1075ui_story"]) then
				if arg_399_1.var_.characterEffect1075ui_story and not isNil(arg_399_1.actors_["1075ui_story"]) then
					arg_399_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_399_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_399_1.time_ - 0) / var_402_0)
				end
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 and not isNil(arg_399_1.actors_["1075ui_story"]) and arg_399_1.var_.characterEffect1075ui_story then
				arg_399_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_399_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_402_1 = 0
			local var_402_2 = 0.175

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_3 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(121441096).content)

				arg_399_1.text_.text = var_402_3

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_5 = 7 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_3) / 7)

				if (7 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_3) / 7)) > 0 and var_402_2 < var_402_5 then
					arg_399_1.talkMaxDuration = var_402_5

					if var_402_5 + var_402_1 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_5 + var_402_1
					end
				end

				arg_399_1.text_.text = var_402_3
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_6 = math.max(var_402_2, arg_399_1.talkMaxDuration)

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_6 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_1) / var_402_6

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_1 + var_402_6 and arg_399_1.time_ < var_402_1 + var_402_6 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play121441097 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 121441097
		arg_403_1.duration_ = 6.93

		local var_403_0 = {
			ja = 4.933,
			ko = 6.933,
			zh = 6.933
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play121441098(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos1076ui_story = arg_403_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_406_0 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 then
				arg_403_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_403_1.time_ - 0) / var_406_0)
				arg_403_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1076ui_story"].transform.position).z)
				arg_403_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1076ui_story"].transform.localEulerAngles = arg_403_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 then
				arg_403_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_403_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1076ui_story"].transform.position).z)
				arg_403_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1076ui_story"].transform.localEulerAngles = arg_403_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_406_1 = arg_403_1.actors_["1076ui_story"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1076ui_story == nil then
				arg_403_1.var_.characterEffect1076ui_story = var_406_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_2 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_2 and not isNil(var_406_1) then
				if arg_403_1.var_.characterEffect1076ui_story and not isNil(var_406_1) then
					arg_403_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_403_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_403_1.time_ - 0) / var_406_2)
				end
			end

			if arg_403_1.time_ >= 0 + var_406_2 and arg_403_1.time_ < 0 + var_406_2 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1076ui_story then
				arg_403_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_403_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_406_3 = arg_403_1.actors_["1075ui_story"].transform

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos1075ui_story = var_406_3.localPosition
			end

			local var_406_4 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_4 then
				var_406_3.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_403_1.time_ - 0) / var_406_4)
				var_406_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_406_3.position).x, (manager.ui.mainCamera.transform.position - var_406_3.position).y, (manager.ui.mainCamera.transform.position - var_406_3.position).z)
				var_406_3.localEulerAngles.z = 0
				var_406_3.localEulerAngles.x = 0
				var_406_3.localEulerAngles = var_406_3.localEulerAngles
			end

			if arg_403_1.time_ >= 0 + var_406_4 and arg_403_1.time_ < 0 + var_406_4 + arg_406_0 then
				var_406_3.localPosition = Vector3.New(0, 100, 0)
				var_406_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_406_3.position).x, (manager.ui.mainCamera.transform.position - var_406_3.position).y, (manager.ui.mainCamera.transform.position - var_406_3.position).z)
				var_406_3.localEulerAngles.z = 0
				var_406_3.localEulerAngles.x = 0
				var_406_3.localEulerAngles = var_406_3.localEulerAngles
			end

			local var_406_5 = arg_403_1.actors_["1075ui_story"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_5) and arg_403_1.var_.characterEffect1075ui_story == nil then
				arg_403_1.var_.characterEffect1075ui_story = var_406_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_6 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_6 and not isNil(var_406_5) then
				if arg_403_1.var_.characterEffect1075ui_story and not isNil(var_406_5) then
					arg_403_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_403_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_403_1.time_ - 0) / var_406_6)
				end
			end

			if arg_403_1.time_ >= 0 + var_406_6 and arg_403_1.time_ < 0 + var_406_6 + arg_406_0 and not isNil(var_406_5) and arg_403_1.var_.characterEffect1075ui_story then
				arg_403_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_403_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_406_7 = arg_403_1.actors_["1084ui_story"].transform

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos1084ui_story = var_406_7.localPosition
			end

			local var_406_8 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_8 then
				var_406_7.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_403_1.time_ - 0) / var_406_8)
				var_406_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_406_7.position).x, (manager.ui.mainCamera.transform.position - var_406_7.position).y, (manager.ui.mainCamera.transform.position - var_406_7.position).z)
				var_406_7.localEulerAngles.z = 0
				var_406_7.localEulerAngles.x = 0
				var_406_7.localEulerAngles = var_406_7.localEulerAngles
			end

			if arg_403_1.time_ >= 0 + var_406_8 and arg_403_1.time_ < 0 + var_406_8 + arg_406_0 then
				var_406_7.localPosition = Vector3.New(0, -0.97, -6)
				var_406_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_406_7.position).x, (manager.ui.mainCamera.transform.position - var_406_7.position).y, (manager.ui.mainCamera.transform.position - var_406_7.position).z)
				var_406_7.localEulerAngles.z = 0
				var_406_7.localEulerAngles.x = 0
				var_406_7.localEulerAngles = var_406_7.localEulerAngles
			end

			local var_406_9 = arg_403_1.actors_["1084ui_story"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_9) and arg_403_1.var_.characterEffect1084ui_story == nil then
				arg_403_1.var_.characterEffect1084ui_story = var_406_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_10 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_10 and not isNil(var_406_9) then
				if arg_403_1.var_.characterEffect1084ui_story and not isNil(var_406_9) then
					arg_403_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= 0 + var_406_10 and arg_403_1.time_ < 0 + var_406_10 + arg_406_0 and not isNil(var_406_9) and arg_403_1.var_.characterEffect1084ui_story then
				arg_403_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_406_12 = 0
			local var_406_13 = 0.75

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_12 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_14 = arg_403_1:GetWordFromCfg(121441097)
				local var_406_15 = arg_403_1:FormatText(var_406_14.content)

				arg_403_1.text_.text = var_406_15

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_17 = 30 <= 0 and var_406_13 or var_406_13 * (utf8.len(var_406_15) / 30)

				if (30 <= 0 and var_406_13 or var_406_13 * (utf8.len(var_406_15) / 30)) > 0 and var_406_13 < var_406_17 then
					arg_403_1.talkMaxDuration = var_406_17

					if var_406_17 + var_406_12 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_17 + var_406_12
					end
				end

				arg_403_1.text_.text = var_406_15
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441097", "story_v_out_121441.awb") ~= 0 then
					local var_406_18 = manager.audio:GetVoiceLength("story_v_out_121441", "121441097", "story_v_out_121441.awb") / 1000

					if var_406_18 + var_406_12 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_18 + var_406_12
					end

					if var_406_14.prefab_name ~= "" and arg_403_1.actors_[var_406_14.prefab_name] ~= nil then
						local var_406_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_14.prefab_name].transform, "story_v_out_121441", "121441097", "story_v_out_121441.awb")

						arg_403_1:RecordAudio("121441097", var_406_19)
						arg_403_1:RecordAudio("121441097", var_406_19)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_121441", "121441097", "story_v_out_121441.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_121441", "121441097", "story_v_out_121441.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_20 = math.max(var_406_13, arg_403_1.talkMaxDuration)

			if var_406_12 <= arg_403_1.time_ and arg_403_1.time_ < var_406_12 + var_406_20 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_12) / var_406_20

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_12 + var_406_20 and arg_403_1.time_ < var_406_12 + var_406_20 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play121441098 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 121441098
		arg_407_1.duration_ = 4

		local var_407_0 = {
			ja = 4,
			ko = 2.4,
			zh = 2.4
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play121441099(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.var_.moveOldPos1084ui_story = arg_407_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_410_0 = 0.001

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 then
				arg_407_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_407_1.time_ - 0) / var_410_0)
				arg_407_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_407_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1084ui_story"].transform.position).z)
				arg_407_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_407_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_407_1.actors_["1084ui_story"].transform.localEulerAngles = arg_407_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 then
				arg_407_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_407_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_407_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1084ui_story"].transform.position).z)
				arg_407_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_407_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_407_1.actors_["1084ui_story"].transform.localEulerAngles = arg_407_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_410_1 = arg_407_1.actors_["1084ui_story"]

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(var_410_1) and arg_407_1.var_.characterEffect1084ui_story == nil then
				arg_407_1.var_.characterEffect1084ui_story = var_410_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_2 = 0.200000002980232

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_2 and not isNil(var_410_1) then
				if arg_407_1.var_.characterEffect1084ui_story and not isNil(var_410_1) then
					arg_407_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_407_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_407_1.time_ - 0) / var_410_2)
				end
			end

			if arg_407_1.time_ >= 0 + var_410_2 and arg_407_1.time_ < 0 + var_410_2 + arg_410_0 and not isNil(var_410_1) and arg_407_1.var_.characterEffect1084ui_story then
				arg_407_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_407_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_410_3 = arg_407_1.actors_["1076ui_story"].transform

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.var_.moveOldPos1076ui_story = var_410_3.localPosition
			end

			local var_410_4 = 0.001

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_4 then
				var_410_3.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_407_1.time_ - 0) / var_410_4)
				var_410_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_410_3.position).x, (manager.ui.mainCamera.transform.position - var_410_3.position).y, (manager.ui.mainCamera.transform.position - var_410_3.position).z)
				var_410_3.localEulerAngles.z = 0
				var_410_3.localEulerAngles.x = 0
				var_410_3.localEulerAngles = var_410_3.localEulerAngles
			end

			if arg_407_1.time_ >= 0 + var_410_4 and arg_407_1.time_ < 0 + var_410_4 + arg_410_0 then
				var_410_3.localPosition = Vector3.New(0, -1.06, -6.2)
				var_410_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_410_3.position).x, (manager.ui.mainCamera.transform.position - var_410_3.position).y, (manager.ui.mainCamera.transform.position - var_410_3.position).z)
				var_410_3.localEulerAngles.z = 0
				var_410_3.localEulerAngles.x = 0
				var_410_3.localEulerAngles = var_410_3.localEulerAngles
			end

			local var_410_5 = arg_407_1.actors_["1076ui_story"]

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(var_410_5) and arg_407_1.var_.characterEffect1076ui_story == nil then
				arg_407_1.var_.characterEffect1076ui_story = var_410_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_6 = 0.200000002980232

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_6 and not isNil(var_410_5) then
				if arg_407_1.var_.characterEffect1076ui_story and not isNil(var_410_5) then
					arg_407_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= 0 + var_410_6 and arg_407_1.time_ < 0 + var_410_6 + arg_410_0 and not isNil(var_410_5) and arg_407_1.var_.characterEffect1076ui_story then
				arg_407_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_410_8 = 0
			local var_410_9 = 0.175

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_8 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_10 = arg_407_1:GetWordFromCfg(121441098)
				local var_410_11 = arg_407_1:FormatText(var_410_10.content)

				arg_407_1.text_.text = var_410_11

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_13 = 7 <= 0 and var_410_9 or var_410_9 * (utf8.len(var_410_11) / 7)

				if (7 <= 0 and var_410_9 or var_410_9 * (utf8.len(var_410_11) / 7)) > 0 and var_410_9 < var_410_13 then
					arg_407_1.talkMaxDuration = var_410_13

					if var_410_13 + var_410_8 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_13 + var_410_8
					end
				end

				arg_407_1.text_.text = var_410_11
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441098", "story_v_out_121441.awb") ~= 0 then
					local var_410_14 = manager.audio:GetVoiceLength("story_v_out_121441", "121441098", "story_v_out_121441.awb") / 1000

					if var_410_14 + var_410_8 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_14 + var_410_8
					end

					if var_410_10.prefab_name ~= "" and arg_407_1.actors_[var_410_10.prefab_name] ~= nil then
						local var_410_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_10.prefab_name].transform, "story_v_out_121441", "121441098", "story_v_out_121441.awb")

						arg_407_1:RecordAudio("121441098", var_410_15)
						arg_407_1:RecordAudio("121441098", var_410_15)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_121441", "121441098", "story_v_out_121441.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_121441", "121441098", "story_v_out_121441.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_16 = math.max(var_410_9, arg_407_1.talkMaxDuration)

			if var_410_8 <= arg_407_1.time_ and arg_407_1.time_ < var_410_8 + var_410_16 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_8) / var_410_16

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_8 + var_410_16 and arg_407_1.time_ < var_410_8 + var_410_16 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_407_1:InitPlayNodeList()
	end,
	Play121441099 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 121441099
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play121441100(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos1076ui_story = arg_411_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_414_0 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_0 then
				arg_411_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_411_1.time_ - 0) / var_414_0)
				arg_411_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_411_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1076ui_story"].transform.position).z)
				arg_411_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_411_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_411_1.actors_["1076ui_story"].transform.localEulerAngles = arg_411_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_411_1.time_ >= 0 + var_414_0 and arg_411_1.time_ < 0 + var_414_0 + arg_414_0 then
				arg_411_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_411_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_411_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1076ui_story"].transform.position).z)
				arg_411_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_411_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_411_1.actors_["1076ui_story"].transform.localEulerAngles = arg_411_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_414_1 = arg_411_1.actors_["1076ui_story"]

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(var_414_1) and arg_411_1.var_.characterEffect1076ui_story == nil then
				arg_411_1.var_.characterEffect1076ui_story = var_414_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_2 = 0.200000002980232

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_2 and not isNil(var_414_1) then
				if arg_411_1.var_.characterEffect1076ui_story and not isNil(var_414_1) then
					arg_411_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_411_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_411_1.time_ - 0) / var_414_2)
				end
			end

			if arg_411_1.time_ >= 0 + var_414_2 and arg_411_1.time_ < 0 + var_414_2 + arg_414_0 and not isNil(var_414_1) and arg_411_1.var_.characterEffect1076ui_story then
				arg_411_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_411_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_414_3 = 0
			local var_414_4 = 0.675

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_3 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, false)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_5 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(121441099).content)

				arg_411_1.text_.text = var_414_5

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_7 = 27 <= 0 and var_414_4 or var_414_4 * (utf8.len(var_414_5) / 27)

				if (27 <= 0 and var_414_4 or var_414_4 * (utf8.len(var_414_5) / 27)) > 0 and var_414_4 < var_414_7 then
					arg_411_1.talkMaxDuration = var_414_7

					if var_414_7 + var_414_3 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_7 + var_414_3
					end
				end

				arg_411_1.text_.text = var_414_5
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_8 = math.max(var_414_4, arg_411_1.talkMaxDuration)

			if var_414_3 <= arg_411_1.time_ and arg_411_1.time_ < var_414_3 + var_414_8 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_3) / var_414_8

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_3 + var_414_8 and arg_411_1.time_ < var_414_3 + var_414_8 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_411_1:InitPlayNodeList()
	end,
	Play121441100 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 121441100
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play121441101(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0.85

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, false)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_1 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(121441100).content)

				arg_415_1.text_.text = var_418_1

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_3 = 34 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_1) / 34)

				if (34 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_1) / 34)) > 0 and var_418_0 < var_418_3 then
					arg_415_1.talkMaxDuration = var_418_3

					if var_418_3 + 0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_3 + 0
					end
				end

				arg_415_1.text_.text = var_418_1
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_4 = math.max(var_418_0, arg_415_1.talkMaxDuration)

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_4 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - 0) / var_418_4

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= 0 + var_418_4 and arg_415_1.time_ < 0 + var_418_4 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play121441101 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 121441101
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play121441102(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 1.25

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_1 = arg_419_1:FormatText(arg_419_1:GetWordFromCfg(121441101).content)

				arg_419_1.text_.text = var_422_1

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_3 = 50 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_1) / 50)

				if (50 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_1) / 50)) > 0 and var_422_0 < var_422_3 then
					arg_419_1.talkMaxDuration = var_422_3

					if var_422_3 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_3 + 0
					end
				end

				arg_419_1.text_.text = var_422_1
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_4 = math.max(var_422_0, arg_419_1.talkMaxDuration)

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_4 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - 0) / var_422_4

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= 0 + var_422_4 and arg_419_1.time_ < 0 + var_422_4 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play121441102 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 121441102
		arg_423_1.duration_ = 12.9

		local var_423_0 = {
			ja = 12.9,
			ko = 8.066,
			zh = 8.066
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play121441103(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.var_.moveOldPos1076ui_story = arg_423_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_426_0 = 0.001

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 then
				arg_423_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_423_1.time_ - 0) / var_426_0)
				arg_423_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_423_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1076ui_story"].transform.position).z)
				arg_423_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_423_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_423_1.actors_["1076ui_story"].transform.localEulerAngles = arg_423_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 then
				arg_423_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_423_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_423_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1076ui_story"].transform.position).z)
				arg_423_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_423_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_423_1.actors_["1076ui_story"].transform.localEulerAngles = arg_423_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_426_1 = arg_423_1.actors_["1076ui_story"]

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1076ui_story == nil then
				arg_423_1.var_.characterEffect1076ui_story = var_426_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_2 = 0.200000002980232

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_2 and not isNil(var_426_1) then
				if arg_423_1.var_.characterEffect1076ui_story and not isNil(var_426_1) then
					arg_423_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= 0 + var_426_2 and arg_423_1.time_ < 0 + var_426_2 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1076ui_story then
				arg_423_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action2_1")
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_426_4 = 0
			local var_426_5 = 0.85

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_4 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_6 = arg_423_1:GetWordFromCfg(121441102)
				local var_426_7 = arg_423_1:FormatText(var_426_6.content)

				arg_423_1.text_.text = var_426_7

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_9 = 34 <= 0 and var_426_5 or var_426_5 * (utf8.len(var_426_7) / 34)

				if (34 <= 0 and var_426_5 or var_426_5 * (utf8.len(var_426_7) / 34)) > 0 and var_426_5 < var_426_9 then
					arg_423_1.talkMaxDuration = var_426_9

					if var_426_9 + var_426_4 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_9 + var_426_4
					end
				end

				arg_423_1.text_.text = var_426_7
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441102", "story_v_out_121441.awb") ~= 0 then
					local var_426_10 = manager.audio:GetVoiceLength("story_v_out_121441", "121441102", "story_v_out_121441.awb") / 1000

					if var_426_10 + var_426_4 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_10 + var_426_4
					end

					if var_426_6.prefab_name ~= "" and arg_423_1.actors_[var_426_6.prefab_name] ~= nil then
						local var_426_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_6.prefab_name].transform, "story_v_out_121441", "121441102", "story_v_out_121441.awb")

						arg_423_1:RecordAudio("121441102", var_426_11)
						arg_423_1:RecordAudio("121441102", var_426_11)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_121441", "121441102", "story_v_out_121441.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_121441", "121441102", "story_v_out_121441.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_12 = math.max(var_426_5, arg_423_1.talkMaxDuration)

			if var_426_4 <= arg_423_1.time_ and arg_423_1.time_ < var_426_4 + var_426_12 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_4) / var_426_12

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_4 + var_426_12 and arg_423_1.time_ < var_426_4 + var_426_12 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_423_1:InitPlayNodeList()
	end,
	Play121441103 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 121441103
		arg_427_1.duration_ = 10.07

		local var_427_0 = {
			ja = 8.366,
			ko = 10.066,
			zh = 10.066
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play121441104(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 1.075

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_1 = arg_427_1:GetWordFromCfg(121441103)
				local var_430_2 = arg_427_1:FormatText(var_430_1.content)

				arg_427_1.text_.text = var_430_2

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_4 = 43 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_2) / 43)

				if (43 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_2) / 43)) > 0 and var_430_0 < var_430_4 then
					arg_427_1.talkMaxDuration = var_430_4

					if var_430_4 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_4 + 0
					end
				end

				arg_427_1.text_.text = var_430_2
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441103", "story_v_out_121441.awb") ~= 0 then
					local var_430_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441103", "story_v_out_121441.awb") / 1000

					if var_430_5 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_5 + 0
					end

					if var_430_1.prefab_name ~= "" and arg_427_1.actors_[var_430_1.prefab_name] ~= nil then
						local var_430_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_1.prefab_name].transform, "story_v_out_121441", "121441103", "story_v_out_121441.awb")

						arg_427_1:RecordAudio("121441103", var_430_6)
						arg_427_1:RecordAudio("121441103", var_430_6)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_121441", "121441103", "story_v_out_121441.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_121441", "121441103", "story_v_out_121441.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_7 = math.max(var_430_0, arg_427_1.talkMaxDuration)

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_7 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - 0) / var_430_7

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= 0 + var_430_7 and arg_427_1.time_ < 0 + var_430_7 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play121441104 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 121441104
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play121441105(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(arg_431_1.actors_["1076ui_story"]) and arg_431_1.var_.characterEffect1076ui_story == nil then
				arg_431_1.var_.characterEffect1076ui_story = arg_431_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_0 = 0.200000002980232

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 and not isNil(arg_431_1.actors_["1076ui_story"]) then
				if arg_431_1.var_.characterEffect1076ui_story and not isNil(arg_431_1.actors_["1076ui_story"]) then
					arg_431_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_431_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_431_1.time_ - 0) / var_434_0)
				end
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 and not isNil(arg_431_1.actors_["1076ui_story"]) and arg_431_1.var_.characterEffect1076ui_story then
				arg_431_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_431_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_434_1 = 0
			local var_434_2 = 0.4

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_3 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(121441104).content)

				arg_431_1.text_.text = var_434_3

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_5 = 16 <= 0 and var_434_2 or var_434_2 * (utf8.len(var_434_3) / 16)

				if (16 <= 0 and var_434_2 or var_434_2 * (utf8.len(var_434_3) / 16)) > 0 and var_434_2 < var_434_5 then
					arg_431_1.talkMaxDuration = var_434_5

					if var_434_5 + var_434_1 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_5 + var_434_1
					end
				end

				arg_431_1.text_.text = var_434_3
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_6 = math.max(var_434_2, arg_431_1.talkMaxDuration)

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_6 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_1) / var_434_6

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_1 + var_434_6 and arg_431_1.time_ < var_434_1 + var_434_6 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play121441105 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 121441105
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play121441106(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0.85

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_435_1.callingController_:SetSelectedState("normal")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_1 = arg_435_1:FormatText(arg_435_1:GetWordFromCfg(121441105).content)

				arg_435_1.text_.text = var_438_1

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_3 = 34 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_1) / 34)

				if (34 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_1) / 34)) > 0 and var_438_0 < var_438_3 then
					arg_435_1.talkMaxDuration = var_438_3

					if var_438_3 + 0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_3 + 0
					end
				end

				arg_435_1.text_.text = var_438_1
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_4 = math.max(var_438_0, arg_435_1.talkMaxDuration)

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_4 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - 0) / var_438_4

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= 0 + var_438_4 and arg_435_1.time_ < 0 + var_438_4 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play121441106 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 121441106
		arg_439_1.duration_ = 13.7

		local var_439_0 = {
			ja = 13.7,
			ko = 7.7,
			zh = 7.7
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play121441107(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(arg_439_1.actors_["1076ui_story"]) and arg_439_1.var_.characterEffect1076ui_story == nil then
				arg_439_1.var_.characterEffect1076ui_story = arg_439_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_0 = 0.200000002980232

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 and not isNil(arg_439_1.actors_["1076ui_story"]) then
				if arg_439_1.var_.characterEffect1076ui_story and not isNil(arg_439_1.actors_["1076ui_story"]) then
					arg_439_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 and not isNil(arg_439_1.actors_["1076ui_story"]) and arg_439_1.var_.characterEffect1076ui_story then
				arg_439_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action2_2")
			end

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_442_2 = 0
			local var_442_3 = 0.85

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_2 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_4 = arg_439_1:GetWordFromCfg(121441106)
				local var_442_5 = arg_439_1:FormatText(var_442_4.content)

				arg_439_1.text_.text = var_442_5

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_7 = 34 <= 0 and var_442_3 or var_442_3 * (utf8.len(var_442_5) / 34)

				if (34 <= 0 and var_442_3 or var_442_3 * (utf8.len(var_442_5) / 34)) > 0 and var_442_3 < var_442_7 then
					arg_439_1.talkMaxDuration = var_442_7

					if var_442_7 + var_442_2 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_7 + var_442_2
					end
				end

				arg_439_1.text_.text = var_442_5
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441106", "story_v_out_121441.awb") ~= 0 then
					local var_442_8 = manager.audio:GetVoiceLength("story_v_out_121441", "121441106", "story_v_out_121441.awb") / 1000

					if var_442_8 + var_442_2 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_8 + var_442_2
					end

					if var_442_4.prefab_name ~= "" and arg_439_1.actors_[var_442_4.prefab_name] ~= nil then
						local var_442_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_4.prefab_name].transform, "story_v_out_121441", "121441106", "story_v_out_121441.awb")

						arg_439_1:RecordAudio("121441106", var_442_9)
						arg_439_1:RecordAudio("121441106", var_442_9)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_121441", "121441106", "story_v_out_121441.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_121441", "121441106", "story_v_out_121441.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_10 = math.max(var_442_3, arg_439_1.talkMaxDuration)

			if var_442_2 <= arg_439_1.time_ and arg_439_1.time_ < var_442_2 + var_442_10 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_2) / var_442_10

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_2 + var_442_10 and arg_439_1.time_ < var_442_2 + var_442_10 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play121441107 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 121441107
		arg_443_1.duration_ = 11

		local var_443_0 = {
			ja = 11,
			ko = 7,
			zh = 7
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play121441108(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 1.025

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_1 = arg_443_1:GetWordFromCfg(121441107)
				local var_446_2 = arg_443_1:FormatText(var_446_1.content)

				arg_443_1.text_.text = var_446_2

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_4 = 41 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_2) / 41)

				if (41 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_2) / 41)) > 0 and var_446_0 < var_446_4 then
					arg_443_1.talkMaxDuration = var_446_4

					if var_446_4 + 0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_4 + 0
					end
				end

				arg_443_1.text_.text = var_446_2
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441107", "story_v_out_121441.awb") ~= 0 then
					local var_446_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441107", "story_v_out_121441.awb") / 1000

					if var_446_5 + 0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_5 + 0
					end

					if var_446_1.prefab_name ~= "" and arg_443_1.actors_[var_446_1.prefab_name] ~= nil then
						local var_446_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_1.prefab_name].transform, "story_v_out_121441", "121441107", "story_v_out_121441.awb")

						arg_443_1:RecordAudio("121441107", var_446_6)
						arg_443_1:RecordAudio("121441107", var_446_6)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_121441", "121441107", "story_v_out_121441.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_121441", "121441107", "story_v_out_121441.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_7 = math.max(var_446_0, arg_443_1.talkMaxDuration)

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_7 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - 0) / var_446_7

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= 0 + var_446_7 and arg_443_1.time_ < 0 + var_446_7 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play121441108 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 121441108
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play121441109(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.var_.moveOldPos1076ui_story = arg_447_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_450_0 = 0.001

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_0 then
				arg_447_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_447_1.time_ - 0) / var_450_0)
				arg_447_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_447_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["1076ui_story"].transform.position).z)
				arg_447_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_447_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_447_1.actors_["1076ui_story"].transform.localEulerAngles = arg_447_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_447_1.time_ >= 0 + var_450_0 and arg_447_1.time_ < 0 + var_450_0 + arg_450_0 then
				arg_447_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_447_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_447_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["1076ui_story"].transform.position).z)
				arg_447_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_447_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_447_1.actors_["1076ui_story"].transform.localEulerAngles = arg_447_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_450_1 = arg_447_1.actors_["1076ui_story"]

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 and not isNil(var_450_1) and arg_447_1.var_.characterEffect1076ui_story == nil then
				arg_447_1.var_.characterEffect1076ui_story = var_450_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_2 = 0.200000002980232

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_2 and not isNil(var_450_1) then
				if arg_447_1.var_.characterEffect1076ui_story and not isNil(var_450_1) then
					arg_447_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_447_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_447_1.time_ - 0) / var_450_2)
				end
			end

			if arg_447_1.time_ >= 0 + var_450_2 and arg_447_1.time_ < 0 + var_450_2 + arg_450_0 and not isNil(var_450_1) and arg_447_1.var_.characterEffect1076ui_story then
				arg_447_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_447_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_450_3 = 0
			local var_450_4 = 0.3

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_3 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, false)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_5 = arg_447_1:FormatText(arg_447_1:GetWordFromCfg(121441108).content)

				arg_447_1.text_.text = var_450_5

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_7 = 12 <= 0 and var_450_4 or var_450_4 * (utf8.len(var_450_5) / 12)

				if (12 <= 0 and var_450_4 or var_450_4 * (utf8.len(var_450_5) / 12)) > 0 and var_450_4 < var_450_7 then
					arg_447_1.talkMaxDuration = var_450_7

					if var_450_7 + var_450_3 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_7 + var_450_3
					end
				end

				arg_447_1.text_.text = var_450_5
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_8 = math.max(var_450_4, arg_447_1.talkMaxDuration)

			if var_450_3 <= arg_447_1.time_ and arg_447_1.time_ < var_450_3 + var_450_8 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_3) / var_450_8

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_3 + var_450_8 and arg_447_1.time_ < var_450_3 + var_450_8 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_447_1:InitPlayNodeList()
	end,
	Play121441109 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 121441109
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play121441110(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 0.925

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, false)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_1 = arg_451_1:FormatText(arg_451_1:GetWordFromCfg(121441109).content)

				arg_451_1.text_.text = var_454_1

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_3 = 35 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_1) / 35)

				if (35 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_1) / 35)) > 0 and var_454_0 < var_454_3 then
					arg_451_1.talkMaxDuration = var_454_3

					if var_454_3 + 0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_3 + 0
					end
				end

				arg_451_1.text_.text = var_454_1
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_4 = math.max(var_454_0, arg_451_1.talkMaxDuration)

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_4 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - 0) / var_454_4

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= 0 + var_454_4 and arg_451_1.time_ < 0 + var_454_4 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play121441110 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 121441110
		arg_455_1.duration_ = 5

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play121441111(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 0.95

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, false)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_1 = arg_455_1:FormatText(arg_455_1:GetWordFromCfg(121441110).content)

				arg_455_1.text_.text = var_458_1

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_3 = 38 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_1) / 38)

				if (38 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_1) / 38)) > 0 and var_458_0 < var_458_3 then
					arg_455_1.talkMaxDuration = var_458_3

					if var_458_3 + 0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_3 + 0
					end
				end

				arg_455_1.text_.text = var_458_1
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_4 = math.max(var_458_0, arg_455_1.talkMaxDuration)

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_4 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - 0) / var_458_4

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= 0 + var_458_4 and arg_455_1.time_ < 0 + var_458_4 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play121441111 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 121441111
		arg_459_1.duration_ = 6.63

		local var_459_0 = {
			ja = 6.633,
			ko = 4.933,
			zh = 4.933
		}
		local var_459_1 = manager.audio:GetLocalizationFlag()

		if var_459_0[var_459_1] ~= nil then
			arg_459_1.duration_ = var_459_0[var_459_1]
		end

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play121441112(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1.var_.moveOldPos1084ui_story = arg_459_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_462_0 = 0.001

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_0 then
				arg_459_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_459_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_459_1.time_ - 0) / var_462_0)
				arg_459_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_459_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_459_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_459_1.actors_["1084ui_story"].transform.position).z)
				arg_459_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_459_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_459_1.actors_["1084ui_story"].transform.localEulerAngles = arg_459_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_459_1.time_ >= 0 + var_462_0 and arg_459_1.time_ < 0 + var_462_0 + arg_462_0 then
				arg_459_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_459_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_459_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_459_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_459_1.actors_["1084ui_story"].transform.position).z)
				arg_459_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_459_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_459_1.actors_["1084ui_story"].transform.localEulerAngles = arg_459_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_462_1 = arg_459_1.actors_["1084ui_story"]

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 and not isNil(var_462_1) and arg_459_1.var_.characterEffect1084ui_story == nil then
				arg_459_1.var_.characterEffect1084ui_story = var_462_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_2 = 0.200000002980232

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_2 and not isNil(var_462_1) then
				if arg_459_1.var_.characterEffect1084ui_story and not isNil(var_462_1) then
					arg_459_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_459_1.time_ >= 0 + var_462_2 and arg_459_1.time_ < 0 + var_462_2 + arg_462_0 and not isNil(var_462_1) and arg_459_1.var_.characterEffect1084ui_story then
				arg_459_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_462_4 = 0
			local var_462_5 = 0.6

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_4 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				arg_459_1.leftNameTxt_.text = arg_459_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_6 = arg_459_1:GetWordFromCfg(121441111)
				local var_462_7 = arg_459_1:FormatText(var_462_6.content)

				arg_459_1.text_.text = var_462_7

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_9 = 24 <= 0 and var_462_5 or var_462_5 * (utf8.len(var_462_7) / 24)

				if (24 <= 0 and var_462_5 or var_462_5 * (utf8.len(var_462_7) / 24)) > 0 and var_462_5 < var_462_9 then
					arg_459_1.talkMaxDuration = var_462_9

					if var_462_9 + var_462_4 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_9 + var_462_4
					end
				end

				arg_459_1.text_.text = var_462_7
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441111", "story_v_out_121441.awb") ~= 0 then
					local var_462_10 = manager.audio:GetVoiceLength("story_v_out_121441", "121441111", "story_v_out_121441.awb") / 1000

					if var_462_10 + var_462_4 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_10 + var_462_4
					end

					if var_462_6.prefab_name ~= "" and arg_459_1.actors_[var_462_6.prefab_name] ~= nil then
						local var_462_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_6.prefab_name].transform, "story_v_out_121441", "121441111", "story_v_out_121441.awb")

						arg_459_1:RecordAudio("121441111", var_462_11)
						arg_459_1:RecordAudio("121441111", var_462_11)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_121441", "121441111", "story_v_out_121441.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_121441", "121441111", "story_v_out_121441.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_12 = math.max(var_462_5, arg_459_1.talkMaxDuration)

			if var_462_4 <= arg_459_1.time_ and arg_459_1.time_ < var_462_4 + var_462_12 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_4) / var_462_12

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_4 + var_462_12 and arg_459_1.time_ < var_462_4 + var_462_12 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_459_1:InitPlayNodeList()
	end,
	Play121441112 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 121441112
		arg_463_1.duration_ = 15.53

		local var_463_0 = {
			ja = 15.533,
			ko = 8.466,
			zh = 8.466
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play121441113(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.var_.moveOldPos1084ui_story = arg_463_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_466_0 = 0.001

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_0 then
				arg_463_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_463_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_463_1.time_ - 0) / var_466_0)
				arg_463_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_463_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_463_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_463_1.actors_["1084ui_story"].transform.position).z)
				arg_463_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_463_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_463_1.actors_["1084ui_story"].transform.localEulerAngles = arg_463_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_463_1.time_ >= 0 + var_466_0 and arg_463_1.time_ < 0 + var_466_0 + arg_466_0 then
				arg_463_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_463_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_463_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_463_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_463_1.actors_["1084ui_story"].transform.position).z)
				arg_463_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_463_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_463_1.actors_["1084ui_story"].transform.localEulerAngles = arg_463_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_466_1 = arg_463_1.actors_["1084ui_story"]

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 and not isNil(var_466_1) and arg_463_1.var_.characterEffect1084ui_story == nil then
				arg_463_1.var_.characterEffect1084ui_story = var_466_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_2 = 0.200000002980232

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_2 and not isNil(var_466_1) then
				if arg_463_1.var_.characterEffect1084ui_story and not isNil(var_466_1) then
					arg_463_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_463_1.time_ >= 0 + var_466_2 and arg_463_1.time_ < 0 + var_466_2 + arg_466_0 and not isNil(var_466_1) and arg_463_1.var_.characterEffect1084ui_story then
				arg_463_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action438")
			end

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_466_4 = 0
			local var_466_5 = 0.95

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_4 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_6 = arg_463_1:GetWordFromCfg(121441112)
				local var_466_7 = arg_463_1:FormatText(var_466_6.content)

				arg_463_1.text_.text = var_466_7

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_9 = 38 <= 0 and var_466_5 or var_466_5 * (utf8.len(var_466_7) / 38)

				if (38 <= 0 and var_466_5 or var_466_5 * (utf8.len(var_466_7) / 38)) > 0 and var_466_5 < var_466_9 then
					arg_463_1.talkMaxDuration = var_466_9

					if var_466_9 + var_466_4 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_9 + var_466_4
					end
				end

				arg_463_1.text_.text = var_466_7
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441112", "story_v_out_121441.awb") ~= 0 then
					local var_466_10 = manager.audio:GetVoiceLength("story_v_out_121441", "121441112", "story_v_out_121441.awb") / 1000

					if var_466_10 + var_466_4 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_10 + var_466_4
					end

					if var_466_6.prefab_name ~= "" and arg_463_1.actors_[var_466_6.prefab_name] ~= nil then
						local var_466_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_6.prefab_name].transform, "story_v_out_121441", "121441112", "story_v_out_121441.awb")

						arg_463_1:RecordAudio("121441112", var_466_11)
						arg_463_1:RecordAudio("121441112", var_466_11)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_121441", "121441112", "story_v_out_121441.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_121441", "121441112", "story_v_out_121441.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_12 = math.max(var_466_5, arg_463_1.talkMaxDuration)

			if var_466_4 <= arg_463_1.time_ and arg_463_1.time_ < var_466_4 + var_466_12 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_4) / var_466_12

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_4 + var_466_12 and arg_463_1.time_ < var_466_4 + var_466_12 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_463_1:InitPlayNodeList()
	end,
	Play121441113 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 121441113
		arg_467_1.duration_ = 9.4

		local var_467_0 = {
			ja = 9.4,
			ko = 5.566,
			zh = 5.566
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play121441114(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.var_.moveOldPos1084ui_story = arg_467_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_470_0 = 0.001

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_0 then
				arg_467_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_467_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_467_1.time_ - 0) / var_470_0)
				arg_467_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_467_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_467_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_467_1.actors_["1084ui_story"].transform.position).z)
				arg_467_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_467_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_467_1.actors_["1084ui_story"].transform.localEulerAngles = arg_467_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_467_1.time_ >= 0 + var_470_0 and arg_467_1.time_ < 0 + var_470_0 + arg_470_0 then
				arg_467_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_467_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_467_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_467_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_467_1.actors_["1084ui_story"].transform.position).z)
				arg_467_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_467_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_467_1.actors_["1084ui_story"].transform.localEulerAngles = arg_467_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_470_1 = arg_467_1.actors_["1084ui_story"]

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 and not isNil(var_470_1) and arg_467_1.var_.characterEffect1084ui_story == nil then
				arg_467_1.var_.characterEffect1084ui_story = var_470_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_2 = 0.200000002980232

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_2 and not isNil(var_470_1) then
				if arg_467_1.var_.characterEffect1084ui_story and not isNil(var_470_1) then
					arg_467_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_467_1.time_ >= 0 + var_470_2 and arg_467_1.time_ < 0 + var_470_2 + arg_470_0 and not isNil(var_470_1) and arg_467_1.var_.characterEffect1084ui_story then
				arg_467_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_470_4 = 0
			local var_470_5 = 0.675

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_4 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_6 = arg_467_1:GetWordFromCfg(121441113)
				local var_470_7 = arg_467_1:FormatText(var_470_6.content)

				arg_467_1.text_.text = var_470_7

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_9 = 27 <= 0 and var_470_5 or var_470_5 * (utf8.len(var_470_7) / 27)

				if (27 <= 0 and var_470_5 or var_470_5 * (utf8.len(var_470_7) / 27)) > 0 and var_470_5 < var_470_9 then
					arg_467_1.talkMaxDuration = var_470_9

					if var_470_9 + var_470_4 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_9 + var_470_4
					end
				end

				arg_467_1.text_.text = var_470_7
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441113", "story_v_out_121441.awb") ~= 0 then
					local var_470_10 = manager.audio:GetVoiceLength("story_v_out_121441", "121441113", "story_v_out_121441.awb") / 1000

					if var_470_10 + var_470_4 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_10 + var_470_4
					end

					if var_470_6.prefab_name ~= "" and arg_467_1.actors_[var_470_6.prefab_name] ~= nil then
						local var_470_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_6.prefab_name].transform, "story_v_out_121441", "121441113", "story_v_out_121441.awb")

						arg_467_1:RecordAudio("121441113", var_470_11)
						arg_467_1:RecordAudio("121441113", var_470_11)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_121441", "121441113", "story_v_out_121441.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_121441", "121441113", "story_v_out_121441.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_12 = math.max(var_470_5, arg_467_1.talkMaxDuration)

			if var_470_4 <= arg_467_1.time_ and arg_467_1.time_ < var_470_4 + var_470_12 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_4) / var_470_12

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_4 + var_470_12 and arg_467_1.time_ < var_470_4 + var_470_12 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_467_1:InitPlayNodeList()
	end,
	Play121441114 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 121441114
		arg_471_1.duration_ = 7.2

		local var_471_0 = {
			ja = 7.2,
			ko = 5.466,
			zh = 5.466
		}
		local var_471_1 = manager.audio:GetLocalizationFlag()

		if var_471_0[var_471_1] ~= nil then
			arg_471_1.duration_ = var_471_0[var_471_1]
		end

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play121441115(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.var_.moveOldPos1084ui_story = arg_471_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_474_0 = 0.001

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_0 then
				arg_471_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_471_1.time_ - 0) / var_474_0)
				arg_471_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_471_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["1084ui_story"].transform.position).z)
				arg_471_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_471_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_471_1.actors_["1084ui_story"].transform.localEulerAngles = arg_471_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_471_1.time_ >= 0 + var_474_0 and arg_471_1.time_ < 0 + var_474_0 + arg_474_0 then
				arg_471_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_471_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_471_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_471_1.actors_["1084ui_story"].transform.position).z)
				arg_471_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_471_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_471_1.actors_["1084ui_story"].transform.localEulerAngles = arg_471_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_474_1 = arg_471_1.actors_["1084ui_story"]

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 and not isNil(var_474_1) and arg_471_1.var_.characterEffect1084ui_story == nil then
				arg_471_1.var_.characterEffect1084ui_story = var_474_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_2 = 0.200000002980232

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_2 and not isNil(var_474_1) then
				if arg_471_1.var_.characterEffect1084ui_story and not isNil(var_474_1) then
					arg_471_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_471_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_471_1.time_ - 0) / var_474_2)
				end
			end

			if arg_471_1.time_ >= 0 + var_474_2 and arg_471_1.time_ < 0 + var_474_2 + arg_474_0 and not isNil(var_474_1) and arg_471_1.var_.characterEffect1084ui_story then
				arg_471_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_471_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_474_3 = arg_471_1.actors_["1075ui_story"].transform

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.var_.moveOldPos1075ui_story = var_474_3.localPosition
			end

			local var_474_4 = 0.001

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_4 then
				var_474_3.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_471_1.time_ - 0) / var_474_4)
				var_474_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_474_3.position).x, (manager.ui.mainCamera.transform.position - var_474_3.position).y, (manager.ui.mainCamera.transform.position - var_474_3.position).z)
				var_474_3.localEulerAngles.z = 0
				var_474_3.localEulerAngles.x = 0
				var_474_3.localEulerAngles = var_474_3.localEulerAngles
			end

			if arg_471_1.time_ >= 0 + var_474_4 and arg_471_1.time_ < 0 + var_474_4 + arg_474_0 then
				var_474_3.localPosition = Vector3.New(0, -1.055, -6.16)
				var_474_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_474_3.position).x, (manager.ui.mainCamera.transform.position - var_474_3.position).y, (manager.ui.mainCamera.transform.position - var_474_3.position).z)
				var_474_3.localEulerAngles.z = 0
				var_474_3.localEulerAngles.x = 0
				var_474_3.localEulerAngles = var_474_3.localEulerAngles
			end

			local var_474_5 = arg_471_1.actors_["1075ui_story"]

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 and not isNil(var_474_5) and arg_471_1.var_.characterEffect1075ui_story == nil then
				arg_471_1.var_.characterEffect1075ui_story = var_474_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_6 = 0.200000002980232

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_6 and not isNil(var_474_5) then
				if arg_471_1.var_.characterEffect1075ui_story and not isNil(var_474_5) then
					arg_471_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_471_1.time_ >= 0 + var_474_6 and arg_471_1.time_ < 0 + var_474_6 + arg_474_0 and not isNil(var_474_5) and arg_471_1.var_.characterEffect1075ui_story then
				arg_471_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_474_8 = 0
			local var_474_9 = 0.475

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_8 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				arg_471_1.leftNameTxt_.text = arg_471_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_10 = arg_471_1:GetWordFromCfg(121441114)
				local var_474_11 = arg_471_1:FormatText(var_474_10.content)

				arg_471_1.text_.text = var_474_11

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_13 = 19 <= 0 and var_474_9 or var_474_9 * (utf8.len(var_474_11) / 19)

				if (19 <= 0 and var_474_9 or var_474_9 * (utf8.len(var_474_11) / 19)) > 0 and var_474_9 < var_474_13 then
					arg_471_1.talkMaxDuration = var_474_13

					if var_474_13 + var_474_8 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_13 + var_474_8
					end
				end

				arg_471_1.text_.text = var_474_11
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441114", "story_v_out_121441.awb") ~= 0 then
					local var_474_14 = manager.audio:GetVoiceLength("story_v_out_121441", "121441114", "story_v_out_121441.awb") / 1000

					if var_474_14 + var_474_8 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_14 + var_474_8
					end

					if var_474_10.prefab_name ~= "" and arg_471_1.actors_[var_474_10.prefab_name] ~= nil then
						local var_474_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_10.prefab_name].transform, "story_v_out_121441", "121441114", "story_v_out_121441.awb")

						arg_471_1:RecordAudio("121441114", var_474_15)
						arg_471_1:RecordAudio("121441114", var_474_15)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_out_121441", "121441114", "story_v_out_121441.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_out_121441", "121441114", "story_v_out_121441.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_16 = math.max(var_474_9, arg_471_1.talkMaxDuration)

			if var_474_8 <= arg_471_1.time_ and arg_471_1.time_ < var_474_8 + var_474_16 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_8) / var_474_16

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_8 + var_474_16 and arg_471_1.time_ < var_474_8 + var_474_16 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_471_1:InitPlayNodeList()
	end,
	Play121441115 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 121441115
		arg_475_1.duration_ = 5

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play121441116(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.var_.moveOldPos1075ui_story = arg_475_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_478_0 = 0.001

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_0 then
				arg_475_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_475_1.time_ - 0) / var_478_0)
				arg_475_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_475_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["1075ui_story"].transform.position).z)
				arg_475_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_475_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_475_1.actors_["1075ui_story"].transform.localEulerAngles = arg_475_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_475_1.time_ >= 0 + var_478_0 and arg_475_1.time_ < 0 + var_478_0 + arg_478_0 then
				arg_475_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_475_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_475_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["1075ui_story"].transform.position).z)
				arg_475_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_475_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_475_1.actors_["1075ui_story"].transform.localEulerAngles = arg_475_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_478_1 = arg_475_1.actors_["1075ui_story"]

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(var_478_1) and arg_475_1.var_.characterEffect1075ui_story == nil then
				arg_475_1.var_.characterEffect1075ui_story = var_478_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_2 = 0.200000002980232

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_2 and not isNil(var_478_1) then
				if arg_475_1.var_.characterEffect1075ui_story and not isNil(var_478_1) then
					arg_475_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_475_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_475_1.time_ - 0) / var_478_2)
				end
			end

			if arg_475_1.time_ >= 0 + var_478_2 and arg_475_1.time_ < 0 + var_478_2 + arg_478_0 and not isNil(var_478_1) and arg_475_1.var_.characterEffect1075ui_story then
				arg_475_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_475_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_478_3 = 0
			local var_478_4 = 0.925

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_3 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, false)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_5 = arg_475_1:FormatText(arg_475_1:GetWordFromCfg(121441115).content)

				arg_475_1.text_.text = var_478_5

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_7 = 37 <= 0 and var_478_4 or var_478_4 * (utf8.len(var_478_5) / 37)

				if (37 <= 0 and var_478_4 or var_478_4 * (utf8.len(var_478_5) / 37)) > 0 and var_478_4 < var_478_7 then
					arg_475_1.talkMaxDuration = var_478_7

					if var_478_7 + var_478_3 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_7 + var_478_3
					end
				end

				arg_475_1.text_.text = var_478_5
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)
				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_8 = math.max(var_478_4, arg_475_1.talkMaxDuration)

			if var_478_3 <= arg_475_1.time_ and arg_475_1.time_ < var_478_3 + var_478_8 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_3) / var_478_8

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_3 + var_478_8 and arg_475_1.time_ < var_478_3 + var_478_8 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_475_1:InitPlayNodeList()
	end,
	Play121441116 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 121441116
		arg_479_1.duration_ = 5

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play121441117(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = 0.55

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, true)
				arg_479_1.iconController_:SetSelectedState("hero")

				arg_479_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_479_1.callingController_:SetSelectedState("normal")

				arg_479_1.keyicon_.color = Color.New(1, 1, 1)
				arg_479_1.icon_.color = Color.New(1, 1, 1)

				local var_482_1 = arg_479_1:FormatText(arg_479_1:GetWordFromCfg(121441116).content)

				arg_479_1.text_.text = var_482_1

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_3 = 22 <= 0 and var_482_0 or var_482_0 * (utf8.len(var_482_1) / 22)

				if (22 <= 0 and var_482_0 or var_482_0 * (utf8.len(var_482_1) / 22)) > 0 and var_482_0 < var_482_3 then
					arg_479_1.talkMaxDuration = var_482_3

					if var_482_3 + 0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_3 + 0
					end
				end

				arg_479_1.text_.text = var_482_1
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)
				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_4 = math.max(var_482_0, arg_479_1.talkMaxDuration)

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_4 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - 0) / var_482_4

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= 0 + var_482_4 and arg_479_1.time_ < 0 + var_482_4 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play121441117 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 121441117
		arg_483_1.duration_ = 6.4

		local var_483_0 = {
			ja = 6.4,
			ko = 5.2,
			zh = 5.2
		}
		local var_483_1 = manager.audio:GetLocalizationFlag()

		if var_483_0[var_483_1] ~= nil then
			arg_483_1.duration_ = var_483_0[var_483_1]
		end

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play121441118(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.var_.moveOldPos1084ui_story = arg_483_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_486_0 = 0.001

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_0 then
				arg_483_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_483_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_483_1.time_ - 0) / var_486_0)
				arg_483_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_483_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["1084ui_story"].transform.position).z)
				arg_483_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_483_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_483_1.actors_["1084ui_story"].transform.localEulerAngles = arg_483_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_483_1.time_ >= 0 + var_486_0 and arg_483_1.time_ < 0 + var_486_0 + arg_486_0 then
				arg_483_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_483_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_483_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["1084ui_story"].transform.position).z)
				arg_483_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_483_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_483_1.actors_["1084ui_story"].transform.localEulerAngles = arg_483_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_486_1 = arg_483_1.actors_["1084ui_story"]

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 and not isNil(var_486_1) and arg_483_1.var_.characterEffect1084ui_story == nil then
				arg_483_1.var_.characterEffect1084ui_story = var_486_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_2 = 0.200000002980232

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_2 and not isNil(var_486_1) then
				if arg_483_1.var_.characterEffect1084ui_story and not isNil(var_486_1) then
					arg_483_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_483_1.time_ >= 0 + var_486_2 and arg_483_1.time_ < 0 + var_486_2 + arg_486_0 and not isNil(var_486_1) and arg_483_1.var_.characterEffect1084ui_story then
				arg_483_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_486_4 = arg_483_1.actors_["1076ui_story"].transform

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.var_.moveOldPos1076ui_story = var_486_4.localPosition
			end

			local var_486_5 = 0.001

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_5 then
				var_486_4.localPosition = Vector3.Lerp(arg_483_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_483_1.time_ - 0) / var_486_5)
				var_486_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_486_4.position).x, (manager.ui.mainCamera.transform.position - var_486_4.position).y, (manager.ui.mainCamera.transform.position - var_486_4.position).z)
				var_486_4.localEulerAngles.z = 0
				var_486_4.localEulerAngles.x = 0
				var_486_4.localEulerAngles = var_486_4.localEulerAngles
			end

			if arg_483_1.time_ >= 0 + var_486_5 and arg_483_1.time_ < 0 + var_486_5 + arg_486_0 then
				var_486_4.localPosition = Vector3.New(0, 100, 0)
				var_486_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_486_4.position).x, (manager.ui.mainCamera.transform.position - var_486_4.position).y, (manager.ui.mainCamera.transform.position - var_486_4.position).z)
				var_486_4.localEulerAngles.z = 0
				var_486_4.localEulerAngles.x = 0
				var_486_4.localEulerAngles = var_486_4.localEulerAngles
			end

			local var_486_6 = 0
			local var_486_7 = 0.725

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_6 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_8 = arg_483_1:GetWordFromCfg(121441117)
				local var_486_9 = arg_483_1:FormatText(var_486_8.content)

				arg_483_1.text_.text = var_486_9

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_11 = 29 <= 0 and var_486_7 or var_486_7 * (utf8.len(var_486_9) / 29)

				if (29 <= 0 and var_486_7 or var_486_7 * (utf8.len(var_486_9) / 29)) > 0 and var_486_7 < var_486_11 then
					arg_483_1.talkMaxDuration = var_486_11

					if var_486_11 + var_486_6 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_11 + var_486_6
					end
				end

				arg_483_1.text_.text = var_486_9
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441117", "story_v_out_121441.awb") ~= 0 then
					local var_486_12 = manager.audio:GetVoiceLength("story_v_out_121441", "121441117", "story_v_out_121441.awb") / 1000

					if var_486_12 + var_486_6 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_12 + var_486_6
					end

					if var_486_8.prefab_name ~= "" and arg_483_1.actors_[var_486_8.prefab_name] ~= nil then
						local var_486_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_8.prefab_name].transform, "story_v_out_121441", "121441117", "story_v_out_121441.awb")

						arg_483_1:RecordAudio("121441117", var_486_13)
						arg_483_1:RecordAudio("121441117", var_486_13)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_out_121441", "121441117", "story_v_out_121441.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_out_121441", "121441117", "story_v_out_121441.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_14 = math.max(var_486_7, arg_483_1.talkMaxDuration)

			if var_486_6 <= arg_483_1.time_ and arg_483_1.time_ < var_486_6 + var_486_14 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_6) / var_486_14

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_6 + var_486_14 and arg_483_1.time_ < var_486_6 + var_486_14 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_483_1:InitPlayNodeList()
	end,
	Play121441118 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 121441118
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play121441119(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.var_.moveOldPos1084ui_story = arg_487_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_490_0 = 0.001

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_0 then
				arg_487_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_487_1.time_ - 0) / var_490_0)
				arg_487_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_487_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_487_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_487_1.actors_["1084ui_story"].transform.position).z)
				arg_487_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_487_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_487_1.actors_["1084ui_story"].transform.localEulerAngles = arg_487_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_487_1.time_ >= 0 + var_490_0 and arg_487_1.time_ < 0 + var_490_0 + arg_490_0 then
				arg_487_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_487_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_487_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_487_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_487_1.actors_["1084ui_story"].transform.position).z)
				arg_487_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_487_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_487_1.actors_["1084ui_story"].transform.localEulerAngles = arg_487_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_490_1 = 0
			local var_490_2 = 0.6

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_1 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, true)
				arg_487_1.iconController_:SetSelectedState("hero")

				arg_487_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_487_1.callingController_:SetSelectedState("normal")

				arg_487_1.keyicon_.color = Color.New(1, 1, 1)
				arg_487_1.icon_.color = Color.New(1, 1, 1)

				local var_490_3 = arg_487_1:FormatText(arg_487_1:GetWordFromCfg(121441118).content)

				arg_487_1.text_.text = var_490_3

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_5 = 24 <= 0 and var_490_2 or var_490_2 * (utf8.len(var_490_3) / 24)

				if (24 <= 0 and var_490_2 or var_490_2 * (utf8.len(var_490_3) / 24)) > 0 and var_490_2 < var_490_5 then
					arg_487_1.talkMaxDuration = var_490_5

					if var_490_5 + var_490_1 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_5 + var_490_1
					end
				end

				arg_487_1.text_.text = var_490_3
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_6 = math.max(var_490_2, arg_487_1.talkMaxDuration)

			if var_490_1 <= arg_487_1.time_ and arg_487_1.time_ < var_490_1 + var_490_6 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_1) / var_490_6

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_1 + var_490_6 and arg_487_1.time_ < var_490_1 + var_490_6 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_487_1:InitPlayNodeList()
	end,
	Play121441119 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 121441119
		arg_491_1.duration_ = 4.2

		local var_491_0 = {
			ja = 4.2,
			ko = 3.566,
			zh = 3.566
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play121441120(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 0.5

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, true)
				arg_491_1.iconController_:SetSelectedState("hero")

				arg_491_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_491_1.callingController_:SetSelectedState("normal")

				arg_491_1.keyicon_.color = Color.New(1, 1, 1)
				arg_491_1.icon_.color = Color.New(1, 1, 1)

				local var_494_1 = arg_491_1:GetWordFromCfg(121441119)
				local var_494_2 = arg_491_1:FormatText(var_494_1.content)

				arg_491_1.text_.text = var_494_2

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_4 = 20 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_2) / 20)

				if (20 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_2) / 20)) > 0 and var_494_0 < var_494_4 then
					arg_491_1.talkMaxDuration = var_494_4

					if var_494_4 + 0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_4 + 0
					end
				end

				arg_491_1.text_.text = var_494_2
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441119", "story_v_out_121441.awb") ~= 0 then
					local var_494_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441119", "story_v_out_121441.awb") / 1000

					if var_494_5 + 0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_5 + 0
					end

					if var_494_1.prefab_name ~= "" and arg_491_1.actors_[var_494_1.prefab_name] ~= nil then
						local var_494_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_1.prefab_name].transform, "story_v_out_121441", "121441119", "story_v_out_121441.awb")

						arg_491_1:RecordAudio("121441119", var_494_6)
						arg_491_1:RecordAudio("121441119", var_494_6)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_121441", "121441119", "story_v_out_121441.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_121441", "121441119", "story_v_out_121441.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_7 = math.max(var_494_0, arg_491_1.talkMaxDuration)

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_7 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - 0) / var_494_7

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= 0 + var_494_7 and arg_491_1.time_ < 0 + var_494_7 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play121441120 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 121441120
		arg_495_1.duration_ = 1.43

		local var_495_0 = {
			ja = 1.433,
			ko = 1.233,
			zh = 1.233
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play121441121(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.var_.moveOldPos1076ui_story = arg_495_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_498_0 = 0.001

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_0 then
				arg_495_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_495_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_495_1.time_ - 0) / var_498_0)
				arg_495_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_495_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1076ui_story"].transform.position).z)
				arg_495_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_495_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_495_1.actors_["1076ui_story"].transform.localEulerAngles = arg_495_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_495_1.time_ >= 0 + var_498_0 and arg_495_1.time_ < 0 + var_498_0 + arg_498_0 then
				arg_495_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_495_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_495_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1076ui_story"].transform.position).z)
				arg_495_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_495_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_495_1.actors_["1076ui_story"].transform.localEulerAngles = arg_495_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_498_1 = arg_495_1.actors_["1076ui_story"]

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(var_498_1) and arg_495_1.var_.characterEffect1076ui_story == nil then
				arg_495_1.var_.characterEffect1076ui_story = var_498_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_2 = 0.200000002980232

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_2 and not isNil(var_498_1) then
				if arg_495_1.var_.characterEffect1076ui_story and not isNil(var_498_1) then
					arg_495_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_495_1.time_ >= 0 + var_498_2 and arg_495_1.time_ < 0 + var_498_2 + arg_498_0 and not isNil(var_498_1) and arg_495_1.var_.characterEffect1076ui_story then
				arg_495_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_498_4 = 0
			local var_498_5 = 0.1

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_4 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_6 = arg_495_1:GetWordFromCfg(121441120)
				local var_498_7 = arg_495_1:FormatText(var_498_6.content)

				arg_495_1.text_.text = var_498_7

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_9 = 4 <= 0 and var_498_5 or var_498_5 * (utf8.len(var_498_7) / 4)

				if (4 <= 0 and var_498_5 or var_498_5 * (utf8.len(var_498_7) / 4)) > 0 and var_498_5 < var_498_9 then
					arg_495_1.talkMaxDuration = var_498_9

					if var_498_9 + var_498_4 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_9 + var_498_4
					end
				end

				arg_495_1.text_.text = var_498_7
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441120", "story_v_out_121441.awb") ~= 0 then
					local var_498_10 = manager.audio:GetVoiceLength("story_v_out_121441", "121441120", "story_v_out_121441.awb") / 1000

					if var_498_10 + var_498_4 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_10 + var_498_4
					end

					if var_498_6.prefab_name ~= "" and arg_495_1.actors_[var_498_6.prefab_name] ~= nil then
						local var_498_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_6.prefab_name].transform, "story_v_out_121441", "121441120", "story_v_out_121441.awb")

						arg_495_1:RecordAudio("121441120", var_498_11)
						arg_495_1:RecordAudio("121441120", var_498_11)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_121441", "121441120", "story_v_out_121441.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_121441", "121441120", "story_v_out_121441.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_12 = math.max(var_498_5, arg_495_1.talkMaxDuration)

			if var_498_4 <= arg_495_1.time_ and arg_495_1.time_ < var_498_4 + var_498_12 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_4) / var_498_12

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_4 + var_498_12 and arg_495_1.time_ < var_498_4 + var_498_12 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_495_1:InitPlayNodeList()
	end,
	Play121441121 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 121441121
		arg_499_1.duration_ = 1.6

		local var_499_0 = {
			ja = 0.999999999999,
			ko = 1.6,
			zh = 1.6
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play121441122(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(arg_499_1.actors_["1076ui_story"]) and arg_499_1.var_.characterEffect1076ui_story == nil then
				arg_499_1.var_.characterEffect1076ui_story = arg_499_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_0 = 0.200000002980232

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 and not isNil(arg_499_1.actors_["1076ui_story"]) then
				if arg_499_1.var_.characterEffect1076ui_story and not isNil(arg_499_1.actors_["1076ui_story"]) then
					arg_499_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_499_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_499_1.time_ - 0) / var_502_0)
				end
			end

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 and not isNil(arg_499_1.actors_["1076ui_story"]) and arg_499_1.var_.characterEffect1076ui_story then
				arg_499_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_499_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_502_1 = 0
			local var_502_2 = 0.075

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_1 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_3 = arg_499_1:GetWordFromCfg(121441121)
				local var_502_4 = arg_499_1:FormatText(var_502_3.content)

				arg_499_1.text_.text = var_502_4

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_6 = 3 <= 0 and var_502_2 or var_502_2 * (utf8.len(var_502_4) / 3)

				if (3 <= 0 and var_502_2 or var_502_2 * (utf8.len(var_502_4) / 3)) > 0 and var_502_2 < var_502_6 then
					arg_499_1.talkMaxDuration = var_502_6

					if var_502_6 + var_502_1 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_6 + var_502_1
					end
				end

				arg_499_1.text_.text = var_502_4
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441121", "story_v_out_121441.awb") ~= 0 then
					local var_502_7 = manager.audio:GetVoiceLength("story_v_out_121441", "121441121", "story_v_out_121441.awb") / 1000

					if var_502_7 + var_502_1 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_7 + var_502_1
					end

					if var_502_3.prefab_name ~= "" and arg_499_1.actors_[var_502_3.prefab_name] ~= nil then
						local var_502_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_3.prefab_name].transform, "story_v_out_121441", "121441121", "story_v_out_121441.awb")

						arg_499_1:RecordAudio("121441121", var_502_8)
						arg_499_1:RecordAudio("121441121", var_502_8)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_121441", "121441121", "story_v_out_121441.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_121441", "121441121", "story_v_out_121441.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_9 = math.max(var_502_2, arg_499_1.talkMaxDuration)

			if var_502_1 <= arg_499_1.time_ and arg_499_1.time_ < var_502_1 + var_502_9 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_1) / var_502_9

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_1 + var_502_9 and arg_499_1.time_ < var_502_1 + var_502_9 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play121441122 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 121441122
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play121441123(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.var_.moveOldPos1076ui_story = arg_503_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_506_0 = 0.001

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_0 then
				arg_503_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_503_1.time_ - 0) / var_506_0)
				arg_503_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_503_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["1076ui_story"].transform.position).z)
				arg_503_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_503_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_503_1.actors_["1076ui_story"].transform.localEulerAngles = arg_503_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_503_1.time_ >= 0 + var_506_0 and arg_503_1.time_ < 0 + var_506_0 + arg_506_0 then
				arg_503_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_503_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_503_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["1076ui_story"].transform.position).z)
				arg_503_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_503_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_503_1.actors_["1076ui_story"].transform.localEulerAngles = arg_503_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_506_1 = arg_503_1.actors_["1076ui_story"]

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 and not isNil(var_506_1) and arg_503_1.var_.characterEffect1076ui_story == nil then
				arg_503_1.var_.characterEffect1076ui_story = var_506_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_2 = 0.200000002980232

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_2 and not isNil(var_506_1) then
				if arg_503_1.var_.characterEffect1076ui_story and not isNil(var_506_1) then
					arg_503_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_503_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_503_1.time_ - 0) / var_506_2)
				end
			end

			if arg_503_1.time_ >= 0 + var_506_2 and arg_503_1.time_ < 0 + var_506_2 + arg_506_0 and not isNil(var_506_1) and arg_503_1.var_.characterEffect1076ui_story then
				arg_503_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_503_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_506_3 = 0
			local var_506_4 = 1.15

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_3 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, false)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_5 = arg_503_1:FormatText(arg_503_1:GetWordFromCfg(121441122).content)

				arg_503_1.text_.text = var_506_5

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_7 = 46 <= 0 and var_506_4 or var_506_4 * (utf8.len(var_506_5) / 46)

				if (46 <= 0 and var_506_4 or var_506_4 * (utf8.len(var_506_5) / 46)) > 0 and var_506_4 < var_506_7 then
					arg_503_1.talkMaxDuration = var_506_7

					if var_506_7 + var_506_3 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_7 + var_506_3
					end
				end

				arg_503_1.text_.text = var_506_5
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_8 = math.max(var_506_4, arg_503_1.talkMaxDuration)

			if var_506_3 <= arg_503_1.time_ and arg_503_1.time_ < var_506_3 + var_506_8 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_3) / var_506_8

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_3 + var_506_8 and arg_503_1.time_ < var_506_3 + var_506_8 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_503_1:InitPlayNodeList()
	end,
	Play121441123 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 121441123
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play121441124(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 1.15

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_1 = arg_507_1:FormatText(arg_507_1:GetWordFromCfg(121441123).content)

				arg_507_1.text_.text = var_510_1

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_3 = 46 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_1) / 46)

				if (46 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_1) / 46)) > 0 and var_510_0 < var_510_3 then
					arg_507_1.talkMaxDuration = var_510_3

					if var_510_3 + 0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_3 + 0
					end
				end

				arg_507_1.text_.text = var_510_1
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_4 = math.max(var_510_0, arg_507_1.talkMaxDuration)

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_4 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - 0) / var_510_4

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= 0 + var_510_4 and arg_507_1.time_ < 0 + var_510_4 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play121441124 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 121441124
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play121441125(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0.516666666666667 < arg_511_1.time_ and arg_511_1.time_ <= 0.516666666666667 + arg_514_0 then
				arg_511_1:AudioAction("play", "effect", "se_story_17", "se_story_17_ui", "")
			end

			local var_514_1 = 0
			local var_514_2 = 0.825

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, false)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_3 = arg_511_1:FormatText(arg_511_1:GetWordFromCfg(121441124).content)

				arg_511_1.text_.text = var_514_3

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_5 = 33 <= 0 and var_514_2 or var_514_2 * (utf8.len(var_514_3) / 33)

				if (33 <= 0 and var_514_2 or var_514_2 * (utf8.len(var_514_3) / 33)) > 0 and var_514_2 < var_514_5 then
					arg_511_1.talkMaxDuration = var_514_5

					if var_514_5 + var_514_1 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_5 + var_514_1
					end
				end

				arg_511_1.text_.text = var_514_3
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_6 = math.max(var_514_2, arg_511_1.talkMaxDuration)

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_6 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_1) / var_514_6

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_1 + var_514_6 and arg_511_1.time_ < var_514_1 + var_514_6 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play121441125 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 121441125
		arg_515_1.duration_ = 6.73

		local var_515_0 = {
			ja = 6.733,
			ko = 3.4,
			zh = 3.4
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play121441126(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.var_.moveOldPos1076ui_story = arg_515_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_518_0 = 0.001

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_0 then
				arg_515_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_515_1.time_ - 0) / var_518_0)
				arg_515_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_515_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1076ui_story"].transform.position).z)
				arg_515_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_515_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_515_1.actors_["1076ui_story"].transform.localEulerAngles = arg_515_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_515_1.time_ >= 0 + var_518_0 and arg_515_1.time_ < 0 + var_518_0 + arg_518_0 then
				arg_515_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_515_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_515_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1076ui_story"].transform.position).z)
				arg_515_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_515_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_515_1.actors_["1076ui_story"].transform.localEulerAngles = arg_515_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_518_1 = arg_515_1.actors_["1076ui_story"]

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(var_518_1) and arg_515_1.var_.characterEffect1076ui_story == nil then
				arg_515_1.var_.characterEffect1076ui_story = var_518_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_2 = 0.200000002980232

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_2 and not isNil(var_518_1) then
				if arg_515_1.var_.characterEffect1076ui_story and not isNil(var_518_1) then
					arg_515_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_515_1.time_ >= 0 + var_518_2 and arg_515_1.time_ < 0 + var_518_2 + arg_518_0 and not isNil(var_518_1) and arg_515_1.var_.characterEffect1076ui_story then
				arg_515_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_518_4 = 0
			local var_518_5 = 0.425

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_4 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_6 = arg_515_1:GetWordFromCfg(121441125)
				local var_518_7 = arg_515_1:FormatText(var_518_6.content)

				arg_515_1.text_.text = var_518_7

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_9 = 17 <= 0 and var_518_5 or var_518_5 * (utf8.len(var_518_7) / 17)

				if (17 <= 0 and var_518_5 or var_518_5 * (utf8.len(var_518_7) / 17)) > 0 and var_518_5 < var_518_9 then
					arg_515_1.talkMaxDuration = var_518_9

					if var_518_9 + var_518_4 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_9 + var_518_4
					end
				end

				arg_515_1.text_.text = var_518_7
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441125", "story_v_out_121441.awb") ~= 0 then
					local var_518_10 = manager.audio:GetVoiceLength("story_v_out_121441", "121441125", "story_v_out_121441.awb") / 1000

					if var_518_10 + var_518_4 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_10 + var_518_4
					end

					if var_518_6.prefab_name ~= "" and arg_515_1.actors_[var_518_6.prefab_name] ~= nil then
						local var_518_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_6.prefab_name].transform, "story_v_out_121441", "121441125", "story_v_out_121441.awb")

						arg_515_1:RecordAudio("121441125", var_518_11)
						arg_515_1:RecordAudio("121441125", var_518_11)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_121441", "121441125", "story_v_out_121441.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_121441", "121441125", "story_v_out_121441.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_12 = math.max(var_518_5, arg_515_1.talkMaxDuration)

			if var_518_4 <= arg_515_1.time_ and arg_515_1.time_ < var_518_4 + var_518_12 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_4) / var_518_12

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_4 + var_518_12 and arg_515_1.time_ < var_518_4 + var_518_12 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_515_1:InitPlayNodeList()
	end,
	Play121441126 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 121441126
		arg_519_1.duration_ = 6.3

		local var_519_0 = {
			ja = 6.3,
			ko = 3.966,
			zh = 3.966
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play121441127(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.var_.moveOldPos1084ui_story = arg_519_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_522_0 = 0.001

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_0 then
				arg_519_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_519_1.time_ - 0) / var_522_0)
				arg_519_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_519_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["1084ui_story"].transform.position).z)
				arg_519_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_519_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_519_1.actors_["1084ui_story"].transform.localEulerAngles = arg_519_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_519_1.time_ >= 0 + var_522_0 and arg_519_1.time_ < 0 + var_522_0 + arg_522_0 then
				arg_519_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_519_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_519_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["1084ui_story"].transform.position).z)
				arg_519_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_519_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_519_1.actors_["1084ui_story"].transform.localEulerAngles = arg_519_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_522_1 = arg_519_1.actors_["1084ui_story"]

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(var_522_1) and arg_519_1.var_.characterEffect1084ui_story == nil then
				arg_519_1.var_.characterEffect1084ui_story = var_522_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_2 = 0.200000002980232

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_2 and not isNil(var_522_1) then
				if arg_519_1.var_.characterEffect1084ui_story and not isNil(var_522_1) then
					arg_519_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_519_1.time_ >= 0 + var_522_2 and arg_519_1.time_ < 0 + var_522_2 + arg_522_0 and not isNil(var_522_1) and arg_519_1.var_.characterEffect1084ui_story then
				arg_519_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_522_4 = arg_519_1.actors_["1076ui_story"]

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(var_522_4) and arg_519_1.var_.characterEffect1076ui_story == nil then
				arg_519_1.var_.characterEffect1076ui_story = var_522_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_5 = 0.200000002980232

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_5 and not isNil(var_522_4) then
				if arg_519_1.var_.characterEffect1076ui_story and not isNil(var_522_4) then
					arg_519_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_519_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_519_1.time_ - 0) / var_522_5)
				end
			end

			if arg_519_1.time_ >= 0 + var_522_5 and arg_519_1.time_ < 0 + var_522_5 + arg_522_0 and not isNil(var_522_4) and arg_519_1.var_.characterEffect1076ui_story then
				arg_519_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_519_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_522_6 = 0
			local var_522_7 = 0.4

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_6 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_8 = arg_519_1:GetWordFromCfg(121441126)
				local var_522_9 = arg_519_1:FormatText(var_522_8.content)

				arg_519_1.text_.text = var_522_9

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_11 = 16 <= 0 and var_522_7 or var_522_7 * (utf8.len(var_522_9) / 16)

				if (16 <= 0 and var_522_7 or var_522_7 * (utf8.len(var_522_9) / 16)) > 0 and var_522_7 < var_522_11 then
					arg_519_1.talkMaxDuration = var_522_11

					if var_522_11 + var_522_6 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_11 + var_522_6
					end
				end

				arg_519_1.text_.text = var_522_9
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441126", "story_v_out_121441.awb") ~= 0 then
					local var_522_12 = manager.audio:GetVoiceLength("story_v_out_121441", "121441126", "story_v_out_121441.awb") / 1000

					if var_522_12 + var_522_6 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_12 + var_522_6
					end

					if var_522_8.prefab_name ~= "" and arg_519_1.actors_[var_522_8.prefab_name] ~= nil then
						local var_522_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_8.prefab_name].transform, "story_v_out_121441", "121441126", "story_v_out_121441.awb")

						arg_519_1:RecordAudio("121441126", var_522_13)
						arg_519_1:RecordAudio("121441126", var_522_13)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_121441", "121441126", "story_v_out_121441.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_121441", "121441126", "story_v_out_121441.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_14 = math.max(var_522_7, arg_519_1.talkMaxDuration)

			if var_522_6 <= arg_519_1.time_ and arg_519_1.time_ < var_522_6 + var_522_14 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_6) / var_522_14

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_6 + var_522_14 and arg_519_1.time_ < var_522_6 + var_522_14 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_519_1:InitPlayNodeList()
	end,
	Play121441127 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 121441127
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play121441128(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 and not isNil(arg_523_1.actors_["1084ui_story"]) and arg_523_1.var_.characterEffect1084ui_story == nil then
				arg_523_1.var_.characterEffect1084ui_story = arg_523_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_0 = 0.200000002980232

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_0 and not isNil(arg_523_1.actors_["1084ui_story"]) then
				if arg_523_1.var_.characterEffect1084ui_story and not isNil(arg_523_1.actors_["1084ui_story"]) then
					arg_523_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_523_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_523_1.time_ - 0) / var_526_0)
				end
			end

			if arg_523_1.time_ >= 0 + var_526_0 and arg_523_1.time_ < 0 + var_526_0 + arg_526_0 and not isNil(arg_523_1.actors_["1084ui_story"]) and arg_523_1.var_.characterEffect1084ui_story then
				arg_523_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_523_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_526_1 = 0
			local var_526_2 = 0.6

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_1 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				arg_523_1.leftNameTxt_.text = arg_523_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, true)
				arg_523_1.iconController_:SetSelectedState("hero")

				arg_523_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_523_1.callingController_:SetSelectedState("normal")

				arg_523_1.keyicon_.color = Color.New(1, 1, 1)
				arg_523_1.icon_.color = Color.New(1, 1, 1)

				local var_526_3 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(121441127).content)

				arg_523_1.text_.text = var_526_3

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_5 = 24 <= 0 and var_526_2 or var_526_2 * (utf8.len(var_526_3) / 24)

				if (24 <= 0 and var_526_2 or var_526_2 * (utf8.len(var_526_3) / 24)) > 0 and var_526_2 < var_526_5 then
					arg_523_1.talkMaxDuration = var_526_5

					if var_526_5 + var_526_1 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_5 + var_526_1
					end
				end

				arg_523_1.text_.text = var_526_3
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_6 = math.max(var_526_2, arg_523_1.talkMaxDuration)

			if var_526_1 <= arg_523_1.time_ and arg_523_1.time_ < var_526_1 + var_526_6 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_1) / var_526_6

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_1 + var_526_6 and arg_523_1.time_ < var_526_1 + var_526_6 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play121441128 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 121441128
		arg_527_1.duration_ = 11.8

		local var_527_0 = {
			ja = 11.8,
			ko = 9.133,
			zh = 9.133
		}
		local var_527_1 = manager.audio:GetLocalizationFlag()

		if var_527_0[var_527_1] ~= nil then
			arg_527_1.duration_ = var_527_0[var_527_1]
		end

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play121441129(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.var_.moveOldPos1076ui_story = arg_527_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_530_0 = 0.001

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_0 then
				arg_527_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_527_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_527_1.time_ - 0) / var_530_0)
				arg_527_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_527_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_527_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_527_1.actors_["1076ui_story"].transform.position).z)
				arg_527_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_527_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_527_1.actors_["1076ui_story"].transform.localEulerAngles = arg_527_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_527_1.time_ >= 0 + var_530_0 and arg_527_1.time_ < 0 + var_530_0 + arg_530_0 then
				arg_527_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_527_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_527_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_527_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_527_1.actors_["1076ui_story"].transform.position).z)
				arg_527_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_527_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_527_1.actors_["1076ui_story"].transform.localEulerAngles = arg_527_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_530_1 = arg_527_1.actors_["1076ui_story"]

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(var_530_1) and arg_527_1.var_.characterEffect1076ui_story == nil then
				arg_527_1.var_.characterEffect1076ui_story = var_530_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_2 = 0.200000002980232

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_2 and not isNil(var_530_1) then
				if arg_527_1.var_.characterEffect1076ui_story and not isNil(var_530_1) then
					arg_527_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_527_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_527_1.time_ - 0) / var_530_2)
				end
			end

			if arg_527_1.time_ >= 0 + var_530_2 and arg_527_1.time_ < 0 + var_530_2 + arg_530_0 and not isNil(var_530_1) and arg_527_1.var_.characterEffect1076ui_story then
				arg_527_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_527_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_530_3 = arg_527_1.actors_["1084ui_story"].transform

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.var_.moveOldPos1084ui_story = var_530_3.localPosition
			end

			local var_530_4 = 0.001

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_4 then
				var_530_3.localPosition = Vector3.Lerp(arg_527_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_527_1.time_ - 0) / var_530_4)
				var_530_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_530_3.position).x, (manager.ui.mainCamera.transform.position - var_530_3.position).y, (manager.ui.mainCamera.transform.position - var_530_3.position).z)
				var_530_3.localEulerAngles.z = 0
				var_530_3.localEulerAngles.x = 0
				var_530_3.localEulerAngles = var_530_3.localEulerAngles
			end

			if arg_527_1.time_ >= 0 + var_530_4 and arg_527_1.time_ < 0 + var_530_4 + arg_530_0 then
				var_530_3.localPosition = Vector3.New(0, 100, 0)
				var_530_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_530_3.position).x, (manager.ui.mainCamera.transform.position - var_530_3.position).y, (manager.ui.mainCamera.transform.position - var_530_3.position).z)
				var_530_3.localEulerAngles.z = 0
				var_530_3.localEulerAngles.x = 0
				var_530_3.localEulerAngles = var_530_3.localEulerAngles
			end

			local var_530_5 = arg_527_1.actors_["1084ui_story"]

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(var_530_5) and arg_527_1.var_.characterEffect1084ui_story == nil then
				arg_527_1.var_.characterEffect1084ui_story = var_530_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_6 = 0.200000002980232

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_6 and not isNil(var_530_5) then
				if arg_527_1.var_.characterEffect1084ui_story and not isNil(var_530_5) then
					arg_527_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_527_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_527_1.time_ - 0) / var_530_6)
				end
			end

			if arg_527_1.time_ >= 0 + var_530_6 and arg_527_1.time_ < 0 + var_530_6 + arg_530_0 and not isNil(var_530_5) and arg_527_1.var_.characterEffect1084ui_story then
				arg_527_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_527_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_530_7 = arg_527_1.actors_["1075ui_story"].transform

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.var_.moveOldPos1075ui_story = var_530_7.localPosition
			end

			local var_530_8 = 0.001

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_8 then
				var_530_7.localPosition = Vector3.Lerp(arg_527_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_527_1.time_ - 0) / var_530_8)
				var_530_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_530_7.position).x, (manager.ui.mainCamera.transform.position - var_530_7.position).y, (manager.ui.mainCamera.transform.position - var_530_7.position).z)
				var_530_7.localEulerAngles.z = 0
				var_530_7.localEulerAngles.x = 0
				var_530_7.localEulerAngles = var_530_7.localEulerAngles
			end

			if arg_527_1.time_ >= 0 + var_530_8 and arg_527_1.time_ < 0 + var_530_8 + arg_530_0 then
				var_530_7.localPosition = Vector3.New(0, -1.055, -6.16)
				var_530_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_530_7.position).x, (manager.ui.mainCamera.transform.position - var_530_7.position).y, (manager.ui.mainCamera.transform.position - var_530_7.position).z)
				var_530_7.localEulerAngles.z = 0
				var_530_7.localEulerAngles.x = 0
				var_530_7.localEulerAngles = var_530_7.localEulerAngles
			end

			local var_530_9 = arg_527_1.actors_["1075ui_story"]

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(var_530_9) and arg_527_1.var_.characterEffect1075ui_story == nil then
				arg_527_1.var_.characterEffect1075ui_story = var_530_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_10 = 0.200000002980232

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_10 and not isNil(var_530_9) then
				if arg_527_1.var_.characterEffect1075ui_story and not isNil(var_530_9) then
					arg_527_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_527_1.time_ >= 0 + var_530_10 and arg_527_1.time_ < 0 + var_530_10 + arg_530_0 and not isNil(var_530_9) and arg_527_1.var_.characterEffect1075ui_story then
				arg_527_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_530_12 = 0
			local var_530_13 = 1.075

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_12 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_14 = arg_527_1:GetWordFromCfg(121441128)
				local var_530_15 = arg_527_1:FormatText(var_530_14.content)

				arg_527_1.text_.text = var_530_15

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_17 = 43 <= 0 and var_530_13 or var_530_13 * (utf8.len(var_530_15) / 43)

				if (43 <= 0 and var_530_13 or var_530_13 * (utf8.len(var_530_15) / 43)) > 0 and var_530_13 < var_530_17 then
					arg_527_1.talkMaxDuration = var_530_17

					if var_530_17 + var_530_12 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_17 + var_530_12
					end
				end

				arg_527_1.text_.text = var_530_15
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441128", "story_v_out_121441.awb") ~= 0 then
					local var_530_18 = manager.audio:GetVoiceLength("story_v_out_121441", "121441128", "story_v_out_121441.awb") / 1000

					if var_530_18 + var_530_12 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_18 + var_530_12
					end

					if var_530_14.prefab_name ~= "" and arg_527_1.actors_[var_530_14.prefab_name] ~= nil then
						local var_530_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_14.prefab_name].transform, "story_v_out_121441", "121441128", "story_v_out_121441.awb")

						arg_527_1:RecordAudio("121441128", var_530_19)
						arg_527_1:RecordAudio("121441128", var_530_19)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_121441", "121441128", "story_v_out_121441.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_121441", "121441128", "story_v_out_121441.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_20 = math.max(var_530_13, arg_527_1.talkMaxDuration)

			if var_530_12 <= arg_527_1.time_ and arg_527_1.time_ < var_530_12 + var_530_20 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_12) / var_530_20

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_12 + var_530_20 and arg_527_1.time_ < var_530_12 + var_530_20 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_527_1:InitPlayNodeList()
	end,
	Play121441129 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 121441129
		arg_531_1.duration_ = 9.3

		local var_531_0 = {
			ja = 9.3,
			ko = 6.466,
			zh = 6.466
		}
		local var_531_1 = manager.audio:GetLocalizationFlag()

		if var_531_0[var_531_1] ~= nil then
			arg_531_1.duration_ = var_531_0[var_531_1]
		end

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play121441130(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = 0.725

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_1 = arg_531_1:GetWordFromCfg(121441129)
				local var_534_2 = arg_531_1:FormatText(var_534_1.content)

				arg_531_1.text_.text = var_534_2

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_4 = 29 <= 0 and var_534_0 or var_534_0 * (utf8.len(var_534_2) / 29)

				if (29 <= 0 and var_534_0 or var_534_0 * (utf8.len(var_534_2) / 29)) > 0 and var_534_0 < var_534_4 then
					arg_531_1.talkMaxDuration = var_534_4

					if var_534_4 + 0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_4 + 0
					end
				end

				arg_531_1.text_.text = var_534_2
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441129", "story_v_out_121441.awb") ~= 0 then
					local var_534_5 = manager.audio:GetVoiceLength("story_v_out_121441", "121441129", "story_v_out_121441.awb") / 1000

					if var_534_5 + 0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_5 + 0
					end

					if var_534_1.prefab_name ~= "" and arg_531_1.actors_[var_534_1.prefab_name] ~= nil then
						local var_534_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_1.prefab_name].transform, "story_v_out_121441", "121441129", "story_v_out_121441.awb")

						arg_531_1:RecordAudio("121441129", var_534_6)
						arg_531_1:RecordAudio("121441129", var_534_6)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_out_121441", "121441129", "story_v_out_121441.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_out_121441", "121441129", "story_v_out_121441.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_7 = math.max(var_534_0, arg_531_1.talkMaxDuration)

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_7 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - 0) / var_534_7

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= 0 + var_534_7 and arg_531_1.time_ < 0 + var_534_7 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play121441130 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 121441130
		arg_535_1.duration_ = 8.2

		local var_535_0 = {
			ja = 7.033,
			ko = 8.2,
			zh = 8.2
		}
		local var_535_1 = manager.audio:GetLocalizationFlag()

		if var_535_0[var_535_1] ~= nil then
			arg_535_1.duration_ = var_535_0[var_535_1]
		end

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play121441131(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.var_.moveOldPos1076ui_story = arg_535_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_538_0 = 0.001

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_0 then
				arg_535_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_535_1.time_ - 0) / var_538_0)
				arg_535_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_535_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_535_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_535_1.actors_["1076ui_story"].transform.position).z)
				arg_535_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_535_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_535_1.actors_["1076ui_story"].transform.localEulerAngles = arg_535_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_535_1.time_ >= 0 + var_538_0 and arg_535_1.time_ < 0 + var_538_0 + arg_538_0 then
				arg_535_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_535_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_535_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_535_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_535_1.actors_["1076ui_story"].transform.position).z)
				arg_535_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_535_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_535_1.actors_["1076ui_story"].transform.localEulerAngles = arg_535_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_538_1 = arg_535_1.actors_["1076ui_story"]

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(var_538_1) and arg_535_1.var_.characterEffect1076ui_story == nil then
				arg_535_1.var_.characterEffect1076ui_story = var_538_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_2 = 0.0166666666666667

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_2 and not isNil(var_538_1) then
				if arg_535_1.var_.characterEffect1076ui_story and not isNil(var_538_1) then
					arg_535_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_535_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_535_1.time_ - 0) / var_538_2)
				end
			end

			if arg_535_1.time_ >= 0 + var_538_2 and arg_535_1.time_ < 0 + var_538_2 + arg_538_0 and not isNil(var_538_1) and arg_535_1.var_.characterEffect1076ui_story then
				arg_535_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_535_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_538_3 = arg_535_1.actors_["1084ui_story"].transform

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.var_.moveOldPos1084ui_story = var_538_3.localPosition
			end

			local var_538_4 = 0.001

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_4 then
				var_538_3.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_535_1.time_ - 0) / var_538_4)
				var_538_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_538_3.position).x, (manager.ui.mainCamera.transform.position - var_538_3.position).y, (manager.ui.mainCamera.transform.position - var_538_3.position).z)
				var_538_3.localEulerAngles.z = 0
				var_538_3.localEulerAngles.x = 0
				var_538_3.localEulerAngles = var_538_3.localEulerAngles
			end

			if arg_535_1.time_ >= 0 + var_538_4 and arg_535_1.time_ < 0 + var_538_4 + arg_538_0 then
				var_538_3.localPosition = Vector3.New(0.7, -0.97, -6)
				var_538_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_538_3.position).x, (manager.ui.mainCamera.transform.position - var_538_3.position).y, (manager.ui.mainCamera.transform.position - var_538_3.position).z)
				var_538_3.localEulerAngles.z = 0
				var_538_3.localEulerAngles.x = 0
				var_538_3.localEulerAngles = var_538_3.localEulerAngles
			end

			local var_538_5 = arg_535_1.actors_["1084ui_story"]

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(var_538_5) and arg_535_1.var_.characterEffect1084ui_story == nil then
				arg_535_1.var_.characterEffect1084ui_story = var_538_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_6 = 0.200000002980232

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_6 and not isNil(var_538_5) then
				if arg_535_1.var_.characterEffect1084ui_story and not isNil(var_538_5) then
					arg_535_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_535_1.time_ >= 0 + var_538_6 and arg_535_1.time_ < 0 + var_538_6 + arg_538_0 and not isNil(var_538_5) and arg_535_1.var_.characterEffect1084ui_story then
				arg_535_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_538_8 = arg_535_1.actors_["1075ui_story"].transform

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.var_.moveOldPos1075ui_story = var_538_8.localPosition
			end

			local var_538_9 = 0.001

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_9 then
				var_538_8.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_535_1.time_ - 0) / var_538_9)
				var_538_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_538_8.position).x, (manager.ui.mainCamera.transform.position - var_538_8.position).y, (manager.ui.mainCamera.transform.position - var_538_8.position).z)
				var_538_8.localEulerAngles.z = 0
				var_538_8.localEulerAngles.x = 0
				var_538_8.localEulerAngles = var_538_8.localEulerAngles
			end

			if arg_535_1.time_ >= 0 + var_538_9 and arg_535_1.time_ < 0 + var_538_9 + arg_538_0 then
				var_538_8.localPosition = Vector3.New(0, 100, 0)
				var_538_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_538_8.position).x, (manager.ui.mainCamera.transform.position - var_538_8.position).y, (manager.ui.mainCamera.transform.position - var_538_8.position).z)
				var_538_8.localEulerAngles.z = 0
				var_538_8.localEulerAngles.x = 0
				var_538_8.localEulerAngles = var_538_8.localEulerAngles
			end

			local var_538_10 = 0
			local var_538_11 = 0.725

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_10 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_12 = arg_535_1:GetWordFromCfg(121441130)
				local var_538_13 = arg_535_1:FormatText(var_538_12.content)

				arg_535_1.text_.text = var_538_13

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_15 = 29 <= 0 and var_538_11 or var_538_11 * (utf8.len(var_538_13) / 29)

				if (29 <= 0 and var_538_11 or var_538_11 * (utf8.len(var_538_13) / 29)) > 0 and var_538_11 < var_538_15 then
					arg_535_1.talkMaxDuration = var_538_15

					if var_538_15 + var_538_10 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_15 + var_538_10
					end
				end

				arg_535_1.text_.text = var_538_13
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441130", "story_v_out_121441.awb") ~= 0 then
					local var_538_16 = manager.audio:GetVoiceLength("story_v_out_121441", "121441130", "story_v_out_121441.awb") / 1000

					if var_538_16 + var_538_10 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_16 + var_538_10
					end

					if var_538_12.prefab_name ~= "" and arg_535_1.actors_[var_538_12.prefab_name] ~= nil then
						local var_538_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_12.prefab_name].transform, "story_v_out_121441", "121441130", "story_v_out_121441.awb")

						arg_535_1:RecordAudio("121441130", var_538_17)
						arg_535_1:RecordAudio("121441130", var_538_17)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_out_121441", "121441130", "story_v_out_121441.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_out_121441", "121441130", "story_v_out_121441.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_18 = math.max(var_538_11, arg_535_1.talkMaxDuration)

			if var_538_10 <= arg_535_1.time_ and arg_535_1.time_ < var_538_10 + var_538_18 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_10) / var_538_18

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_10 + var_538_18 and arg_535_1.time_ < var_538_10 + var_538_18 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_535_1:InitPlayNodeList()
	end,
	Play121441131 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 121441131
		arg_539_1.duration_ = 2.4

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play121441132(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 and not isNil(arg_539_1.actors_["1076ui_story"]) and arg_539_1.var_.characterEffect1076ui_story == nil then
				arg_539_1.var_.characterEffect1076ui_story = arg_539_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_542_0 = 0.200000002980232

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_0 and not isNil(arg_539_1.actors_["1076ui_story"]) then
				if arg_539_1.var_.characterEffect1076ui_story and not isNil(arg_539_1.actors_["1076ui_story"]) then
					arg_539_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_539_1.time_ >= 0 + var_542_0 and arg_539_1.time_ < 0 + var_542_0 + arg_542_0 and not isNil(arg_539_1.actors_["1076ui_story"]) and arg_539_1.var_.characterEffect1076ui_story then
				arg_539_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_542_2 = arg_539_1.actors_["1084ui_story"]

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 and not isNil(var_542_2) and arg_539_1.var_.characterEffect1084ui_story == nil then
				arg_539_1.var_.characterEffect1084ui_story = var_542_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_542_3 = 0.200000002980232

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_3 and not isNil(var_542_2) then
				if arg_539_1.var_.characterEffect1084ui_story and not isNil(var_542_2) then
					arg_539_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_539_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_539_1.time_ - 0) / var_542_3)
				end
			end

			if arg_539_1.time_ >= 0 + var_542_3 and arg_539_1.time_ < 0 + var_542_3 + arg_542_0 and not isNil(var_542_2) and arg_539_1.var_.characterEffect1084ui_story then
				arg_539_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_539_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			local var_542_4 = 0
			local var_542_5 = 0.175

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_4 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				arg_539_1.leftNameTxt_.text = arg_539_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_6 = arg_539_1:GetWordFromCfg(121441131)
				local var_542_7 = arg_539_1:FormatText(var_542_6.content)

				arg_539_1.text_.text = var_542_7

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_9 = 7 <= 0 and var_542_5 or var_542_5 * (utf8.len(var_542_7) / 7)

				if (7 <= 0 and var_542_5 or var_542_5 * (utf8.len(var_542_7) / 7)) > 0 and var_542_5 < var_542_9 then
					arg_539_1.talkMaxDuration = var_542_9

					if var_542_9 + var_542_4 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_9 + var_542_4
					end
				end

				arg_539_1.text_.text = var_542_7
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441131", "story_v_out_121441.awb") ~= 0 then
					local var_542_10 = manager.audio:GetVoiceLength("story_v_out_121441", "121441131", "story_v_out_121441.awb") / 1000

					if var_542_10 + var_542_4 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_10 + var_542_4
					end

					if var_542_6.prefab_name ~= "" and arg_539_1.actors_[var_542_6.prefab_name] ~= nil then
						local var_542_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_6.prefab_name].transform, "story_v_out_121441", "121441131", "story_v_out_121441.awb")

						arg_539_1:RecordAudio("121441131", var_542_11)
						arg_539_1:RecordAudio("121441131", var_542_11)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_out_121441", "121441131", "story_v_out_121441.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_out_121441", "121441131", "story_v_out_121441.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_12 = math.max(var_542_5, arg_539_1.talkMaxDuration)

			if var_542_4 <= arg_539_1.time_ and arg_539_1.time_ < var_542_4 + var_542_12 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_4) / var_542_12

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_4 + var_542_12 and arg_539_1.time_ < var_542_4 + var_542_12 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play121441132 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 121441132
		arg_543_1.duration_ = 5

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play121441133(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 and not isNil(arg_543_1.actors_["1076ui_story"]) and arg_543_1.var_.characterEffect1076ui_story == nil then
				arg_543_1.var_.characterEffect1076ui_story = arg_543_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_546_0 = 0.200000002980232

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_0 and not isNil(arg_543_1.actors_["1076ui_story"]) then
				if arg_543_1.var_.characterEffect1076ui_story and not isNil(arg_543_1.actors_["1076ui_story"]) then
					arg_543_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_543_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_543_1.time_ - 0) / var_546_0)
				end
			end

			if arg_543_1.time_ >= 0 + var_546_0 and arg_543_1.time_ < 0 + var_546_0 + arg_546_0 and not isNil(arg_543_1.actors_["1076ui_story"]) and arg_543_1.var_.characterEffect1076ui_story then
				arg_543_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_543_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_546_1 = 0
			local var_546_2 = 0.8

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_1 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				arg_543_1.leftNameTxt_.text = arg_543_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, true)
				arg_543_1.iconController_:SetSelectedState("hero")

				arg_543_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_543_1.callingController_:SetSelectedState("normal")

				arg_543_1.keyicon_.color = Color.New(1, 1, 1)
				arg_543_1.icon_.color = Color.New(1, 1, 1)

				local var_546_3 = arg_543_1:FormatText(arg_543_1:GetWordFromCfg(121441132).content)

				arg_543_1.text_.text = var_546_3

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_5 = 32 <= 0 and var_546_2 or var_546_2 * (utf8.len(var_546_3) / 32)

				if (32 <= 0 and var_546_2 or var_546_2 * (utf8.len(var_546_3) / 32)) > 0 and var_546_2 < var_546_5 then
					arg_543_1.talkMaxDuration = var_546_5

					if var_546_5 + var_546_1 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_5 + var_546_1
					end
				end

				arg_543_1.text_.text = var_546_3
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)
				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_6 = math.max(var_546_2, arg_543_1.talkMaxDuration)

			if var_546_1 <= arg_543_1.time_ and arg_543_1.time_ < var_546_1 + var_546_6 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_1) / var_546_6

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_1 + var_546_6 and arg_543_1.time_ < var_546_1 + var_546_6 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play121441133 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 121441133
		arg_547_1.duration_ = 0.33

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"

			SetActive(arg_547_1.choicesGo_, true)

			for iter_548_0, iter_548_1 in ipairs(arg_547_1.choices_) do
				SetActive(iter_548_1.go, iter_548_0 <= 1)
			end

			arg_547_1.choices_[1].txt.text = arg_547_1:FormatText(StoryChoiceCfg[397].name)
			arg_547_1.choices_[2].txt.text = arg_547_1:FormatText(StoryChoiceCfg[398].name)
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play121441134(arg_547_1)
			end

			arg_547_1:RecordChoiceLog(121441133, 397, 398)
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1.allBtn_.enabled = false
			end

			if arg_547_1.time_ >= 0 + 0.333333333333333 and arg_547_1.time_ < 0 + 0.333333333333333 + arg_550_0 then
				arg_547_1.allBtn_.enabled = true
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play121441134 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 121441134
		arg_551_1.duration_ = 2.6

		local var_551_0 = {
			ja = 2.466,
			ko = 2.6,
			zh = 2.6
		}
		local var_551_1 = manager.audio:GetLocalizationFlag()

		if var_551_0[var_551_1] ~= nil then
			arg_551_1.duration_ = var_551_0[var_551_1]
		end

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play121441135(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1.var_.moveOldPos1076ui_story = arg_551_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_554_0 = 0.001

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_0 then
				arg_551_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_551_1.var_.moveOldPos1076ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_551_1.time_ - 0) / var_554_0)
				arg_551_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_551_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_551_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_551_1.actors_["1076ui_story"].transform.position).z)
				arg_551_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_551_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_551_1.actors_["1076ui_story"].transform.localEulerAngles = arg_551_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_551_1.time_ >= 0 + var_554_0 and arg_551_1.time_ < 0 + var_554_0 + arg_554_0 then
				arg_551_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_551_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_551_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_551_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_551_1.actors_["1076ui_story"].transform.position).z)
				arg_551_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_551_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_551_1.actors_["1076ui_story"].transform.localEulerAngles = arg_551_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_554_1 = arg_551_1.actors_["1076ui_story"]

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 and not isNil(var_554_1) and arg_551_1.var_.characterEffect1076ui_story == nil then
				arg_551_1.var_.characterEffect1076ui_story = var_554_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_554_2 = 0.200000002980232

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_2 and not isNil(var_554_1) then
				if arg_551_1.var_.characterEffect1076ui_story and not isNil(var_554_1) then
					arg_551_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_551_1.time_ >= 0 + var_554_2 and arg_551_1.time_ < 0 + var_554_2 + arg_554_0 and not isNil(var_554_1) and arg_551_1.var_.characterEffect1076ui_story then
				arg_551_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_554_4 = 0
			local var_554_5 = 0.175

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= var_554_4 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				arg_551_1.leftNameTxt_.text = arg_551_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_6 = arg_551_1:GetWordFromCfg(121441134)
				local var_554_7 = arg_551_1:FormatText(var_554_6.content)

				arg_551_1.text_.text = var_554_7

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_9 = 7 <= 0 and var_554_5 or var_554_5 * (utf8.len(var_554_7) / 7)

				if (7 <= 0 and var_554_5 or var_554_5 * (utf8.len(var_554_7) / 7)) > 0 and var_554_5 < var_554_9 then
					arg_551_1.talkMaxDuration = var_554_9

					if var_554_9 + var_554_4 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_9 + var_554_4
					end
				end

				arg_551_1.text_.text = var_554_7
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441134", "story_v_out_121441.awb") ~= 0 then
					local var_554_10 = manager.audio:GetVoiceLength("story_v_out_121441", "121441134", "story_v_out_121441.awb") / 1000

					if var_554_10 + var_554_4 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_10 + var_554_4
					end

					if var_554_6.prefab_name ~= "" and arg_551_1.actors_[var_554_6.prefab_name] ~= nil then
						local var_554_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_6.prefab_name].transform, "story_v_out_121441", "121441134", "story_v_out_121441.awb")

						arg_551_1:RecordAudio("121441134", var_554_11)
						arg_551_1:RecordAudio("121441134", var_554_11)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_out_121441", "121441134", "story_v_out_121441.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_out_121441", "121441134", "story_v_out_121441.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_12 = math.max(var_554_5, arg_551_1.talkMaxDuration)

			if var_554_4 <= arg_551_1.time_ and arg_551_1.time_ < var_554_4 + var_554_12 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_4) / var_554_12

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_4 + var_554_12 and arg_551_1.time_ < var_554_4 + var_554_12 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_551_1:InitPlayNodeList()
	end,
	Play121441135 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 121441135
		arg_555_1.duration_ = 9.47

		local var_555_0 = {
			ja = 9.466,
			ko = 4.833,
			zh = 4.833
		}
		local var_555_1 = manager.audio:GetLocalizationFlag()

		if var_555_0[var_555_1] ~= nil then
			arg_555_1.duration_ = var_555_0[var_555_1]
		end

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play121441136(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1.var_.moveOldPos1084ui_story = arg_555_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_558_0 = 0.001

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_0 then
				arg_555_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_555_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_555_1.time_ - 0) / var_558_0)
				arg_555_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_555_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["1084ui_story"].transform.position).z)
				arg_555_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_555_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_555_1.actors_["1084ui_story"].transform.localEulerAngles = arg_555_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_555_1.time_ >= 0 + var_558_0 and arg_555_1.time_ < 0 + var_558_0 + arg_558_0 then
				arg_555_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_555_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_555_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["1084ui_story"].transform.position).z)
				arg_555_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_555_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_555_1.actors_["1084ui_story"].transform.localEulerAngles = arg_555_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_558_1 = arg_555_1.actors_["1084ui_story"]

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 and not isNil(var_558_1) and arg_555_1.var_.characterEffect1084ui_story == nil then
				arg_555_1.var_.characterEffect1084ui_story = var_558_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_558_2 = 0.200000002980232

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_2 and not isNil(var_558_1) then
				if arg_555_1.var_.characterEffect1084ui_story and not isNil(var_558_1) then
					arg_555_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_555_1.time_ >= 0 + var_558_2 and arg_555_1.time_ < 0 + var_558_2 + arg_558_0 and not isNil(var_558_1) and arg_555_1.var_.characterEffect1084ui_story then
				arg_555_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_558_4 = arg_555_1.actors_["1076ui_story"]

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 and not isNil(var_558_4) and arg_555_1.var_.characterEffect1076ui_story == nil then
				arg_555_1.var_.characterEffect1076ui_story = var_558_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_558_5 = 0.200000002980232

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_5 and not isNil(var_558_4) then
				if arg_555_1.var_.characterEffect1076ui_story and not isNil(var_558_4) then
					arg_555_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_555_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_555_1.time_ - 0) / var_558_5)
				end
			end

			if arg_555_1.time_ >= 0 + var_558_5 and arg_555_1.time_ < 0 + var_558_5 + arg_558_0 and not isNil(var_558_4) and arg_555_1.var_.characterEffect1076ui_story then
				arg_555_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_555_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_558_6 = 0
			local var_558_7 = 0.675

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_6 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				arg_555_1.leftNameTxt_.text = arg_555_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_8 = arg_555_1:GetWordFromCfg(121441135)
				local var_558_9 = arg_555_1:FormatText(var_558_8.content)

				arg_555_1.text_.text = var_558_9

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_11 = 27 <= 0 and var_558_7 or var_558_7 * (utf8.len(var_558_9) / 27)

				if (27 <= 0 and var_558_7 or var_558_7 * (utf8.len(var_558_9) / 27)) > 0 and var_558_7 < var_558_11 then
					arg_555_1.talkMaxDuration = var_558_11

					if var_558_11 + var_558_6 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_11 + var_558_6
					end
				end

				arg_555_1.text_.text = var_558_9
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441135", "story_v_out_121441.awb") ~= 0 then
					local var_558_12 = manager.audio:GetVoiceLength("story_v_out_121441", "121441135", "story_v_out_121441.awb") / 1000

					if var_558_12 + var_558_6 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_12 + var_558_6
					end

					if var_558_8.prefab_name ~= "" and arg_555_1.actors_[var_558_8.prefab_name] ~= nil then
						local var_558_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_555_1.actors_[var_558_8.prefab_name].transform, "story_v_out_121441", "121441135", "story_v_out_121441.awb")

						arg_555_1:RecordAudio("121441135", var_558_13)
						arg_555_1:RecordAudio("121441135", var_558_13)
					else
						arg_555_1:AudioAction("play", "voice", "story_v_out_121441", "121441135", "story_v_out_121441.awb")
					end

					arg_555_1:RecordHistoryTalkVoice("story_v_out_121441", "121441135", "story_v_out_121441.awb")
				end

				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_14 = math.max(var_558_7, arg_555_1.talkMaxDuration)

			if var_558_6 <= arg_555_1.time_ and arg_555_1.time_ < var_558_6 + var_558_14 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_6) / var_558_14

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_6 + var_558_14 and arg_555_1.time_ < var_558_6 + var_558_14 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_555_1:InitPlayNodeList()
	end,
	Play121441136 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 121441136
		arg_559_1.duration_ = 4.6

		local var_559_0 = {
			ja = 4.6,
			ko = 3.133,
			zh = 3.133
		}
		local var_559_1 = manager.audio:GetLocalizationFlag()

		if var_559_0[var_559_1] ~= nil then
			arg_559_1.duration_ = var_559_0[var_559_1]
		end

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play121441137(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1.var_.moveOldPos1084ui_story = arg_559_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_562_0 = 0.001

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_0 then
				arg_559_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_559_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_559_1.time_ - 0) / var_562_0)
				arg_559_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_559_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_559_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_559_1.actors_["1084ui_story"].transform.position).z)
				arg_559_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_559_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_559_1.actors_["1084ui_story"].transform.localEulerAngles = arg_559_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_559_1.time_ >= 0 + var_562_0 and arg_559_1.time_ < 0 + var_562_0 + arg_562_0 then
				arg_559_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_559_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_559_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_559_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_559_1.actors_["1084ui_story"].transform.position).z)
				arg_559_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_559_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_559_1.actors_["1084ui_story"].transform.localEulerAngles = arg_559_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_562_1 = arg_559_1.actors_["1084ui_story"]

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 and not isNil(var_562_1) and arg_559_1.var_.characterEffect1084ui_story == nil then
				arg_559_1.var_.characterEffect1084ui_story = var_562_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_562_2 = 0.200000002980232

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_2 and not isNil(var_562_1) then
				if arg_559_1.var_.characterEffect1084ui_story and not isNil(var_562_1) then
					arg_559_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_559_1.time_ >= 0 + var_562_2 and arg_559_1.time_ < 0 + var_562_2 + arg_562_0 and not isNil(var_562_1) and arg_559_1.var_.characterEffect1084ui_story then
				arg_559_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_562_4 = 0
			local var_562_5 = 0.425

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_4 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				arg_559_1.leftNameTxt_.text = arg_559_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_6 = arg_559_1:GetWordFromCfg(121441136)
				local var_562_7 = arg_559_1:FormatText(var_562_6.content)

				arg_559_1.text_.text = var_562_7

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_9 = 17 <= 0 and var_562_5 or var_562_5 * (utf8.len(var_562_7) / 17)

				if (17 <= 0 and var_562_5 or var_562_5 * (utf8.len(var_562_7) / 17)) > 0 and var_562_5 < var_562_9 then
					arg_559_1.talkMaxDuration = var_562_9

					if var_562_9 + var_562_4 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_9 + var_562_4
					end
				end

				arg_559_1.text_.text = var_562_7
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441136", "story_v_out_121441.awb") ~= 0 then
					local var_562_10 = manager.audio:GetVoiceLength("story_v_out_121441", "121441136", "story_v_out_121441.awb") / 1000

					if var_562_10 + var_562_4 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_10 + var_562_4
					end

					if var_562_6.prefab_name ~= "" and arg_559_1.actors_[var_562_6.prefab_name] ~= nil then
						local var_562_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_559_1.actors_[var_562_6.prefab_name].transform, "story_v_out_121441", "121441136", "story_v_out_121441.awb")

						arg_559_1:RecordAudio("121441136", var_562_11)
						arg_559_1:RecordAudio("121441136", var_562_11)
					else
						arg_559_1:AudioAction("play", "voice", "story_v_out_121441", "121441136", "story_v_out_121441.awb")
					end

					arg_559_1:RecordHistoryTalkVoice("story_v_out_121441", "121441136", "story_v_out_121441.awb")
				end

				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_12 = math.max(var_562_5, arg_559_1.talkMaxDuration)

			if var_562_4 <= arg_559_1.time_ and arg_559_1.time_ < var_562_4 + var_562_12 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_4) / var_562_12

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_4 + var_562_12 and arg_559_1.time_ < var_562_4 + var_562_12 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_559_1:InitPlayNodeList()
	end,
	Play121441137 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 121441137
		arg_563_1.duration_ = 6.97

		local var_563_0 = {
			ja = 6.966,
			ko = 4.133,
			zh = 4.133
		}
		local var_563_1 = manager.audio:GetLocalizationFlag()

		if var_563_0[var_563_1] ~= nil then
			arg_563_1.duration_ = var_563_0[var_563_1]
		end

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
			arg_563_1.auto_ = false
		end

		function arg_563_1.playNext_(arg_565_0)
			arg_563_1.onStoryFinished_()
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 and not isNil(arg_563_1.actors_["1076ui_story"]) and arg_563_1.var_.characterEffect1076ui_story == nil then
				arg_563_1.var_.characterEffect1076ui_story = arg_563_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_566_0 = 0.200000002980232

			if 0 <= arg_563_1.time_ and arg_563_1.time_ < 0 + var_566_0 and not isNil(arg_563_1.actors_["1076ui_story"]) then
				if arg_563_1.var_.characterEffect1076ui_story and not isNil(arg_563_1.actors_["1076ui_story"]) then
					arg_563_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_563_1.time_ >= 0 + var_566_0 and arg_563_1.time_ < 0 + var_566_0 + arg_566_0 and not isNil(arg_563_1.actors_["1076ui_story"]) and arg_563_1.var_.characterEffect1076ui_story then
				arg_563_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_566_2 = arg_563_1.actors_["1084ui_story"]

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 and not isNil(var_566_2) and arg_563_1.var_.characterEffect1084ui_story == nil then
				arg_563_1.var_.characterEffect1084ui_story = var_566_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_566_3 = 0.200000002980232

			if 0 <= arg_563_1.time_ and arg_563_1.time_ < 0 + var_566_3 and not isNil(var_566_2) then
				if arg_563_1.var_.characterEffect1084ui_story and not isNil(var_566_2) then
					arg_563_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_563_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_563_1.time_ - 0) / var_566_3)
				end
			end

			if arg_563_1.time_ >= 0 + var_566_3 and arg_563_1.time_ < 0 + var_566_3 + arg_566_0 and not isNil(var_566_2) and arg_563_1.var_.characterEffect1084ui_story then
				arg_563_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_563_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_566_4 = 0
			local var_566_5 = 0.525

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= var_566_4 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				arg_563_1.leftNameTxt_.text = arg_563_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_6 = arg_563_1:GetWordFromCfg(121441137)
				local var_566_7 = arg_563_1:FormatText(var_566_6.content)

				arg_563_1.text_.text = var_566_7

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_9 = 21 <= 0 and var_566_5 or var_566_5 * (utf8.len(var_566_7) / 21)

				if (21 <= 0 and var_566_5 or var_566_5 * (utf8.len(var_566_7) / 21)) > 0 and var_566_5 < var_566_9 then
					arg_563_1.talkMaxDuration = var_566_9

					if var_566_9 + var_566_4 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_9 + var_566_4
					end
				end

				arg_563_1.text_.text = var_566_7
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121441", "121441137", "story_v_out_121441.awb") ~= 0 then
					local var_566_10 = manager.audio:GetVoiceLength("story_v_out_121441", "121441137", "story_v_out_121441.awb") / 1000

					if var_566_10 + var_566_4 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_10 + var_566_4
					end

					if var_566_6.prefab_name ~= "" and arg_563_1.actors_[var_566_6.prefab_name] ~= nil then
						local var_566_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_6.prefab_name].transform, "story_v_out_121441", "121441137", "story_v_out_121441.awb")

						arg_563_1:RecordAudio("121441137", var_566_11)
						arg_563_1:RecordAudio("121441137", var_566_11)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_out_121441", "121441137", "story_v_out_121441.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_out_121441", "121441137", "story_v_out_121441.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_12 = math.max(var_566_5, arg_563_1.talkMaxDuration)

			if var_566_4 <= arg_563_1.time_ and arg_563_1.time_ < var_566_4 + var_566_12 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_4) / var_566_12

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_4 + var_566_12 and arg_563_1.time_ < var_566_4 + var_566_12 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST42",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/XH0302",
		"TextureConfig/Background/ST37",
		"TextureConfig/Background/ST41"
	},
	voices = {
		"story_v_out_121441.awb"
	}
}
