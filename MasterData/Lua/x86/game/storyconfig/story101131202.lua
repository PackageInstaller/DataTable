return {
	Play113122001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113122001
		arg_1_1.duration_ = 7

		local var_1_0 = {
			ja = 7,
			ko = 5.933,
			zh = 6.833,
			en = 5.433
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
				arg_1_0:Play113122002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F02_1 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F02_1")
				var_4_0.name = "F02_1"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F02_1 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F02_1

				arg_1_1.bgs_.F02_1.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F02_1" then
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 2
			local var_4_15 = 0.3

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6045")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_17 = arg_1_1:GetWordFromCfg(113122001)
				local var_4_18 = arg_1_1:FormatText(var_4_17.content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 12 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 12)

				if (12 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 12)) > 0 and var_4_15 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_14 = var_4_14 + 0.3

					if var_4_20 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122001", "story_v_out_113122.awb") ~= 0 then
					local var_4_21 = manager.audio:GetVoiceLength("story_v_out_113122", "113122001", "story_v_out_113122.awb") / 1000

					if var_4_21 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_14
					end

					if var_4_17.prefab_name ~= "" and arg_1_1.actors_[var_4_17.prefab_name] ~= nil then
						local var_4_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_17.prefab_name].transform, "story_v_out_113122", "113122001", "story_v_out_113122.awb")

						arg_1_1:RecordAudio("113122001", var_4_22)
						arg_1_1:RecordAudio("113122001", var_4_22)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_113122", "113122001", "story_v_out_113122.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_113122", "113122001", "story_v_out_113122.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_23 = var_4_14 + 0.3
			local var_4_24 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_23) / var_4_24

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play113122002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 113122002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play113122003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.65

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(113122002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 26 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 26)

				if (26 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 26)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play113122003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 113122003
		arg_13_1.duration_ = 3.8

		local var_13_0 = {
			ja = 3.8,
			ko = 2.866,
			zh = 3.3,
			en = 3
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
				arg_13_0:Play113122004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["6046_story"] == nil and not isNil((Asset.Load("Char/" .. "6046_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "6046_story"), arg_13_1.stage_.transform)

				var_16_0.name = "6046_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["6046_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["6046_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["6046_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["6046_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["6046_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos6046_story = var_16_3.localPosition

				local var_16_4 = GameObjectTools.GetOrAddComponent(var_16_3.gameObject, typeof(DynamicBoneHelper))

				if var_16_4 then
					var_16_4:EnableDynamicBone(false)
				end
			end

			local var_16_5 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_5 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos6046_story, Vector3.New(-0.7, -0.5, -6.3), (arg_13_1.time_ - 0) / var_16_5)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_5 and arg_13_1.time_ < 0 + var_16_5 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles

				local var_16_6 = GameObjectTools.GetOrAddComponent(var_16_3.gameObject, typeof(DynamicBoneHelper))

				if var_16_6 then
					var_16_6:EnableDynamicBone(true)
				end
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_16_7 = arg_13_1.actors_["6046_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.characterEffect6046_story == nil then
				arg_13_1.var_.characterEffect6046_story = var_16_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_8 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_8 and not isNil(var_16_7) then
				if arg_13_1.var_.characterEffect6046_story and not isNil(var_16_7) then
					arg_13_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_8 and arg_13_1.time_ < 0 + var_16_8 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.characterEffect6046_story then
				arg_13_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_16_10 = 0
			local var_16_11 = 0.25

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_12 = arg_13_1:GetWordFromCfg(113122003)
				local var_16_13 = arg_13_1:FormatText(var_16_12.content)

				arg_13_1.text_.text = var_16_13

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_15 = 10 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 10)

				if (10 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 10)) > 0 and var_16_11 < var_16_15 then
					arg_13_1.talkMaxDuration = var_16_15

					if var_16_15 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_10
					end
				end

				arg_13_1.text_.text = var_16_13
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122003", "story_v_out_113122.awb") ~= 0 then
					local var_16_16 = manager.audio:GetVoiceLength("story_v_out_113122", "113122003", "story_v_out_113122.awb") / 1000

					if var_16_16 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_10
					end

					if var_16_12.prefab_name ~= "" and arg_13_1.actors_[var_16_12.prefab_name] ~= nil then
						local var_16_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_12.prefab_name].transform, "story_v_out_113122", "113122003", "story_v_out_113122.awb")

						arg_13_1:RecordAudio("113122003", var_16_17)
						arg_13_1:RecordAudio("113122003", var_16_17)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_113122", "113122003", "story_v_out_113122.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_113122", "113122003", "story_v_out_113122.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_18 = math.max(var_16_11, arg_13_1.talkMaxDuration)

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_18 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_10) / var_16_18

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_10 + var_16_18 and arg_13_1.time_ < var_16_10 + var_16_18 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play113122004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 113122004
		arg_17_1.duration_ = 5.23

		local var_17_0 = {
			ja = 5.233,
			ko = 4.966,
			zh = 3.133,
			en = 2.533
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
				arg_17_0:Play113122005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["6046_story"]) and arg_17_1.var_.characterEffect6046_story == nil then
				arg_17_1.var_.characterEffect6046_story = arg_17_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["6046_story"]) then
				if arg_17_1.var_.characterEffect6046_story and not isNil(arg_17_1.actors_["6046_story"]) then
					arg_17_1.var_.characterEffect6046_story.fillFlat = true
					arg_17_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["6046_story"]) and arg_17_1.var_.characterEffect6046_story then
				arg_17_1.var_.characterEffect6046_story.fillFlat = true
				arg_17_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_20_1 = "10006ui_story"

			if arg_17_1.actors_["10006ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10006ui_story"))) then
				local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "10006ui_story"), arg_17_1.stage_.transform)

				var_20_2.name = var_20_1
				var_20_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_[var_20_1] = var_20_2

				local var_20_3 = var_20_2:GetComponentInChildren(typeof(CharacterEffect))

				var_20_3.enabled = true

				local var_20_4 = GameObjectTools.GetOrAddComponent(var_20_2, typeof(DynamicBoneHelper))

				if var_20_4 then
					var_20_4:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_3.transform, false)

				arg_17_1.var_[var_20_1 .. "Animator"] = var_20_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_[var_20_1 .. "Animator"].applyRootMotion = true
				arg_17_1.var_[var_20_1 .. "LipSync"] = var_20_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_5 = arg_17_1.actors_["10006ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10006ui_story = var_20_5.localPosition
			end

			local var_20_6 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 then
				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10006ui_story, Vector3.New(0.7, -0.98, -5.65), (arg_17_1.time_ - 0) / var_20_6)
				var_20_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_5.position).x, (manager.ui.mainCamera.transform.position - var_20_5.position).y, (manager.ui.mainCamera.transform.position - var_20_5.position).z)
				var_20_5.localEulerAngles.z = 0
				var_20_5.localEulerAngles.x = 0
				var_20_5.localEulerAngles = var_20_5.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0.7, -0.98, -5.65)
				var_20_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_5.position).x, (manager.ui.mainCamera.transform.position - var_20_5.position).y, (manager.ui.mainCamera.transform.position - var_20_5.position).z)
				var_20_5.localEulerAngles.z = 0
				var_20_5.localEulerAngles.x = 0
				var_20_5.localEulerAngles = var_20_5.localEulerAngles
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action7_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_20_7 = arg_17_1.actors_["10006ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.characterEffect10006ui_story == nil then
				arg_17_1.var_.characterEffect10006ui_story = var_20_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_8 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_8 and not isNil(var_20_7) then
				if arg_17_1.var_.characterEffect10006ui_story and not isNil(var_20_7) then
					arg_17_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_8 and arg_17_1.time_ < 0 + var_20_8 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.characterEffect10006ui_story then
				arg_17_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_20_10 = 0
			local var_20_11 = 0.225

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_12 = arg_17_1:GetWordFromCfg(113122004)
				local var_20_13 = arg_17_1:FormatText(var_20_12.content)

				arg_17_1.text_.text = var_20_13

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_15 = 9 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_13) / 9)

				if (9 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_13) / 9)) > 0 and var_20_11 < var_20_15 then
					arg_17_1.talkMaxDuration = var_20_15

					if var_20_15 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_15 + var_20_10
					end
				end

				arg_17_1.text_.text = var_20_13
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122004", "story_v_out_113122.awb") ~= 0 then
					local var_20_16 = manager.audio:GetVoiceLength("story_v_out_113122", "113122004", "story_v_out_113122.awb") / 1000

					if var_20_16 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_10
					end

					if var_20_12.prefab_name ~= "" and arg_17_1.actors_[var_20_12.prefab_name] ~= nil then
						local var_20_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_12.prefab_name].transform, "story_v_out_113122", "113122004", "story_v_out_113122.awb")

						arg_17_1:RecordAudio("113122004", var_20_17)
						arg_17_1:RecordAudio("113122004", var_20_17)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_113122", "113122004", "story_v_out_113122.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_113122", "113122004", "story_v_out_113122.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_18 = math.max(var_20_11, arg_17_1.talkMaxDuration)

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_18 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_10) / var_20_18

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_10 + var_20_18 and arg_17_1.time_ < var_20_10 + var_20_18 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play113122005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 113122005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play113122006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos6046_story = arg_21_1.actors_["6046_story"].transform.localPosition

				local var_24_0 = GameObjectTools.GetOrAddComponent(arg_21_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_24_0 then
					var_24_0:EnableDynamicBone(false)
				end
			end

			local var_24_1 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 then
				arg_21_1.actors_["6046_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_1)
				arg_21_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["6046_story"].transform.position).z)
				arg_21_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["6046_story"].transform.localEulerAngles = arg_21_1.actors_["6046_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 then
				arg_21_1.actors_["6046_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["6046_story"].transform.position).z)
				arg_21_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["6046_story"].transform.localEulerAngles = arg_21_1.actors_["6046_story"].transform.localEulerAngles

				local var_24_2 = GameObjectTools.GetOrAddComponent(arg_21_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(true)
				end
			end

			local var_24_3 = arg_21_1.actors_["10006ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10006ui_story = var_24_3.localPosition
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_3.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10006ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_4)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_3.localPosition = Vector3.New(0, 100, 0)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			local var_24_5 = 0
			local var_24_6 = 0.775

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_7 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(113122005).content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 31 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_7) / 31)

				if (31 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_7) / 31)) > 0 and var_24_6 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_6, arg_21_1.talkMaxDuration)

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_5) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_5 + var_24_10 and arg_21_1.time_ < var_24_5 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play113122006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 113122006
		arg_25_1.duration_ = 7.47

		local var_25_0 = {
			ja = 7.466,
			ko = 5.933,
			zh = 6.4,
			en = 4.333
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
				arg_25_0:Play113122007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.actors_["6045_story"] == nil and not isNil((Asset.Load("Char/" .. "6045_story"))) then
				local var_28_0 = Object.Instantiate(Asset.Load("Char/" .. "6045_story"), arg_25_1.stage_.transform)

				var_28_0.name = "6045_story"
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["6045_story"] = var_28_0

				local var_28_1 = var_28_0:GetComponentInChildren(typeof(CharacterEffect))

				var_28_1.enabled = true

				local var_28_2 = GameObjectTools.GetOrAddComponent(var_28_0, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(false)
				end

				arg_25_1:ShowWeapon(var_28_1.transform, false)

				arg_25_1.var_["6045_story" .. "Animator"] = var_28_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_25_1.var_["6045_story" .. "Animator"].applyRootMotion = true
				arg_25_1.var_["6045_story" .. "LipSync"] = var_28_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_28_3 = arg_25_1.actors_["6045_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos6045_story = var_28_3.localPosition

				local var_28_4 = GameObjectTools.GetOrAddComponent(var_28_3.gameObject, typeof(DynamicBoneHelper))

				if var_28_4 then
					var_28_4:EnableDynamicBone(false)
				end
			end

			local var_28_5 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_5 then
				var_28_3.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_25_1.time_ - 0) / var_28_5)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_5 and arg_25_1.time_ < 0 + var_28_5 + arg_28_0 then
				var_28_3.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles

				local var_28_6 = GameObjectTools.GetOrAddComponent(var_28_3.gameObject, typeof(DynamicBoneHelper))

				if var_28_6 then
					var_28_6:EnableDynamicBone(true)
				end
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_28_7 = arg_25_1.actors_["6045_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.characterEffect6045_story == nil then
				arg_25_1.var_.characterEffect6045_story = var_28_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_8 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_8 and not isNil(var_28_7) then
				if arg_25_1.var_.characterEffect6045_story and not isNil(var_28_7) then
					arg_25_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_8 and arg_25_1.time_ < 0 + var_28_8 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.characterEffect6045_story then
				arg_25_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_28_10 = 0
			local var_28_11 = 0.35

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_12 = arg_25_1:GetWordFromCfg(113122006)
				local var_28_13 = arg_25_1:FormatText(var_28_12.content)

				arg_25_1.text_.text = var_28_13

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_15 = 14 <= 0 and var_28_11 or var_28_11 * (utf8.len(var_28_13) / 14)

				if (14 <= 0 and var_28_11 or var_28_11 * (utf8.len(var_28_13) / 14)) > 0 and var_28_11 < var_28_15 then
					arg_25_1.talkMaxDuration = var_28_15

					if var_28_15 + var_28_10 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_15 + var_28_10
					end
				end

				arg_25_1.text_.text = var_28_13
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122006", "story_v_out_113122.awb") ~= 0 then
					local var_28_16 = manager.audio:GetVoiceLength("story_v_out_113122", "113122006", "story_v_out_113122.awb") / 1000

					if var_28_16 + var_28_10 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_16 + var_28_10
					end

					if var_28_12.prefab_name ~= "" and arg_25_1.actors_[var_28_12.prefab_name] ~= nil then
						local var_28_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_12.prefab_name].transform, "story_v_out_113122", "113122006", "story_v_out_113122.awb")

						arg_25_1:RecordAudio("113122006", var_28_17)
						arg_25_1:RecordAudio("113122006", var_28_17)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_113122", "113122006", "story_v_out_113122.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_113122", "113122006", "story_v_out_113122.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_18 = math.max(var_28_11, arg_25_1.talkMaxDuration)

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_18 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_10) / var_28_18

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_10 + var_28_18 and arg_25_1.time_ < var_28_10 + var_28_18 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play113122007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 113122007
		arg_29_1.duration_ = 5

		local var_29_0 = {
			ja = 5,
			ko = 3.8,
			zh = 4.066,
			en = 3.833
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
				arg_29_0:Play113122008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos6046_story = arg_29_1.actors_["6046_story"].transform.localPosition

				local var_32_0 = GameObjectTools.GetOrAddComponent(arg_29_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_32_0 then
					var_32_0:EnableDynamicBone(false)
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["6046_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_29_1.time_ - 0) / var_32_1)
				arg_29_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["6046_story"].transform.position).z)
				arg_29_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["6046_story"].transform.localEulerAngles = arg_29_1.actors_["6046_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["6046_story"].transform.localPosition = Vector3.New(0.7, -0.5, -6.3)
				arg_29_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["6046_story"].transform.position).z)
				arg_29_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["6046_story"].transform.localEulerAngles = arg_29_1.actors_["6046_story"].transform.localEulerAngles

				local var_32_2 = GameObjectTools.GetOrAddComponent(arg_29_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action2_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_32_3 = arg_29_1.actors_["6046_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_3) and arg_29_1.var_.characterEffect6046_story == nil then
				arg_29_1.var_.characterEffect6046_story = var_32_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_4 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 and not isNil(var_32_3) then
				if arg_29_1.var_.characterEffect6046_story and not isNil(var_32_3) then
					arg_29_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 and not isNil(var_32_3) and arg_29_1.var_.characterEffect6046_story then
				arg_29_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_32_6 = arg_29_1.actors_["6045_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect6045_story == nil then
				arg_29_1.var_.characterEffect6045_story = var_32_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_7 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 and not isNil(var_32_6) then
				if arg_29_1.var_.characterEffect6045_story and not isNil(var_32_6) then
					arg_29_1.var_.characterEffect6045_story.fillFlat = true
					arg_29_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_7)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect6045_story then
				arg_29_1.var_.characterEffect6045_story.fillFlat = true
				arg_29_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_32_8 = 0
			local var_32_9 = 0.325

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_10 = arg_29_1:GetWordFromCfg(113122007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 13 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 13)

				if (13 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 13)) > 0 and var_32_9 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122007", "story_v_out_113122.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_113122", "113122007", "story_v_out_113122.awb") / 1000

					if var_32_14 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_8
					end

					if var_32_10.prefab_name ~= "" and arg_29_1.actors_[var_32_10.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_10.prefab_name].transform, "story_v_out_113122", "113122007", "story_v_out_113122.awb")

						arg_29_1:RecordAudio("113122007", var_32_15)
						arg_29_1:RecordAudio("113122007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_113122", "113122007", "story_v_out_113122.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_113122", "113122007", "story_v_out_113122.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_16 and arg_29_1.time_ < var_32_8 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play113122008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 113122008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play113122009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos6046_story = arg_33_1.actors_["6046_story"].transform.localPosition

				local var_36_0 = GameObjectTools.GetOrAddComponent(arg_33_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_36_0 then
					var_36_0:EnableDynamicBone(false)
				end
			end

			local var_36_1 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 then
				arg_33_1.actors_["6046_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_1)
				arg_33_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["6046_story"].transform.position).z)
				arg_33_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["6046_story"].transform.localEulerAngles = arg_33_1.actors_["6046_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 then
				arg_33_1.actors_["6046_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["6046_story"].transform.position).z)
				arg_33_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["6046_story"].transform.localEulerAngles = arg_33_1.actors_["6046_story"].transform.localEulerAngles

				local var_36_2 = GameObjectTools.GetOrAddComponent(arg_33_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_36_2 then
					var_36_2:EnableDynamicBone(true)
				end
			end

			local var_36_3 = arg_33_1.actors_["6045_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos6045_story = var_36_3.localPosition

				local var_36_4 = GameObjectTools.GetOrAddComponent(var_36_3.gameObject, typeof(DynamicBoneHelper))

				if var_36_4 then
					var_36_4:EnableDynamicBone(false)
				end
			end

			local var_36_5 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_5 then
				var_36_3.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_5)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_5 and arg_33_1.time_ < 0 + var_36_5 + arg_36_0 then
				var_36_3.localPosition = Vector3.New(0, 100, 0)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles

				local var_36_6 = GameObjectTools.GetOrAddComponent(var_36_3.gameObject, typeof(DynamicBoneHelper))

				if var_36_6 then
					var_36_6:EnableDynamicBone(true)
				end
			end

			local var_36_7 = 0
			local var_36_8 = 0.85

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_7 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_9 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(113122008).content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 34 <= 0 and var_36_8 or var_36_8 * (utf8.len(var_36_9) / 34)

				if (34 <= 0 and var_36_8 or var_36_8 * (utf8.len(var_36_9) / 34)) > 0 and var_36_8 < var_36_11 then
					arg_33_1.talkMaxDuration = var_36_11

					if var_36_11 + var_36_7 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_7
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_8, arg_33_1.talkMaxDuration)

			if var_36_7 <= arg_33_1.time_ and arg_33_1.time_ < var_36_7 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_7) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_7 + var_36_12 and arg_33_1.time_ < var_36_7 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play113122009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 113122009
		arg_37_1.duration_ = 1.27

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play113122010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:AudioAction("play", "effect", "se_story_10", "se_story_10_mouse", "")
			end

			local var_40_1 = 0
			local var_40_2 = 0.125

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[220].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(113122009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 5 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_4) / 5)

				if (5 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_4) / 5)) > 0 and var_40_2 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122009", "story_v_out_113122.awb") ~= 0 then
					local var_40_7 = manager.audio:GetVoiceLength("story_v_out_113122", "113122009", "story_v_out_113122.awb") / 1000

					if var_40_7 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_1
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_113122", "113122009", "story_v_out_113122.awb")

						arg_37_1:RecordAudio("113122009", var_40_8)
						arg_37_1:RecordAudio("113122009", var_40_8)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_113122", "113122009", "story_v_out_113122.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_113122", "113122009", "story_v_out_113122.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_9 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_9 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_9

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_9 and arg_37_1.time_ < var_40_1 + var_40_9 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play113122010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 113122010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play113122011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.9

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(113122010).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 36 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 36)

				if (36 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 36)) > 0 and var_44_0 < var_44_3 then
					arg_41_1.talkMaxDuration = var_44_3

					if var_44_3 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_3 + 0
					end
				end

				arg_41_1.text_.text = var_44_1
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_4 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_4

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play113122011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 113122011
		arg_45_1.duration_ = 3.83

		local var_45_0 = {
			ja = 3.466,
			ko = 3.166,
			zh = 3.833,
			en = 3.066
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
				arg_45_0:Play113122012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos6045_story = arg_45_1.actors_["6045_story"].transform.localPosition

				local var_48_0 = GameObjectTools.GetOrAddComponent(arg_45_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_48_0 then
					var_48_0:EnableDynamicBone(false)
				end
			end

			local var_48_1 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 then
				arg_45_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos6045_story, Vector3.New(0, -0.5, -6.3), (arg_45_1.time_ - 0) / var_48_1)
				arg_45_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["6045_story"].transform.position).z)
				arg_45_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["6045_story"].transform.localEulerAngles = arg_45_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 then
				arg_45_1.actors_["6045_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_45_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["6045_story"].transform.position).z)
				arg_45_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["6045_story"].transform.localEulerAngles = arg_45_1.actors_["6045_story"].transform.localEulerAngles

				local var_48_2 = GameObjectTools.GetOrAddComponent(arg_45_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_48_2 then
					var_48_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_48_3 = arg_45_1.actors_["6045_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_3) and arg_45_1.var_.characterEffect6045_story == nil then
				arg_45_1.var_.characterEffect6045_story = var_48_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_4 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 and not isNil(var_48_3) then
				if arg_45_1.var_.characterEffect6045_story and not isNil(var_48_3) then
					arg_45_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 and not isNil(var_48_3) and arg_45_1.var_.characterEffect6045_story then
				arg_45_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_48_6 = 0
			local var_48_7 = 0.325

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_8 = arg_45_1:GetWordFromCfg(113122011)
				local var_48_9 = arg_45_1:FormatText(var_48_8.content)

				arg_45_1.text_.text = var_48_9

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 13 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_9) / 13)

				if (13 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_9) / 13)) > 0 and var_48_7 < var_48_11 then
					arg_45_1.talkMaxDuration = var_48_11

					if var_48_11 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_9
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122011", "story_v_out_113122.awb") ~= 0 then
					local var_48_12 = manager.audio:GetVoiceLength("story_v_out_113122", "113122011", "story_v_out_113122.awb") / 1000

					if var_48_12 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_12 + var_48_6
					end

					if var_48_8.prefab_name ~= "" and arg_45_1.actors_[var_48_8.prefab_name] ~= nil then
						local var_48_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_8.prefab_name].transform, "story_v_out_113122", "113122011", "story_v_out_113122.awb")

						arg_45_1:RecordAudio("113122011", var_48_13)
						arg_45_1:RecordAudio("113122011", var_48_13)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_113122", "113122011", "story_v_out_113122.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_113122", "113122011", "story_v_out_113122.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_14 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_14 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_14

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_14 and arg_45_1.time_ < var_48_6 + var_48_14 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play113122012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 113122012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play113122013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos6045_story = arg_49_1.actors_["6045_story"].transform.localPosition

				local var_52_0 = GameObjectTools.GetOrAddComponent(arg_49_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_52_0 then
					var_52_0:EnableDynamicBone(false)
				end
			end

			local var_52_1 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 then
				arg_49_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 0) / var_52_1)
				arg_49_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["6045_story"].transform.position).z)
				arg_49_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["6045_story"].transform.localEulerAngles = arg_49_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 then
				arg_49_1.actors_["6045_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["6045_story"].transform.position).z)
				arg_49_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["6045_story"].transform.localEulerAngles = arg_49_1.actors_["6045_story"].transform.localEulerAngles

				local var_52_2 = GameObjectTools.GetOrAddComponent(arg_49_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_52_2 then
					var_52_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:AudioAction("play", "effect", "se_story_10", "se_story_10_wood", "")
			end

			local var_52_4 = 0
			local var_52_5 = 1.025

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(113122012).content)

				arg_49_1.text_.text = var_52_6

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_8 = 41 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_6) / 41)

				if (41 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_6) / 41)) > 0 and var_52_5 < var_52_8 then
					arg_49_1.talkMaxDuration = var_52_8

					if var_52_8 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_6
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_9 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_9 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_9

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_9 and arg_49_1.time_ < var_52_4 + var_52_9 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play113122013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 113122013
		arg_53_1.duration_ = 5.93

		local var_53_0 = {
			ja = 5.933,
			ko = 3.533,
			zh = 5.366,
			en = 5.033
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
				arg_53_0:Play113122014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_56_0 = 0.6

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				local var_56_1, var_56_2 = math.modf((arg_53_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_56_2 * 0.13, var_56_2 * 0.13, var_56_2 * 0.13) + arg_53_1.var_.shakeOldPos
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				manager.ui.mainCamera.transform.localPosition = arg_53_1.var_.shakeOldPos
			end

			local var_56_3 = 0

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_3 + arg_56_0 then
				arg_53_1.allBtn_.enabled = false
			end

			if arg_53_1.time_ >= var_56_3 + 0.6 and arg_53_1.time_ < var_56_3 + 0.6 + arg_56_0 then
				arg_53_1.allBtn_.enabled = true
			end

			local var_56_4 = 0
			local var_56_5 = 0.475

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6045")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_6 = arg_53_1:GetWordFromCfg(113122013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 19 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 19)

				if (19 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 19)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122013", "story_v_out_113122.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_out_113122", "113122013", "story_v_out_113122.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_out_113122", "113122013", "story_v_out_113122.awb")

						arg_53_1:RecordAudio("113122013", var_56_11)
						arg_53_1:RecordAudio("113122013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_113122", "113122013", "story_v_out_113122.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_113122", "113122013", "story_v_out_113122.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_12 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_12 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_12

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_12 and arg_53_1.time_ < var_56_4 + var_56_12 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play113122014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 113122014
		arg_57_1.duration_ = 6.53

		local var_57_0 = {
			ja = 6.533,
			ko = 4.766,
			zh = 5.533,
			en = 5.633
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
				arg_57_0:Play113122015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos6046_story = arg_57_1.actors_["6046_story"].transform.localPosition

				local var_60_0 = GameObjectTools.GetOrAddComponent(arg_57_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_60_0 then
					var_60_0:EnableDynamicBone(false)
				end
			end

			local var_60_1 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 then
				arg_57_1.actors_["6046_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos6046_story, Vector3.New(-0.7, -0.5, -6.3), (arg_57_1.time_ - 0) / var_60_1)
				arg_57_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["6046_story"].transform.position).z)
				arg_57_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["6046_story"].transform.localEulerAngles = arg_57_1.actors_["6046_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 then
				arg_57_1.actors_["6046_story"].transform.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				arg_57_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["6046_story"].transform.position).z)
				arg_57_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["6046_story"].transform.localEulerAngles = arg_57_1.actors_["6046_story"].transform.localEulerAngles

				local var_60_2 = GameObjectTools.GetOrAddComponent(arg_57_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_60_2 then
					var_60_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_60_3 = arg_57_1.actors_["6046_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect6046_story == nil then
				arg_57_1.var_.characterEffect6046_story = var_60_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_4 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 and not isNil(var_60_3) then
				if arg_57_1.var_.characterEffect6046_story and not isNil(var_60_3) then
					arg_57_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect6046_story then
				arg_57_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_60_6 = 0
			local var_60_7 = 0.7

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_8 = arg_57_1:GetWordFromCfg(113122014)
				local var_60_9 = arg_57_1:FormatText(var_60_8.content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 28 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 28)

				if (28 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 28)) > 0 and var_60_7 < var_60_11 then
					arg_57_1.talkMaxDuration = var_60_11

					if var_60_11 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122014", "story_v_out_113122.awb") ~= 0 then
					local var_60_12 = manager.audio:GetVoiceLength("story_v_out_113122", "113122014", "story_v_out_113122.awb") / 1000

					if var_60_12 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_6
					end

					if var_60_8.prefab_name ~= "" and arg_57_1.actors_[var_60_8.prefab_name] ~= nil then
						local var_60_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_8.prefab_name].transform, "story_v_out_113122", "113122014", "story_v_out_113122.awb")

						arg_57_1:RecordAudio("113122014", var_60_13)
						arg_57_1:RecordAudio("113122014", var_60_13)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_113122", "113122014", "story_v_out_113122.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_113122", "113122014", "story_v_out_113122.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_14 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_14 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_14

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_14 and arg_57_1.time_ < var_60_6 + var_60_14 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play113122015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 113122015
		arg_61_1.duration_ = 5.83

		local var_61_0 = {
			ja = 5.833,
			ko = 3.2,
			zh = 3.766,
			en = 3.766
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
				arg_61_0:Play113122016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046actionlink/6046action442")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_64_0 = 0
			local var_64_1 = 0.325

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_2 = arg_61_1:GetWordFromCfg(113122015)
				local var_64_3 = arg_61_1:FormatText(var_64_2.content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 13 <= 0 and var_64_1 or var_64_1 * (utf8.len(var_64_3) / 13)

				if (13 <= 0 and var_64_1 or var_64_1 * (utf8.len(var_64_3) / 13)) > 0 and var_64_1 < var_64_5 then
					arg_61_1.talkMaxDuration = var_64_5

					if var_64_5 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122015", "story_v_out_113122.awb") ~= 0 then
					local var_64_6 = manager.audio:GetVoiceLength("story_v_out_113122", "113122015", "story_v_out_113122.awb") / 1000

					if var_64_6 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_0
					end

					if var_64_2.prefab_name ~= "" and arg_61_1.actors_[var_64_2.prefab_name] ~= nil then
						local var_64_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_2.prefab_name].transform, "story_v_out_113122", "113122015", "story_v_out_113122.awb")

						arg_61_1:RecordAudio("113122015", var_64_7)
						arg_61_1:RecordAudio("113122015", var_64_7)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_113122", "113122015", "story_v_out_113122.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_113122", "113122015", "story_v_out_113122.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_8 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_8 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_8

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_8 and arg_61_1.time_ < var_64_0 + var_64_8 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play113122016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 113122016
		arg_65_1.duration_ = 5.87

		local var_65_0 = {
			ja = 5.866,
			ko = 4.4,
			zh = 5.1,
			en = 5.2
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
				arg_65_0:Play113122017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if arg_65_1.actors_["1097ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1097ui_story"))) then
				local var_68_0 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_65_1.stage_.transform)

				var_68_0.name = "1097ui_story"
				var_68_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.actors_["1097ui_story"] = var_68_0

				local var_68_1 = var_68_0:GetComponentInChildren(typeof(CharacterEffect))

				var_68_1.enabled = true

				local var_68_2 = GameObjectTools.GetOrAddComponent(var_68_0, typeof(DynamicBoneHelper))

				if var_68_2 then
					var_68_2:EnableDynamicBone(false)
				end

				arg_65_1:ShowWeapon(var_68_1.transform, false)

				arg_65_1.var_["1097ui_story" .. "Animator"] = var_68_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_65_1.var_["1097ui_story" .. "Animator"].applyRootMotion = true
				arg_65_1.var_["1097ui_story" .. "LipSync"] = var_68_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_68_3 = arg_65_1.actors_["1097ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1097ui_story = var_68_3.localPosition
			end

			local var_68_4 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				var_68_3.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_65_1.time_ - 0) / var_68_4)
				var_68_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_3.position).x, (manager.ui.mainCamera.transform.position - var_68_3.position).y, (manager.ui.mainCamera.transform.position - var_68_3.position).z)
				var_68_3.localEulerAngles.z = 0
				var_68_3.localEulerAngles.x = 0
				var_68_3.localEulerAngles = var_68_3.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				var_68_3.localPosition = Vector3.New(0.7, -0.54, -6.3)
				var_68_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_3.position).x, (manager.ui.mainCamera.transform.position - var_68_3.position).y, (manager.ui.mainCamera.transform.position - var_68_3.position).z)
				var_68_3.localEulerAngles.z = 0
				var_68_3.localEulerAngles.x = 0
				var_68_3.localEulerAngles = var_68_3.localEulerAngles
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action4_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_68_5 = arg_65_1.actors_["1097ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.characterEffect1097ui_story == nil then
				arg_65_1.var_.characterEffect1097ui_story = var_68_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_6 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_6 and not isNil(var_68_5) then
				if arg_65_1.var_.characterEffect1097ui_story and not isNil(var_68_5) then
					arg_65_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_6 and arg_65_1.time_ < 0 + var_68_6 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.characterEffect1097ui_story then
				arg_65_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_68_8 = arg_65_1.actors_["6046_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.characterEffect6046_story == nil then
				arg_65_1.var_.characterEffect6046_story = var_68_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_9 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_9 and not isNil(var_68_8) then
				if arg_65_1.var_.characterEffect6046_story and not isNil(var_68_8) then
					arg_65_1.var_.characterEffect6046_story.fillFlat = true
					arg_65_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_9)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_9 and arg_65_1.time_ < 0 + var_68_9 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.characterEffect6046_story then
				arg_65_1.var_.characterEffect6046_story.fillFlat = true
				arg_65_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_68_10 = 0
			local var_68_11 = 0.275

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_12 = arg_65_1:GetWordFromCfg(113122016)
				local var_68_13 = arg_65_1:FormatText(var_68_12.content)

				arg_65_1.text_.text = var_68_13

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_15 = 11 <= 0 and var_68_11 or var_68_11 * (utf8.len(var_68_13) / 11)

				if (11 <= 0 and var_68_11 or var_68_11 * (utf8.len(var_68_13) / 11)) > 0 and var_68_11 < var_68_15 then
					arg_65_1.talkMaxDuration = var_68_15

					if var_68_15 + var_68_10 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_15 + var_68_10
					end
				end

				arg_65_1.text_.text = var_68_13
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122016", "story_v_out_113122.awb") ~= 0 then
					local var_68_16 = manager.audio:GetVoiceLength("story_v_out_113122", "113122016", "story_v_out_113122.awb") / 1000

					if var_68_16 + var_68_10 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_16 + var_68_10
					end

					if var_68_12.prefab_name ~= "" and arg_65_1.actors_[var_68_12.prefab_name] ~= nil then
						local var_68_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_12.prefab_name].transform, "story_v_out_113122", "113122016", "story_v_out_113122.awb")

						arg_65_1:RecordAudio("113122016", var_68_17)
						arg_65_1:RecordAudio("113122016", var_68_17)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_113122", "113122016", "story_v_out_113122.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_113122", "113122016", "story_v_out_113122.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_18 = math.max(var_68_11, arg_65_1.talkMaxDuration)

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_18 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_10) / var_68_18

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_10 + var_68_18 and arg_65_1.time_ < var_68_10 + var_68_18 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play113122017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 113122017
		arg_69_1.duration_ = 6.73

		local var_69_0 = {
			ja = 6.733,
			ko = 6.333,
			zh = 5.833,
			en = 5.7
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
				arg_69_0:Play113122018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1097ui_story"]) and arg_69_1.var_.characterEffect1097ui_story == nil then
				arg_69_1.var_.characterEffect1097ui_story = arg_69_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1097ui_story"]) then
				if arg_69_1.var_.characterEffect1097ui_story and not isNil(arg_69_1.actors_["1097ui_story"]) then
					arg_69_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1097ui_story"]) and arg_69_1.var_.characterEffect1097ui_story then
				arg_69_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_72_1 = arg_69_1.actors_["6045_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos6045_story = var_72_1.localPosition

				local var_72_2 = GameObjectTools.GetOrAddComponent(var_72_1.gameObject, typeof(DynamicBoneHelper))

				if var_72_2 then
					var_72_2:EnableDynamicBone(false)
				end
			end

			local var_72_3 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 then
				var_72_1.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_69_1.time_ - 0) / var_72_3)
				var_72_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_1.position).x, (manager.ui.mainCamera.transform.position - var_72_1.position).y, (manager.ui.mainCamera.transform.position - var_72_1.position).z)
				var_72_1.localEulerAngles.z = 0
				var_72_1.localEulerAngles.x = 0
				var_72_1.localEulerAngles = var_72_1.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 then
				var_72_1.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_72_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_1.position).x, (manager.ui.mainCamera.transform.position - var_72_1.position).y, (manager.ui.mainCamera.transform.position - var_72_1.position).z)
				var_72_1.localEulerAngles.z = 0
				var_72_1.localEulerAngles.x = 0
				var_72_1.localEulerAngles = var_72_1.localEulerAngles

				local var_72_4 = GameObjectTools.GetOrAddComponent(var_72_1.gameObject, typeof(DynamicBoneHelper))

				if var_72_4 then
					var_72_4:EnableDynamicBone(true)
				end
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_72_5 = arg_69_1.actors_["6045_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect6045_story == nil then
				arg_69_1.var_.characterEffect6045_story = var_72_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_6 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_6 and not isNil(var_72_5) then
				if arg_69_1.var_.characterEffect6045_story and not isNil(var_72_5) then
					arg_69_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_6 and arg_69_1.time_ < 0 + var_72_6 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect6045_story then
				arg_69_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_72_8 = arg_69_1.actors_["6046_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos6046_story = var_72_8.localPosition

				local var_72_9 = GameObjectTools.GetOrAddComponent(var_72_8.gameObject, typeof(DynamicBoneHelper))

				if var_72_9 then
					var_72_9:EnableDynamicBone(false)
				end
			end

			local var_72_10 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_10 then
				var_72_8.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_10)
				var_72_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_8.position).x, (manager.ui.mainCamera.transform.position - var_72_8.position).y, (manager.ui.mainCamera.transform.position - var_72_8.position).z)
				var_72_8.localEulerAngles.z = 0
				var_72_8.localEulerAngles.x = 0
				var_72_8.localEulerAngles = var_72_8.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_10 and arg_69_1.time_ < 0 + var_72_10 + arg_72_0 then
				var_72_8.localPosition = Vector3.New(0, 100, 0)
				var_72_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_8.position).x, (manager.ui.mainCamera.transform.position - var_72_8.position).y, (manager.ui.mainCamera.transform.position - var_72_8.position).z)
				var_72_8.localEulerAngles.z = 0
				var_72_8.localEulerAngles.x = 0
				var_72_8.localEulerAngles = var_72_8.localEulerAngles

				local var_72_11 = GameObjectTools.GetOrAddComponent(var_72_8.gameObject, typeof(DynamicBoneHelper))

				if var_72_11 then
					var_72_11:EnableDynamicBone(true)
				end
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action4_2")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_72_12 = 0
			local var_72_13 = 0.4

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_14 = arg_69_1:GetWordFromCfg(113122017)
				local var_72_15 = arg_69_1:FormatText(var_72_14.content)

				arg_69_1.text_.text = var_72_15

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_17 = 16 <= 0 and var_72_13 or var_72_13 * (utf8.len(var_72_15) / 16)

				if (16 <= 0 and var_72_13 or var_72_13 * (utf8.len(var_72_15) / 16)) > 0 and var_72_13 < var_72_17 then
					arg_69_1.talkMaxDuration = var_72_17

					if var_72_17 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_17 + var_72_12
					end
				end

				arg_69_1.text_.text = var_72_15
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122017", "story_v_out_113122.awb") ~= 0 then
					local var_72_18 = manager.audio:GetVoiceLength("story_v_out_113122", "113122017", "story_v_out_113122.awb") / 1000

					if var_72_18 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_18 + var_72_12
					end

					if var_72_14.prefab_name ~= "" and arg_69_1.actors_[var_72_14.prefab_name] ~= nil then
						local var_72_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_14.prefab_name].transform, "story_v_out_113122", "113122017", "story_v_out_113122.awb")

						arg_69_1:RecordAudio("113122017", var_72_19)
						arg_69_1:RecordAudio("113122017", var_72_19)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_113122", "113122017", "story_v_out_113122.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_113122", "113122017", "story_v_out_113122.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_20 = math.max(var_72_13, arg_69_1.talkMaxDuration)

			if var_72_12 <= arg_69_1.time_ and arg_69_1.time_ < var_72_12 + var_72_20 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_12) / var_72_20

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_12 + var_72_20 and arg_69_1.time_ < var_72_12 + var_72_20 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play113122018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 113122018
		arg_73_1.duration_ = 3.1

		local var_73_0 = {
			ja = 3.1,
			ko = 2.733,
			zh = 2.866,
			en = 2.8
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play113122019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["6045_story"]) and arg_73_1.var_.characterEffect6045_story == nil then
				arg_73_1.var_.characterEffect6045_story = arg_73_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["6045_story"]) then
				if arg_73_1.var_.characterEffect6045_story and not isNil(arg_73_1.actors_["6045_story"]) then
					arg_73_1.var_.characterEffect6045_story.fillFlat = true
					arg_73_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["6045_story"]) and arg_73_1.var_.characterEffect6045_story then
				arg_73_1.var_.characterEffect6045_story.fillFlat = true
				arg_73_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_76_1 = 0
			local var_76_2 = 0.25

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6046")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(113122018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 10 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_4) / 10)

				if (10 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_4) / 10)) > 0 and var_76_2 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122018", "story_v_out_113122.awb") ~= 0 then
					local var_76_7 = manager.audio:GetVoiceLength("story_v_out_113122", "113122018", "story_v_out_113122.awb") / 1000

					if var_76_7 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_1
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_113122", "113122018", "story_v_out_113122.awb")

						arg_73_1:RecordAudio("113122018", var_76_8)
						arg_73_1:RecordAudio("113122018", var_76_8)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_113122", "113122018", "story_v_out_113122.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_113122", "113122018", "story_v_out_113122.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_9 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_9 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_9

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_9 and arg_73_1.time_ < var_76_1 + var_76_9 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play113122019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 113122019
		arg_77_1.duration_ = 14.97

		local var_77_0 = {
			ja = 14.966,
			ko = 12.366,
			zh = 11.466,
			en = 12.066
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
				arg_77_0:Play113122020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_80_0 = arg_77_1.actors_["1097ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1097ui_story == nil then
				arg_77_1.var_.characterEffect1097ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_1 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 and not isNil(var_80_0) then
				if arg_77_1.var_.characterEffect1097ui_story and not isNil(var_80_0) then
					arg_77_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1097ui_story then
				arg_77_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_80_3 = 0
			local var_80_4 = 0.95

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_3 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_5 = arg_77_1:GetWordFromCfg(113122019)
				local var_80_6 = arg_77_1:FormatText(var_80_5.content)

				arg_77_1.text_.text = var_80_6

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_8 = 38 <= 0 and var_80_4 or var_80_4 * (utf8.len(var_80_6) / 38)

				if (38 <= 0 and var_80_4 or var_80_4 * (utf8.len(var_80_6) / 38)) > 0 and var_80_4 < var_80_8 then
					arg_77_1.talkMaxDuration = var_80_8

					if var_80_8 + var_80_3 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_3
					end
				end

				arg_77_1.text_.text = var_80_6
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122019", "story_v_out_113122.awb") ~= 0 then
					local var_80_9 = manager.audio:GetVoiceLength("story_v_out_113122", "113122019", "story_v_out_113122.awb") / 1000

					if var_80_9 + var_80_3 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_3
					end

					if var_80_5.prefab_name ~= "" and arg_77_1.actors_[var_80_5.prefab_name] ~= nil then
						local var_80_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_5.prefab_name].transform, "story_v_out_113122", "113122019", "story_v_out_113122.awb")

						arg_77_1:RecordAudio("113122019", var_80_10)
						arg_77_1:RecordAudio("113122019", var_80_10)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_113122", "113122019", "story_v_out_113122.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_113122", "113122019", "story_v_out_113122.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_11 = math.max(var_80_4, arg_77_1.talkMaxDuration)

			if var_80_3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_3 + var_80_11 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_3) / var_80_11

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_3 + var_80_11 and arg_77_1.time_ < var_80_3 + var_80_11 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play113122020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 113122020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play113122021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1097ui_story = arg_81_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1097ui_story"].transform.position).z)
				arg_81_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1097ui_story"].transform.localEulerAngles = arg_81_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1097ui_story"].transform.position).z)
				arg_81_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1097ui_story"].transform.localEulerAngles = arg_81_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["6045_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos6045_story = var_84_1.localPosition

				local var_84_2 = GameObjectTools.GetOrAddComponent(var_84_1.gameObject, typeof(DynamicBoneHelper))

				if var_84_2 then
					var_84_2:EnableDynamicBone(false)
				end
			end

			local var_84_3 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 then
				var_84_1.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_3)
				var_84_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_1.position).x, (manager.ui.mainCamera.transform.position - var_84_1.position).y, (manager.ui.mainCamera.transform.position - var_84_1.position).z)
				var_84_1.localEulerAngles.z = 0
				var_84_1.localEulerAngles.x = 0
				var_84_1.localEulerAngles = var_84_1.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 then
				var_84_1.localPosition = Vector3.New(0, 100, 0)
				var_84_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_1.position).x, (manager.ui.mainCamera.transform.position - var_84_1.position).y, (manager.ui.mainCamera.transform.position - var_84_1.position).z)
				var_84_1.localEulerAngles.z = 0
				var_84_1.localEulerAngles.x = 0
				var_84_1.localEulerAngles = var_84_1.localEulerAngles

				local var_84_4 = GameObjectTools.GetOrAddComponent(var_84_1.gameObject, typeof(DynamicBoneHelper))

				if var_84_4 then
					var_84_4:EnableDynamicBone(true)
				end
			end

			local var_84_5 = 0
			local var_84_6 = 0.325

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_7 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(113122020).content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 13 <= 0 and var_84_6 or var_84_6 * (utf8.len(var_84_7) / 13)

				if (13 <= 0 and var_84_6 or var_84_6 * (utf8.len(var_84_7) / 13)) > 0 and var_84_6 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_5 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_5
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_6, arg_81_1.talkMaxDuration)

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_5) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_5 + var_84_10 and arg_81_1.time_ < var_84_5 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play113122021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 113122021
		arg_85_1.duration_ = 8.9

		local var_85_0 = {
			ja = 8.9,
			ko = 6.633,
			zh = 7.333,
			en = 6.9
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
				arg_85_0:Play113122022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1097ui_story = arg_85_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1097ui_story"].transform.position).z)
				arg_85_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1097ui_story"].transform.localEulerAngles = arg_85_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_85_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1097ui_story"].transform.position).z)
				arg_85_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1097ui_story"].transform.localEulerAngles = arg_85_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_88_1 = arg_85_1.actors_["1097ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1097ui_story == nil then
				arg_85_1.var_.characterEffect1097ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1097ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1097ui_story then
				arg_85_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_88_4 = 0
			local var_88_5 = 0.4

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(113122021)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 16 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 16)

				if (16 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 16)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122021", "story_v_out_113122.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_out_113122", "113122021", "story_v_out_113122.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_out_113122", "113122021", "story_v_out_113122.awb")

						arg_85_1:RecordAudio("113122021", var_88_11)
						arg_85_1:RecordAudio("113122021", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_113122", "113122021", "story_v_out_113122.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_113122", "113122021", "story_v_out_113122.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_12 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_12 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_12

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_12 and arg_85_1.time_ < var_88_4 + var_88_12 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play113122022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 113122022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play113122023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1097ui_story"]) and arg_89_1.var_.characterEffect1097ui_story == nil then
				arg_89_1.var_.characterEffect1097ui_story = arg_89_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1097ui_story"]) then
				if arg_89_1.var_.characterEffect1097ui_story and not isNil(arg_89_1.actors_["1097ui_story"]) then
					arg_89_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1097ui_story"]) and arg_89_1.var_.characterEffect1097ui_story then
				arg_89_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_92_1 = 0
			local var_92_2 = 1.05

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(113122022).content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 42 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 42)

				if (42 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 42)) > 0 and var_92_2 < var_92_5 then
					arg_89_1.talkMaxDuration = var_92_5

					if var_92_5 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + var_92_1
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_6 = math.max(var_92_2, arg_89_1.talkMaxDuration)

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_6 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_1) / var_92_6

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_1 + var_92_6 and arg_89_1.time_ < var_92_1 + var_92_6 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play113122023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 113122023
		arg_93_1.duration_ = 8.03

		local var_93_0 = {
			ja = 5.566,
			ko = 8.033,
			zh = 5.766,
			en = 5.9
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
				arg_93_0:Play113122024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10006ui_story = arg_93_1.actors_["10006ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["10006ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10006ui_story, Vector3.New(0.7, -0.98, -5.65), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10006ui_story"].transform.position).z)
				arg_93_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10006ui_story"].transform.localEulerAngles = arg_93_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["10006ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -5.65)
				arg_93_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10006ui_story"].transform.position).z)
				arg_93_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10006ui_story"].transform.localEulerAngles = arg_93_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action6_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_96_1 = arg_93_1.actors_["10006ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect10006ui_story == nil then
				arg_93_1.var_.characterEffect10006ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect10006ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect10006ui_story then
				arg_93_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_96_4 = 0
			local var_96_5 = 0.55

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(113122023)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 22 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 22)

				if (22 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 22)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122023", "story_v_out_113122.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_113122", "113122023", "story_v_out_113122.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_113122", "113122023", "story_v_out_113122.awb")

						arg_93_1:RecordAudio("113122023", var_96_11)
						arg_93_1:RecordAudio("113122023", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_113122", "113122023", "story_v_out_113122.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_113122", "113122023", "story_v_out_113122.awb")
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

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play113122024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 113122024
		arg_97_1.duration_ = 12.6

		local var_97_0 = {
			ja = 12.6,
			ko = 9.3,
			zh = 6.766,
			en = 11.7
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
				arg_97_0:Play113122025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["10006ui_story"]) and arg_97_1.var_.characterEffect10006ui_story == nil then
				arg_97_1.var_.characterEffect10006ui_story = arg_97_1.actors_["10006ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["10006ui_story"]) then
				if arg_97_1.var_.characterEffect10006ui_story and not isNil(arg_97_1.actors_["10006ui_story"]) then
					arg_97_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["10006ui_story"]) and arg_97_1.var_.characterEffect10006ui_story then
				arg_97_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_100_1 = arg_97_1.actors_["1097ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1097ui_story == nil then
				arg_97_1.var_.characterEffect1097ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect1097ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1097ui_story then
				arg_97_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_100_4 = 0
			local var_100_5 = 0.75

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(113122024)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 30 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 30)

				if (30 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 30)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122024", "story_v_out_113122.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_out_113122", "113122024", "story_v_out_113122.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_out_113122", "113122024", "story_v_out_113122.awb")

						arg_97_1:RecordAudio("113122024", var_100_11)
						arg_97_1:RecordAudio("113122024", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_113122", "113122024", "story_v_out_113122.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_113122", "113122024", "story_v_out_113122.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_12 and arg_97_1.time_ < var_100_4 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play113122025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 113122025
		arg_101_1.duration_ = 5.9

		local var_101_0 = {
			ja = 5.566,
			ko = 4.5,
			zh = 5.9,
			en = 5.6
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
				arg_101_0:Play113122026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos6046_story = arg_101_1.actors_["6046_story"].transform.localPosition

				local var_104_0 = GameObjectTools.GetOrAddComponent(arg_101_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_104_0 then
					var_104_0:EnableDynamicBone(false)
				end
			end

			local var_104_1 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_1 then
				arg_101_1.actors_["6046_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_101_1.time_ - 0) / var_104_1)
				arg_101_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["6046_story"].transform.position).z)
				arg_101_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["6046_story"].transform.localEulerAngles = arg_101_1.actors_["6046_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_1 and arg_101_1.time_ < 0 + var_104_1 + arg_104_0 then
				arg_101_1.actors_["6046_story"].transform.localPosition = Vector3.New(0.7, -0.5, -6.3)
				arg_101_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["6046_story"].transform.position).z)
				arg_101_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["6046_story"].transform.localEulerAngles = arg_101_1.actors_["6046_story"].transform.localEulerAngles

				local var_104_2 = GameObjectTools.GetOrAddComponent(arg_101_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_104_2 then
					var_104_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_104_3 = arg_101_1.actors_["6046_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_3) and arg_101_1.var_.characterEffect6046_story == nil then
				arg_101_1.var_.characterEffect6046_story = var_104_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_4 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 and not isNil(var_104_3) then
				if arg_101_1.var_.characterEffect6046_story and not isNil(var_104_3) then
					arg_101_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 and not isNil(var_104_3) and arg_101_1.var_.characterEffect6046_story then
				arg_101_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_104_6 = arg_101_1.actors_["10006ui_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10006ui_story = var_104_6.localPosition
			end

			local var_104_7 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				var_104_6.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10006ui_story, Vector3.New(0, 100, 0), (arg_101_1.time_ - 0) / var_104_7)
				var_104_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_6.position).x, (manager.ui.mainCamera.transform.position - var_104_6.position).y, (manager.ui.mainCamera.transform.position - var_104_6.position).z)
				var_104_6.localEulerAngles.z = 0
				var_104_6.localEulerAngles.x = 0
				var_104_6.localEulerAngles = var_104_6.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				var_104_6.localPosition = Vector3.New(0, 100, 0)
				var_104_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_6.position).x, (manager.ui.mainCamera.transform.position - var_104_6.position).y, (manager.ui.mainCamera.transform.position - var_104_6.position).z)
				var_104_6.localEulerAngles.z = 0
				var_104_6.localEulerAngles.x = 0
				var_104_6.localEulerAngles = var_104_6.localEulerAngles
			end

			local var_104_8 = arg_101_1.actors_["1097ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_8) and arg_101_1.var_.characterEffect1097ui_story == nil then
				arg_101_1.var_.characterEffect1097ui_story = var_104_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_9 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_9 and not isNil(var_104_8) then
				if arg_101_1.var_.characterEffect1097ui_story and not isNil(var_104_8) then
					arg_101_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_9)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_9 and arg_101_1.time_ < 0 + var_104_9 + arg_104_0 and not isNil(var_104_8) and arg_101_1.var_.characterEffect1097ui_story then
				arg_101_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_104_10 = 0
			local var_104_11 = 0.5

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_12 = arg_101_1:GetWordFromCfg(113122025)
				local var_104_13 = arg_101_1:FormatText(var_104_12.content)

				arg_101_1.text_.text = var_104_13

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_15 = 20 <= 0 and var_104_11 or var_104_11 * (utf8.len(var_104_13) / 20)

				if (20 <= 0 and var_104_11 or var_104_11 * (utf8.len(var_104_13) / 20)) > 0 and var_104_11 < var_104_15 then
					arg_101_1.talkMaxDuration = var_104_15

					if var_104_15 + var_104_10 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_15 + var_104_10
					end
				end

				arg_101_1.text_.text = var_104_13
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122025", "story_v_out_113122.awb") ~= 0 then
					local var_104_16 = manager.audio:GetVoiceLength("story_v_out_113122", "113122025", "story_v_out_113122.awb") / 1000

					if var_104_16 + var_104_10 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_16 + var_104_10
					end

					if var_104_12.prefab_name ~= "" and arg_101_1.actors_[var_104_12.prefab_name] ~= nil then
						local var_104_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_12.prefab_name].transform, "story_v_out_113122", "113122025", "story_v_out_113122.awb")

						arg_101_1:RecordAudio("113122025", var_104_17)
						arg_101_1:RecordAudio("113122025", var_104_17)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_113122", "113122025", "story_v_out_113122.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_113122", "113122025", "story_v_out_113122.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_18 = math.max(var_104_11, arg_101_1.talkMaxDuration)

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_18 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_10) / var_104_18

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_10 + var_104_18 and arg_101_1.time_ < var_104_10 + var_104_18 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play113122026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 113122026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play113122027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos6046_story = arg_105_1.actors_["6046_story"].transform.localPosition

				local var_108_0 = GameObjectTools.GetOrAddComponent(arg_105_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_108_0 then
					var_108_0:EnableDynamicBone(false)
				end
			end

			local var_108_1 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 then
				arg_105_1.actors_["6046_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_1)
				arg_105_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["6046_story"].transform.position).z)
				arg_105_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["6046_story"].transform.localEulerAngles = arg_105_1.actors_["6046_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 then
				arg_105_1.actors_["6046_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["6046_story"].transform.position).z)
				arg_105_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["6046_story"].transform.localEulerAngles = arg_105_1.actors_["6046_story"].transform.localEulerAngles

				local var_108_2 = GameObjectTools.GetOrAddComponent(arg_105_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_108_2 then
					var_108_2:EnableDynamicBone(true)
				end
			end

			local var_108_3 = arg_105_1.actors_["1097ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1097ui_story = var_108_3.localPosition
			end

			local var_108_4 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				var_108_3.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_4)
				var_108_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_3.position).x, (manager.ui.mainCamera.transform.position - var_108_3.position).y, (manager.ui.mainCamera.transform.position - var_108_3.position).z)
				var_108_3.localEulerAngles.z = 0
				var_108_3.localEulerAngles.x = 0
				var_108_3.localEulerAngles = var_108_3.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				var_108_3.localPosition = Vector3.New(0, 100, 0)
				var_108_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_3.position).x, (manager.ui.mainCamera.transform.position - var_108_3.position).y, (manager.ui.mainCamera.transform.position - var_108_3.position).z)
				var_108_3.localEulerAngles.z = 0
				var_108_3.localEulerAngles.x = 0
				var_108_3.localEulerAngles = var_108_3.localEulerAngles
			end

			local var_108_5 = 0
			local var_108_6 = 0.6

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_7 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(113122026).content)

				arg_105_1.text_.text = var_108_7

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_9 = 24 <= 0 and var_108_6 or var_108_6 * (utf8.len(var_108_7) / 24)

				if (24 <= 0 and var_108_6 or var_108_6 * (utf8.len(var_108_7) / 24)) > 0 and var_108_6 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_5 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_5
					end
				end

				arg_105_1.text_.text = var_108_7
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_6, arg_105_1.talkMaxDuration)

			if var_108_5 <= arg_105_1.time_ and arg_105_1.time_ < var_108_5 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_5) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_5 + var_108_10 and arg_105_1.time_ < var_108_5 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play113122027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 113122027
		arg_109_1.duration_ = 8.67

		local var_109_0 = {
			ja = 8.266,
			ko = 5.366,
			zh = 7.566,
			en = 8.666
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play113122028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos6046_story = arg_109_1.actors_["6046_story"].transform.localPosition

				local var_112_0 = GameObjectTools.GetOrAddComponent(arg_109_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_112_0 then
					var_112_0:EnableDynamicBone(false)
				end
			end

			local var_112_1 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_1 then
				arg_109_1.actors_["6046_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos6046_story, Vector3.New(-0.7, -0.5, -6.3), (arg_109_1.time_ - 0) / var_112_1)
				arg_109_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["6046_story"].transform.position).z)
				arg_109_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["6046_story"].transform.localEulerAngles = arg_109_1.actors_["6046_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_1 and arg_109_1.time_ < 0 + var_112_1 + arg_112_0 then
				arg_109_1.actors_["6046_story"].transform.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				arg_109_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["6046_story"].transform.position).z)
				arg_109_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["6046_story"].transform.localEulerAngles = arg_109_1.actors_["6046_story"].transform.localEulerAngles

				local var_112_2 = GameObjectTools.GetOrAddComponent(arg_109_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_112_2 then
					var_112_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_112_3 = arg_109_1.actors_["6046_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_3) and arg_109_1.var_.characterEffect6046_story == nil then
				arg_109_1.var_.characterEffect6046_story = var_112_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_4 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 and not isNil(var_112_3) then
				if arg_109_1.var_.characterEffect6046_story and not isNil(var_112_3) then
					arg_109_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 and not isNil(var_112_3) and arg_109_1.var_.characterEffect6046_story then
				arg_109_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_112_6 = 0
			local var_112_7 = 0.75

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_8 = arg_109_1:GetWordFromCfg(113122027)
				local var_112_9 = arg_109_1:FormatText(var_112_8.content)

				arg_109_1.text_.text = var_112_9

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 30 <= 0 and var_112_7 or var_112_7 * (utf8.len(var_112_9) / 30)

				if (30 <= 0 and var_112_7 or var_112_7 * (utf8.len(var_112_9) / 30)) > 0 and var_112_7 < var_112_11 then
					arg_109_1.talkMaxDuration = var_112_11

					if var_112_11 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_11 + var_112_6
					end
				end

				arg_109_1.text_.text = var_112_9
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122027", "story_v_out_113122.awb") ~= 0 then
					local var_112_12 = manager.audio:GetVoiceLength("story_v_out_113122", "113122027", "story_v_out_113122.awb") / 1000

					if var_112_12 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_12 + var_112_6
					end

					if var_112_8.prefab_name ~= "" and arg_109_1.actors_[var_112_8.prefab_name] ~= nil then
						local var_112_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_8.prefab_name].transform, "story_v_out_113122", "113122027", "story_v_out_113122.awb")

						arg_109_1:RecordAudio("113122027", var_112_13)
						arg_109_1:RecordAudio("113122027", var_112_13)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_113122", "113122027", "story_v_out_113122.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_113122", "113122027", "story_v_out_113122.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_14 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_14 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_6) / var_112_14

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_6 + var_112_14 and arg_109_1.time_ < var_112_6 + var_112_14 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play113122028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 113122028
		arg_113_1.duration_ = 2.43

		local var_113_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.433,
			en = 1.999999999999
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play113122029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10006ui_story = arg_113_1.actors_["10006ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["10006ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10006ui_story, Vector3.New(0.7, -0.98, -5.65), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10006ui_story"].transform.position).z)
				arg_113_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10006ui_story"].transform.localEulerAngles = arg_113_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["10006ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -5.65)
				arg_113_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10006ui_story"].transform.position).z)
				arg_113_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10006ui_story"].transform.localEulerAngles = arg_113_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action1_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_116_1 = arg_113_1.actors_["10006ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10006ui_story == nil then
				arg_113_1.var_.characterEffect10006ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect10006ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10006ui_story then
				arg_113_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_116_4 = arg_113_1.actors_["6046_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_4) and arg_113_1.var_.characterEffect6046_story == nil then
				arg_113_1.var_.characterEffect6046_story = var_116_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_5 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_5 and not isNil(var_116_4) then
				if arg_113_1.var_.characterEffect6046_story and not isNil(var_116_4) then
					arg_113_1.var_.characterEffect6046_story.fillFlat = true
					arg_113_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_5)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_5 and arg_113_1.time_ < 0 + var_116_5 + arg_116_0 and not isNil(var_116_4) and arg_113_1.var_.characterEffect6046_story then
				arg_113_1.var_.characterEffect6046_story.fillFlat = true
				arg_113_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_116_6 = 0
			local var_116_7 = 0.1

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_8 = arg_113_1:GetWordFromCfg(113122028)
				local var_116_9 = arg_113_1:FormatText(var_116_8.content)

				arg_113_1.text_.text = var_116_9

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_11 = 4 <= 0 and var_116_7 or var_116_7 * (utf8.len(var_116_9) / 4)

				if (4 <= 0 and var_116_7 or var_116_7 * (utf8.len(var_116_9) / 4)) > 0 and var_116_7 < var_116_11 then
					arg_113_1.talkMaxDuration = var_116_11

					if var_116_11 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_11 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_9
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122028", "story_v_out_113122.awb") ~= 0 then
					local var_116_12 = manager.audio:GetVoiceLength("story_v_out_113122", "113122028", "story_v_out_113122.awb") / 1000

					if var_116_12 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_12 + var_116_6
					end

					if var_116_8.prefab_name ~= "" and arg_113_1.actors_[var_116_8.prefab_name] ~= nil then
						local var_116_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_8.prefab_name].transform, "story_v_out_113122", "113122028", "story_v_out_113122.awb")

						arg_113_1:RecordAudio("113122028", var_116_13)
						arg_113_1:RecordAudio("113122028", var_116_13)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_113122", "113122028", "story_v_out_113122.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_113122", "113122028", "story_v_out_113122.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_14 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_14 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_14

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_14 and arg_113_1.time_ < var_116_6 + var_116_14 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play113122029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 113122029
		arg_117_1.duration_ = 6.87

		local var_117_0 = {
			ja = 2.833,
			ko = 1.4,
			zh = 6.866,
			en = 4.066
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play113122030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["10006ui_story"]) and arg_117_1.var_.characterEffect10006ui_story == nil then
				arg_117_1.var_.characterEffect10006ui_story = arg_117_1.actors_["10006ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["10006ui_story"]) then
				if arg_117_1.var_.characterEffect10006ui_story and not isNil(arg_117_1.actors_["10006ui_story"]) then
					arg_117_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_0)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["10006ui_story"]) and arg_117_1.var_.characterEffect10006ui_story then
				arg_117_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			local var_120_1 = 0
			local var_120_2 = 0.475

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:GetWordFromCfg(113122029)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_6 = 18 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_4) / 18)

				if (18 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_4) / 18)) > 0 and var_120_2 < var_120_6 then
					arg_117_1.talkMaxDuration = var_120_6

					if var_120_6 + var_120_1 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_6 + var_120_1
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122029", "story_v_out_113122.awb") ~= 0 then
					local var_120_7 = manager.audio:GetVoiceLength("story_v_out_113122", "113122029", "story_v_out_113122.awb") / 1000

					if var_120_7 + var_120_1 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_1
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_out_113122", "113122029", "story_v_out_113122.awb")

						arg_117_1:RecordAudio("113122029", var_120_8)
						arg_117_1:RecordAudio("113122029", var_120_8)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_113122", "113122029", "story_v_out_113122.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_113122", "113122029", "story_v_out_113122.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_9 = math.max(var_120_2, arg_117_1.talkMaxDuration)

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_9 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_1) / var_120_9

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_1 + var_120_9 and arg_117_1.time_ < var_120_1 + var_120_9 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play113122030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 113122030
		arg_121_1.duration_ = 15.7

		local var_121_0 = {
			ja = 15.7,
			ko = 11.2,
			zh = 7.466,
			en = 12.133
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play113122031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action6_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_124_0 = arg_121_1.actors_["10006ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect10006ui_story == nil then
				arg_121_1.var_.characterEffect10006ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_1 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_1 and not isNil(var_124_0) then
				if arg_121_1.var_.characterEffect10006ui_story and not isNil(var_124_0) then
					arg_121_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_1 and arg_121_1.time_ < 0 + var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect10006ui_story then
				arg_121_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_124_3 = 0
			local var_124_4 = 1

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_3 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_5 = arg_121_1:GetWordFromCfg(113122030)
				local var_124_6 = arg_121_1:FormatText(var_124_5.content)

				arg_121_1.text_.text = var_124_6

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_8 = 40 <= 0 and var_124_4 or var_124_4 * (utf8.len(var_124_6) / 40)

				if (40 <= 0 and var_124_4 or var_124_4 * (utf8.len(var_124_6) / 40)) > 0 and var_124_4 < var_124_8 then
					arg_121_1.talkMaxDuration = var_124_8

					if var_124_8 + var_124_3 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_3
					end
				end

				arg_121_1.text_.text = var_124_6
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122030", "story_v_out_113122.awb") ~= 0 then
					local var_124_9 = manager.audio:GetVoiceLength("story_v_out_113122", "113122030", "story_v_out_113122.awb") / 1000

					if var_124_9 + var_124_3 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_3
					end

					if var_124_5.prefab_name ~= "" and arg_121_1.actors_[var_124_5.prefab_name] ~= nil then
						local var_124_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_5.prefab_name].transform, "story_v_out_113122", "113122030", "story_v_out_113122.awb")

						arg_121_1:RecordAudio("113122030", var_124_10)
						arg_121_1:RecordAudio("113122030", var_124_10)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_113122", "113122030", "story_v_out_113122.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_113122", "113122030", "story_v_out_113122.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_11 = math.max(var_124_4, arg_121_1.talkMaxDuration)

			if var_124_3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_3 + var_124_11 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_3) / var_124_11

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_3 + var_124_11 and arg_121_1.time_ < var_124_3 + var_124_11 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play113122031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 113122031
		arg_125_1.duration_ = 10.73

		local var_125_0 = {
			ja = 10.733,
			ko = 6.666,
			zh = 4.966,
			en = 6.066
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play113122032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_128_0 = 0
			local var_128_1 = 0.65

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_2 = arg_125_1:GetWordFromCfg(113122031)
				local var_128_3 = arg_125_1:FormatText(var_128_2.content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 26 <= 0 and var_128_1 or var_128_1 * (utf8.len(var_128_3) / 26)

				if (26 <= 0 and var_128_1 or var_128_1 * (utf8.len(var_128_3) / 26)) > 0 and var_128_1 < var_128_5 then
					arg_125_1.talkMaxDuration = var_128_5

					if var_128_5 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122031", "story_v_out_113122.awb") ~= 0 then
					local var_128_6 = manager.audio:GetVoiceLength("story_v_out_113122", "113122031", "story_v_out_113122.awb") / 1000

					if var_128_6 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_6 + var_128_0
					end

					if var_128_2.prefab_name ~= "" and arg_125_1.actors_[var_128_2.prefab_name] ~= nil then
						local var_128_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_2.prefab_name].transform, "story_v_out_113122", "113122031", "story_v_out_113122.awb")

						arg_125_1:RecordAudio("113122031", var_128_7)
						arg_125_1:RecordAudio("113122031", var_128_7)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_113122", "113122031", "story_v_out_113122.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_113122", "113122031", "story_v_out_113122.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_8 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_8 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_8

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_8 and arg_125_1.time_ < var_128_0 + var_128_8 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play113122032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 113122032
		arg_129_1.duration_ = 1.83

		local var_129_0 = {
			ja = 1.666,
			ko = 1.266,
			zh = 1.6,
			en = 1.833
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play113122033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["10006ui_story"]) and arg_129_1.var_.characterEffect10006ui_story == nil then
				arg_129_1.var_.characterEffect10006ui_story = arg_129_1.actors_["10006ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["10006ui_story"]) then
				if arg_129_1.var_.characterEffect10006ui_story and not isNil(arg_129_1.actors_["10006ui_story"]) then
					arg_129_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_0)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["10006ui_story"]) and arg_129_1.var_.characterEffect10006ui_story then
				arg_129_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			local var_132_1 = 0
			local var_132_2 = 0.075

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:GetWordFromCfg(113122032)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_6 = 3 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_4) / 3)

				if (3 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_4) / 3)) > 0 and var_132_2 < var_132_6 then
					arg_129_1.talkMaxDuration = var_132_6

					if var_132_6 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122032", "story_v_out_113122.awb") ~= 0 then
					local var_132_7 = manager.audio:GetVoiceLength("story_v_out_113122", "113122032", "story_v_out_113122.awb") / 1000

					if var_132_7 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_1
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_113122", "113122032", "story_v_out_113122.awb")

						arg_129_1:RecordAudio("113122032", var_132_8)
						arg_129_1:RecordAudio("113122032", var_132_8)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_113122", "113122032", "story_v_out_113122.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_113122", "113122032", "story_v_out_113122.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_9 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_9 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_9

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_9 and arg_129_1.time_ < var_132_1 + var_132_9 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play113122033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 113122033
		arg_133_1.duration_ = 11.1

		local var_133_0 = {
			ja = 11.1,
			ko = 8.8,
			zh = 7.9,
			en = 5.7
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play113122034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046actionlink/6046action442")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_136_0 = arg_133_1.actors_["6046_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect6046_story == nil then
				arg_133_1.var_.characterEffect6046_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_1 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_1 and not isNil(var_136_0) then
				if arg_133_1.var_.characterEffect6046_story and not isNil(var_136_0) then
					arg_133_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_1 and arg_133_1.time_ < 0 + var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect6046_story then
				arg_133_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_136_3 = 0
			local var_136_4 = 0.775

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_3 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_5 = arg_133_1:GetWordFromCfg(113122033)
				local var_136_6 = arg_133_1:FormatText(var_136_5.content)

				arg_133_1.text_.text = var_136_6

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_8 = 31 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_6) / 31)

				if (31 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_6) / 31)) > 0 and var_136_4 < var_136_8 then
					arg_133_1.talkMaxDuration = var_136_8

					if var_136_8 + var_136_3 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_3
					end
				end

				arg_133_1.text_.text = var_136_6
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122033", "story_v_out_113122.awb") ~= 0 then
					local var_136_9 = manager.audio:GetVoiceLength("story_v_out_113122", "113122033", "story_v_out_113122.awb") / 1000

					if var_136_9 + var_136_3 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_3
					end

					if var_136_5.prefab_name ~= "" and arg_133_1.actors_[var_136_5.prefab_name] ~= nil then
						local var_136_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_5.prefab_name].transform, "story_v_out_113122", "113122033", "story_v_out_113122.awb")

						arg_133_1:RecordAudio("113122033", var_136_10)
						arg_133_1:RecordAudio("113122033", var_136_10)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_113122", "113122033", "story_v_out_113122.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_113122", "113122033", "story_v_out_113122.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_11 = math.max(var_136_4, arg_133_1.talkMaxDuration)

			if var_136_3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_3 + var_136_11 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_3) / var_136_11

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_3 + var_136_11 and arg_133_1.time_ < var_136_3 + var_136_11 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play113122034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 113122034
		arg_137_1.duration_ = 20.5

		local var_137_0 = {
			ja = 20.133,
			ko = 14.433,
			zh = 10.9,
			en = 20.5
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play113122035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["6046_story"]) and arg_137_1.var_.characterEffect6046_story == nil then
				arg_137_1.var_.characterEffect6046_story = arg_137_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["6046_story"]) then
				if arg_137_1.var_.characterEffect6046_story and not isNil(arg_137_1.actors_["6046_story"]) then
					arg_137_1.var_.characterEffect6046_story.fillFlat = true
					arg_137_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_0)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["6046_story"]) and arg_137_1.var_.characterEffect6046_story then
				arg_137_1.var_.characterEffect6046_story.fillFlat = true
				arg_137_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006actionlink/10006action464")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_140_1 = arg_137_1.actors_["10006ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect10006ui_story == nil then
				arg_137_1.var_.characterEffect10006ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect10006ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect10006ui_story then
				arg_137_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_140_4 = 0
			local var_140_5 = 1.275

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_6 = arg_137_1:GetWordFromCfg(113122034)
				local var_140_7 = arg_137_1:FormatText(var_140_6.content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 51 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 51)

				if (51 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 51)) > 0 and var_140_5 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122034", "story_v_out_113122.awb") ~= 0 then
					local var_140_10 = manager.audio:GetVoiceLength("story_v_out_113122", "113122034", "story_v_out_113122.awb") / 1000

					if var_140_10 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_4
					end

					if var_140_6.prefab_name ~= "" and arg_137_1.actors_[var_140_6.prefab_name] ~= nil then
						local var_140_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_6.prefab_name].transform, "story_v_out_113122", "113122034", "story_v_out_113122.awb")

						arg_137_1:RecordAudio("113122034", var_140_11)
						arg_137_1:RecordAudio("113122034", var_140_11)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_113122", "113122034", "story_v_out_113122.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_113122", "113122034", "story_v_out_113122.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_12 = math.max(var_140_5, arg_137_1.talkMaxDuration)

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_12 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_4) / var_140_12

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_4 + var_140_12 and arg_137_1.time_ < var_140_4 + var_140_12 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play113122035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 113122035
		arg_141_1.duration_ = 4.43

		local var_141_0 = {
			ja = 4.433,
			ko = 3.3,
			zh = 3.966,
			en = 3.266
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play113122036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["10006ui_story"]) and arg_141_1.var_.characterEffect10006ui_story == nil then
				arg_141_1.var_.characterEffect10006ui_story = arg_141_1.actors_["10006ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["10006ui_story"]) then
				if arg_141_1.var_.characterEffect10006ui_story and not isNil(arg_141_1.actors_["10006ui_story"]) then
					arg_141_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_0)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["10006ui_story"]) and arg_141_1.var_.characterEffect10006ui_story then
				arg_141_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action2_2")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_144_1 = arg_141_1.actors_["6046_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect6046_story == nil then
				arg_141_1.var_.characterEffect6046_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect6046_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect6046_story then
				arg_141_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action4_2")
			end

			local var_144_4 = 0
			local var_144_5 = 0.375

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(113122035)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 15 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 15)

				if (15 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 15)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122035", "story_v_out_113122.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_out_113122", "113122035", "story_v_out_113122.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_out_113122", "113122035", "story_v_out_113122.awb")

						arg_141_1:RecordAudio("113122035", var_144_11)
						arg_141_1:RecordAudio("113122035", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_113122", "113122035", "story_v_out_113122.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_113122", "113122035", "story_v_out_113122.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_12 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_12 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_12

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_12 and arg_141_1.time_ < var_144_4 + var_144_12 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play113122036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 113122036
		arg_145_1.duration_ = 5.37

		local var_145_0 = {
			ja = 5.366,
			ko = 4.6,
			zh = 5.166,
			en = 4
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play113122037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["6046_story"]) and arg_145_1.var_.characterEffect6046_story == nil then
				arg_145_1.var_.characterEffect6046_story = arg_145_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["6046_story"]) then
				if arg_145_1.var_.characterEffect6046_story and not isNil(arg_145_1.actors_["6046_story"]) then
					arg_145_1.var_.characterEffect6046_story.fillFlat = true
					arg_145_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_0)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["6046_story"]) and arg_145_1.var_.characterEffect6046_story then
				arg_145_1.var_.characterEffect6046_story.fillFlat = true
				arg_145_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_148_1 = 0
			local var_148_2 = 0.275

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6045")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_3 = arg_145_1:GetWordFromCfg(113122036)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_6 = 11 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_4) / 11)

				if (11 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_4) / 11)) > 0 and var_148_2 < var_148_6 then
					arg_145_1.talkMaxDuration = var_148_6

					if var_148_6 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_6 + var_148_1
					end
				end

				arg_145_1.text_.text = var_148_4
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122036", "story_v_out_113122.awb") ~= 0 then
					local var_148_7 = manager.audio:GetVoiceLength("story_v_out_113122", "113122036", "story_v_out_113122.awb") / 1000

					if var_148_7 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_1
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_113122", "113122036", "story_v_out_113122.awb")

						arg_145_1:RecordAudio("113122036", var_148_8)
						arg_145_1:RecordAudio("113122036", var_148_8)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_113122", "113122036", "story_v_out_113122.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_113122", "113122036", "story_v_out_113122.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_9 = math.max(var_148_2, arg_145_1.talkMaxDuration)

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_9 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_1) / var_148_9

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_1 + var_148_9 and arg_145_1.time_ < var_148_1 + var_148_9 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play113122037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 113122037
		arg_149_1.duration_ = 4.73

		local var_149_0 = {
			ja = 3.6,
			ko = 3.5,
			zh = 4.733,
			en = 3.5
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play113122038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action5_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_152_0 = arg_149_1.actors_["6046_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect6046_story == nil then
				arg_149_1.var_.characterEffect6046_story = var_152_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_1 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_1 and not isNil(var_152_0) then
				if arg_149_1.var_.characterEffect6046_story and not isNil(var_152_0) then
					arg_149_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_1 and arg_149_1.time_ < 0 + var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect6046_story then
				arg_149_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_152_3 = 0
			local var_152_4 = 0.3

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_3 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_5 = arg_149_1:GetWordFromCfg(113122037)
				local var_152_6 = arg_149_1:FormatText(var_152_5.content)

				arg_149_1.text_.text = var_152_6

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_8 = 12 <= 0 and var_152_4 or var_152_4 * (utf8.len(var_152_6) / 12)

				if (12 <= 0 and var_152_4 or var_152_4 * (utf8.len(var_152_6) / 12)) > 0 and var_152_4 < var_152_8 then
					arg_149_1.talkMaxDuration = var_152_8

					if var_152_8 + var_152_3 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_3
					end
				end

				arg_149_1.text_.text = var_152_6
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122037", "story_v_out_113122.awb") ~= 0 then
					local var_152_9 = manager.audio:GetVoiceLength("story_v_out_113122", "113122037", "story_v_out_113122.awb") / 1000

					if var_152_9 + var_152_3 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_3
					end

					if var_152_5.prefab_name ~= "" and arg_149_1.actors_[var_152_5.prefab_name] ~= nil then
						local var_152_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_5.prefab_name].transform, "story_v_out_113122", "113122037", "story_v_out_113122.awb")

						arg_149_1:RecordAudio("113122037", var_152_10)
						arg_149_1:RecordAudio("113122037", var_152_10)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_113122", "113122037", "story_v_out_113122.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_113122", "113122037", "story_v_out_113122.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_11 = math.max(var_152_4, arg_149_1.talkMaxDuration)

			if var_152_3 <= arg_149_1.time_ and arg_149_1.time_ < var_152_3 + var_152_11 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_3) / var_152_11

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_3 + var_152_11 and arg_149_1.time_ < var_152_3 + var_152_11 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play113122038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 113122038
		arg_153_1.duration_ = 5.87

		local var_153_0 = {
			ja = 5.866,
			ko = 3.9,
			zh = 4.333,
			en = 4.833
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play113122039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos6046_story = arg_153_1.actors_["6046_story"].transform.localPosition

				local var_156_0 = GameObjectTools.GetOrAddComponent(arg_153_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_156_0 then
					var_156_0:EnableDynamicBone(false)
				end
			end

			local var_156_1 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_1 then
				arg_153_1.actors_["6046_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_153_1.time_ - 0) / var_156_1)
				arg_153_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["6046_story"].transform.position).z)
				arg_153_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["6046_story"].transform.localEulerAngles = arg_153_1.actors_["6046_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_1 and arg_153_1.time_ < 0 + var_156_1 + arg_156_0 then
				arg_153_1.actors_["6046_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_153_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["6046_story"].transform.position).z)
				arg_153_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["6046_story"].transform.localEulerAngles = arg_153_1.actors_["6046_story"].transform.localEulerAngles

				local var_156_2 = GameObjectTools.GetOrAddComponent(arg_153_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_156_2 then
					var_156_2:EnableDynamicBone(true)
				end
			end

			local var_156_3 = arg_153_1.actors_["10006ui_story"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10006ui_story = var_156_3.localPosition
			end

			local var_156_4 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 then
				var_156_3.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10006ui_story, Vector3.New(0, 100, 0), (arg_153_1.time_ - 0) / var_156_4)
				var_156_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_3.position).x, (manager.ui.mainCamera.transform.position - var_156_3.position).y, (manager.ui.mainCamera.transform.position - var_156_3.position).z)
				var_156_3.localEulerAngles.z = 0
				var_156_3.localEulerAngles.x = 0
				var_156_3.localEulerAngles = var_156_3.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 then
				var_156_3.localPosition = Vector3.New(0, 100, 0)
				var_156_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_3.position).x, (manager.ui.mainCamera.transform.position - var_156_3.position).y, (manager.ui.mainCamera.transform.position - var_156_3.position).z)
				var_156_3.localEulerAngles.z = 0
				var_156_3.localEulerAngles.x = 0
				var_156_3.localEulerAngles = var_156_3.localEulerAngles
			end

			local var_156_5 = arg_153_1.actors_["1097ui_story"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1097ui_story = var_156_5.localPosition
			end

			local var_156_6 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_6 then
				var_156_5.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_153_1.time_ - 0) / var_156_6)
				var_156_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_5.position).x, (manager.ui.mainCamera.transform.position - var_156_5.position).y, (manager.ui.mainCamera.transform.position - var_156_5.position).z)
				var_156_5.localEulerAngles.z = 0
				var_156_5.localEulerAngles.x = 0
				var_156_5.localEulerAngles = var_156_5.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_6 and arg_153_1.time_ < 0 + var_156_6 + arg_156_0 then
				var_156_5.localPosition = Vector3.New(0, -0.54, -6.3)
				var_156_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_5.position).x, (manager.ui.mainCamera.transform.position - var_156_5.position).y, (manager.ui.mainCamera.transform.position - var_156_5.position).z)
				var_156_5.localEulerAngles.z = 0
				var_156_5.localEulerAngles.x = 0
				var_156_5.localEulerAngles = var_156_5.localEulerAngles
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_156_7 = arg_153_1.actors_["1097ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_7) and arg_153_1.var_.characterEffect1097ui_story == nil then
				arg_153_1.var_.characterEffect1097ui_story = var_156_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_8 = 0.2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_8 and not isNil(var_156_7) then
				if arg_153_1.var_.characterEffect1097ui_story and not isNil(var_156_7) then
					arg_153_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_8 and arg_153_1.time_ < 0 + var_156_8 + arg_156_0 and not isNil(var_156_7) and arg_153_1.var_.characterEffect1097ui_story then
				arg_153_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_156_10 = 0
			local var_156_11 = 0.4

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_12 = arg_153_1:GetWordFromCfg(113122038)
				local var_156_13 = arg_153_1:FormatText(var_156_12.content)

				arg_153_1.text_.text = var_156_13

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_15 = 16 <= 0 and var_156_11 or var_156_11 * (utf8.len(var_156_13) / 16)

				if (16 <= 0 and var_156_11 or var_156_11 * (utf8.len(var_156_13) / 16)) > 0 and var_156_11 < var_156_15 then
					arg_153_1.talkMaxDuration = var_156_15

					if var_156_15 + var_156_10 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_15 + var_156_10
					end
				end

				arg_153_1.text_.text = var_156_13
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122038", "story_v_out_113122.awb") ~= 0 then
					local var_156_16 = manager.audio:GetVoiceLength("story_v_out_113122", "113122038", "story_v_out_113122.awb") / 1000

					if var_156_16 + var_156_10 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_16 + var_156_10
					end

					if var_156_12.prefab_name ~= "" and arg_153_1.actors_[var_156_12.prefab_name] ~= nil then
						local var_156_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_12.prefab_name].transform, "story_v_out_113122", "113122038", "story_v_out_113122.awb")

						arg_153_1:RecordAudio("113122038", var_156_17)
						arg_153_1:RecordAudio("113122038", var_156_17)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_113122", "113122038", "story_v_out_113122.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_113122", "113122038", "story_v_out_113122.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_18 = math.max(var_156_11, arg_153_1.talkMaxDuration)

			if var_156_10 <= arg_153_1.time_ and arg_153_1.time_ < var_156_10 + var_156_18 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_10) / var_156_18

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_10 + var_156_18 and arg_153_1.time_ < var_156_10 + var_156_18 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play113122039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 113122039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play113122040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1097ui_story = arg_157_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1097ui_story"].transform.position).z)
				arg_157_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1097ui_story"].transform.localEulerAngles = arg_157_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_157_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1097ui_story"].transform.position).z)
				arg_157_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1097ui_story"].transform.localEulerAngles = arg_157_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_160_1 = 0
			local var_160_2 = 1.05

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_3 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(113122039).content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 42 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 42)

				if (42 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 42)) > 0 and var_160_2 < var_160_5 then
					arg_157_1.talkMaxDuration = var_160_5

					if var_160_5 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + var_160_1
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_6 = math.max(var_160_2, arg_157_1.talkMaxDuration)

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_6 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_1) / var_160_6

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_1 + var_160_6 and arg_157_1.time_ < var_160_1 + var_160_6 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play113122040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 113122040
		arg_161_1.duration_ = 14.4

		local var_161_0 = {
			ja = 14.4,
			ko = 13,
			zh = 12.4,
			en = 11.6
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play113122041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 4.5 < arg_161_1.time_ and arg_161_1.time_ <= 4.5 + arg_164_0 then
				arg_161_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_164_0 = arg_161_1.actors_["1097ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1097ui_story == nil then
				arg_161_1.var_.characterEffect1097ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_1 = 0.2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_1 and not isNil(var_164_0) then
				if arg_161_1.var_.characterEffect1097ui_story and not isNil(var_164_0) then
					arg_161_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_1 and arg_161_1.time_ < 0 + var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1097ui_story then
				arg_161_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_164_3 = 0

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_3 + arg_164_0 then
				arg_161_1.mask_.enabled = true
				arg_161_1.mask_.raycastTarget = true

				arg_161_1:SetGaussion(false)
			end

			local var_164_4 = 2

			if var_164_3 <= arg_161_1.time_ and arg_161_1.time_ < var_164_3 + var_164_4 then
				local var_164_5 = Color.New(0, 0, 0)

				var_164_5.a = Mathf.Lerp(0, 1, (arg_161_1.time_ - var_164_3) / var_164_4)
				arg_161_1.mask_.color = var_164_5
			end

			if arg_161_1.time_ >= var_164_3 + var_164_4 and arg_161_1.time_ < var_164_3 + var_164_4 + arg_164_0 then
				local var_164_6 = Color.New(0, 0, 0)

				var_164_6.a = 1
				arg_161_1.mask_.color = var_164_6
			end

			local var_164_7 = 2.5

			if 2.5 < arg_161_1.time_ and arg_161_1.time_ <= var_164_7 + arg_164_0 then
				arg_161_1.mask_.enabled = true
				arg_161_1.mask_.raycastTarget = true

				arg_161_1:SetGaussion(false)
			end

			local var_164_8 = 2

			if var_164_7 <= arg_161_1.time_ and arg_161_1.time_ < var_164_7 + var_164_8 then
				local var_164_9 = Color.New(0, 0, 0)

				var_164_9.a = Mathf.Lerp(1, 0, (arg_161_1.time_ - var_164_7) / var_164_8)
				arg_161_1.mask_.color = var_164_9
			end

			if arg_161_1.time_ >= var_164_7 + var_164_8 and arg_161_1.time_ < var_164_7 + var_164_8 + arg_164_0 then
				local var_164_10 = Color.New(0, 0, 0)

				arg_161_1.mask_.enabled = false
				var_164_10.a = 0
				arg_161_1.mask_.color = var_164_10
			end

			local var_164_11 = 2

			if 2 < arg_161_1.time_ and arg_161_1.time_ <= var_164_11 + arg_164_0 then
				arg_161_1.allBtn_.enabled = false
			end

			if arg_161_1.time_ >= var_164_11 + 0.5 and arg_161_1.time_ < var_164_11 + 0.5 + arg_164_0 then
				arg_161_1.allBtn_.enabled = true
			end

			local var_164_12 = 4.5

			if 4.5 < arg_161_1.time_ and arg_161_1.time_ <= var_164_12 + arg_164_0 then
				arg_161_1.allBtn_.enabled = false
			end

			if arg_161_1.time_ >= var_164_12 + 0.725 and arg_161_1.time_ < var_164_12 + 0.725 + arg_164_0 then
				arg_161_1.allBtn_.enabled = true
			end

			if arg_161_1.frameCnt_ <= 1 then
				arg_161_1.dialog_:SetActive(false)
			end

			local var_164_13 = 4.5
			local var_164_14 = 0.725

			if 4.5 < arg_161_1.time_ and arg_161_1.time_ <= var_164_13 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0

				arg_161_1.dialog_:SetActive(true)

				arg_161_1.dialogCg_.alpha = 0

				local var_164_15 = LeanTween.value(arg_161_1.dialog_, 0, 1, 0.3)

				var_164_15:setOnUpdate(LuaHelper.FloatAction(function(arg_165_0)
					arg_161_1.dialogCg_.alpha = arg_165_0
				end))
				var_164_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_161_1.dialog_)
					var_164_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_161_1.duration_ = arg_161_1.duration_ + 0.3

				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_16 = arg_161_1:GetWordFromCfg(113122040)
				local var_164_17 = arg_161_1:FormatText(var_164_16.content)

				arg_161_1.text_.text = var_164_17

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_19 = 29 <= 0 and var_164_14 or var_164_14 * (utf8.len(var_164_17) / 29)

				if (29 <= 0 and var_164_14 or var_164_14 * (utf8.len(var_164_17) / 29)) > 0 and var_164_14 < var_164_19 then
					arg_161_1.talkMaxDuration = var_164_19
					var_164_13 = var_164_13 + 0.3

					if var_164_19 + var_164_13 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_19 + var_164_13
					end
				end

				arg_161_1.text_.text = var_164_17
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122040", "story_v_out_113122.awb") ~= 0 then
					local var_164_20 = manager.audio:GetVoiceLength("story_v_out_113122", "113122040", "story_v_out_113122.awb") / 1000

					if var_164_20 + var_164_13 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_20 + var_164_13
					end

					if var_164_16.prefab_name ~= "" and arg_161_1.actors_[var_164_16.prefab_name] ~= nil then
						local var_164_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_16.prefab_name].transform, "story_v_out_113122", "113122040", "story_v_out_113122.awb")

						arg_161_1:RecordAudio("113122040", var_164_21)
						arg_161_1:RecordAudio("113122040", var_164_21)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_113122", "113122040", "story_v_out_113122.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_113122", "113122040", "story_v_out_113122.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_22 = var_164_13 + 0.3
			local var_164_23 = math.max(var_164_14, arg_161_1.talkMaxDuration)

			if var_164_13 + 0.3 <= arg_161_1.time_ and arg_161_1.time_ < var_164_22 + var_164_23 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_22) / var_164_23

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_22 + var_164_23 and arg_161_1.time_ < var_164_22 + var_164_23 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play113122041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 113122041
		arg_167_1.duration_ = 4.8

		local var_167_0 = {
			ja = 4.8,
			ko = 3.3,
			zh = 3,
			en = 3.866
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
				arg_167_0:Play113122042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1097ui_story"]) and arg_167_1.var_.characterEffect1097ui_story == nil then
				arg_167_1.var_.characterEffect1097ui_story = arg_167_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1097ui_story"]) then
				if arg_167_1.var_.characterEffect1097ui_story and not isNil(arg_167_1.actors_["1097ui_story"]) then
					arg_167_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_0)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1097ui_story"]) and arg_167_1.var_.characterEffect1097ui_story then
				arg_167_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_170_1 = 0
			local var_170_2 = 0.275

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_3 = arg_167_1:GetWordFromCfg(113122041)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_6 = 11 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_4) / 11)

				if (11 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_4) / 11)) > 0 and var_170_2 < var_170_6 then
					arg_167_1.talkMaxDuration = var_170_6

					if var_170_6 + var_170_1 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_6 + var_170_1
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122041", "story_v_out_113122.awb") ~= 0 then
					local var_170_7 = manager.audio:GetVoiceLength("story_v_out_113122", "113122041", "story_v_out_113122.awb") / 1000

					if var_170_7 + var_170_1 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_1
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_113122", "113122041", "story_v_out_113122.awb")

						arg_167_1:RecordAudio("113122041", var_170_8)
						arg_167_1:RecordAudio("113122041", var_170_8)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_113122", "113122041", "story_v_out_113122.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_113122", "113122041", "story_v_out_113122.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_9 = math.max(var_170_2, arg_167_1.talkMaxDuration)

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_9 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_1) / var_170_9

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_1 + var_170_9 and arg_167_1.time_ < var_170_1 + var_170_9 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play113122042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 113122042
		arg_171_1.duration_ = 11.9

		local var_171_0 = {
			ja = 10.666,
			ko = 8.8,
			zh = 7.433,
			en = 11.9
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
				arg_171_0:Play113122043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_174_0 = arg_171_1.actors_["1097ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1097ui_story == nil then
				arg_171_1.var_.characterEffect1097ui_story = var_174_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_1 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_1 and not isNil(var_174_0) then
				if arg_171_1.var_.characterEffect1097ui_story and not isNil(var_174_0) then
					arg_171_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_1 and arg_171_1.time_ < 0 + var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1097ui_story then
				arg_171_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_174_3 = arg_171_1.actors_["1097ui_story"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1097ui_story = var_174_3.localPosition
			end

			local var_174_4 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				var_174_3.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_171_1.time_ - 0) / var_174_4)
				var_174_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_3.position).x, (manager.ui.mainCamera.transform.position - var_174_3.position).y, (manager.ui.mainCamera.transform.position - var_174_3.position).z)
				var_174_3.localEulerAngles.z = 0
				var_174_3.localEulerAngles.x = 0
				var_174_3.localEulerAngles = var_174_3.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				var_174_3.localPosition = Vector3.New(0, -0.54, -6.3)
				var_174_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_3.position).x, (manager.ui.mainCamera.transform.position - var_174_3.position).y, (manager.ui.mainCamera.transform.position - var_174_3.position).z)
				var_174_3.localEulerAngles.z = 0
				var_174_3.localEulerAngles.x = 0
				var_174_3.localEulerAngles = var_174_3.localEulerAngles
			end

			local var_174_5 = 0
			local var_174_6 = 0.85

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_7 = arg_171_1:GetWordFromCfg(113122042)
				local var_174_8 = arg_171_1:FormatText(var_174_7.content)

				arg_171_1.text_.text = var_174_8

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_10 = 34 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_8) / 34)

				if (34 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_8) / 34)) > 0 and var_174_6 < var_174_10 then
					arg_171_1.talkMaxDuration = var_174_10

					if var_174_10 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_5
					end
				end

				arg_171_1.text_.text = var_174_8
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122042", "story_v_out_113122.awb") ~= 0 then
					local var_174_11 = manager.audio:GetVoiceLength("story_v_out_113122", "113122042", "story_v_out_113122.awb") / 1000

					if var_174_11 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_11 + var_174_5
					end

					if var_174_7.prefab_name ~= "" and arg_171_1.actors_[var_174_7.prefab_name] ~= nil then
						local var_174_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_7.prefab_name].transform, "story_v_out_113122", "113122042", "story_v_out_113122.awb")

						arg_171_1:RecordAudio("113122042", var_174_12)
						arg_171_1:RecordAudio("113122042", var_174_12)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_113122", "113122042", "story_v_out_113122.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_113122", "113122042", "story_v_out_113122.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_13 = math.max(var_174_6, arg_171_1.talkMaxDuration)

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_13 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_5) / var_174_13

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_5 + var_174_13 and arg_171_1.time_ < var_174_5 + var_174_13 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play113122043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 113122043
		arg_175_1.duration_ = 5.63

		local var_175_0 = {
			ja = 4.466,
			ko = 4.4,
			zh = 4.2,
			en = 5.633
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
				arg_175_0:Play113122044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["1097ui_story"]) and arg_175_1.var_.characterEffect1097ui_story == nil then
				arg_175_1.var_.characterEffect1097ui_story = arg_175_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["1097ui_story"]) then
				if arg_175_1.var_.characterEffect1097ui_story and not isNil(arg_175_1.actors_["1097ui_story"]) then
					arg_175_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_0)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["1097ui_story"]) and arg_175_1.var_.characterEffect1097ui_story then
				arg_175_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_178_1 = 0
			local var_178_2 = 0.3

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:GetWordFromCfg(113122043)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_6 = 12 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_4) / 12)

				if (12 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_4) / 12)) > 0 and var_178_2 < var_178_6 then
					arg_175_1.talkMaxDuration = var_178_6

					if var_178_6 + var_178_1 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_6 + var_178_1
					end
				end

				arg_175_1.text_.text = var_178_4
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122043", "story_v_out_113122.awb") ~= 0 then
					local var_178_7 = manager.audio:GetVoiceLength("story_v_out_113122", "113122043", "story_v_out_113122.awb") / 1000

					if var_178_7 + var_178_1 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_1
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_out_113122", "113122043", "story_v_out_113122.awb")

						arg_175_1:RecordAudio("113122043", var_178_8)
						arg_175_1:RecordAudio("113122043", var_178_8)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_113122", "113122043", "story_v_out_113122.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_113122", "113122043", "story_v_out_113122.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_9 = math.max(var_178_2, arg_175_1.talkMaxDuration)

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_9 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_1) / var_178_9

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_1 + var_178_9 and arg_175_1.time_ < var_178_1 + var_178_9 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play113122044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 113122044
		arg_179_1.duration_ = 6.2

		local var_179_0 = {
			ja = 6.2,
			ko = 5.333,
			zh = 3.566,
			en = 4.7
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
				arg_179_0:Play113122045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_9000

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_182_0 = arg_179_1.actors_["1097ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1097ui_story == nil then
				arg_179_1.var_.characterEffect1097ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_1 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_1 and not isNil(var_182_0) then
				if arg_179_1.var_.characterEffect1097ui_story and not isNil(var_182_0) then
					arg_179_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_1 and arg_179_1.time_ < 0 + var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1097ui_story then
				arg_179_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action5_1")
			end

			local var_182_3 = arg_179_1.actors_["1097ui_story"].transform

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1097ui_story = var_182_3.localPosition

				arg_179_1:ShowWeapon(arg_179_1.var_["1097ui_story" .. "Animator"].transform, true)
			end

			local var_182_4 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				var_182_3.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_179_1.time_ - 0) / var_182_4)
				var_182_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_182_3.position).x, (manager.ui.mainCamera.transform.position - var_182_3.position).y, (manager.ui.mainCamera.transform.position - var_182_3.position).z)
				var_182_3.localEulerAngles.z = 0
				var_182_3.localEulerAngles.x = 0
				var_182_3.localEulerAngles = var_182_3.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				var_182_3.localPosition = Vector3.New(0, -0.54, -6.3)
				var_182_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_182_3.position).x, (manager.ui.mainCamera.transform.position - var_182_3.position).y, (manager.ui.mainCamera.transform.position - var_182_3.position).z)
				var_182_3.localEulerAngles.z = 0
				var_182_3.localEulerAngles.x = 0
				var_182_3.localEulerAngles = var_182_3.localEulerAngles
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				local var_182_5 = arg_179_1.var_.effect1097ui_storyyanwu2

				if not arg_179_1.var_.effect1097ui_storyyanwu2 then
					var_182_5 = Object.Instantiate(Asset.Load("Effect/Hero/1097/fx_1097_story_smoke"), arg_179_1.actors_["1097ui_story"].transform)
					var_182_5.name = "yanwu2"
					arg_179_1.var_.effect1097ui_storyyanwu2 = var_182_5
				else
					var_182_5.transform:SetParent(var_182_9000)
				end

				var_182_5.transform.localPosition = Vector3.New(0, 1.28, 0.3)
				var_182_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_179_1.time_ and arg_179_1.time_ <= 2 + arg_182_0 then
				if arg_179_1.var_.effect1097ui_storyyanwu2 then
					Object.Destroy(arg_179_1.var_.effect1097ui_storyyanwu2)

					arg_179_1.var_.effect1097ui_storyyanwu2 = nil
				end
			end

			local var_182_8 = 0
			local var_182_9 = 0.35

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_8 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_10 = arg_179_1:GetWordFromCfg(113122044)
				local var_182_11 = arg_179_1:FormatText(var_182_10.content)

				arg_179_1.text_.text = var_182_11

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_13 = 14 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 14)

				if (14 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 14)) > 0 and var_182_9 < var_182_13 then
					arg_179_1.talkMaxDuration = var_182_13

					if var_182_13 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_13 + var_182_8
					end
				end

				arg_179_1.text_.text = var_182_11
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122044", "story_v_out_113122.awb") ~= 0 then
					local var_182_14 = manager.audio:GetVoiceLength("story_v_out_113122", "113122044", "story_v_out_113122.awb") / 1000

					if var_182_14 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_14 + var_182_8
					end

					if var_182_10.prefab_name ~= "" and arg_179_1.actors_[var_182_10.prefab_name] ~= nil then
						local var_182_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_10.prefab_name].transform, "story_v_out_113122", "113122044", "story_v_out_113122.awb")

						arg_179_1:RecordAudio("113122044", var_182_15)
						arg_179_1:RecordAudio("113122044", var_182_15)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_113122", "113122044", "story_v_out_113122.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_113122", "113122044", "story_v_out_113122.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_16 = math.max(var_182_9, arg_179_1.talkMaxDuration)

			if var_182_8 <= arg_179_1.time_ and arg_179_1.time_ < var_182_8 + var_182_16 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_8) / var_182_16

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_8 + var_182_16 and arg_179_1.time_ < var_182_8 + var_182_16 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play113122045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 113122045
		arg_183_1.duration_ = 20.42

		local var_183_0 = {
			ja = 19.8826666666667,
			ko = 20.4166666666667,
			zh = 18.6496666666667,
			en = 17.0826666666667
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
			arg_183_1.auto_ = false
		end

		function arg_183_1.playNext_(arg_185_0)
			arg_183_1.onStoryFinished_()
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_0 = 2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				local var_186_1 = Color.New(0, 0, 0)

				var_186_1.a = Mathf.Lerp(0, 1, (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.mask_.color = var_186_1
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				local var_186_2 = Color.New(0, 0, 0)

				var_186_2.a = 1
				arg_183_1.mask_.color = var_186_2
			end

			local var_186_3 = 2.5

			if 2.5 < arg_183_1.time_ and arg_183_1.time_ <= var_186_3 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_4 = 2

			if var_186_3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_3 + var_186_4 then
				local var_186_5 = Color.New(0, 0, 0)

				var_186_5.a = Mathf.Lerp(1, 0, (arg_183_1.time_ - var_186_3) / var_186_4)
				arg_183_1.mask_.color = var_186_5
			end

			if arg_183_1.time_ >= var_186_3 + var_186_4 and arg_183_1.time_ < var_186_3 + var_186_4 + arg_186_0 then
				local var_186_6 = Color.New(0, 0, 0)

				arg_183_1.mask_.enabled = false
				var_186_6.a = 0
				arg_183_1.mask_.color = var_186_6
			end

			local var_186_7 = 5

			if 5 < arg_183_1.time_ and arg_183_1.time_ <= var_186_7 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_8 = 2.5

			if var_186_7 <= arg_183_1.time_ and arg_183_1.time_ < var_186_7 + var_186_8 then
				local var_186_9 = Color.New(0, 0, 0)

				var_186_9.a = Mathf.Lerp(0, 1, (arg_183_1.time_ - var_186_7) / var_186_8)
				arg_183_1.mask_.color = var_186_9
			end

			if arg_183_1.time_ >= var_186_7 + var_186_8 and arg_183_1.time_ < var_186_7 + var_186_8 + arg_186_0 then
				local var_186_10 = Color.New(0, 0, 0)

				var_186_10.a = 1
				arg_183_1.mask_.color = var_186_10
			end

			local var_186_11 = 7.5

			if 7.5 < arg_183_1.time_ and arg_183_1.time_ <= var_186_11 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_12 = 0.0166666666666667

			if var_186_11 <= arg_183_1.time_ and arg_183_1.time_ < var_186_11 + var_186_12 then
				local var_186_13 = Color.New(0, 0, 0)

				var_186_13.a = Mathf.Lerp(1, 0, (arg_183_1.time_ - var_186_11) / var_186_12)
				arg_183_1.mask_.color = var_186_13
			end

			if arg_183_1.time_ >= var_186_11 + var_186_12 and arg_183_1.time_ < var_186_11 + var_186_12 + arg_186_0 then
				local var_186_14 = Color.New(0, 0, 0)

				arg_183_1.mask_.enabled = false
				var_186_14.a = 0
				arg_183_1.mask_.color = var_186_14
			end

			local var_186_15 = 2

			if 2 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 then
				arg_183_1.allBtn_.enabled = false
			end

			if arg_183_1.time_ >= var_186_15 + 0.5 and arg_183_1.time_ < var_186_15 + 0.5 + arg_186_0 then
				arg_183_1.allBtn_.enabled = true
			end

			local var_186_16 = 4.5

			if 4.5 < arg_183_1.time_ and arg_183_1.time_ <= var_186_16 + arg_186_0 then
				arg_183_1.allBtn_.enabled = false
			end

			if arg_183_1.time_ >= var_186_16 + 0.5 and arg_183_1.time_ < var_186_16 + 0.5 + arg_186_0 then
				arg_183_1.allBtn_.enabled = true
			end

			local var_186_17 = "STblack"

			if arg_183_1.bgs_.STblack == nil then
				local var_186_18 = Object.Instantiate(arg_183_1.paintGo_)

				var_186_18:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_186_17)
				var_186_18.name = var_186_17
				var_186_18.transform.parent = arg_183_1.stage_.transform
				var_186_18.transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.bgs_[var_186_17] = var_186_18
			end

			if 7.5 < arg_183_1.time_ and arg_183_1.time_ <= 7.5 + arg_186_0 then
				local var_186_19 = arg_183_1.bgs_.STblack

				arg_183_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_186_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_186_20 = var_186_19:GetComponent("SpriteRenderer")

				if var_186_20 and var_186_20.sprite then
					local var_186_21 = 2 * (var_186_19.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_186_19.transform.localScale = Vector3.New(var_186_21 / var_186_20.sprite.bounds.size.y < var_186_21 * manager.ui.mainCameraCom_.aspect / var_186_20.sprite.bounds.size.x and var_186_21 * manager.ui.mainCameraCom_.aspect / var_186_20.sprite.bounds.size.x or var_186_21 / var_186_20.sprite.bounds.size.y, var_186_21 / var_186_20.sprite.bounds.size.y < var_186_21 * manager.ui.mainCameraCom_.aspect / var_186_20.sprite.bounds.size.x and var_186_21 * manager.ui.mainCameraCom_.aspect / var_186_20.sprite.bounds.size.x or var_186_21 / var_186_20.sprite.bounds.size.y, 0)
				end

				for iter_186_0, iter_186_1 in pairs(arg_183_1.bgs_) do
					if iter_186_0 ~= "STblack" then
						iter_186_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_186_22 = arg_183_1.actors_["1097ui_story"].transform

			if 1.966 < arg_183_1.time_ and arg_183_1.time_ <= 1.966 + arg_186_0 then
				arg_183_1.var_.moveOldPos1097ui_story = var_186_22.localPosition
			end

			local var_186_23 = 0.001

			if 1.966 <= arg_183_1.time_ and arg_183_1.time_ < 1.966 + var_186_23 then
				var_186_22.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_183_1.time_ - 1.966) / var_186_23)
				var_186_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_22.position).x, (manager.ui.mainCamera.transform.position - var_186_22.position).y, (manager.ui.mainCamera.transform.position - var_186_22.position).z)
				var_186_22.localEulerAngles.z = 0
				var_186_22.localEulerAngles.x = 0
				var_186_22.localEulerAngles = var_186_22.localEulerAngles
			end

			if arg_183_1.time_ >= 1.966 + var_186_23 and arg_183_1.time_ < 1.966 + var_186_23 + arg_186_0 then
				var_186_22.localPosition = Vector3.New(0, 100, 0)
				var_186_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_22.position).x, (manager.ui.mainCamera.transform.position - var_186_22.position).y, (manager.ui.mainCamera.transform.position - var_186_22.position).z)
				var_186_22.localEulerAngles.z = 0
				var_186_22.localEulerAngles.x = 0
				var_186_22.localEulerAngles = var_186_22.localEulerAngles
			end

			if arg_183_1.frameCnt_ <= 1 then
				arg_183_1.dialog_:SetActive(false)
			end

			local var_186_24 = 7.51666666666667
			local var_186_25 = 1

			if 7.51666666666667 < arg_183_1.time_ and arg_183_1.time_ <= var_186_24 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				arg_183_1.dialog_:SetActive(true)

				arg_183_1.dialogCg_.alpha = 0

				local var_186_26 = LeanTween.value(arg_183_1.dialog_, 0, 1, 0.3)

				var_186_26:setOnUpdate(LuaHelper.FloatAction(function(arg_187_0)
					arg_183_1.dialogCg_.alpha = arg_187_0
				end))
				var_186_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_183_1.dialog_)
					var_186_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_183_1.duration_ = arg_183_1.duration_ + 0.3

				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_27 = arg_183_1:GetWordFromCfg(113122045)
				local var_186_28 = arg_183_1:FormatText(var_186_27.content)

				arg_183_1.text_.text = var_186_28

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_30 = 40 <= 0 and var_186_25 or var_186_25 * (utf8.len(var_186_28) / 40)

				if (40 <= 0 and var_186_25 or var_186_25 * (utf8.len(var_186_28) / 40)) > 0 and var_186_25 < var_186_30 then
					arg_183_1.talkMaxDuration = var_186_30
					var_186_24 = var_186_24 + 0.3

					if var_186_30 + var_186_24 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_30 + var_186_24
					end
				end

				arg_183_1.text_.text = var_186_28
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113122", "113122045", "story_v_out_113122.awb") ~= 0 then
					local var_186_31 = manager.audio:GetVoiceLength("story_v_out_113122", "113122045", "story_v_out_113122.awb") / 1000

					if var_186_31 + var_186_24 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_31 + var_186_24
					end

					if var_186_27.prefab_name ~= "" and arg_183_1.actors_[var_186_27.prefab_name] ~= nil then
						local var_186_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_27.prefab_name].transform, "story_v_out_113122", "113122045", "story_v_out_113122.awb")

						arg_183_1:RecordAudio("113122045", var_186_32)
						arg_183_1:RecordAudio("113122045", var_186_32)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_113122", "113122045", "story_v_out_113122.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_113122", "113122045", "story_v_out_113122.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_33 = var_186_24 + 0.3
			local var_186_34 = math.max(var_186_25, arg_183_1.talkMaxDuration)

			if var_186_24 + 0.3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_33 + var_186_34 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_33) / var_186_34

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_33 + var_186_34 and arg_183_1.time_ < var_186_33 + var_186_34 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F02_1",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_113122.awb"
	}
}
