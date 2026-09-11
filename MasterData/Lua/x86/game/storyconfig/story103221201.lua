return {
	Play322121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322121001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play322121002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L14f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L14f")
				var_4_0.name = "L14f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L14f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L14f

				arg_1_1.bgs_.L14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L14f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
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

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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

			if 0.500666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.500666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious.awb")

				local var_4_15 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_15 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_15

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_15
						arg_1_1.bgmTxt2_.text = var_4_15
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

			if 0.51 < arg_1_1.time_ and arg_1_1.time_ <= 0.51 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_5_story_serious", "init_battle", "bgm_activity_4_5_story_serious.awb")

				local var_4_18 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "init_battle")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_18 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_18

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_18
						arg_1_1.bgmTxt2_.text = var_4_18
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

			local var_4_19 = 2
			local var_4_20 = 0.8

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_21 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_21:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_22 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(322121001).content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 32 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 32)

				if (32 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 32)) > 0 and var_4_20 < var_4_24 then
					arg_1_1.talkMaxDuration = var_4_24
					var_4_19 = var_4_19 + 0.3

					if var_4_24 + var_4_19 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_24 + var_4_19
					end
				end

				arg_1_1.text_.text = var_4_22
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_25 = var_4_19 + 0.3
			local var_4_26 = math.max(var_4_20, arg_1_1.talkMaxDuration)

			if var_4_19 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_25) / var_4_26

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play322121002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 322121002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play322121003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 1.05

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_1 = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(322121002).content)

				arg_10_1.text_.text = var_13_1

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_3 = 42 <= 0 and var_13_0 or var_13_0 * (utf8.len(var_13_1) / 42)

				if (42 <= 0 and var_13_0 or var_13_0 * (utf8.len(var_13_1) / 42)) > 0 and var_13_0 < var_13_3 then
					arg_10_1.talkMaxDuration = var_13_3

					if var_13_3 + 0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_3 + 0
					end
				end

				arg_10_1.text_.text = var_13_1
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_4 = math.max(var_13_0, arg_10_1.talkMaxDuration)

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_4 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - 0) / var_13_4

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= 0 + var_13_4 and arg_10_1.time_ < 0 + var_13_4 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play322121003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 322121003
		arg_14_1.duration_ = 6.2

		local var_14_0 = {
			zh = 4.066,
			ja = 6.2
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play322121004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if arg_14_1.actors_["6056ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6056ui_story"))) then
				local var_17_0 = Object.Instantiate(Asset.Load("Char/" .. "6056ui_story"), arg_14_1.stage_.transform)

				var_17_0.name = "6056ui_story"
				var_17_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_14_1.actors_["6056ui_story"] = var_17_0

				local var_17_1 = var_17_0:GetComponentInChildren(typeof(CharacterEffect))

				var_17_1.enabled = true

				local var_17_2 = GameObjectTools.GetOrAddComponent(var_17_0, typeof(DynamicBoneHelper))

				if var_17_2 then
					var_17_2:EnableDynamicBone(false)
				end

				arg_14_1:ShowWeapon(var_17_1.transform, false)

				arg_14_1.var_["6056ui_story" .. "Animator"] = var_17_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_14_1.var_["6056ui_story" .. "Animator"].applyRootMotion = true
				arg_14_1.var_["6056ui_story" .. "LipSync"] = var_17_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				if arg_14_1.var_.characterEffect6056ui_story == nil then
					arg_14_1.var_.characterEffect6056ui_story = arg_14_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_17_3 = arg_14_1.var_.characterEffect6056ui_story

				arg_14_1.var_.characterEffect6056ui_story.imageEffect:turnOff()

				var_17_3.interferenceEffect.enabled = true
				var_17_3.interferenceEffect.noise = 0
				var_17_3.interferenceEffect.simTimeScale = 1
				var_17_3.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				if arg_14_1.var_.characterEffect6056ui_story == nil then
					arg_14_1.var_.characterEffect6056ui_story = arg_14_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_14_1.var_.characterEffect6056ui_story.imageEffect:turnOn(false)
			end

			local var_17_5 = arg_14_1.actors_["6056ui_story"].transform

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.var_.moveOldPos6056ui_story = var_17_5.localPosition
			end

			local var_17_6 = 0.001

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_6 then
				var_17_5.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos6056ui_story, Vector3.New(0.15, -1.16, -6.15), (arg_14_1.time_ - 0) / var_17_6)
				var_17_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_17_5.position).x, (manager.ui.mainCamera.transform.position - var_17_5.position).y, (manager.ui.mainCamera.transform.position - var_17_5.position).z)
				var_17_5.localEulerAngles.z = 0
				var_17_5.localEulerAngles.x = 0
				var_17_5.localEulerAngles = var_17_5.localEulerAngles
			end

			if arg_14_1.time_ >= 0 + var_17_6 and arg_14_1.time_ < 0 + var_17_6 + arg_17_0 then
				var_17_5.localPosition = Vector3.New(0.15, -1.16, -6.15)
				var_17_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_17_5.position).x, (manager.ui.mainCamera.transform.position - var_17_5.position).y, (manager.ui.mainCamera.transform.position - var_17_5.position).z)
				var_17_5.localEulerAngles.z = 0
				var_17_5.localEulerAngles.x = 0
				var_17_5.localEulerAngles = var_17_5.localEulerAngles
			end

			local var_17_7 = arg_14_1.actors_["6056ui_story"]

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 and not isNil(var_17_7) and arg_14_1.var_.characterEffect6056ui_story == nil then
				arg_14_1.var_.characterEffect6056ui_story = var_17_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_17_8 = 0.200000002980232

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_8 and not isNil(var_17_7) then
				if arg_14_1.var_.characterEffect6056ui_story and not isNil(var_17_7) then
					arg_14_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_14_1.time_ >= 0 + var_17_8 and arg_14_1.time_ < 0 + var_17_8 + arg_17_0 and not isNil(var_17_7) and arg_14_1.var_.characterEffect6056ui_story then
				arg_14_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action1_1")
			end

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_17_10 = 0
			local var_17_11 = 0.45

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_10 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_12 = arg_14_1:GetWordFromCfg(322121003)
				local var_17_13 = arg_14_1:FormatText(var_17_12.content)

				arg_14_1.text_.text = var_17_13

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_15 = 18 <= 0 and var_17_11 or var_17_11 * (utf8.len(var_17_13) / 18)

				if (18 <= 0 and var_17_11 or var_17_11 * (utf8.len(var_17_13) / 18)) > 0 and var_17_11 < var_17_15 then
					arg_14_1.talkMaxDuration = var_17_15

					if var_17_15 + var_17_10 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_15 + var_17_10
					end
				end

				arg_14_1.text_.text = var_17_13
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121003", "story_v_out_322121.awb") ~= 0 then
					local var_17_16 = manager.audio:GetVoiceLength("story_v_out_322121", "322121003", "story_v_out_322121.awb") / 1000

					if var_17_16 + var_17_10 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_16 + var_17_10
					end

					if var_17_12.prefab_name ~= "" and arg_14_1.actors_[var_17_12.prefab_name] ~= nil then
						local var_17_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_12.prefab_name].transform, "story_v_out_322121", "322121003", "story_v_out_322121.awb")

						arg_14_1:RecordAudio("322121003", var_17_17)
						arg_14_1:RecordAudio("322121003", var_17_17)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_322121", "322121003", "story_v_out_322121.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_322121", "322121003", "story_v_out_322121.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_18 = math.max(var_17_11, arg_14_1.talkMaxDuration)

			if var_17_10 <= arg_14_1.time_ and arg_14_1.time_ < var_17_10 + var_17_18 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_10) / var_17_18

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_10 + var_17_18 and arg_14_1.time_ < var_17_10 + var_17_18 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play322121004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 322121004
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play322121005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 and not isNil(arg_18_1.actors_["6056ui_story"]) and arg_18_1.var_.characterEffect6056ui_story == nil then
				arg_18_1.var_.characterEffect6056ui_story = arg_18_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_0 = 0.200000002980232

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_0 and not isNil(arg_18_1.actors_["6056ui_story"]) then
				if arg_18_1.var_.characterEffect6056ui_story and not isNil(arg_18_1.actors_["6056ui_story"]) then
					arg_18_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_18_1.var_.characterEffect6056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_18_1.time_ - 0) / var_21_0)
				end
			end

			if arg_18_1.time_ >= 0 + var_21_0 and arg_18_1.time_ < 0 + var_21_0 + arg_21_0 and not isNil(arg_18_1.actors_["6056ui_story"]) and arg_18_1.var_.characterEffect6056ui_story then
				arg_18_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_18_1.var_.characterEffect6056ui_story.fillRatio = 0.5
			end

			local var_21_1 = 0
			local var_21_2 = 0.35

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, true)
				arg_18_1.iconController_:SetSelectedState("hero")

				arg_18_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_18_1.callingController_:SetSelectedState("normal")

				arg_18_1.keyicon_.color = Color.New(1, 1, 1)
				arg_18_1.icon_.color = Color.New(1, 1, 1)

				local var_21_3 = arg_18_1:FormatText(arg_18_1:GetWordFromCfg(322121004).content)

				arg_18_1.text_.text = var_21_3

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_5 = 14 <= 0 and var_21_2 or var_21_2 * (utf8.len(var_21_3) / 14)

				if (14 <= 0 and var_21_2 or var_21_2 * (utf8.len(var_21_3) / 14)) > 0 and var_21_2 < var_21_5 then
					arg_18_1.talkMaxDuration = var_21_5

					if var_21_5 + var_21_1 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_5 + var_21_1
					end
				end

				arg_18_1.text_.text = var_21_3
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_6 = math.max(var_21_2, arg_18_1.talkMaxDuration)

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_6 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_1) / var_21_6

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_1 + var_21_6 and arg_18_1.time_ < var_21_1 + var_21_6 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play322121005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 322121005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play322121006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0.275

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_1 = arg_22_1:FormatText(arg_22_1:GetWordFromCfg(322121005).content)

				arg_22_1.text_.text = var_25_1

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_3 = 11 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_1) / 11)

				if (11 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_1) / 11)) > 0 and var_25_0 < var_25_3 then
					arg_22_1.talkMaxDuration = var_25_3

					if var_25_3 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_3 + 0
					end
				end

				arg_22_1.text_.text = var_25_1
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_4 = math.max(var_25_0, arg_22_1.talkMaxDuration)

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_4 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - 0) / var_25_4

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= 0 + var_25_4 and arg_22_1.time_ < 0 + var_25_4 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play322121006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 322121006
		arg_26_1.duration_ = 4.47

		local var_26_0 = {
			zh = 3.499999999999,
			ja = 4.466
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play322121007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.var_.moveOldPos6056ui_story = arg_26_1.actors_["6056ui_story"].transform.localPosition
			end

			local var_29_0 = 0.001

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_0 then
				arg_26_1.actors_["6056ui_story"].transform.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos6056ui_story, Vector3.New(0.15, -1.16, -6.15), (arg_26_1.time_ - 0) / var_29_0)
				arg_26_1.actors_["6056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_26_1.actors_["6056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_26_1.actors_["6056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_26_1.actors_["6056ui_story"].transform.position).z)
				arg_26_1.actors_["6056ui_story"].transform.localEulerAngles.z = 0
				arg_26_1.actors_["6056ui_story"].transform.localEulerAngles.x = 0
				arg_26_1.actors_["6056ui_story"].transform.localEulerAngles = arg_26_1.actors_["6056ui_story"].transform.localEulerAngles
			end

			if arg_26_1.time_ >= 0 + var_29_0 and arg_26_1.time_ < 0 + var_29_0 + arg_29_0 then
				arg_26_1.actors_["6056ui_story"].transform.localPosition = Vector3.New(0.15, -1.16, -6.15)
				arg_26_1.actors_["6056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_26_1.actors_["6056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_26_1.actors_["6056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_26_1.actors_["6056ui_story"].transform.position).z)
				arg_26_1.actors_["6056ui_story"].transform.localEulerAngles.z = 0
				arg_26_1.actors_["6056ui_story"].transform.localEulerAngles.x = 0
				arg_26_1.actors_["6056ui_story"].transform.localEulerAngles = arg_26_1.actors_["6056ui_story"].transform.localEulerAngles
			end

			local var_29_1 = arg_26_1.actors_["6056ui_story"]

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(var_29_1) and arg_26_1.var_.characterEffect6056ui_story == nil then
				arg_26_1.var_.characterEffect6056ui_story = var_29_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_2 = 0.200000002980232

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_2 and not isNil(var_29_1) then
				if arg_26_1.var_.characterEffect6056ui_story and not isNil(var_29_1) then
					arg_26_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= 0 + var_29_2 and arg_26_1.time_ < 0 + var_29_2 + arg_29_0 and not isNil(var_29_1) and arg_26_1.var_.characterEffect6056ui_story then
				arg_26_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action2_1")
			end

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				if arg_26_1.var_.characterEffect6056ui_story == nil then
					arg_26_1.var_.characterEffect6056ui_story = arg_26_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_29_4 = arg_26_1.var_.characterEffect6056ui_story

				arg_26_1.var_.characterEffect6056ui_story.imageEffect:turnOff()

				var_29_4.interferenceEffect.enabled = true
				var_29_4.interferenceEffect.noise = 0
				var_29_4.interferenceEffect.simTimeScale = 1
				var_29_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				if arg_26_1.var_.characterEffect6056ui_story == nil then
					arg_26_1.var_.characterEffect6056ui_story = arg_26_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_26_1.var_.characterEffect6056ui_story.imageEffect:turnOn(false)
			end

			local var_29_6 = 0
			local var_29_7 = 0.45

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_6 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_8 = arg_26_1:GetWordFromCfg(322121006)
				local var_29_9 = arg_26_1:FormatText(var_29_8.content)

				arg_26_1.text_.text = var_29_9

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_11 = 18 <= 0 and var_29_7 or var_29_7 * (utf8.len(var_29_9) / 18)

				if (18 <= 0 and var_29_7 or var_29_7 * (utf8.len(var_29_9) / 18)) > 0 and var_29_7 < var_29_11 then
					arg_26_1.talkMaxDuration = var_29_11

					if var_29_11 + var_29_6 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_11 + var_29_6
					end
				end

				arg_26_1.text_.text = var_29_9
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121006", "story_v_out_322121.awb") ~= 0 then
					local var_29_12 = manager.audio:GetVoiceLength("story_v_out_322121", "322121006", "story_v_out_322121.awb") / 1000

					if var_29_12 + var_29_6 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_12 + var_29_6
					end

					if var_29_8.prefab_name ~= "" and arg_26_1.actors_[var_29_8.prefab_name] ~= nil then
						local var_29_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_8.prefab_name].transform, "story_v_out_322121", "322121006", "story_v_out_322121.awb")

						arg_26_1:RecordAudio("322121006", var_29_13)
						arg_26_1:RecordAudio("322121006", var_29_13)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_322121", "322121006", "story_v_out_322121.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_322121", "322121006", "story_v_out_322121.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_14 = math.max(var_29_7, arg_26_1.talkMaxDuration)

			if var_29_6 <= arg_26_1.time_ and arg_26_1.time_ < var_29_6 + var_29_14 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_6) / var_29_14

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_6 + var_29_14 and arg_26_1.time_ < var_29_6 + var_29_14 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play322121007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 322121007
		arg_30_1.duration_ = 13.7

		local var_30_0 = {
			zh = 8.466,
			ja = 13.7
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play322121008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(arg_30_1.actors_["6056ui_story"]) and arg_30_1.var_.characterEffect6056ui_story == nil then
				arg_30_1.var_.characterEffect6056ui_story = arg_30_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_0 = 0.200000002980232

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 and not isNil(arg_30_1.actors_["6056ui_story"]) then
				if arg_30_1.var_.characterEffect6056ui_story and not isNil(arg_30_1.actors_["6056ui_story"]) then
					arg_30_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["6056ui_story"]) and arg_30_1.var_.characterEffect6056ui_story then
				arg_30_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_33_2 = 0
			local var_33_3 = 0.975

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_2 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_4 = arg_30_1:GetWordFromCfg(322121007)
				local var_33_5 = arg_30_1:FormatText(var_33_4.content)

				arg_30_1.text_.text = var_33_5

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_7 = 39 <= 0 and var_33_3 or var_33_3 * (utf8.len(var_33_5) / 39)

				if (39 <= 0 and var_33_3 or var_33_3 * (utf8.len(var_33_5) / 39)) > 0 and var_33_3 < var_33_7 then
					arg_30_1.talkMaxDuration = var_33_7

					if var_33_7 + var_33_2 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_7 + var_33_2
					end
				end

				arg_30_1.text_.text = var_33_5
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121007", "story_v_out_322121.awb") ~= 0 then
					local var_33_8 = manager.audio:GetVoiceLength("story_v_out_322121", "322121007", "story_v_out_322121.awb") / 1000

					if var_33_8 + var_33_2 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_8 + var_33_2
					end

					if var_33_4.prefab_name ~= "" and arg_30_1.actors_[var_33_4.prefab_name] ~= nil then
						local var_33_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_4.prefab_name].transform, "story_v_out_322121", "322121007", "story_v_out_322121.awb")

						arg_30_1:RecordAudio("322121007", var_33_9)
						arg_30_1:RecordAudio("322121007", var_33_9)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_322121", "322121007", "story_v_out_322121.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_322121", "322121007", "story_v_out_322121.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_10 = math.max(var_33_3, arg_30_1.talkMaxDuration)

			if var_33_2 <= arg_30_1.time_ and arg_30_1.time_ < var_33_2 + var_33_10 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_2) / var_33_10

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_2 + var_33_10 and arg_30_1.time_ < var_33_2 + var_33_10 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play322121008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 322121008
		arg_34_1.duration_ = 6.17

		local var_34_0 = {
			zh = 5.633,
			ja = 6.166
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play322121009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action2_2")
			end

			local var_37_0 = arg_34_1.actors_["6056ui_story"]

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect6056ui_story == nil then
				arg_34_1.var_.characterEffect6056ui_story = var_37_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_1 = 0.200000002980232

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_1 and not isNil(var_37_0) then
				if arg_34_1.var_.characterEffect6056ui_story and not isNil(var_37_0) then
					arg_34_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= 0 + var_37_1 and arg_34_1.time_ < 0 + var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect6056ui_story then
				arg_34_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_37_3 = 0
			local var_37_4 = 0.6

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_3 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_5 = arg_34_1:GetWordFromCfg(322121008)
				local var_37_6 = arg_34_1:FormatText(var_37_5.content)

				arg_34_1.text_.text = var_37_6

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_8 = 24 <= 0 and var_37_4 or var_37_4 * (utf8.len(var_37_6) / 24)

				if (24 <= 0 and var_37_4 or var_37_4 * (utf8.len(var_37_6) / 24)) > 0 and var_37_4 < var_37_8 then
					arg_34_1.talkMaxDuration = var_37_8

					if var_37_8 + var_37_3 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_8 + var_37_3
					end
				end

				arg_34_1.text_.text = var_37_6
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121008", "story_v_out_322121.awb") ~= 0 then
					local var_37_9 = manager.audio:GetVoiceLength("story_v_out_322121", "322121008", "story_v_out_322121.awb") / 1000

					if var_37_9 + var_37_3 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_9 + var_37_3
					end

					if var_37_5.prefab_name ~= "" and arg_34_1.actors_[var_37_5.prefab_name] ~= nil then
						local var_37_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_5.prefab_name].transform, "story_v_out_322121", "322121008", "story_v_out_322121.awb")

						arg_34_1:RecordAudio("322121008", var_37_10)
						arg_34_1:RecordAudio("322121008", var_37_10)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_322121", "322121008", "story_v_out_322121.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_322121", "322121008", "story_v_out_322121.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_11 = math.max(var_37_4, arg_34_1.talkMaxDuration)

			if var_37_3 <= arg_34_1.time_ and arg_34_1.time_ < var_37_3 + var_37_11 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_3) / var_37_11

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_3 + var_37_11 and arg_34_1.time_ < var_37_3 + var_37_11 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play322121009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 322121009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play322121010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["6056ui_story"]) and arg_38_1.var_.characterEffect6056ui_story == nil then
				arg_38_1.var_.characterEffect6056ui_story = arg_38_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_0 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["6056ui_story"]) then
				if arg_38_1.var_.characterEffect6056ui_story and not isNil(arg_38_1.actors_["6056ui_story"]) then
					arg_38_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_38_1.var_.characterEffect6056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_38_1.time_ - 0) / var_41_0)
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["6056ui_story"]) and arg_38_1.var_.characterEffect6056ui_story then
				arg_38_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_38_1.var_.characterEffect6056ui_story.fillRatio = 0.5
			end

			local var_41_1 = 0
			local var_41_2 = 0.75

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_3 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(322121009).content)

				arg_38_1.text_.text = var_41_3

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_5 = 30 <= 0 and var_41_2 or var_41_2 * (utf8.len(var_41_3) / 30)

				if (30 <= 0 and var_41_2 or var_41_2 * (utf8.len(var_41_3) / 30)) > 0 and var_41_2 < var_41_5 then
					arg_38_1.talkMaxDuration = var_41_5

					if var_41_5 + var_41_1 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_5 + var_41_1
					end
				end

				arg_38_1.text_.text = var_41_3
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_6 = math.max(var_41_2, arg_38_1.talkMaxDuration)

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_6 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_1) / var_41_6

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_1 + var_41_6 and arg_38_1.time_ < var_41_1 + var_41_6 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play322121010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 322121010
		arg_42_1.duration_ = 4

		local var_42_0 = {
			zh = 4,
			ja = 3.499999999999
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play322121011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos6056ui_story = arg_42_1.actors_["6056ui_story"].transform.localPosition
			end

			local var_45_0 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 then
				arg_42_1.actors_["6056ui_story"].transform.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos6056ui_story, Vector3.New(0.15, -1.16, -6.15), (arg_42_1.time_ - 0) / var_45_0)
				arg_42_1.actors_["6056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_42_1.actors_["6056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["6056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["6056ui_story"].transform.position).z)
				arg_42_1.actors_["6056ui_story"].transform.localEulerAngles.z = 0
				arg_42_1.actors_["6056ui_story"].transform.localEulerAngles.x = 0
				arg_42_1.actors_["6056ui_story"].transform.localEulerAngles = arg_42_1.actors_["6056ui_story"].transform.localEulerAngles
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 then
				arg_42_1.actors_["6056ui_story"].transform.localPosition = Vector3.New(0.15, -1.16, -6.15)
				arg_42_1.actors_["6056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_42_1.actors_["6056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["6056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["6056ui_story"].transform.position).z)
				arg_42_1.actors_["6056ui_story"].transform.localEulerAngles.z = 0
				arg_42_1.actors_["6056ui_story"].transform.localEulerAngles.x = 0
				arg_42_1.actors_["6056ui_story"].transform.localEulerAngles = arg_42_1.actors_["6056ui_story"].transform.localEulerAngles
			end

			local var_45_1 = arg_42_1.actors_["6056ui_story"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_1) and arg_42_1.var_.characterEffect6056ui_story == nil then
				arg_42_1.var_.characterEffect6056ui_story = var_45_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_2 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_2 and not isNil(var_45_1) then
				if arg_42_1.var_.characterEffect6056ui_story and not isNil(var_45_1) then
					arg_42_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= 0 + var_45_2 and arg_42_1.time_ < 0 + var_45_2 + arg_45_0 and not isNil(var_45_1) and arg_42_1.var_.characterEffect6056ui_story then
				arg_42_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action1_1")
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				if arg_42_1.var_.characterEffect6056ui_story == nil then
					arg_42_1.var_.characterEffect6056ui_story = arg_42_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_45_4 = arg_42_1.var_.characterEffect6056ui_story

				arg_42_1.var_.characterEffect6056ui_story.imageEffect:turnOff()

				var_45_4.interferenceEffect.enabled = true
				var_45_4.interferenceEffect.noise = 0
				var_45_4.interferenceEffect.simTimeScale = 1
				var_45_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				if arg_42_1.var_.characterEffect6056ui_story == nil then
					arg_42_1.var_.characterEffect6056ui_story = arg_42_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_42_1.var_.characterEffect6056ui_story.imageEffect:turnOn(false)
			end

			local var_45_6 = 0
			local var_45_7 = 0.3

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_8 = arg_42_1:GetWordFromCfg(322121010)
				local var_45_9 = arg_42_1:FormatText(var_45_8.content)

				arg_42_1.text_.text = var_45_9

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_11 = 12 <= 0 and var_45_7 or var_45_7 * (utf8.len(var_45_9) / 12)

				if (12 <= 0 and var_45_7 or var_45_7 * (utf8.len(var_45_9) / 12)) > 0 and var_45_7 < var_45_11 then
					arg_42_1.talkMaxDuration = var_45_11

					if var_45_11 + var_45_6 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_11 + var_45_6
					end
				end

				arg_42_1.text_.text = var_45_9
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121010", "story_v_out_322121.awb") ~= 0 then
					local var_45_12 = manager.audio:GetVoiceLength("story_v_out_322121", "322121010", "story_v_out_322121.awb") / 1000

					if var_45_12 + var_45_6 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_12 + var_45_6
					end

					if var_45_8.prefab_name ~= "" and arg_42_1.actors_[var_45_8.prefab_name] ~= nil then
						local var_45_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_8.prefab_name].transform, "story_v_out_322121", "322121010", "story_v_out_322121.awb")

						arg_42_1:RecordAudio("322121010", var_45_13)
						arg_42_1:RecordAudio("322121010", var_45_13)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_322121", "322121010", "story_v_out_322121.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_322121", "322121010", "story_v_out_322121.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_14 = math.max(var_45_7, arg_42_1.talkMaxDuration)

			if var_45_6 <= arg_42_1.time_ and arg_42_1.time_ < var_45_6 + var_45_14 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_6) / var_45_14

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_6 + var_45_14 and arg_42_1.time_ < var_45_6 + var_45_14 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play322121011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 322121011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play322121012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["6056ui_story"]) and arg_46_1.var_.characterEffect6056ui_story == nil then
				arg_46_1.var_.characterEffect6056ui_story = arg_46_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_0 = 0.200000002980232

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["6056ui_story"]) then
				if arg_46_1.var_.characterEffect6056ui_story and not isNil(arg_46_1.actors_["6056ui_story"]) then
					arg_46_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_46_1.var_.characterEffect6056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_46_1.time_ - 0) / var_49_0)
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["6056ui_story"]) and arg_46_1.var_.characterEffect6056ui_story then
				arg_46_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_46_1.var_.characterEffect6056ui_story.fillRatio = 0.5
			end

			local var_49_1 = 0
			local var_49_2 = 0.375

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_3 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(322121011).content)

				arg_46_1.text_.text = var_49_3

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_5 = 15 <= 0 and var_49_2 or var_49_2 * (utf8.len(var_49_3) / 15)

				if (15 <= 0 and var_49_2 or var_49_2 * (utf8.len(var_49_3) / 15)) > 0 and var_49_2 < var_49_5 then
					arg_46_1.talkMaxDuration = var_49_5

					if var_49_5 + var_49_1 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + var_49_1
					end
				end

				arg_46_1.text_.text = var_49_3
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_6 = math.max(var_49_2, arg_46_1.talkMaxDuration)

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_6 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_1) / var_49_6

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_1 + var_49_6 and arg_46_1.time_ < var_49_1 + var_49_6 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play322121012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 322121012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play322121013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 1.2

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_1 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(322121012).content)

				arg_50_1.text_.text = var_53_1

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_3 = 48 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_1) / 48)

				if (48 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_1) / 48)) > 0 and var_53_0 < var_53_3 then
					arg_50_1.talkMaxDuration = var_53_3

					if var_53_3 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_3 + 0
					end
				end

				arg_50_1.text_.text = var_53_1
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_4 = math.max(var_53_0, arg_50_1.talkMaxDuration)

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - 0) / var_53_4

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play322121013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 322121013
		arg_54_1.duration_ = 5.17

		local var_54_0 = {
			zh = 4.633,
			ja = 5.166
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play322121014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos6056ui_story = arg_54_1.actors_["6056ui_story"].transform.localPosition
			end

			local var_57_0 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 then
				arg_54_1.actors_["6056ui_story"].transform.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos6056ui_story, Vector3.New(0.15, -1.16, -6.15), (arg_54_1.time_ - 0) / var_57_0)
				arg_54_1.actors_["6056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_54_1.actors_["6056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["6056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["6056ui_story"].transform.position).z)
				arg_54_1.actors_["6056ui_story"].transform.localEulerAngles.z = 0
				arg_54_1.actors_["6056ui_story"].transform.localEulerAngles.x = 0
				arg_54_1.actors_["6056ui_story"].transform.localEulerAngles = arg_54_1.actors_["6056ui_story"].transform.localEulerAngles
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 then
				arg_54_1.actors_["6056ui_story"].transform.localPosition = Vector3.New(0.15, -1.16, -6.15)
				arg_54_1.actors_["6056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_54_1.actors_["6056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["6056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["6056ui_story"].transform.position).z)
				arg_54_1.actors_["6056ui_story"].transform.localEulerAngles.z = 0
				arg_54_1.actors_["6056ui_story"].transform.localEulerAngles.x = 0
				arg_54_1.actors_["6056ui_story"].transform.localEulerAngles = arg_54_1.actors_["6056ui_story"].transform.localEulerAngles
			end

			local var_57_1 = arg_54_1.actors_["6056ui_story"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_1) and arg_54_1.var_.characterEffect6056ui_story == nil then
				arg_54_1.var_.characterEffect6056ui_story = var_57_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_2 and not isNil(var_57_1) then
				if arg_54_1.var_.characterEffect6056ui_story and not isNil(var_57_1) then
					arg_54_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= 0 + var_57_2 and arg_54_1.time_ < 0 + var_57_2 + arg_57_0 and not isNil(var_57_1) and arg_54_1.var_.characterEffect6056ui_story then
				arg_54_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action1_1")
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				if arg_54_1.var_.characterEffect6056ui_story == nil then
					arg_54_1.var_.characterEffect6056ui_story = arg_54_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_57_4 = arg_54_1.var_.characterEffect6056ui_story

				arg_54_1.var_.characterEffect6056ui_story.imageEffect:turnOff()

				var_57_4.interferenceEffect.enabled = true
				var_57_4.interferenceEffect.noise = 0
				var_57_4.interferenceEffect.simTimeScale = 1
				var_57_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				if arg_54_1.var_.characterEffect6056ui_story == nil then
					arg_54_1.var_.characterEffect6056ui_story = arg_54_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_54_1.var_.characterEffect6056ui_story.imageEffect:turnOn(false)
			end

			local var_57_6 = 0
			local var_57_7 = 0.425

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_6 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_8 = arg_54_1:GetWordFromCfg(322121013)
				local var_57_9 = arg_54_1:FormatText(var_57_8.content)

				arg_54_1.text_.text = var_57_9

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_11 = 17 <= 0 and var_57_7 or var_57_7 * (utf8.len(var_57_9) / 17)

				if (17 <= 0 and var_57_7 or var_57_7 * (utf8.len(var_57_9) / 17)) > 0 and var_57_7 < var_57_11 then
					arg_54_1.talkMaxDuration = var_57_11

					if var_57_11 + var_57_6 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_11 + var_57_6
					end
				end

				arg_54_1.text_.text = var_57_9
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121013", "story_v_out_322121.awb") ~= 0 then
					local var_57_12 = manager.audio:GetVoiceLength("story_v_out_322121", "322121013", "story_v_out_322121.awb") / 1000

					if var_57_12 + var_57_6 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_12 + var_57_6
					end

					if var_57_8.prefab_name ~= "" and arg_54_1.actors_[var_57_8.prefab_name] ~= nil then
						local var_57_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_8.prefab_name].transform, "story_v_out_322121", "322121013", "story_v_out_322121.awb")

						arg_54_1:RecordAudio("322121013", var_57_13)
						arg_54_1:RecordAudio("322121013", var_57_13)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_322121", "322121013", "story_v_out_322121.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_322121", "322121013", "story_v_out_322121.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_14 = math.max(var_57_7, arg_54_1.talkMaxDuration)

			if var_57_6 <= arg_54_1.time_ and arg_54_1.time_ < var_57_6 + var_57_14 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_6) / var_57_14

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_6 + var_57_14 and arg_54_1.time_ < var_57_6 + var_57_14 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play322121014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 322121014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play322121015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["6056ui_story"]) and arg_58_1.var_.characterEffect6056ui_story == nil then
				arg_58_1.var_.characterEffect6056ui_story = arg_58_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_0 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["6056ui_story"]) then
				if arg_58_1.var_.characterEffect6056ui_story and not isNil(arg_58_1.actors_["6056ui_story"]) then
					arg_58_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_58_1.var_.characterEffect6056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_58_1.time_ - 0) / var_61_0)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["6056ui_story"]) and arg_58_1.var_.characterEffect6056ui_story then
				arg_58_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_58_1.var_.characterEffect6056ui_story.fillRatio = 0.5
			end

			local var_61_1 = 0
			local var_61_2 = 0.125

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_3 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(322121014).content)

				arg_58_1.text_.text = var_61_3

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 5 <= 0 and var_61_2 or var_61_2 * (utf8.len(var_61_3) / 5)

				if (5 <= 0 and var_61_2 or var_61_2 * (utf8.len(var_61_3) / 5)) > 0 and var_61_2 < var_61_5 then
					arg_58_1.talkMaxDuration = var_61_5

					if var_61_5 + var_61_1 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_5 + var_61_1
					end
				end

				arg_58_1.text_.text = var_61_3
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_6 = math.max(var_61_2, arg_58_1.talkMaxDuration)

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_6 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_1) / var_61_6

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_1 + var_61_6 and arg_58_1.time_ < var_61_1 + var_61_6 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play322121015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 322121015
		arg_62_1.duration_ = 16.03

		local var_62_0 = {
			zh = 9,
			ja = 16.033
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play322121016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos6056ui_story = arg_62_1.actors_["6056ui_story"].transform.localPosition
			end

			local var_65_0 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 then
				arg_62_1.actors_["6056ui_story"].transform.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos6056ui_story, Vector3.New(0.15, -1.16, -6.15), (arg_62_1.time_ - 0) / var_65_0)
				arg_62_1.actors_["6056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["6056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["6056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["6056ui_story"].transform.position).z)
				arg_62_1.actors_["6056ui_story"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["6056ui_story"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["6056ui_story"].transform.localEulerAngles = arg_62_1.actors_["6056ui_story"].transform.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 then
				arg_62_1.actors_["6056ui_story"].transform.localPosition = Vector3.New(0.15, -1.16, -6.15)
				arg_62_1.actors_["6056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["6056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["6056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["6056ui_story"].transform.position).z)
				arg_62_1.actors_["6056ui_story"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["6056ui_story"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["6056ui_story"].transform.localEulerAngles = arg_62_1.actors_["6056ui_story"].transform.localEulerAngles
			end

			local var_65_1 = arg_62_1.actors_["6056ui_story"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_1) and arg_62_1.var_.characterEffect6056ui_story == nil then
				arg_62_1.var_.characterEffect6056ui_story = var_65_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_2 and not isNil(var_65_1) then
				if arg_62_1.var_.characterEffect6056ui_story and not isNil(var_65_1) then
					arg_62_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= 0 + var_65_2 and arg_62_1.time_ < 0 + var_65_2 + arg_65_0 and not isNil(var_65_1) and arg_62_1.var_.characterEffect6056ui_story then
				arg_62_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action3_1")
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				if arg_62_1.var_.characterEffect6056ui_story == nil then
					arg_62_1.var_.characterEffect6056ui_story = arg_62_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_65_4 = arg_62_1.var_.characterEffect6056ui_story

				arg_62_1.var_.characterEffect6056ui_story.imageEffect:turnOff()

				var_65_4.interferenceEffect.enabled = true
				var_65_4.interferenceEffect.noise = 0
				var_65_4.interferenceEffect.simTimeScale = 1
				var_65_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				if arg_62_1.var_.characterEffect6056ui_story == nil then
					arg_62_1.var_.characterEffect6056ui_story = arg_62_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_62_1.var_.characterEffect6056ui_story.imageEffect:turnOn(false)
			end

			local var_65_6 = 0
			local var_65_7 = 1.275

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_8 = arg_62_1:GetWordFromCfg(322121015)
				local var_65_9 = arg_62_1:FormatText(var_65_8.content)

				arg_62_1.text_.text = var_65_9

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_11 = 51 <= 0 and var_65_7 or var_65_7 * (utf8.len(var_65_9) / 51)

				if (51 <= 0 and var_65_7 or var_65_7 * (utf8.len(var_65_9) / 51)) > 0 and var_65_7 < var_65_11 then
					arg_62_1.talkMaxDuration = var_65_11

					if var_65_11 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_11 + var_65_6
					end
				end

				arg_62_1.text_.text = var_65_9
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121015", "story_v_out_322121.awb") ~= 0 then
					local var_65_12 = manager.audio:GetVoiceLength("story_v_out_322121", "322121015", "story_v_out_322121.awb") / 1000

					if var_65_12 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_12 + var_65_6
					end

					if var_65_8.prefab_name ~= "" and arg_62_1.actors_[var_65_8.prefab_name] ~= nil then
						local var_65_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_8.prefab_name].transform, "story_v_out_322121", "322121015", "story_v_out_322121.awb")

						arg_62_1:RecordAudio("322121015", var_65_13)
						arg_62_1:RecordAudio("322121015", var_65_13)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_322121", "322121015", "story_v_out_322121.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_322121", "322121015", "story_v_out_322121.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_14 = math.max(var_65_7, arg_62_1.talkMaxDuration)

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_14 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_6) / var_65_14

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_6 + var_65_14 and arg_62_1.time_ < var_65_6 + var_65_14 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play322121016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 322121016
		arg_66_1.duration_ = 7.8

		local var_66_0 = {
			zh = 6.233,
			ja = 7.8
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play322121017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0.75

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_1 = arg_66_1:GetWordFromCfg(322121016)
				local var_69_2 = arg_66_1:FormatText(var_69_1.content)

				arg_66_1.text_.text = var_69_2

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 30 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 30)

				if (30 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 30)) > 0 and var_69_0 < var_69_4 then
					arg_66_1.talkMaxDuration = var_69_4

					if var_69_4 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_4 + 0
					end
				end

				arg_66_1.text_.text = var_69_2
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121016", "story_v_out_322121.awb") ~= 0 then
					local var_69_5 = manager.audio:GetVoiceLength("story_v_out_322121", "322121016", "story_v_out_322121.awb") / 1000

					if var_69_5 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + 0
					end

					if var_69_1.prefab_name ~= "" and arg_66_1.actors_[var_69_1.prefab_name] ~= nil then
						local var_69_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_1.prefab_name].transform, "story_v_out_322121", "322121016", "story_v_out_322121.awb")

						arg_66_1:RecordAudio("322121016", var_69_6)
						arg_66_1:RecordAudio("322121016", var_69_6)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_322121", "322121016", "story_v_out_322121.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_322121", "322121016", "story_v_out_322121.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_7 = math.max(var_69_0, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_7 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - 0) / var_69_7

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_7 and arg_66_1.time_ < 0 + var_69_7 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play322121017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 322121017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play322121018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos6056ui_story = arg_70_1.actors_["6056ui_story"].transform.localPosition
			end

			local var_73_0 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 then
				arg_70_1.actors_["6056ui_story"].transform.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos6056ui_story, Vector3.New(0, 100, 0), (arg_70_1.time_ - 0) / var_73_0)
				arg_70_1.actors_["6056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_70_1.actors_["6056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["6056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["6056ui_story"].transform.position).z)
				arg_70_1.actors_["6056ui_story"].transform.localEulerAngles.z = 0
				arg_70_1.actors_["6056ui_story"].transform.localEulerAngles.x = 0
				arg_70_1.actors_["6056ui_story"].transform.localEulerAngles = arg_70_1.actors_["6056ui_story"].transform.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 then
				arg_70_1.actors_["6056ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.actors_["6056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_70_1.actors_["6056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["6056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["6056ui_story"].transform.position).z)
				arg_70_1.actors_["6056ui_story"].transform.localEulerAngles.z = 0
				arg_70_1.actors_["6056ui_story"].transform.localEulerAngles.x = 0
				arg_70_1.actors_["6056ui_story"].transform.localEulerAngles = arg_70_1.actors_["6056ui_story"].transform.localEulerAngles
			end

			local var_73_1 = 0
			local var_73_2 = 1.375

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_3 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(322121017).content)

				arg_70_1.text_.text = var_73_3

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 55 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_3) / 55)

				if (55 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_3) / 55)) > 0 and var_73_2 < var_73_5 then
					arg_70_1.talkMaxDuration = var_73_5

					if var_73_5 + var_73_1 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_5 + var_73_1
					end
				end

				arg_70_1.text_.text = var_73_3
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_6 = math.max(var_73_2, arg_70_1.talkMaxDuration)

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_6 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_1) / var_73_6

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_1 + var_73_6 and arg_70_1.time_ < var_73_1 + var_73_6 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play322121018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 322121018
		arg_74_1.duration_ = 8.37

		local var_74_0 = {
			zh = 6.4,
			ja = 8.366
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play322121019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if arg_74_1.actors_["10104ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10104ui_story"))) then
				local var_77_0 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_74_1.stage_.transform)

				var_77_0.name = "10104ui_story"
				var_77_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_74_1.actors_["10104ui_story"] = var_77_0

				local var_77_1 = var_77_0:GetComponentInChildren(typeof(CharacterEffect))

				var_77_1.enabled = true

				local var_77_2 = GameObjectTools.GetOrAddComponent(var_77_0, typeof(DynamicBoneHelper))

				if var_77_2 then
					var_77_2:EnableDynamicBone(false)
				end

				arg_74_1:ShowWeapon(var_77_1.transform, false)

				arg_74_1.var_["10104ui_story" .. "Animator"] = var_77_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_74_1.var_["10104ui_story" .. "Animator"].applyRootMotion = true
				arg_74_1.var_["10104ui_story" .. "LipSync"] = var_77_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_77_3 = arg_74_1.actors_["10104ui_story"].transform

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos10104ui_story = var_77_3.localPosition
			end

			local var_77_4 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_4 then
				var_77_3.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos10104ui_story, Vector3.New(-0.88, -1.12, -5.99), (arg_74_1.time_ - 0) / var_77_4)
				var_77_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_3.position).x, (manager.ui.mainCamera.transform.position - var_77_3.position).y, (manager.ui.mainCamera.transform.position - var_77_3.position).z)
				var_77_3.localEulerAngles.z = 0
				var_77_3.localEulerAngles.x = 0
				var_77_3.localEulerAngles = var_77_3.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_4 and arg_74_1.time_ < 0 + var_77_4 + arg_77_0 then
				var_77_3.localPosition = Vector3.New(-0.88, -1.12, -5.99)
				var_77_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_3.position).x, (manager.ui.mainCamera.transform.position - var_77_3.position).y, (manager.ui.mainCamera.transform.position - var_77_3.position).z)
				var_77_3.localEulerAngles.z = 0
				var_77_3.localEulerAngles.x = 0
				var_77_3.localEulerAngles = var_77_3.localEulerAngles
			end

			local var_77_5 = arg_74_1.actors_["10104ui_story"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_5) and arg_74_1.var_.characterEffect10104ui_story == nil then
				arg_74_1.var_.characterEffect10104ui_story = var_77_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_6 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_6 and not isNil(var_77_5) then
				if arg_74_1.var_.characterEffect10104ui_story and not isNil(var_77_5) then
					arg_74_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 0 + var_77_6 and arg_74_1.time_ < 0 + var_77_6 + arg_77_0 and not isNil(var_77_5) and arg_74_1.var_.characterEffect10104ui_story then
				arg_74_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_1")
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_77_8 = 0
			local var_77_9 = 0.7

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_8 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_10 = arg_74_1:GetWordFromCfg(322121018)
				local var_77_11 = arg_74_1:FormatText(var_77_10.content)

				arg_74_1.text_.text = var_77_11

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_13 = 28 <= 0 and var_77_9 or var_77_9 * (utf8.len(var_77_11) / 28)

				if (28 <= 0 and var_77_9 or var_77_9 * (utf8.len(var_77_11) / 28)) > 0 and var_77_9 < var_77_13 then
					arg_74_1.talkMaxDuration = var_77_13

					if var_77_13 + var_77_8 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_13 + var_77_8
					end
				end

				arg_74_1.text_.text = var_77_11
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121018", "story_v_out_322121.awb") ~= 0 then
					local var_77_14 = manager.audio:GetVoiceLength("story_v_out_322121", "322121018", "story_v_out_322121.awb") / 1000

					if var_77_14 + var_77_8 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_14 + var_77_8
					end

					if var_77_10.prefab_name ~= "" and arg_74_1.actors_[var_77_10.prefab_name] ~= nil then
						local var_77_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_10.prefab_name].transform, "story_v_out_322121", "322121018", "story_v_out_322121.awb")

						arg_74_1:RecordAudio("322121018", var_77_15)
						arg_74_1:RecordAudio("322121018", var_77_15)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_322121", "322121018", "story_v_out_322121.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_322121", "322121018", "story_v_out_322121.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_16 = math.max(var_77_9, arg_74_1.talkMaxDuration)

			if var_77_8 <= arg_74_1.time_ and arg_74_1.time_ < var_77_8 + var_77_16 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_8) / var_77_16

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_8 + var_77_16 and arg_74_1.time_ < var_77_8 + var_77_16 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play322121019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 322121019
		arg_78_1.duration_ = 4.6

		local var_78_0 = {
			zh = 4.6,
			ja = 4.3
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play322121020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos6056ui_story = arg_78_1.actors_["6056ui_story"].transform.localPosition
			end

			local var_81_0 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 then
				arg_78_1.actors_["6056ui_story"].transform.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos6056ui_story, Vector3.New(0.95, -1.16, -6.15), (arg_78_1.time_ - 0) / var_81_0)
				arg_78_1.actors_["6056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_78_1.actors_["6056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["6056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["6056ui_story"].transform.position).z)
				arg_78_1.actors_["6056ui_story"].transform.localEulerAngles.z = 0
				arg_78_1.actors_["6056ui_story"].transform.localEulerAngles.x = 0
				arg_78_1.actors_["6056ui_story"].transform.localEulerAngles = arg_78_1.actors_["6056ui_story"].transform.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 then
				arg_78_1.actors_["6056ui_story"].transform.localPosition = Vector3.New(0.95, -1.16, -6.15)
				arg_78_1.actors_["6056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_78_1.actors_["6056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["6056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["6056ui_story"].transform.position).z)
				arg_78_1.actors_["6056ui_story"].transform.localEulerAngles.z = 0
				arg_78_1.actors_["6056ui_story"].transform.localEulerAngles.x = 0
				arg_78_1.actors_["6056ui_story"].transform.localEulerAngles = arg_78_1.actors_["6056ui_story"].transform.localEulerAngles
			end

			local var_81_1 = arg_78_1.actors_["6056ui_story"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_1) and arg_78_1.var_.characterEffect6056ui_story == nil then
				arg_78_1.var_.characterEffect6056ui_story = var_81_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_2 and not isNil(var_81_1) then
				if arg_78_1.var_.characterEffect6056ui_story and not isNil(var_81_1) then
					arg_78_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_2 and arg_78_1.time_ < 0 + var_81_2 + arg_81_0 and not isNil(var_81_1) and arg_78_1.var_.characterEffect6056ui_story then
				arg_78_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_81_4 = arg_78_1.actors_["10104ui_story"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_4) and arg_78_1.var_.characterEffect10104ui_story == nil then
				arg_78_1.var_.characterEffect10104ui_story = var_81_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_5 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_5 and not isNil(var_81_4) then
				if arg_78_1.var_.characterEffect10104ui_story and not isNil(var_81_4) then
					arg_78_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_78_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_5)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_5 and arg_78_1.time_ < 0 + var_81_5 + arg_81_0 and not isNil(var_81_4) and arg_78_1.var_.characterEffect10104ui_story then
				arg_78_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_78_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action4_1")
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				if arg_78_1.var_.characterEffect6056ui_story == nil then
					arg_78_1.var_.characterEffect6056ui_story = arg_78_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_81_6 = arg_78_1.var_.characterEffect6056ui_story

				arg_78_1.var_.characterEffect6056ui_story.imageEffect:turnOff()

				var_81_6.interferenceEffect.enabled = true
				var_81_6.interferenceEffect.noise = 0
				var_81_6.interferenceEffect.simTimeScale = 1
				var_81_6.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				if arg_78_1.var_.characterEffect6056ui_story == nil then
					arg_78_1.var_.characterEffect6056ui_story = arg_78_1.actors_["6056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_78_1.var_.characterEffect6056ui_story.imageEffect:turnOn(false)
			end

			local var_81_8 = 0
			local var_81_9 = 0.45

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_8 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_10 = arg_78_1:GetWordFromCfg(322121019)
				local var_81_11 = arg_78_1:FormatText(var_81_10.content)

				arg_78_1.text_.text = var_81_11

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_13 = 18 <= 0 and var_81_9 or var_81_9 * (utf8.len(var_81_11) / 18)

				if (18 <= 0 and var_81_9 or var_81_9 * (utf8.len(var_81_11) / 18)) > 0 and var_81_9 < var_81_13 then
					arg_78_1.talkMaxDuration = var_81_13

					if var_81_13 + var_81_8 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_13 + var_81_8
					end
				end

				arg_78_1.text_.text = var_81_11
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121019", "story_v_out_322121.awb") ~= 0 then
					local var_81_14 = manager.audio:GetVoiceLength("story_v_out_322121", "322121019", "story_v_out_322121.awb") / 1000

					if var_81_14 + var_81_8 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_14 + var_81_8
					end

					if var_81_10.prefab_name ~= "" and arg_78_1.actors_[var_81_10.prefab_name] ~= nil then
						local var_81_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_10.prefab_name].transform, "story_v_out_322121", "322121019", "story_v_out_322121.awb")

						arg_78_1:RecordAudio("322121019", var_81_15)
						arg_78_1:RecordAudio("322121019", var_81_15)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_322121", "322121019", "story_v_out_322121.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_322121", "322121019", "story_v_out_322121.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_16 = math.max(var_81_9, arg_78_1.talkMaxDuration)

			if var_81_8 <= arg_78_1.time_ and arg_78_1.time_ < var_81_8 + var_81_16 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_8) / var_81_16

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_8 + var_81_16 and arg_78_1.time_ < var_81_8 + var_81_16 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play322121020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 322121020
		arg_82_1.duration_ = 10.83

		local var_82_0 = {
			zh = 7.6,
			ja = 10.833
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play322121021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0.9

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_1 = arg_82_1:GetWordFromCfg(322121020)
				local var_85_2 = arg_82_1:FormatText(var_85_1.content)

				arg_82_1.text_.text = var_85_2

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_4 = 36 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 36)

				if (36 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 36)) > 0 and var_85_0 < var_85_4 then
					arg_82_1.talkMaxDuration = var_85_4

					if var_85_4 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_4 + 0
					end
				end

				arg_82_1.text_.text = var_85_2
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121020", "story_v_out_322121.awb") ~= 0 then
					local var_85_5 = manager.audio:GetVoiceLength("story_v_out_322121", "322121020", "story_v_out_322121.awb") / 1000

					if var_85_5 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + 0
					end

					if var_85_1.prefab_name ~= "" and arg_82_1.actors_[var_85_1.prefab_name] ~= nil then
						local var_85_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_1.prefab_name].transform, "story_v_out_322121", "322121020", "story_v_out_322121.awb")

						arg_82_1:RecordAudio("322121020", var_85_6)
						arg_82_1:RecordAudio("322121020", var_85_6)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_322121", "322121020", "story_v_out_322121.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_322121", "322121020", "story_v_out_322121.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_7 = math.max(var_85_0, arg_82_1.talkMaxDuration)

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_7 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - 0) / var_85_7

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= 0 + var_85_7 and arg_82_1.time_ < 0 + var_85_7 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play322121021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 322121021
		arg_86_1.duration_ = 7.13

		local var_86_0 = {
			zh = 6.333,
			ja = 7.133
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play322121022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if arg_86_1.bgs_.L17f == nil then
				local var_89_0 = Object.Instantiate(arg_86_1.paintGo_)

				var_89_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L17f")
				var_89_0.name = "L17f"
				var_89_0.transform.parent = arg_86_1.stage_.transform
				var_89_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.bgs_.L17f = var_89_0
			end

			if 2 < arg_86_1.time_ and arg_86_1.time_ <= 2 + arg_89_0 then
				local var_89_1 = arg_86_1.bgs_.L17f

				arg_86_1.bgs_.L17f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_89_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_89_2 = var_89_1:GetComponent("SpriteRenderer")

				if var_89_2 and var_89_2.sprite then
					local var_89_3 = 2 * (var_89_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_89_1.transform.localScale = Vector3.New(var_89_3 / var_89_2.sprite.bounds.size.y < var_89_3 * manager.ui.mainCameraCom_.aspect / var_89_2.sprite.bounds.size.x and var_89_3 * manager.ui.mainCameraCom_.aspect / var_89_2.sprite.bounds.size.x or var_89_3 / var_89_2.sprite.bounds.size.y, var_89_3 / var_89_2.sprite.bounds.size.y < var_89_3 * manager.ui.mainCameraCom_.aspect / var_89_2.sprite.bounds.size.x and var_89_3 * manager.ui.mainCameraCom_.aspect / var_89_2.sprite.bounds.size.x or var_89_3 / var_89_2.sprite.bounds.size.y, 0)
				end

				for iter_89_0, iter_89_1 in pairs(arg_86_1.bgs_) do
					if iter_89_0 ~= "L17f" then
						iter_89_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_89_4 = 4

			if 4 < arg_86_1.time_ and arg_86_1.time_ <= var_89_4 + arg_89_0 then
				arg_86_1.allBtn_.enabled = false
			end

			if arg_86_1.time_ >= var_89_4 + 0.3 and arg_86_1.time_ < var_89_4 + 0.3 + arg_89_0 then
				arg_86_1.allBtn_.enabled = true
			end

			local var_89_5 = 0

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_5 + arg_89_0 then
				arg_86_1.mask_.enabled = true
				arg_86_1.mask_.raycastTarget = true

				arg_86_1:SetGaussion(false)
			end

			local var_89_6 = 2

			if var_89_5 <= arg_86_1.time_ and arg_86_1.time_ < var_89_5 + var_89_6 then
				local var_89_7 = Color.New(0, 0, 0)

				var_89_7.a = Mathf.Lerp(0, 1, (arg_86_1.time_ - var_89_5) / var_89_6)
				arg_86_1.mask_.color = var_89_7
			end

			if arg_86_1.time_ >= var_89_5 + var_89_6 and arg_86_1.time_ < var_89_5 + var_89_6 + arg_89_0 then
				local var_89_8 = Color.New(0, 0, 0)

				var_89_8.a = 1
				arg_86_1.mask_.color = var_89_8
			end

			local var_89_9 = 2

			if 2 < arg_86_1.time_ and arg_86_1.time_ <= var_89_9 + arg_89_0 then
				arg_86_1.mask_.enabled = true
				arg_86_1.mask_.raycastTarget = true

				arg_86_1:SetGaussion(false)
			end

			local var_89_10 = 2

			if var_89_9 <= arg_86_1.time_ and arg_86_1.time_ < var_89_9 + var_89_10 then
				local var_89_11 = Color.New(0, 0, 0)

				var_89_11.a = Mathf.Lerp(1, 0, (arg_86_1.time_ - var_89_9) / var_89_10)
				arg_86_1.mask_.color = var_89_11
			end

			if arg_86_1.time_ >= var_89_9 + var_89_10 and arg_86_1.time_ < var_89_9 + var_89_10 + arg_89_0 then
				local var_89_12 = Color.New(0, 0, 0)

				arg_86_1.mask_.enabled = false
				var_89_12.a = 0
				arg_86_1.mask_.color = var_89_12
			end

			local var_89_13 = arg_86_1.actors_["6056ui_story"].transform

			if 1.96599999815226 < arg_86_1.time_ and arg_86_1.time_ <= 1.96599999815226 + arg_89_0 then
				arg_86_1.var_.moveOldPos6056ui_story = var_89_13.localPosition
			end

			local var_89_14 = 0.001

			if 1.96599999815226 <= arg_86_1.time_ and arg_86_1.time_ < 1.96599999815226 + var_89_14 then
				var_89_13.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos6056ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 1.96599999815226) / var_89_14)
				var_89_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_13.position).x, (manager.ui.mainCamera.transform.position - var_89_13.position).y, (manager.ui.mainCamera.transform.position - var_89_13.position).z)
				var_89_13.localEulerAngles.z = 0
				var_89_13.localEulerAngles.x = 0
				var_89_13.localEulerAngles = var_89_13.localEulerAngles
			end

			if arg_86_1.time_ >= 1.96599999815226 + var_89_14 and arg_86_1.time_ < 1.96599999815226 + var_89_14 + arg_89_0 then
				var_89_13.localPosition = Vector3.New(0, 100, 0)
				var_89_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_13.position).x, (manager.ui.mainCamera.transform.position - var_89_13.position).y, (manager.ui.mainCamera.transform.position - var_89_13.position).z)
				var_89_13.localEulerAngles.z = 0
				var_89_13.localEulerAngles.x = 0
				var_89_13.localEulerAngles = var_89_13.localEulerAngles
			end

			local var_89_15 = arg_86_1.actors_["10104ui_story"].transform

			if 1.96599999815226 < arg_86_1.time_ and arg_86_1.time_ <= 1.96599999815226 + arg_89_0 then
				arg_86_1.var_.moveOldPos10104ui_story = var_89_15.localPosition
			end

			local var_89_16 = 0.001

			if 1.96599999815226 <= arg_86_1.time_ and arg_86_1.time_ < 1.96599999815226 + var_89_16 then
				var_89_15.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 1.96599999815226) / var_89_16)
				var_89_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_15.position).x, (manager.ui.mainCamera.transform.position - var_89_15.position).y, (manager.ui.mainCamera.transform.position - var_89_15.position).z)
				var_89_15.localEulerAngles.z = 0
				var_89_15.localEulerAngles.x = 0
				var_89_15.localEulerAngles = var_89_15.localEulerAngles
			end

			if arg_86_1.time_ >= 1.96599999815226 + var_89_16 and arg_86_1.time_ < 1.96599999815226 + var_89_16 + arg_89_0 then
				var_89_15.localPosition = Vector3.New(0, 100, 0)
				var_89_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_15.position).x, (manager.ui.mainCamera.transform.position - var_89_15.position).y, (manager.ui.mainCamera.transform.position - var_89_15.position).z)
				var_89_15.localEulerAngles.z = 0
				var_89_15.localEulerAngles.x = 0
				var_89_15.localEulerAngles = var_89_15.localEulerAngles
			end

			local var_89_17 = "10103ui_story"

			if arg_86_1.actors_["10103ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10103ui_story"))) then
				local var_89_18 = Object.Instantiate(Asset.Load("Char/" .. "10103ui_story"), arg_86_1.stage_.transform)

				var_89_18.name = var_89_17
				var_89_18.transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.actors_[var_89_17] = var_89_18

				local var_89_19 = var_89_18:GetComponentInChildren(typeof(CharacterEffect))

				var_89_19.enabled = true

				local var_89_20 = GameObjectTools.GetOrAddComponent(var_89_18, typeof(DynamicBoneHelper))

				if var_89_20 then
					var_89_20:EnableDynamicBone(false)
				end

				arg_86_1:ShowWeapon(var_89_19.transform, false)

				arg_86_1.var_[var_89_17 .. "Animator"] = var_89_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_86_1.var_[var_89_17 .. "Animator"].applyRootMotion = true
				arg_86_1.var_[var_89_17 .. "LipSync"] = var_89_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_89_21 = arg_86_1.actors_["10103ui_story"].transform

			if 3.8 < arg_86_1.time_ and arg_86_1.time_ <= 3.8 + arg_89_0 then
				arg_86_1.var_.moveOldPos10103ui_story = var_89_21.localPosition

				local var_89_22 = GameObjectTools.GetOrAddComponent(var_89_21.gameObject, typeof(DynamicBoneHelper))

				if var_89_22 then
					var_89_22:EnableDynamicBone(false)
				end
			end

			local var_89_23 = 0.001

			if 3.8 <= arg_86_1.time_ and arg_86_1.time_ < 3.8 + var_89_23 then
				var_89_21.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10103ui_story, Vector3.New(0, -0.95, -6.2), (arg_86_1.time_ - 3.8) / var_89_23)
				var_89_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_21.position).x, (manager.ui.mainCamera.transform.position - var_89_21.position).y, (manager.ui.mainCamera.transform.position - var_89_21.position).z)
				var_89_21.localEulerAngles.z = 0
				var_89_21.localEulerAngles.x = 0
				var_89_21.localEulerAngles = var_89_21.localEulerAngles
			end

			if arg_86_1.time_ >= 3.8 + var_89_23 and arg_86_1.time_ < 3.8 + var_89_23 + arg_89_0 then
				var_89_21.localPosition = Vector3.New(0, -0.95, -6.2)
				var_89_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_21.position).x, (manager.ui.mainCamera.transform.position - var_89_21.position).y, (manager.ui.mainCamera.transform.position - var_89_21.position).z)
				var_89_21.localEulerAngles.z = 0
				var_89_21.localEulerAngles.x = 0
				var_89_21.localEulerAngles = var_89_21.localEulerAngles

				local var_89_24 = GameObjectTools.GetOrAddComponent(var_89_21.gameObject, typeof(DynamicBoneHelper))

				if var_89_24 then
					var_89_24:EnableDynamicBone(true)
				end
			end

			local var_89_25 = arg_86_1.actors_["10103ui_story"]

			if 3.8 < arg_86_1.time_ and arg_86_1.time_ <= 3.8 + arg_89_0 and not isNil(var_89_25) and arg_86_1.var_.characterEffect10103ui_story == nil then
				arg_86_1.var_.characterEffect10103ui_story = var_89_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_26 = 0.200000002980232

			if 3.8 <= arg_86_1.time_ and arg_86_1.time_ < 3.8 + var_89_26 and not isNil(var_89_25) then
				if arg_86_1.var_.characterEffect10103ui_story and not isNil(var_89_25) then
					arg_86_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 3.8 + var_89_26 and arg_86_1.time_ < 3.8 + var_89_26 + arg_89_0 and not isNil(var_89_25) and arg_86_1.var_.characterEffect10103ui_story then
				arg_86_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			if 3.8 < arg_86_1.time_ and arg_86_1.time_ <= 3.8 + arg_89_0 then
				arg_86_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			if 3.8 < arg_86_1.time_ and arg_86_1.time_ <= 3.8 + arg_89_0 then
				arg_86_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0.166666666666667 < arg_86_1.time_ and arg_86_1.time_ <= 0.166666666666667 + arg_89_0 then
				arg_86_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if 1.53333333333333 < arg_86_1.time_ and arg_86_1.time_ <= 1.53333333333333 + arg_89_0 then
				arg_86_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			if 1.53333333333333 < arg_86_1.time_ and arg_86_1.time_ <= 1.53333333333333 + arg_89_0 then
				arg_86_1:AudioAction("play", "music", "bgm_activity_4_5_story_serious", "story", "bgm_activity_4_5_story_serious.awb")

				local var_89_32 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "story")

				if "" ~= "" then
					if arg_86_1.bgmTxt_.text ~= var_89_32 and arg_86_1.bgmTxt_.text ~= "" then
						if arg_86_1.bgmTxt2_.text ~= "" then
							arg_86_1.bgmTxt_.text = arg_86_1.bgmTxt2_.text
						end

						arg_86_1.bgmTxt2_.text = var_89_32

						arg_86_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_86_1.bgmTxt_.text = var_89_32
						arg_86_1.bgmTxt2_.text = var_89_32
					end

					if arg_86_1.bgmTimer then
						arg_86_1.bgmTimer:Stop()

						arg_86_1.bgmTimer = nil
					end

					if arg_86_1.settingData.show_music_name == 1 then
						arg_86_1.musicController:SetSelectedState("show")
						arg_86_1.musicAnimator_:Play("open", 0, 0)

						if arg_86_1.settingData.music_time ~= 0 then
							arg_86_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_86_1.settingData.music_time), function()
								if arg_86_1 == nil or isNil(arg_86_1.bgmTxt_) then
									return
								end

								arg_86_1.musicController:SetSelectedState("hide")
								arg_86_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 3.8 < arg_86_1.time_ and arg_86_1.time_ <= 3.8 + arg_89_0 then
				if not isNil(arg_86_1.actors_["10103ui_story"]) then
					local var_89_33 = GameObjectTools.GetOrAddComponent(arg_86_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_89_33 then
						var_89_33:EnableDynamicBone(true)
					end
				end
			end

			if arg_86_1.frameCnt_ <= 1 then
				arg_86_1.dialog_:SetActive(false)
			end

			local var_89_34 = 4
			local var_89_35 = 0.325

			if 4 < arg_86_1.time_ and arg_86_1.time_ <= var_89_34 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0

				arg_86_1.dialog_:SetActive(true)

				arg_86_1.dialogCg_.alpha = 0

				local var_89_36 = LeanTween.value(arg_86_1.dialog_, 0, 1, 0.3)

				var_89_36:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_86_1.dialogCg_.alpha = arg_91_0
				end))
				var_89_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_86_1.dialog_)
					var_89_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_86_1.duration_ = arg_86_1.duration_ + 0.3

				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_37 = arg_86_1:GetWordFromCfg(322121021)
				local var_89_38 = arg_86_1:FormatText(var_89_37.content)

				arg_86_1.text_.text = var_89_38

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_40 = 13 <= 0 and var_89_35 or var_89_35 * (utf8.len(var_89_38) / 13)

				if (13 <= 0 and var_89_35 or var_89_35 * (utf8.len(var_89_38) / 13)) > 0 and var_89_35 < var_89_40 then
					arg_86_1.talkMaxDuration = var_89_40
					var_89_34 = var_89_34 + 0.3

					if var_89_40 + var_89_34 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_40 + var_89_34
					end
				end

				arg_86_1.text_.text = var_89_38
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121021", "story_v_out_322121.awb") ~= 0 then
					local var_89_41 = manager.audio:GetVoiceLength("story_v_out_322121", "322121021", "story_v_out_322121.awb") / 1000

					if var_89_41 + var_89_34 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_41 + var_89_34
					end

					if var_89_37.prefab_name ~= "" and arg_86_1.actors_[var_89_37.prefab_name] ~= nil then
						local var_89_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_37.prefab_name].transform, "story_v_out_322121", "322121021", "story_v_out_322121.awb")

						arg_86_1:RecordAudio("322121021", var_89_42)
						arg_86_1:RecordAudio("322121021", var_89_42)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_322121", "322121021", "story_v_out_322121.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_322121", "322121021", "story_v_out_322121.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_43 = var_89_34 + 0.3
			local var_89_44 = math.max(var_89_35, arg_86_1.talkMaxDuration)

			if var_89_34 + 0.3 <= arg_86_1.time_ and arg_86_1.time_ < var_89_43 + var_89_44 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_43) / var_89_44

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_43 + var_89_44 and arg_86_1.time_ < var_89_43 + var_89_44 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play322121022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 322121022
		arg_93_1.duration_ = 13.2

		local var_93_0 = {
			zh = 9.4,
			ja = 13.2
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
				arg_93_0:Play322121023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if arg_93_1.actors_["10130ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10130ui_story"))) then
				local var_96_0 = Object.Instantiate(Asset.Load("Char/" .. "10130ui_story"), arg_93_1.stage_.transform)

				var_96_0.name = "10130ui_story"
				var_96_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.actors_["10130ui_story"] = var_96_0

				local var_96_1 = var_96_0:GetComponentInChildren(typeof(CharacterEffect))

				var_96_1.enabled = true

				local var_96_2 = GameObjectTools.GetOrAddComponent(var_96_0, typeof(DynamicBoneHelper))

				if var_96_2 then
					var_96_2:EnableDynamicBone(false)
				end

				arg_93_1:ShowWeapon(var_96_1.transform, false)

				arg_93_1.var_["10130ui_story" .. "Animator"] = var_96_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_93_1.var_["10130ui_story" .. "Animator"].applyRootMotion = true
				arg_93_1.var_["10130ui_story" .. "LipSync"] = var_96_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_96_3 = arg_93_1.actors_["10130ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10130ui_story = var_96_3.localPosition
			end

			local var_96_4 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				var_96_3.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10130ui_story, Vector3.New(0.77, -1.02, -5.81), (arg_93_1.time_ - 0) / var_96_4)
				var_96_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_3.position).x, (manager.ui.mainCamera.transform.position - var_96_3.position).y, (manager.ui.mainCamera.transform.position - var_96_3.position).z)
				var_96_3.localEulerAngles.z = 0
				var_96_3.localEulerAngles.x = 0
				var_96_3.localEulerAngles = var_96_3.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				var_96_3.localPosition = Vector3.New(0.77, -1.02, -5.81)
				var_96_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_3.position).x, (manager.ui.mainCamera.transform.position - var_96_3.position).y, (manager.ui.mainCamera.transform.position - var_96_3.position).z)
				var_96_3.localEulerAngles.z = 0
				var_96_3.localEulerAngles.x = 0
				var_96_3.localEulerAngles = var_96_3.localEulerAngles
			end

			local var_96_5 = arg_93_1.actors_["10103ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10103ui_story = var_96_5.localPosition

				local var_96_6 = GameObjectTools.GetOrAddComponent(var_96_5.gameObject, typeof(DynamicBoneHelper))

				if var_96_6 then
					var_96_6:EnableDynamicBone(false)
				end
			end

			local var_96_7 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				var_96_5.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10103ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_93_1.time_ - 0) / var_96_7)
				var_96_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_5.position).x, (manager.ui.mainCamera.transform.position - var_96_5.position).y, (manager.ui.mainCamera.transform.position - var_96_5.position).z)
				var_96_5.localEulerAngles.z = 0
				var_96_5.localEulerAngles.x = 0
				var_96_5.localEulerAngles = var_96_5.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				var_96_5.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				var_96_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_5.position).x, (manager.ui.mainCamera.transform.position - var_96_5.position).y, (manager.ui.mainCamera.transform.position - var_96_5.position).z)
				var_96_5.localEulerAngles.z = 0
				var_96_5.localEulerAngles.x = 0
				var_96_5.localEulerAngles = var_96_5.localEulerAngles

				local var_96_8 = GameObjectTools.GetOrAddComponent(var_96_5.gameObject, typeof(DynamicBoneHelper))

				if var_96_8 then
					var_96_8:EnableDynamicBone(true)
				end
			end

			local var_96_9 = arg_93_1.actors_["10130ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect10130ui_story == nil then
				arg_93_1.var_.characterEffect10130ui_story = var_96_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_10 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_10 and not isNil(var_96_9) then
				if arg_93_1.var_.characterEffect10130ui_story and not isNil(var_96_9) then
					arg_93_1.var_.characterEffect10130ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_10 and arg_93_1.time_ < 0 + var_96_10 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect10130ui_story then
				arg_93_1.var_.characterEffect10130ui_story.fillFlat = false
			end

			local var_96_12 = arg_93_1.actors_["10103ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_12) and arg_93_1.var_.characterEffect10103ui_story == nil then
				arg_93_1.var_.characterEffect10103ui_story = var_96_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_13 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_13 and not isNil(var_96_12) then
				if arg_93_1.var_.characterEffect10103ui_story and not isNil(var_96_12) then
					arg_93_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_13)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_13 and arg_93_1.time_ < 0 + var_96_13 + arg_96_0 and not isNil(var_96_12) and arg_93_1.var_.characterEffect10103ui_story then
				arg_93_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/story10130/story10130action/10130action1_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				if not isNil(arg_93_1.actors_["10103ui_story"]) then
					local var_96_14 = GameObjectTools.GetOrAddComponent(arg_93_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_96_14 then
						var_96_14:EnableDynamicBone(true)
					end
				end
			end

			local var_96_15 = 0
			local var_96_16 = 0.625

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_17 = arg_93_1:GetWordFromCfg(322121022)
				local var_96_18 = arg_93_1:FormatText(var_96_17.content)

				arg_93_1.text_.text = var_96_18

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_20 = 25 <= 0 and var_96_16 or var_96_16 * (utf8.len(var_96_18) / 25)

				if (25 <= 0 and var_96_16 or var_96_16 * (utf8.len(var_96_18) / 25)) > 0 and var_96_16 < var_96_20 then
					arg_93_1.talkMaxDuration = var_96_20

					if var_96_20 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_20 + var_96_15
					end
				end

				arg_93_1.text_.text = var_96_18
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121022", "story_v_out_322121.awb") ~= 0 then
					local var_96_21 = manager.audio:GetVoiceLength("story_v_out_322121", "322121022", "story_v_out_322121.awb") / 1000

					if var_96_21 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_21 + var_96_15
					end

					if var_96_17.prefab_name ~= "" and arg_93_1.actors_[var_96_17.prefab_name] ~= nil then
						local var_96_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_17.prefab_name].transform, "story_v_out_322121", "322121022", "story_v_out_322121.awb")

						arg_93_1:RecordAudio("322121022", var_96_22)
						arg_93_1:RecordAudio("322121022", var_96_22)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_322121", "322121022", "story_v_out_322121.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_322121", "322121022", "story_v_out_322121.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_23 = math.max(var_96_16, arg_93_1.talkMaxDuration)

			if var_96_15 <= arg_93_1.time_ and arg_93_1.time_ < var_96_15 + var_96_23 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_15) / var_96_23

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_15 + var_96_23 and arg_93_1.time_ < var_96_15 + var_96_23 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play322121023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 322121023
		arg_97_1.duration_ = 10.17

		local var_97_0 = {
			zh = 9.1,
			ja = 10.166
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
				arg_97_0:Play322121024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10103ui_story = arg_97_1.actors_["10103ui_story"].transform.localPosition

				local var_100_0 = GameObjectTools.GetOrAddComponent(arg_97_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_100_0 then
					var_100_0:EnableDynamicBone(false)
				end
			end

			local var_100_1 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 then
				arg_97_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10103ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_97_1.time_ - 0) / var_100_1)
				arg_97_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10103ui_story"].transform.position).z)
				arg_97_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10103ui_story"].transform.localEulerAngles = arg_97_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 then
				arg_97_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				arg_97_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10103ui_story"].transform.position).z)
				arg_97_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10103ui_story"].transform.localEulerAngles = arg_97_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_100_2 = GameObjectTools.GetOrAddComponent(arg_97_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_100_2 then
					var_100_2:EnableDynamicBone(true)
				end
			end

			local var_100_3 = arg_97_1.actors_["10103ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_3) and arg_97_1.var_.characterEffect10103ui_story == nil then
				arg_97_1.var_.characterEffect10103ui_story = var_100_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_4 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 and not isNil(var_100_3) then
				if arg_97_1.var_.characterEffect10103ui_story and not isNil(var_100_3) then
					arg_97_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 and not isNil(var_100_3) and arg_97_1.var_.characterEffect10103ui_story then
				arg_97_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_100_6 = arg_97_1.actors_["10130ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_6) and arg_97_1.var_.characterEffect10130ui_story == nil then
				arg_97_1.var_.characterEffect10130ui_story = var_100_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_7 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 and not isNil(var_100_6) then
				if arg_97_1.var_.characterEffect10130ui_story and not isNil(var_100_6) then
					arg_97_1.var_.characterEffect10130ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10130ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_7)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 and not isNil(var_100_6) and arg_97_1.var_.characterEffect10130ui_story then
				arg_97_1.var_.characterEffect10130ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10130ui_story.fillRatio = 0.5
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				if not isNil(arg_97_1.actors_["10103ui_story"]) then
					local var_100_8 = GameObjectTools.GetOrAddComponent(arg_97_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_100_8 then
						var_100_8:EnableDynamicBone(true)
					end
				end
			end

			local var_100_9 = 0
			local var_100_10 = 1.05

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_11 = arg_97_1:GetWordFromCfg(322121023)
				local var_100_12 = arg_97_1:FormatText(var_100_11.content)

				arg_97_1.text_.text = var_100_12

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_14 = 42 <= 0 and var_100_10 or var_100_10 * (utf8.len(var_100_12) / 42)

				if (42 <= 0 and var_100_10 or var_100_10 * (utf8.len(var_100_12) / 42)) > 0 and var_100_10 < var_100_14 then
					arg_97_1.talkMaxDuration = var_100_14

					if var_100_14 + var_100_9 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_9
					end
				end

				arg_97_1.text_.text = var_100_12
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121023", "story_v_out_322121.awb") ~= 0 then
					local var_100_15 = manager.audio:GetVoiceLength("story_v_out_322121", "322121023", "story_v_out_322121.awb") / 1000

					if var_100_15 + var_100_9 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_15 + var_100_9
					end

					if var_100_11.prefab_name ~= "" and arg_97_1.actors_[var_100_11.prefab_name] ~= nil then
						local var_100_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_11.prefab_name].transform, "story_v_out_322121", "322121023", "story_v_out_322121.awb")

						arg_97_1:RecordAudio("322121023", var_100_16)
						arg_97_1:RecordAudio("322121023", var_100_16)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_322121", "322121023", "story_v_out_322121.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_322121", "322121023", "story_v_out_322121.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_17 = math.max(var_100_10, arg_97_1.talkMaxDuration)

			if var_100_9 <= arg_97_1.time_ and arg_97_1.time_ < var_100_9 + var_100_17 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_9) / var_100_17

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_9 + var_100_17 and arg_97_1.time_ < var_100_9 + var_100_17 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play322121024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 322121024
		arg_101_1.duration_ = 15.23

		local var_101_0 = {
			zh = 12.066,
			ja = 15.233
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
				arg_101_0:Play322121025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 1.3

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:GetWordFromCfg(322121024)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 52 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 52)

				if (52 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 52)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121024", "story_v_out_322121.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_322121", "322121024", "story_v_out_322121.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_322121", "322121024", "story_v_out_322121.awb")

						arg_101_1:RecordAudio("322121024", var_104_6)
						arg_101_1:RecordAudio("322121024", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_322121", "322121024", "story_v_out_322121.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_322121", "322121024", "story_v_out_322121.awb")
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
	Play322121025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 322121025
		arg_105_1.duration_ = 15.73

		local var_105_0 = {
			zh = 10.766,
			ja = 15.733
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play322121026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10103ui_story = arg_105_1.actors_["10103ui_story"].transform.localPosition

				local var_108_0 = GameObjectTools.GetOrAddComponent(arg_105_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_108_0 then
					var_108_0:EnableDynamicBone(false)
				end
			end

			local var_108_1 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 then
				arg_105_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10103ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_105_1.time_ - 0) / var_108_1)
				arg_105_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10103ui_story"].transform.position).z)
				arg_105_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10103ui_story"].transform.localEulerAngles = arg_105_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 then
				arg_105_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				arg_105_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10103ui_story"].transform.position).z)
				arg_105_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10103ui_story"].transform.localEulerAngles = arg_105_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_108_2 = GameObjectTools.GetOrAddComponent(arg_105_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_108_2 then
					var_108_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_2")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				if not isNil(arg_105_1.actors_["10103ui_story"]) then
					local var_108_3 = GameObjectTools.GetOrAddComponent(arg_105_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_108_3 then
						var_108_3:EnableDynamicBone(true)
					end
				end
			end

			local var_108_4 = 0
			local var_108_5 = 1.125

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:GetWordFromCfg(322121025)
				local var_108_7 = arg_105_1:FormatText(var_108_6.content)

				arg_105_1.text_.text = var_108_7

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_9 = 45 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 45)

				if (45 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 45)) > 0 and var_108_5 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_7
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121025", "story_v_out_322121.awb") ~= 0 then
					local var_108_10 = manager.audio:GetVoiceLength("story_v_out_322121", "322121025", "story_v_out_322121.awb") / 1000

					if var_108_10 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_4
					end

					if var_108_6.prefab_name ~= "" and arg_105_1.actors_[var_108_6.prefab_name] ~= nil then
						local var_108_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_6.prefab_name].transform, "story_v_out_322121", "322121025", "story_v_out_322121.awb")

						arg_105_1:RecordAudio("322121025", var_108_11)
						arg_105_1:RecordAudio("322121025", var_108_11)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_322121", "322121025", "story_v_out_322121.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_322121", "322121025", "story_v_out_322121.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_12 = math.max(var_108_5, arg_105_1.talkMaxDuration)

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_12 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_4) / var_108_12

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_4 + var_108_12 and arg_105_1.time_ < var_108_4 + var_108_12 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play322121026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 322121026
		arg_109_1.duration_ = 7.33

		local var_109_0 = {
			zh = 6.733,
			ja = 7.333
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
				arg_109_0:Play322121027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.575

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:GetWordFromCfg(322121026)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 23 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 23)

				if (23 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 23)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121026", "story_v_out_322121.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_322121", "322121026", "story_v_out_322121.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_322121", "322121026", "story_v_out_322121.awb")

						arg_109_1:RecordAudio("322121026", var_112_6)
						arg_109_1:RecordAudio("322121026", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_322121", "322121026", "story_v_out_322121.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_322121", "322121026", "story_v_out_322121.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play322121027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 322121027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play322121028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10103ui_story = arg_113_1.actors_["10103ui_story"].transform.localPosition

				local var_116_0 = GameObjectTools.GetOrAddComponent(arg_113_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_116_0 then
					var_116_0:EnableDynamicBone(false)
				end
			end

			local var_116_1 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_1 then
				arg_113_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10103ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_1)
				arg_113_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10103ui_story"].transform.position).z)
				arg_113_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10103ui_story"].transform.localEulerAngles = arg_113_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_1 and arg_113_1.time_ < 0 + var_116_1 + arg_116_0 then
				arg_113_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10103ui_story"].transform.position).z)
				arg_113_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10103ui_story"].transform.localEulerAngles = arg_113_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_116_2 = GameObjectTools.GetOrAddComponent(arg_113_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_116_2 then
					var_116_2:EnableDynamicBone(true)
				end
			end

			local var_116_3 = arg_113_1.actors_["10130ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10130ui_story = var_116_3.localPosition
			end

			local var_116_4 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				var_116_3.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10130ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_4)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				var_116_3.localPosition = Vector3.New(0, 100, 0)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles
			end

			local var_116_5 = 0
			local var_116_6 = 1.2

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_7 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(322121027).content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 48 <= 0 and var_116_6 or var_116_6 * (utf8.len(var_116_7) / 48)

				if (48 <= 0 and var_116_6 or var_116_6 * (utf8.len(var_116_7) / 48)) > 0 and var_116_6 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_5 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_5
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_10 = math.max(var_116_6, arg_113_1.talkMaxDuration)

			if var_116_5 <= arg_113_1.time_ and arg_113_1.time_ < var_116_5 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_5) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_5 + var_116_10 and arg_113_1.time_ < var_116_5 + var_116_10 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play322121028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 322121028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play322121029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 1.75

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(322121028).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 70 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 70)

				if (70 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 70)) > 0 and var_120_0 < var_120_3 then
					arg_117_1.talkMaxDuration = var_120_3

					if var_120_3 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_3 + 0
					end
				end

				arg_117_1.text_.text = var_120_1
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_4 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_4

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play322121029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 322121029
		arg_121_1.duration_ = 8.87

		local var_121_0 = {
			zh = 4.8,
			ja = 8.866
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
				arg_121_0:Play322121030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if arg_121_1.actors_["4037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4037ui_story"))) then
				local var_124_0 = Object.Instantiate(Asset.Load("Char/" .. "4037ui_story"), arg_121_1.stage_.transform)

				var_124_0.name = "4037ui_story"
				var_124_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.actors_["4037ui_story"] = var_124_0

				local var_124_1 = var_124_0:GetComponentInChildren(typeof(CharacterEffect))

				var_124_1.enabled = true

				local var_124_2 = GameObjectTools.GetOrAddComponent(var_124_0, typeof(DynamicBoneHelper))

				if var_124_2 then
					var_124_2:EnableDynamicBone(false)
				end

				arg_121_1:ShowWeapon(var_124_1.transform, false)

				arg_121_1.var_["4037ui_story" .. "Animator"] = var_124_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_121_1.var_["4037ui_story" .. "Animator"].applyRootMotion = true
				arg_121_1.var_["4037ui_story" .. "LipSync"] = var_124_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_124_3 = arg_121_1.actors_["4037ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos4037ui_story = var_124_3.localPosition
			end

			local var_124_4 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				var_124_3.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos4037ui_story, Vector3.New(-0.7, -1.12, -6.2), (arg_121_1.time_ - 0) / var_124_4)
				var_124_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_3.position).x, (manager.ui.mainCamera.transform.position - var_124_3.position).y, (manager.ui.mainCamera.transform.position - var_124_3.position).z)
				var_124_3.localEulerAngles.z = 0
				var_124_3.localEulerAngles.x = 0
				var_124_3.localEulerAngles = var_124_3.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				var_124_3.localPosition = Vector3.New(-0.7, -1.12, -6.2)
				var_124_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_3.position).x, (manager.ui.mainCamera.transform.position - var_124_3.position).y, (manager.ui.mainCamera.transform.position - var_124_3.position).z)
				var_124_3.localEulerAngles.z = 0
				var_124_3.localEulerAngles.x = 0
				var_124_3.localEulerAngles = var_124_3.localEulerAngles
			end

			local var_124_5 = arg_121_1.actors_["4037ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.characterEffect4037ui_story == nil then
				arg_121_1.var_.characterEffect4037ui_story = var_124_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_6 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_6 and not isNil(var_124_5) then
				if arg_121_1.var_.characterEffect4037ui_story and not isNil(var_124_5) then
					arg_121_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_6 and arg_121_1.time_ < 0 + var_124_6 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.characterEffect4037ui_story then
				arg_121_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_124_8 = 0
			local var_124_9 = 0.6

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_10 = arg_121_1:GetWordFromCfg(322121029)
				local var_124_11 = arg_121_1:FormatText(var_124_10.content)

				arg_121_1.text_.text = var_124_11

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_13 = 24 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 24)

				if (24 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 24)) > 0 and var_124_9 < var_124_13 then
					arg_121_1.talkMaxDuration = var_124_13

					if var_124_13 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_8
					end
				end

				arg_121_1.text_.text = var_124_11
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121029", "story_v_out_322121.awb") ~= 0 then
					local var_124_14 = manager.audio:GetVoiceLength("story_v_out_322121", "322121029", "story_v_out_322121.awb") / 1000

					if var_124_14 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_14 + var_124_8
					end

					if var_124_10.prefab_name ~= "" and arg_121_1.actors_[var_124_10.prefab_name] ~= nil then
						local var_124_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_10.prefab_name].transform, "story_v_out_322121", "322121029", "story_v_out_322121.awb")

						arg_121_1:RecordAudio("322121029", var_124_15)
						arg_121_1:RecordAudio("322121029", var_124_15)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_322121", "322121029", "story_v_out_322121.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_322121", "322121029", "story_v_out_322121.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_16 = math.max(var_124_9, arg_121_1.talkMaxDuration)

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_16 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_8) / var_124_16

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_8 + var_124_16 and arg_121_1.time_ < var_124_8 + var_124_16 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play322121030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 322121030
		arg_125_1.duration_ = 5.3

		local var_125_0 = {
			zh = 2.8,
			ja = 5.3
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
				arg_125_0:Play322121031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10103ui_story = arg_125_1.actors_["10103ui_story"].transform.localPosition

				local var_128_0 = GameObjectTools.GetOrAddComponent(arg_125_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_128_0 then
					var_128_0:EnableDynamicBone(false)
				end
			end

			local var_128_1 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_1 then
				arg_125_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10103ui_story, Vector3.New(0.7, -0.95, -6.2), (arg_125_1.time_ - 0) / var_128_1)
				arg_125_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10103ui_story"].transform.position).z)
				arg_125_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["10103ui_story"].transform.localEulerAngles = arg_125_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_1 and arg_125_1.time_ < 0 + var_128_1 + arg_128_0 then
				arg_125_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.2)
				arg_125_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10103ui_story"].transform.position).z)
				arg_125_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["10103ui_story"].transform.localEulerAngles = arg_125_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_128_2 = GameObjectTools.GetOrAddComponent(arg_125_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_128_2 then
					var_128_2:EnableDynamicBone(true)
				end
			end

			local var_128_3 = arg_125_1.actors_["10103ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_3) and arg_125_1.var_.characterEffect10103ui_story == nil then
				arg_125_1.var_.characterEffect10103ui_story = var_128_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_4 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 and not isNil(var_128_3) then
				if arg_125_1.var_.characterEffect10103ui_story and not isNil(var_128_3) then
					arg_125_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 and not isNil(var_128_3) and arg_125_1.var_.characterEffect10103ui_story then
				arg_125_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_128_6 = arg_125_1.actors_["4037ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect4037ui_story == nil then
				arg_125_1.var_.characterEffect4037ui_story = var_128_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_7 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 and not isNil(var_128_6) then
				if arg_125_1.var_.characterEffect4037ui_story and not isNil(var_128_6) then
					arg_125_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_125_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_7)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 and not isNil(var_128_6) and arg_125_1.var_.characterEffect4037ui_story then
				arg_125_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_125_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				if not isNil(arg_125_1.actors_["10103ui_story"]) then
					local var_128_8 = GameObjectTools.GetOrAddComponent(arg_125_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_128_8 then
						var_128_8:EnableDynamicBone(true)
					end
				end
			end

			local var_128_9 = 0
			local var_128_10 = 0.2

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_9 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_11 = arg_125_1:GetWordFromCfg(322121030)
				local var_128_12 = arg_125_1:FormatText(var_128_11.content)

				arg_125_1.text_.text = var_128_12

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_14 = 8 <= 0 and var_128_10 or var_128_10 * (utf8.len(var_128_12) / 8)

				if (8 <= 0 and var_128_10 or var_128_10 * (utf8.len(var_128_12) / 8)) > 0 and var_128_10 < var_128_14 then
					arg_125_1.talkMaxDuration = var_128_14

					if var_128_14 + var_128_9 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_14 + var_128_9
					end
				end

				arg_125_1.text_.text = var_128_12
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121030", "story_v_out_322121.awb") ~= 0 then
					local var_128_15 = manager.audio:GetVoiceLength("story_v_out_322121", "322121030", "story_v_out_322121.awb") / 1000

					if var_128_15 + var_128_9 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_15 + var_128_9
					end

					if var_128_11.prefab_name ~= "" and arg_125_1.actors_[var_128_11.prefab_name] ~= nil then
						local var_128_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_11.prefab_name].transform, "story_v_out_322121", "322121030", "story_v_out_322121.awb")

						arg_125_1:RecordAudio("322121030", var_128_16)
						arg_125_1:RecordAudio("322121030", var_128_16)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_322121", "322121030", "story_v_out_322121.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_322121", "322121030", "story_v_out_322121.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_17 = math.max(var_128_10, arg_125_1.talkMaxDuration)

			if var_128_9 <= arg_125_1.time_ and arg_125_1.time_ < var_128_9 + var_128_17 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_9) / var_128_17

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_9 + var_128_17 and arg_125_1.time_ < var_128_9 + var_128_17 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play322121031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 322121031
		arg_129_1.duration_ = 8.53

		local var_129_0 = {
			zh = 6.033,
			ja = 8.533
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
				arg_129_0:Play322121032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos4037ui_story = arg_129_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos4037ui_story, Vector3.New(-0.7, -1.12, -6.2), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["4037ui_story"].transform.position).z)
				arg_129_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["4037ui_story"].transform.localEulerAngles = arg_129_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(-0.7, -1.12, -6.2)
				arg_129_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["4037ui_story"].transform.position).z)
				arg_129_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["4037ui_story"].transform.localEulerAngles = arg_129_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["4037ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect4037ui_story == nil then
				arg_129_1.var_.characterEffect4037ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect4037ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect4037ui_story then
				arg_129_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_132_4 = arg_129_1.actors_["10103ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_4) and arg_129_1.var_.characterEffect10103ui_story == nil then
				arg_129_1.var_.characterEffect10103ui_story = var_132_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_5 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_5 and not isNil(var_132_4) then
				if arg_129_1.var_.characterEffect10103ui_story and not isNil(var_132_4) then
					arg_129_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_5)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_5 and arg_129_1.time_ < 0 + var_132_5 + arg_132_0 and not isNil(var_132_4) and arg_129_1.var_.characterEffect10103ui_story then
				arg_129_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_2")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				if not isNil(arg_129_1.actors_["10103ui_story"]) then
					local var_132_6 = GameObjectTools.GetOrAddComponent(arg_129_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_132_6 then
						var_132_6:EnableDynamicBone(true)
					end
				end
			end

			local var_132_7 = 0
			local var_132_8 = 0.625

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_7 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_9 = arg_129_1:GetWordFromCfg(322121031)
				local var_132_10 = arg_129_1:FormatText(var_132_9.content)

				arg_129_1.text_.text = var_132_10

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_12 = 25 <= 0 and var_132_8 or var_132_8 * (utf8.len(var_132_10) / 25)

				if (25 <= 0 and var_132_8 or var_132_8 * (utf8.len(var_132_10) / 25)) > 0 and var_132_8 < var_132_12 then
					arg_129_1.talkMaxDuration = var_132_12

					if var_132_12 + var_132_7 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_12 + var_132_7
					end
				end

				arg_129_1.text_.text = var_132_10
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121031", "story_v_out_322121.awb") ~= 0 then
					local var_132_13 = manager.audio:GetVoiceLength("story_v_out_322121", "322121031", "story_v_out_322121.awb") / 1000

					if var_132_13 + var_132_7 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_13 + var_132_7
					end

					if var_132_9.prefab_name ~= "" and arg_129_1.actors_[var_132_9.prefab_name] ~= nil then
						local var_132_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_9.prefab_name].transform, "story_v_out_322121", "322121031", "story_v_out_322121.awb")

						arg_129_1:RecordAudio("322121031", var_132_14)
						arg_129_1:RecordAudio("322121031", var_132_14)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_322121", "322121031", "story_v_out_322121.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_322121", "322121031", "story_v_out_322121.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_15 = math.max(var_132_8, arg_129_1.talkMaxDuration)

			if var_132_7 <= arg_129_1.time_ and arg_129_1.time_ < var_132_7 + var_132_15 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_7) / var_132_15

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_7 + var_132_15 and arg_129_1.time_ < var_132_7 + var_132_15 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play322121032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 322121032
		arg_133_1.duration_ = 3.5

		local var_133_0 = {
			zh = 1.999999999999,
			ja = 3.5
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
				arg_133_0:Play322121033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10130ui_story = arg_133_1.actors_["10130ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["10130ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10130ui_story, Vector3.New(0.77, -1.02, -5.81), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["10130ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["10130ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10130ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10130ui_story"].transform.position).z)
				arg_133_1.actors_["10130ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["10130ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["10130ui_story"].transform.localEulerAngles = arg_133_1.actors_["10130ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["10130ui_story"].transform.localPosition = Vector3.New(0.77, -1.02, -5.81)
				arg_133_1.actors_["10130ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["10130ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10130ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10130ui_story"].transform.position).z)
				arg_133_1.actors_["10130ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["10130ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["10130ui_story"].transform.localEulerAngles = arg_133_1.actors_["10130ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["10103ui_story"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10103ui_story = var_136_1.localPosition

				local var_136_2 = GameObjectTools.GetOrAddComponent(var_136_1.gameObject, typeof(DynamicBoneHelper))

				if var_136_2 then
					var_136_2:EnableDynamicBone(false)
				end
			end

			local var_136_3 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_3 then
				var_136_1.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10103ui_story, Vector3.New(0, 100, 0), (arg_133_1.time_ - 0) / var_136_3)
				var_136_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_1.position).x, (manager.ui.mainCamera.transform.position - var_136_1.position).y, (manager.ui.mainCamera.transform.position - var_136_1.position).z)
				var_136_1.localEulerAngles.z = 0
				var_136_1.localEulerAngles.x = 0
				var_136_1.localEulerAngles = var_136_1.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_3 and arg_133_1.time_ < 0 + var_136_3 + arg_136_0 then
				var_136_1.localPosition = Vector3.New(0, 100, 0)
				var_136_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_1.position).x, (manager.ui.mainCamera.transform.position - var_136_1.position).y, (manager.ui.mainCamera.transform.position - var_136_1.position).z)
				var_136_1.localEulerAngles.z = 0
				var_136_1.localEulerAngles.x = 0
				var_136_1.localEulerAngles = var_136_1.localEulerAngles

				local var_136_4 = GameObjectTools.GetOrAddComponent(var_136_1.gameObject, typeof(DynamicBoneHelper))

				if var_136_4 then
					var_136_4:EnableDynamicBone(true)
				end
			end

			local var_136_5 = arg_133_1.actors_["10130ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_5) and arg_133_1.var_.characterEffect10130ui_story == nil then
				arg_133_1.var_.characterEffect10130ui_story = var_136_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_6 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_6 and not isNil(var_136_5) then
				if arg_133_1.var_.characterEffect10130ui_story and not isNil(var_136_5) then
					arg_133_1.var_.characterEffect10130ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_6 and arg_133_1.time_ < 0 + var_136_6 + arg_136_0 and not isNil(var_136_5) and arg_133_1.var_.characterEffect10130ui_story then
				arg_133_1.var_.characterEffect10130ui_story.fillFlat = false
			end

			local var_136_8 = arg_133_1.actors_["4037ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_8) and arg_133_1.var_.characterEffect4037ui_story == nil then
				arg_133_1.var_.characterEffect4037ui_story = var_136_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_9 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_9 and not isNil(var_136_8) then
				if arg_133_1.var_.characterEffect4037ui_story and not isNil(var_136_8) then
					arg_133_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_133_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_9)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_9 and arg_133_1.time_ < 0 + var_136_9 + arg_136_0 and not isNil(var_136_8) and arg_133_1.var_.characterEffect4037ui_story then
				arg_133_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_133_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/story10130/story10130action/10130action1_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_136_10 = 0
			local var_136_11 = 0.075

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_12 = arg_133_1:GetWordFromCfg(322121032)
				local var_136_13 = arg_133_1:FormatText(var_136_12.content)

				arg_133_1.text_.text = var_136_13

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_15 = 3 <= 0 and var_136_11 or var_136_11 * (utf8.len(var_136_13) / 3)

				if (3 <= 0 and var_136_11 or var_136_11 * (utf8.len(var_136_13) / 3)) > 0 and var_136_11 < var_136_15 then
					arg_133_1.talkMaxDuration = var_136_15

					if var_136_15 + var_136_10 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_15 + var_136_10
					end
				end

				arg_133_1.text_.text = var_136_13
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121032", "story_v_out_322121.awb") ~= 0 then
					local var_136_16 = manager.audio:GetVoiceLength("story_v_out_322121", "322121032", "story_v_out_322121.awb") / 1000

					if var_136_16 + var_136_10 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_16 + var_136_10
					end

					if var_136_12.prefab_name ~= "" and arg_133_1.actors_[var_136_12.prefab_name] ~= nil then
						local var_136_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_12.prefab_name].transform, "story_v_out_322121", "322121032", "story_v_out_322121.awb")

						arg_133_1:RecordAudio("322121032", var_136_17)
						arg_133_1:RecordAudio("322121032", var_136_17)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_322121", "322121032", "story_v_out_322121.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_322121", "322121032", "story_v_out_322121.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_18 = math.max(var_136_11, arg_133_1.talkMaxDuration)

			if var_136_10 <= arg_133_1.time_ and arg_133_1.time_ < var_136_10 + var_136_18 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_10) / var_136_18

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_10 + var_136_18 and arg_133_1.time_ < var_136_10 + var_136_18 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play322121033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 322121033
		arg_137_1.duration_ = 10.8

		local var_137_0 = {
			zh = 6.033,
			ja = 10.8
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
				arg_137_0:Play322121034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["4037ui_story"]) and arg_137_1.var_.characterEffect4037ui_story == nil then
				arg_137_1.var_.characterEffect4037ui_story = arg_137_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["4037ui_story"]) then
				if arg_137_1.var_.characterEffect4037ui_story and not isNil(arg_137_1.actors_["4037ui_story"]) then
					arg_137_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["4037ui_story"]) and arg_137_1.var_.characterEffect4037ui_story then
				arg_137_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_140_2 = arg_137_1.actors_["10130ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.characterEffect10130ui_story == nil then
				arg_137_1.var_.characterEffect10130ui_story = var_140_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_3 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_3 and not isNil(var_140_2) then
				if arg_137_1.var_.characterEffect10130ui_story and not isNil(var_140_2) then
					arg_137_1.var_.characterEffect10130ui_story.fillFlat = true
					arg_137_1.var_.characterEffect10130ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_3)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_3 and arg_137_1.time_ < 0 + var_140_3 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.characterEffect10130ui_story then
				arg_137_1.var_.characterEffect10130ui_story.fillFlat = true
				arg_137_1.var_.characterEffect10130ui_story.fillRatio = 0.5
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_140_4 = 0
			local var_140_5 = 0.675

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_6 = arg_137_1:GetWordFromCfg(322121033)
				local var_140_7 = arg_137_1:FormatText(var_140_6.content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 27 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 27)

				if (27 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 27)) > 0 and var_140_5 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121033", "story_v_out_322121.awb") ~= 0 then
					local var_140_10 = manager.audio:GetVoiceLength("story_v_out_322121", "322121033", "story_v_out_322121.awb") / 1000

					if var_140_10 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_4
					end

					if var_140_6.prefab_name ~= "" and arg_137_1.actors_[var_140_6.prefab_name] ~= nil then
						local var_140_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_6.prefab_name].transform, "story_v_out_322121", "322121033", "story_v_out_322121.awb")

						arg_137_1:RecordAudio("322121033", var_140_11)
						arg_137_1:RecordAudio("322121033", var_140_11)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_322121", "322121033", "story_v_out_322121.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_322121", "322121033", "story_v_out_322121.awb")
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
	Play322121034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 322121034
		arg_141_1.duration_ = 8.1

		local var_141_0 = {
			zh = 4.433,
			ja = 8.1
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
				arg_141_0:Play322121035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10130ui_story = arg_141_1.actors_["10130ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["10130ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10130ui_story, Vector3.New(0.77, -1.02, -5.81), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["10130ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["10130ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10130ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10130ui_story"].transform.position).z)
				arg_141_1.actors_["10130ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["10130ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["10130ui_story"].transform.localEulerAngles = arg_141_1.actors_["10130ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["10130ui_story"].transform.localPosition = Vector3.New(0.77, -1.02, -5.81)
				arg_141_1.actors_["10130ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["10130ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10130ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10130ui_story"].transform.position).z)
				arg_141_1.actors_["10130ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["10130ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["10130ui_story"].transform.localEulerAngles = arg_141_1.actors_["10130ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["10130ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect10130ui_story == nil then
				arg_141_1.var_.characterEffect10130ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect10130ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect10130ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect10130ui_story then
				arg_141_1.var_.characterEffect10130ui_story.fillFlat = false
			end

			local var_144_4 = arg_141_1.actors_["4037ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect4037ui_story == nil then
				arg_141_1.var_.characterEffect4037ui_story = var_144_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_5 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_5 and not isNil(var_144_4) then
				if arg_141_1.var_.characterEffect4037ui_story and not isNil(var_144_4) then
					arg_141_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_141_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_5)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_5 and arg_141_1.time_ < 0 + var_144_5 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect4037ui_story then
				arg_141_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_141_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/story10130/story10130action/10130action3_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva", "EmotionTimelineAnimator")
			end

			local var_144_6 = 0
			local var_144_7 = 0.45

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_8 = arg_141_1:GetWordFromCfg(322121034)
				local var_144_9 = arg_141_1:FormatText(var_144_8.content)

				arg_141_1.text_.text = var_144_9

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_11 = 18 <= 0 and var_144_7 or var_144_7 * (utf8.len(var_144_9) / 18)

				if (18 <= 0 and var_144_7 or var_144_7 * (utf8.len(var_144_9) / 18)) > 0 and var_144_7 < var_144_11 then
					arg_141_1.talkMaxDuration = var_144_11

					if var_144_11 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_6
					end
				end

				arg_141_1.text_.text = var_144_9
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121034", "story_v_out_322121.awb") ~= 0 then
					local var_144_12 = manager.audio:GetVoiceLength("story_v_out_322121", "322121034", "story_v_out_322121.awb") / 1000

					if var_144_12 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_12 + var_144_6
					end

					if var_144_8.prefab_name ~= "" and arg_141_1.actors_[var_144_8.prefab_name] ~= nil then
						local var_144_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_8.prefab_name].transform, "story_v_out_322121", "322121034", "story_v_out_322121.awb")

						arg_141_1:RecordAudio("322121034", var_144_13)
						arg_141_1:RecordAudio("322121034", var_144_13)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_322121", "322121034", "story_v_out_322121.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_322121", "322121034", "story_v_out_322121.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_14 = math.max(var_144_7, arg_141_1.talkMaxDuration)

			if var_144_6 <= arg_141_1.time_ and arg_141_1.time_ < var_144_6 + var_144_14 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_6) / var_144_14

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_6 + var_144_14 and arg_141_1.time_ < var_144_6 + var_144_14 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play322121035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 322121035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play322121036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos10130ui_story = arg_145_1.actors_["10130ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["10130ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10130ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["10130ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["10130ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10130ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10130ui_story"].transform.position).z)
				arg_145_1.actors_["10130ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["10130ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["10130ui_story"].transform.localEulerAngles = arg_145_1.actors_["10130ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["10130ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.actors_["10130ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["10130ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10130ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10130ui_story"].transform.position).z)
				arg_145_1.actors_["10130ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["10130ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["10130ui_story"].transform.localEulerAngles = arg_145_1.actors_["10130ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["4037ui_story"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos4037ui_story = var_148_1.localPosition
			end

			local var_148_2 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 then
				var_148_1.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_2)
				var_148_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_1.position).x, (manager.ui.mainCamera.transform.position - var_148_1.position).y, (manager.ui.mainCamera.transform.position - var_148_1.position).z)
				var_148_1.localEulerAngles.z = 0
				var_148_1.localEulerAngles.x = 0
				var_148_1.localEulerAngles = var_148_1.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 then
				var_148_1.localPosition = Vector3.New(0, 100, 0)
				var_148_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_1.position).x, (manager.ui.mainCamera.transform.position - var_148_1.position).y, (manager.ui.mainCamera.transform.position - var_148_1.position).z)
				var_148_1.localEulerAngles.z = 0
				var_148_1.localEulerAngles.x = 0
				var_148_1.localEulerAngles = var_148_1.localEulerAngles
			end

			local var_148_3 = 0
			local var_148_4 = 0.925

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_3 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_5 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(322121035).content)

				arg_145_1.text_.text = var_148_5

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_7 = 37 <= 0 and var_148_4 or var_148_4 * (utf8.len(var_148_5) / 37)

				if (37 <= 0 and var_148_4 or var_148_4 * (utf8.len(var_148_5) / 37)) > 0 and var_148_4 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_3 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_3
					end
				end

				arg_145_1.text_.text = var_148_5
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_8 = math.max(var_148_4, arg_145_1.talkMaxDuration)

			if var_148_3 <= arg_145_1.time_ and arg_145_1.time_ < var_148_3 + var_148_8 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_3) / var_148_8

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_3 + var_148_8 and arg_145_1.time_ < var_148_3 + var_148_8 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play322121036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 322121036
		arg_149_1.duration_ = 5.07

		local var_149_0 = {
			zh = 3.9,
			ja = 5.066
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
				arg_149_0:Play322121037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos4037ui_story = arg_149_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["4037ui_story"].transform.position).z)
				arg_149_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["4037ui_story"].transform.localEulerAngles = arg_149_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_149_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["4037ui_story"].transform.position).z)
				arg_149_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["4037ui_story"].transform.localEulerAngles = arg_149_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["4037ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect4037ui_story == nil then
				arg_149_1.var_.characterEffect4037ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect4037ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect4037ui_story then
				arg_149_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action5_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_152_4 = 0
			local var_152_5 = 0.4

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:GetWordFromCfg(322121036)
				local var_152_7 = arg_149_1:FormatText(var_152_6.content)

				arg_149_1.text_.text = var_152_7

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_9 = 16 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 16)

				if (16 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 16)) > 0 and var_152_5 < var_152_9 then
					arg_149_1.talkMaxDuration = var_152_9

					if var_152_9 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_7
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121036", "story_v_out_322121.awb") ~= 0 then
					local var_152_10 = manager.audio:GetVoiceLength("story_v_out_322121", "322121036", "story_v_out_322121.awb") / 1000

					if var_152_10 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_4
					end

					if var_152_6.prefab_name ~= "" and arg_149_1.actors_[var_152_6.prefab_name] ~= nil then
						local var_152_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_6.prefab_name].transform, "story_v_out_322121", "322121036", "story_v_out_322121.awb")

						arg_149_1:RecordAudio("322121036", var_152_11)
						arg_149_1:RecordAudio("322121036", var_152_11)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_322121", "322121036", "story_v_out_322121.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_322121", "322121036", "story_v_out_322121.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_12 = math.max(var_152_5, arg_149_1.talkMaxDuration)

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_12 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_4) / var_152_12

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_4 + var_152_12 and arg_149_1.time_ < var_152_4 + var_152_12 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play322121037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 322121037
		arg_153_1.duration_ = 14.6

		local var_153_0 = {
			zh = 10.633,
			ja = 14.6
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
				arg_153_0:Play322121038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 1.225

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:GetWordFromCfg(322121037)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 49 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 49)

				if (49 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 49)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121037", "story_v_out_322121.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_322121", "322121037", "story_v_out_322121.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_322121", "322121037", "story_v_out_322121.awb")

						arg_153_1:RecordAudio("322121037", var_156_6)
						arg_153_1:RecordAudio("322121037", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_322121", "322121037", "story_v_out_322121.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_322121", "322121037", "story_v_out_322121.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play322121038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 322121038
		arg_157_1.duration_ = 9.2

		local var_157_0 = {
			zh = 3.166,
			ja = 9.2
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play322121039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos10130ui_story = arg_157_1.actors_["10130ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["10130ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10130ui_story, Vector3.New(0.77, -1.02, -5.81), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["10130ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["10130ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10130ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10130ui_story"].transform.position).z)
				arg_157_1.actors_["10130ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["10130ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["10130ui_story"].transform.localEulerAngles = arg_157_1.actors_["10130ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["10130ui_story"].transform.localPosition = Vector3.New(0.77, -1.02, -5.81)
				arg_157_1.actors_["10130ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["10130ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10130ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10130ui_story"].transform.position).z)
				arg_157_1.actors_["10130ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["10130ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["10130ui_story"].transform.localEulerAngles = arg_157_1.actors_["10130ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["4037ui_story"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos4037ui_story = var_160_1.localPosition
			end

			local var_160_2 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 then
				var_160_1.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos4037ui_story, Vector3.New(-0.7, -1.12, -6.2), (arg_157_1.time_ - 0) / var_160_2)
				var_160_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_1.position).x, (manager.ui.mainCamera.transform.position - var_160_1.position).y, (manager.ui.mainCamera.transform.position - var_160_1.position).z)
				var_160_1.localEulerAngles.z = 0
				var_160_1.localEulerAngles.x = 0
				var_160_1.localEulerAngles = var_160_1.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 then
				var_160_1.localPosition = Vector3.New(-0.7, -1.12, -6.2)
				var_160_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_1.position).x, (manager.ui.mainCamera.transform.position - var_160_1.position).y, (manager.ui.mainCamera.transform.position - var_160_1.position).z)
				var_160_1.localEulerAngles.z = 0
				var_160_1.localEulerAngles.x = 0
				var_160_1.localEulerAngles = var_160_1.localEulerAngles
			end

			local var_160_3 = arg_157_1.actors_["10130ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_3) and arg_157_1.var_.characterEffect10130ui_story == nil then
				arg_157_1.var_.characterEffect10130ui_story = var_160_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_4 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 and not isNil(var_160_3) then
				if arg_157_1.var_.characterEffect10130ui_story and not isNil(var_160_3) then
					arg_157_1.var_.characterEffect10130ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 and not isNil(var_160_3) and arg_157_1.var_.characterEffect10130ui_story then
				arg_157_1.var_.characterEffect10130ui_story.fillFlat = false
			end

			local var_160_6 = arg_157_1.actors_["4037ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect4037ui_story == nil then
				arg_157_1.var_.characterEffect4037ui_story = var_160_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_7 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 and not isNil(var_160_6) then
				if arg_157_1.var_.characterEffect4037ui_story and not isNil(var_160_6) then
					arg_157_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_157_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_7)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect4037ui_story then
				arg_157_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_157_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/story10130/story10130action/10130action5_1")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_160_8 = 0
			local var_160_9 = 0.2

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1049].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_10 = arg_157_1:GetWordFromCfg(322121038)
				local var_160_11 = arg_157_1:FormatText(var_160_10.content)

				arg_157_1.text_.text = var_160_11

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_13 = 8 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 8)

				if (8 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 8)) > 0 and var_160_9 < var_160_13 then
					arg_157_1.talkMaxDuration = var_160_13

					if var_160_13 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_13 + var_160_8
					end
				end

				arg_157_1.text_.text = var_160_11
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121038", "story_v_out_322121.awb") ~= 0 then
					local var_160_14 = manager.audio:GetVoiceLength("story_v_out_322121", "322121038", "story_v_out_322121.awb") / 1000

					if var_160_14 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_14 + var_160_8
					end

					if var_160_10.prefab_name ~= "" and arg_157_1.actors_[var_160_10.prefab_name] ~= nil then
						local var_160_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_10.prefab_name].transform, "story_v_out_322121", "322121038", "story_v_out_322121.awb")

						arg_157_1:RecordAudio("322121038", var_160_15)
						arg_157_1:RecordAudio("322121038", var_160_15)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_322121", "322121038", "story_v_out_322121.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_322121", "322121038", "story_v_out_322121.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_16 = math.max(var_160_9, arg_157_1.talkMaxDuration)

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_16 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_8) / var_160_16

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_8 + var_160_16 and arg_157_1.time_ < var_160_8 + var_160_16 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play322121039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 322121039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play322121040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos10130ui_story = arg_161_1.actors_["10130ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["10130ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10130ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["10130ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["10130ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10130ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10130ui_story"].transform.position).z)
				arg_161_1.actors_["10130ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["10130ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["10130ui_story"].transform.localEulerAngles = arg_161_1.actors_["10130ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["10130ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_161_1.actors_["10130ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["10130ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10130ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10130ui_story"].transform.position).z)
				arg_161_1.actors_["10130ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["10130ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["10130ui_story"].transform.localEulerAngles = arg_161_1.actors_["10130ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["4037ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos4037ui_story = var_164_1.localPosition
			end

			local var_164_2 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 then
				var_164_1.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_2)
				var_164_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_1.position).x, (manager.ui.mainCamera.transform.position - var_164_1.position).y, (manager.ui.mainCamera.transform.position - var_164_1.position).z)
				var_164_1.localEulerAngles.z = 0
				var_164_1.localEulerAngles.x = 0
				var_164_1.localEulerAngles = var_164_1.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 then
				var_164_1.localPosition = Vector3.New(0, 100, 0)
				var_164_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_1.position).x, (manager.ui.mainCamera.transform.position - var_164_1.position).y, (manager.ui.mainCamera.transform.position - var_164_1.position).z)
				var_164_1.localEulerAngles.z = 0
				var_164_1.localEulerAngles.x = 0
				var_164_1.localEulerAngles = var_164_1.localEulerAngles
			end

			if 0.1 < arg_161_1.time_ and arg_161_1.time_ <= 0.1 + arg_164_0 then
				arg_161_1:AudioAction("play", "effect", "se_story_side_1067", "se_story_1067_horse02", "")
			end

			local var_164_4 = 0
			local var_164_5 = 1.1

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_6 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(322121039).content)

				arg_161_1.text_.text = var_164_6

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_8 = 44 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_6) / 44)

				if (44 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_6) / 44)) > 0 and var_164_5 < var_164_8 then
					arg_161_1.talkMaxDuration = var_164_8

					if var_164_8 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_4
					end
				end

				arg_161_1.text_.text = var_164_6
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_9 = math.max(var_164_5, arg_161_1.talkMaxDuration)

			if var_164_4 <= arg_161_1.time_ and arg_161_1.time_ < var_164_4 + var_164_9 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_4) / var_164_9

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_4 + var_164_9 and arg_161_1.time_ < var_164_4 + var_164_9 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10130ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play322121040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 322121040
		arg_165_1.duration_ = 4.3

		local var_165_0 = {
			zh = 2,
			ja = 4.3
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play322121041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos10103ui_story = arg_165_1.actors_["10103ui_story"].transform.localPosition

				local var_168_0 = GameObjectTools.GetOrAddComponent(arg_165_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_168_0 then
					var_168_0:EnableDynamicBone(false)
				end
			end

			local var_168_1 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_1 then
				arg_165_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10103ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_165_1.time_ - 0) / var_168_1)
				arg_165_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["10103ui_story"].transform.position).z)
				arg_165_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["10103ui_story"].transform.localEulerAngles = arg_165_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_1 and arg_165_1.time_ < 0 + var_168_1 + arg_168_0 then
				arg_165_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				arg_165_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["10103ui_story"].transform.position).z)
				arg_165_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["10103ui_story"].transform.localEulerAngles = arg_165_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_168_2 = GameObjectTools.GetOrAddComponent(arg_165_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_168_2 then
					var_168_2:EnableDynamicBone(true)
				end
			end

			local var_168_3 = arg_165_1.actors_["10103ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_3) and arg_165_1.var_.characterEffect10103ui_story == nil then
				arg_165_1.var_.characterEffect10103ui_story = var_168_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_4 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 and not isNil(var_168_3) then
				if arg_165_1.var_.characterEffect10103ui_story and not isNil(var_168_3) then
					arg_165_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 and not isNil(var_168_3) and arg_165_1.var_.characterEffect10103ui_story then
				arg_165_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				if not isNil(arg_165_1.actors_["10103ui_story"]) then
					local var_168_6 = GameObjectTools.GetOrAddComponent(arg_165_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_168_6 then
						var_168_6:EnableDynamicBone(true)
					end
				end
			end

			local var_168_7 = 0
			local var_168_8 = 0.25

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_7 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_9 = arg_165_1:GetWordFromCfg(322121040)
				local var_168_10 = arg_165_1:FormatText(var_168_9.content)

				arg_165_1.text_.text = var_168_10

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_12 = 10 <= 0 and var_168_8 or var_168_8 * (utf8.len(var_168_10) / 10)

				if (10 <= 0 and var_168_8 or var_168_8 * (utf8.len(var_168_10) / 10)) > 0 and var_168_8 < var_168_12 then
					arg_165_1.talkMaxDuration = var_168_12

					if var_168_12 + var_168_7 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_12 + var_168_7
					end
				end

				arg_165_1.text_.text = var_168_10
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121040", "story_v_out_322121.awb") ~= 0 then
					local var_168_13 = manager.audio:GetVoiceLength("story_v_out_322121", "322121040", "story_v_out_322121.awb") / 1000

					if var_168_13 + var_168_7 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_13 + var_168_7
					end

					if var_168_9.prefab_name ~= "" and arg_165_1.actors_[var_168_9.prefab_name] ~= nil then
						local var_168_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_9.prefab_name].transform, "story_v_out_322121", "322121040", "story_v_out_322121.awb")

						arg_165_1:RecordAudio("322121040", var_168_14)
						arg_165_1:RecordAudio("322121040", var_168_14)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_322121", "322121040", "story_v_out_322121.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_322121", "322121040", "story_v_out_322121.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_15 = math.max(var_168_8, arg_165_1.talkMaxDuration)

			if var_168_7 <= arg_165_1.time_ and arg_165_1.time_ < var_168_7 + var_168_15 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_7) / var_168_15

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_7 + var_168_15 and arg_165_1.time_ < var_168_7 + var_168_15 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play322121041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 322121041
		arg_169_1.duration_ = 4.47

		local var_169_0 = {
			zh = 2.433,
			ja = 4.466
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play322121042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos4037ui_story = arg_169_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos4037ui_story, Vector3.New(0.7, -1.12, -6.2), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["4037ui_story"].transform.position).z)
				arg_169_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["4037ui_story"].transform.localEulerAngles = arg_169_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -6.2)
				arg_169_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["4037ui_story"].transform.position).z)
				arg_169_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["4037ui_story"].transform.localEulerAngles = arg_169_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["4037ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect4037ui_story == nil then
				arg_169_1.var_.characterEffect4037ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect4037ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect4037ui_story then
				arg_169_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_172_4 = arg_169_1.actors_["10103ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_4) and arg_169_1.var_.characterEffect10103ui_story == nil then
				arg_169_1.var_.characterEffect10103ui_story = var_172_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_5 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_5 and not isNil(var_172_4) then
				if arg_169_1.var_.characterEffect10103ui_story and not isNil(var_172_4) then
					arg_169_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_169_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_5)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_5 and arg_169_1.time_ < 0 + var_172_5 + arg_172_0 and not isNil(var_172_4) and arg_169_1.var_.characterEffect10103ui_story then
				arg_169_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_169_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_172_6 = 0
			local var_172_7 = 0.3

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_8 = arg_169_1:GetWordFromCfg(322121041)
				local var_172_9 = arg_169_1:FormatText(var_172_8.content)

				arg_169_1.text_.text = var_172_9

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_11 = 12 <= 0 and var_172_7 or var_172_7 * (utf8.len(var_172_9) / 12)

				if (12 <= 0 and var_172_7 or var_172_7 * (utf8.len(var_172_9) / 12)) > 0 and var_172_7 < var_172_11 then
					arg_169_1.talkMaxDuration = var_172_11

					if var_172_11 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_11 + var_172_6
					end
				end

				arg_169_1.text_.text = var_172_9
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121041", "story_v_out_322121.awb") ~= 0 then
					local var_172_12 = manager.audio:GetVoiceLength("story_v_out_322121", "322121041", "story_v_out_322121.awb") / 1000

					if var_172_12 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_12 + var_172_6
					end

					if var_172_8.prefab_name ~= "" and arg_169_1.actors_[var_172_8.prefab_name] ~= nil then
						local var_172_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_8.prefab_name].transform, "story_v_out_322121", "322121041", "story_v_out_322121.awb")

						arg_169_1:RecordAudio("322121041", var_172_13)
						arg_169_1:RecordAudio("322121041", var_172_13)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_322121", "322121041", "story_v_out_322121.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_322121", "322121041", "story_v_out_322121.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_14 = math.max(var_172_7, arg_169_1.talkMaxDuration)

			if var_172_6 <= arg_169_1.time_ and arg_169_1.time_ < var_172_6 + var_172_14 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_6) / var_172_14

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_6 + var_172_14 and arg_169_1.time_ < var_172_6 + var_172_14 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play322121042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 322121042
		arg_173_1.duration_ = 14.2

		local var_173_0 = {
			zh = 9.1,
			ja = 14.2
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play322121043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos10103ui_story = arg_173_1.actors_["10103ui_story"].transform.localPosition

				local var_176_0 = GameObjectTools.GetOrAddComponent(arg_173_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_176_0 then
					var_176_0:EnableDynamicBone(false)
				end
			end

			local var_176_1 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_1 then
				arg_173_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10103ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_173_1.time_ - 0) / var_176_1)
				arg_173_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10103ui_story"].transform.position).z)
				arg_173_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["10103ui_story"].transform.localEulerAngles = arg_173_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_1 and arg_173_1.time_ < 0 + var_176_1 + arg_176_0 then
				arg_173_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				arg_173_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10103ui_story"].transform.position).z)
				arg_173_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["10103ui_story"].transform.localEulerAngles = arg_173_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_176_2 = GameObjectTools.GetOrAddComponent(arg_173_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_176_2 then
					var_176_2:EnableDynamicBone(true)
				end
			end

			local var_176_3 = arg_173_1.actors_["10103ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_3) and arg_173_1.var_.characterEffect10103ui_story == nil then
				arg_173_1.var_.characterEffect10103ui_story = var_176_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_4 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 and not isNil(var_176_3) then
				if arg_173_1.var_.characterEffect10103ui_story and not isNil(var_176_3) then
					arg_173_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 and not isNil(var_176_3) and arg_173_1.var_.characterEffect10103ui_story then
				arg_173_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_176_6 = arg_173_1.actors_["4037ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect4037ui_story == nil then
				arg_173_1.var_.characterEffect4037ui_story = var_176_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_7 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 and not isNil(var_176_6) then
				if arg_173_1.var_.characterEffect4037ui_story and not isNil(var_176_6) then
					arg_173_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_173_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_7)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect4037ui_story then
				arg_173_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_173_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action4_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				if not isNil(arg_173_1.actors_["10103ui_story"]) then
					local var_176_8 = GameObjectTools.GetOrAddComponent(arg_173_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_176_8 then
						var_176_8:EnableDynamicBone(true)
					end
				end
			end

			local var_176_9 = 0
			local var_176_10 = 1

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_9 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_11 = arg_173_1:GetWordFromCfg(322121042)
				local var_176_12 = arg_173_1:FormatText(var_176_11.content)

				arg_173_1.text_.text = var_176_12

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_14 = 40 <= 0 and var_176_10 or var_176_10 * (utf8.len(var_176_12) / 40)

				if (40 <= 0 and var_176_10 or var_176_10 * (utf8.len(var_176_12) / 40)) > 0 and var_176_10 < var_176_14 then
					arg_173_1.talkMaxDuration = var_176_14

					if var_176_14 + var_176_9 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_14 + var_176_9
					end
				end

				arg_173_1.text_.text = var_176_12
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121042", "story_v_out_322121.awb") ~= 0 then
					local var_176_15 = manager.audio:GetVoiceLength("story_v_out_322121", "322121042", "story_v_out_322121.awb") / 1000

					if var_176_15 + var_176_9 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_15 + var_176_9
					end

					if var_176_11.prefab_name ~= "" and arg_173_1.actors_[var_176_11.prefab_name] ~= nil then
						local var_176_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_11.prefab_name].transform, "story_v_out_322121", "322121042", "story_v_out_322121.awb")

						arg_173_1:RecordAudio("322121042", var_176_16)
						arg_173_1:RecordAudio("322121042", var_176_16)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_322121", "322121042", "story_v_out_322121.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_322121", "322121042", "story_v_out_322121.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_17 = math.max(var_176_10, arg_173_1.talkMaxDuration)

			if var_176_9 <= arg_173_1.time_ and arg_173_1.time_ < var_176_9 + var_176_17 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_9) / var_176_17

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_9 + var_176_17 and arg_173_1.time_ < var_176_9 + var_176_17 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play322121043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 322121043
		arg_177_1.duration_ = 16.2

		local var_177_0 = {
			zh = 11.333,
			ja = 16.2
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play322121044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 1

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:GetWordFromCfg(322121043)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 39 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 39)

				if (39 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 39)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121043", "story_v_out_322121.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_out_322121", "322121043", "story_v_out_322121.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_out_322121", "322121043", "story_v_out_322121.awb")

						arg_177_1:RecordAudio("322121043", var_180_6)
						arg_177_1:RecordAudio("322121043", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_322121", "322121043", "story_v_out_322121.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_322121", "322121043", "story_v_out_322121.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play322121044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 322121044
		arg_181_1.duration_ = 6.1

		local var_181_0 = {
			zh = 4.033,
			ja = 6.1
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play322121045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos4037ui_story = arg_181_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos4037ui_story, Vector3.New(0.7, -1.12, -6.2), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["4037ui_story"].transform.position).z)
				arg_181_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["4037ui_story"].transform.localEulerAngles = arg_181_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -6.2)
				arg_181_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["4037ui_story"].transform.position).z)
				arg_181_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["4037ui_story"].transform.localEulerAngles = arg_181_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["4037ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect4037ui_story == nil then
				arg_181_1.var_.characterEffect4037ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect4037ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect4037ui_story then
				arg_181_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_184_4 = arg_181_1.actors_["10103ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect10103ui_story == nil then
				arg_181_1.var_.characterEffect10103ui_story = var_184_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_5 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_5 and not isNil(var_184_4) then
				if arg_181_1.var_.characterEffect10103ui_story and not isNil(var_184_4) then
					arg_181_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_181_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_5)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_5 and arg_181_1.time_ < 0 + var_184_5 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect10103ui_story then
				arg_181_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_181_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action3_1")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_184_6 = 0
			local var_184_7 = 0.35

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_8 = arg_181_1:GetWordFromCfg(322121044)
				local var_184_9 = arg_181_1:FormatText(var_184_8.content)

				arg_181_1.text_.text = var_184_9

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_11 = 14 <= 0 and var_184_7 or var_184_7 * (utf8.len(var_184_9) / 14)

				if (14 <= 0 and var_184_7 or var_184_7 * (utf8.len(var_184_9) / 14)) > 0 and var_184_7 < var_184_11 then
					arg_181_1.talkMaxDuration = var_184_11

					if var_184_11 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_11 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_9
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121044", "story_v_out_322121.awb") ~= 0 then
					local var_184_12 = manager.audio:GetVoiceLength("story_v_out_322121", "322121044", "story_v_out_322121.awb") / 1000

					if var_184_12 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_12 + var_184_6
					end

					if var_184_8.prefab_name ~= "" and arg_181_1.actors_[var_184_8.prefab_name] ~= nil then
						local var_184_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_8.prefab_name].transform, "story_v_out_322121", "322121044", "story_v_out_322121.awb")

						arg_181_1:RecordAudio("322121044", var_184_13)
						arg_181_1:RecordAudio("322121044", var_184_13)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_322121", "322121044", "story_v_out_322121.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_322121", "322121044", "story_v_out_322121.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_14 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_14 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_14

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_14 and arg_181_1.time_ < var_184_6 + var_184_14 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play322121045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 322121045
		arg_185_1.duration_ = 5.17

		local var_185_0 = {
			zh = 3.066,
			ja = 5.166
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play322121046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos10103ui_story = arg_185_1.actors_["10103ui_story"].transform.localPosition

				local var_188_0 = GameObjectTools.GetOrAddComponent(arg_185_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_188_0 then
					var_188_0:EnableDynamicBone(false)
				end
			end

			local var_188_1 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_1 then
				arg_185_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10103ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_185_1.time_ - 0) / var_188_1)
				arg_185_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10103ui_story"].transform.position).z)
				arg_185_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["10103ui_story"].transform.localEulerAngles = arg_185_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_1 and arg_185_1.time_ < 0 + var_188_1 + arg_188_0 then
				arg_185_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				arg_185_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["10103ui_story"].transform.position).z)
				arg_185_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["10103ui_story"].transform.localEulerAngles = arg_185_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_188_2 = GameObjectTools.GetOrAddComponent(arg_185_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_188_2 then
					var_188_2:EnableDynamicBone(true)
				end
			end

			local var_188_3 = arg_185_1.actors_["10103ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_3) and arg_185_1.var_.characterEffect10103ui_story == nil then
				arg_185_1.var_.characterEffect10103ui_story = var_188_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_4 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 and not isNil(var_188_3) then
				if arg_185_1.var_.characterEffect10103ui_story and not isNil(var_188_3) then
					arg_185_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 and not isNil(var_188_3) and arg_185_1.var_.characterEffect10103ui_story then
				arg_185_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_188_6 = arg_185_1.actors_["4037ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect4037ui_story == nil then
				arg_185_1.var_.characterEffect4037ui_story = var_188_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_7 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 and not isNil(var_188_6) then
				if arg_185_1.var_.characterEffect4037ui_story and not isNil(var_188_6) then
					arg_185_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_185_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_7)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect4037ui_story then
				arg_185_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_185_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action4_2")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				if not isNil(arg_185_1.actors_["10103ui_story"]) then
					local var_188_8 = GameObjectTools.GetOrAddComponent(arg_185_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_188_8 then
						var_188_8:EnableDynamicBone(true)
					end
				end
			end

			local var_188_9 = 0
			local var_188_10 = 0.25

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_9 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_11 = arg_185_1:GetWordFromCfg(322121045)
				local var_188_12 = arg_185_1:FormatText(var_188_11.content)

				arg_185_1.text_.text = var_188_12

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_14 = 10 <= 0 and var_188_10 or var_188_10 * (utf8.len(var_188_12) / 10)

				if (10 <= 0 and var_188_10 or var_188_10 * (utf8.len(var_188_12) / 10)) > 0 and var_188_10 < var_188_14 then
					arg_185_1.talkMaxDuration = var_188_14

					if var_188_14 + var_188_9 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_9
					end
				end

				arg_185_1.text_.text = var_188_12
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121045", "story_v_out_322121.awb") ~= 0 then
					local var_188_15 = manager.audio:GetVoiceLength("story_v_out_322121", "322121045", "story_v_out_322121.awb") / 1000

					if var_188_15 + var_188_9 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_15 + var_188_9
					end

					if var_188_11.prefab_name ~= "" and arg_185_1.actors_[var_188_11.prefab_name] ~= nil then
						local var_188_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_11.prefab_name].transform, "story_v_out_322121", "322121045", "story_v_out_322121.awb")

						arg_185_1:RecordAudio("322121045", var_188_16)
						arg_185_1:RecordAudio("322121045", var_188_16)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_322121", "322121045", "story_v_out_322121.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_322121", "322121045", "story_v_out_322121.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_17 = math.max(var_188_10, arg_185_1.talkMaxDuration)

			if var_188_9 <= arg_185_1.time_ and arg_185_1.time_ < var_188_9 + var_188_17 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_9) / var_188_17

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_9 + var_188_17 and arg_185_1.time_ < var_188_9 + var_188_17 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play322121046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 322121046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play322121047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10103ui_story = arg_189_1.actors_["10103ui_story"].transform.localPosition

				local var_192_0 = GameObjectTools.GetOrAddComponent(arg_189_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_192_0 then
					var_192_0:EnableDynamicBone(false)
				end
			end

			local var_192_1 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_1 then
				arg_189_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10103ui_story, Vector3.New(0, 100, 0), (arg_189_1.time_ - 0) / var_192_1)
				arg_189_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["10103ui_story"].transform.position).z)
				arg_189_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["10103ui_story"].transform.localEulerAngles = arg_189_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_1 and arg_189_1.time_ < 0 + var_192_1 + arg_192_0 then
				arg_189_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_189_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["10103ui_story"].transform.position).z)
				arg_189_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["10103ui_story"].transform.localEulerAngles = arg_189_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_192_2 = GameObjectTools.GetOrAddComponent(arg_189_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_192_2 then
					var_192_2:EnableDynamicBone(true)
				end
			end

			local var_192_3 = arg_189_1.actors_["4037ui_story"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos4037ui_story = var_192_3.localPosition
			end

			local var_192_4 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				var_192_3.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_189_1.time_ - 0) / var_192_4)
				var_192_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_3.position).x, (manager.ui.mainCamera.transform.position - var_192_3.position).y, (manager.ui.mainCamera.transform.position - var_192_3.position).z)
				var_192_3.localEulerAngles.z = 0
				var_192_3.localEulerAngles.x = 0
				var_192_3.localEulerAngles = var_192_3.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				var_192_3.localPosition = Vector3.New(0, 100, 0)
				var_192_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_3.position).x, (manager.ui.mainCamera.transform.position - var_192_3.position).y, (manager.ui.mainCamera.transform.position - var_192_3.position).z)
				var_192_3.localEulerAngles.z = 0
				var_192_3.localEulerAngles.x = 0
				var_192_3.localEulerAngles = var_192_3.localEulerAngles
			end

			if 0.200000002980232 < arg_189_1.time_ and arg_189_1.time_ <= 0.200000002980232 + arg_192_0 then
				arg_189_1:AudioAction("play", "effect", "se_story_145", "se_story_145_summon_slime2", "")
			end

			local var_192_6 = 0
			local var_192_7 = 1.225

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_8 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(322121046).content)

				arg_189_1.text_.text = var_192_8

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_10 = 49 <= 0 and var_192_7 or var_192_7 * (utf8.len(var_192_8) / 49)

				if (49 <= 0 and var_192_7 or var_192_7 * (utf8.len(var_192_8) / 49)) > 0 and var_192_7 < var_192_10 then
					arg_189_1.talkMaxDuration = var_192_10

					if var_192_10 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_6
					end
				end

				arg_189_1.text_.text = var_192_8
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_11 = math.max(var_192_7, arg_189_1.talkMaxDuration)

			if var_192_6 <= arg_189_1.time_ and arg_189_1.time_ < var_192_6 + var_192_11 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_6) / var_192_11

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_6 + var_192_11 and arg_189_1.time_ < var_192_6 + var_192_11 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play322121047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 322121047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play322121048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 1.575

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(322121047).content)

				arg_193_1.text_.text = var_196_1

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_3 = 63 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 63)

				if (63 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 63)) > 0 and var_196_0 < var_196_3 then
					arg_193_1.talkMaxDuration = var_196_3

					if var_196_3 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_3 + 0
					end
				end

				arg_193_1.text_.text = var_196_1
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_4 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_4

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play322121048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 322121048
		arg_197_1.duration_ = 2

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play322121049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos4037ui_story = arg_197_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["4037ui_story"].transform.position).z)
				arg_197_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["4037ui_story"].transform.localEulerAngles = arg_197_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_197_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["4037ui_story"].transform.position).z)
				arg_197_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["4037ui_story"].transform.localEulerAngles = arg_197_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_200_1 = arg_197_1.actors_["4037ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect4037ui_story == nil then
				arg_197_1.var_.characterEffect4037ui_story = var_200_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 and not isNil(var_200_1) then
				if arg_197_1.var_.characterEffect4037ui_story and not isNil(var_200_1) then
					arg_197_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect4037ui_story then
				arg_197_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva", "EmotionTimelineAnimator")
			end

			local var_200_4 = 0
			local var_200_5 = 0.05

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_6 = arg_197_1:GetWordFromCfg(322121048)
				local var_200_7 = arg_197_1:FormatText(var_200_6.content)

				arg_197_1.text_.text = var_200_7

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_9 = 2 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 2)

				if (2 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 2)) > 0 and var_200_5 < var_200_9 then
					arg_197_1.talkMaxDuration = var_200_9

					if var_200_9 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_9 + var_200_4
					end
				end

				arg_197_1.text_.text = var_200_7
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121048", "story_v_out_322121.awb") ~= 0 then
					local var_200_10 = manager.audio:GetVoiceLength("story_v_out_322121", "322121048", "story_v_out_322121.awb") / 1000

					if var_200_10 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_4
					end

					if var_200_6.prefab_name ~= "" and arg_197_1.actors_[var_200_6.prefab_name] ~= nil then
						local var_200_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_6.prefab_name].transform, "story_v_out_322121", "322121048", "story_v_out_322121.awb")

						arg_197_1:RecordAudio("322121048", var_200_11)
						arg_197_1:RecordAudio("322121048", var_200_11)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_322121", "322121048", "story_v_out_322121.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_322121", "322121048", "story_v_out_322121.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_12 = math.max(var_200_5, arg_197_1.talkMaxDuration)

			if var_200_4 <= arg_197_1.time_ and arg_197_1.time_ < var_200_4 + var_200_12 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_4) / var_200_12

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_4 + var_200_12 and arg_197_1.time_ < var_200_4 + var_200_12 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play322121049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 322121049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play322121050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos4037ui_story = arg_201_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["4037ui_story"].transform.position).z)
				arg_201_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["4037ui_story"].transform.localEulerAngles = arg_201_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_201_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["4037ui_story"].transform.position).z)
				arg_201_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["4037ui_story"].transform.localEulerAngles = arg_201_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if 0.1 < arg_201_1.time_ and arg_201_1.time_ <= 0.1 + arg_204_0 then
				arg_201_1:AudioAction("play", "effect", "se_story_143", "se_story_143_walk08", "")
			end

			local var_204_2 = 0
			local var_204_3 = 1.35

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_2 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_4 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(322121049).content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_6 = 54 <= 0 and var_204_3 or var_204_3 * (utf8.len(var_204_4) / 54)

				if (54 <= 0 and var_204_3 or var_204_3 * (utf8.len(var_204_4) / 54)) > 0 and var_204_3 < var_204_6 then
					arg_201_1.talkMaxDuration = var_204_6

					if var_204_6 + var_204_2 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_6 + var_204_2
					end
				end

				arg_201_1.text_.text = var_204_4
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_7 = math.max(var_204_3, arg_201_1.talkMaxDuration)

			if var_204_2 <= arg_201_1.time_ and arg_201_1.time_ < var_204_2 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_2) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_2 + var_204_7 and arg_201_1.time_ < var_204_2 + var_204_7 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play322121050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 322121050
		arg_205_1.duration_ = 9.9

		local var_205_0 = {
			zh = 7.633,
			ja = 9.9
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play322121051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if arg_205_1.actors_["10150ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10150ui_story"))) then
				local var_208_0 = Object.Instantiate(Asset.Load("Char/" .. "10150ui_story"), arg_205_1.stage_.transform)

				var_208_0.name = "10150ui_story"
				var_208_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_205_1.actors_["10150ui_story"] = var_208_0

				local var_208_1 = var_208_0:GetComponentInChildren(typeof(CharacterEffect))

				var_208_1.enabled = true

				local var_208_2 = GameObjectTools.GetOrAddComponent(var_208_0, typeof(DynamicBoneHelper))

				if var_208_2 then
					var_208_2:EnableDynamicBone(false)
				end

				arg_205_1:ShowWeapon(var_208_1.transform, false)

				arg_205_1.var_["10150ui_story" .. "Animator"] = var_208_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_205_1.var_["10150ui_story" .. "Animator"].applyRootMotion = true
				arg_205_1.var_["10150ui_story" .. "LipSync"] = var_208_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_208_3 = arg_205_1.actors_["10150ui_story"].transform

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos10150ui_story = var_208_3.localPosition

				local var_208_4 = GameObjectTools.GetOrAddComponent(var_208_3.gameObject, typeof(DynamicBoneHelper))

				if var_208_4 then
					var_208_4:EnableDynamicBone(false)
				end
			end

			local var_208_5 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_5 then
				var_208_3.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10150ui_story, Vector3.New(-0.9, -1.73, -5.5), (arg_205_1.time_ - 0) / var_208_5)
				var_208_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_3.position).x, (manager.ui.mainCamera.transform.position - var_208_3.position).y, (manager.ui.mainCamera.transform.position - var_208_3.position).z)
				var_208_3.localEulerAngles.z = 0
				var_208_3.localEulerAngles.x = 0
				var_208_3.localEulerAngles = var_208_3.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_5 and arg_205_1.time_ < 0 + var_208_5 + arg_208_0 then
				var_208_3.localPosition = Vector3.New(-0.9, -1.73, -5.5)
				var_208_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_3.position).x, (manager.ui.mainCamera.transform.position - var_208_3.position).y, (manager.ui.mainCamera.transform.position - var_208_3.position).z)
				var_208_3.localEulerAngles.z = 0
				var_208_3.localEulerAngles.x = 0
				var_208_3.localEulerAngles = var_208_3.localEulerAngles

				local var_208_6 = GameObjectTools.GetOrAddComponent(var_208_3.gameObject, typeof(DynamicBoneHelper))

				if var_208_6 then
					var_208_6:EnableDynamicBone(true)
				end
			end

			local var_208_7 = arg_205_1.actors_["10150ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_7) and arg_205_1.var_.characterEffect10150ui_story == nil then
				arg_205_1.var_.characterEffect10150ui_story = var_208_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_8 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_8 and not isNil(var_208_7) then
				if arg_205_1.var_.characterEffect10150ui_story and not isNil(var_208_7) then
					arg_205_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_8 and arg_205_1.time_ < 0 + var_208_8 + arg_208_0 and not isNil(var_208_7) and arg_205_1.var_.characterEffect10150ui_story then
				arg_205_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_208_10 = arg_205_1.actors_["4037ui_story"].transform

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos4037ui_story = var_208_10.localPosition
			end

			local var_208_11 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_11 then
				var_208_10.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_205_1.time_ - 0) / var_208_11)
				var_208_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_10.position).x, (manager.ui.mainCamera.transform.position - var_208_10.position).y, (manager.ui.mainCamera.transform.position - var_208_10.position).z)
				var_208_10.localEulerAngles.z = 0
				var_208_10.localEulerAngles.x = 0
				var_208_10.localEulerAngles = var_208_10.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_11 and arg_205_1.time_ < 0 + var_208_11 + arg_208_0 then
				var_208_10.localPosition = Vector3.New(0, 100, 0)
				var_208_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_10.position).x, (manager.ui.mainCamera.transform.position - var_208_10.position).y, (manager.ui.mainCamera.transform.position - var_208_10.position).z)
				var_208_10.localEulerAngles.z = 0
				var_208_10.localEulerAngles.x = 0
				var_208_10.localEulerAngles = var_208_10.localEulerAngles
			end

			local var_208_12 = 0
			local var_208_13 = 0.475

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_12 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_14 = arg_205_1:GetWordFromCfg(322121050)
				local var_208_15 = arg_205_1:FormatText(var_208_14.content)

				arg_205_1.text_.text = var_208_15

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_17 = 19 <= 0 and var_208_13 or var_208_13 * (utf8.len(var_208_15) / 19)

				if (19 <= 0 and var_208_13 or var_208_13 * (utf8.len(var_208_15) / 19)) > 0 and var_208_13 < var_208_17 then
					arg_205_1.talkMaxDuration = var_208_17

					if var_208_17 + var_208_12 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_17 + var_208_12
					end
				end

				arg_205_1.text_.text = var_208_15
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121050", "story_v_out_322121.awb") ~= 0 then
					local var_208_18 = manager.audio:GetVoiceLength("story_v_out_322121", "322121050", "story_v_out_322121.awb") / 1000

					if var_208_18 + var_208_12 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_18 + var_208_12
					end

					if var_208_14.prefab_name ~= "" and arg_205_1.actors_[var_208_14.prefab_name] ~= nil then
						local var_208_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_14.prefab_name].transform, "story_v_out_322121", "322121050", "story_v_out_322121.awb")

						arg_205_1:RecordAudio("322121050", var_208_19)
						arg_205_1:RecordAudio("322121050", var_208_19)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_322121", "322121050", "story_v_out_322121.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_322121", "322121050", "story_v_out_322121.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_20 = math.max(var_208_13, arg_205_1.talkMaxDuration)

			if var_208_12 <= arg_205_1.time_ and arg_205_1.time_ < var_208_12 + var_208_20 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_12) / var_208_20

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_12 + var_208_20 and arg_205_1.time_ < var_208_12 + var_208_20 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play322121051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 322121051
		arg_209_1.duration_ = 10.2

		local var_209_0 = {
			zh = 6.533,
			ja = 10.2
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play322121052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos4037ui_story = arg_209_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos4037ui_story, Vector3.New(0.7, -1.12, -6.2), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["4037ui_story"].transform.position).z)
				arg_209_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["4037ui_story"].transform.localEulerAngles = arg_209_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -6.2)
				arg_209_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["4037ui_story"].transform.position).z)
				arg_209_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["4037ui_story"].transform.localEulerAngles = arg_209_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["4037ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect4037ui_story == nil then
				arg_209_1.var_.characterEffect4037ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect4037ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect4037ui_story then
				arg_209_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_212_4 = arg_209_1.actors_["10150ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_4) and arg_209_1.var_.characterEffect10150ui_story == nil then
				arg_209_1.var_.characterEffect10150ui_story = var_212_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_5 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_5 and not isNil(var_212_4) then
				if arg_209_1.var_.characterEffect10150ui_story and not isNil(var_212_4) then
					arg_209_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_209_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_5)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_5 and arg_209_1.time_ < 0 + var_212_5 + arg_212_0 and not isNil(var_212_4) and arg_209_1.var_.characterEffect10150ui_story then
				arg_209_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_209_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_212_6 = 0
			local var_212_7 = 0.7

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_8 = arg_209_1:GetWordFromCfg(322121051)
				local var_212_9 = arg_209_1:FormatText(var_212_8.content)

				arg_209_1.text_.text = var_212_9

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_11 = 28 <= 0 and var_212_7 or var_212_7 * (utf8.len(var_212_9) / 28)

				if (28 <= 0 and var_212_7 or var_212_7 * (utf8.len(var_212_9) / 28)) > 0 and var_212_7 < var_212_11 then
					arg_209_1.talkMaxDuration = var_212_11

					if var_212_11 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_11 + var_212_6
					end
				end

				arg_209_1.text_.text = var_212_9
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121051", "story_v_out_322121.awb") ~= 0 then
					local var_212_12 = manager.audio:GetVoiceLength("story_v_out_322121", "322121051", "story_v_out_322121.awb") / 1000

					if var_212_12 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_12 + var_212_6
					end

					if var_212_8.prefab_name ~= "" and arg_209_1.actors_[var_212_8.prefab_name] ~= nil then
						local var_212_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_8.prefab_name].transform, "story_v_out_322121", "322121051", "story_v_out_322121.awb")

						arg_209_1:RecordAudio("322121051", var_212_13)
						arg_209_1:RecordAudio("322121051", var_212_13)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_322121", "322121051", "story_v_out_322121.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_322121", "322121051", "story_v_out_322121.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_14 = math.max(var_212_7, arg_209_1.talkMaxDuration)

			if var_212_6 <= arg_209_1.time_ and arg_209_1.time_ < var_212_6 + var_212_14 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_6) / var_212_14

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_6 + var_212_14 and arg_209_1.time_ < var_212_6 + var_212_14 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play322121052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 322121052
		arg_213_1.duration_ = 5.93

		local var_213_0 = {
			zh = 5.6,
			ja = 5.933
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play322121053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos10150ui_story = arg_213_1.actors_["10150ui_story"].transform.localPosition

				local var_216_0 = GameObjectTools.GetOrAddComponent(arg_213_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_216_0 then
					var_216_0:EnableDynamicBone(false)
				end
			end

			local var_216_1 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_1 then
				arg_213_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10150ui_story, Vector3.New(-0.9, -1.73, -5.5), (arg_213_1.time_ - 0) / var_216_1)
				arg_213_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["10150ui_story"].transform.position).z)
				arg_213_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["10150ui_story"].transform.localEulerAngles = arg_213_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_1 and arg_213_1.time_ < 0 + var_216_1 + arg_216_0 then
				arg_213_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(-0.9, -1.73, -5.5)
				arg_213_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["10150ui_story"].transform.position).z)
				arg_213_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["10150ui_story"].transform.localEulerAngles = arg_213_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_216_2 = GameObjectTools.GetOrAddComponent(arg_213_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_216_2 then
					var_216_2:EnableDynamicBone(true)
				end
			end

			local var_216_3 = arg_213_1.actors_["10150ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_3) and arg_213_1.var_.characterEffect10150ui_story == nil then
				arg_213_1.var_.characterEffect10150ui_story = var_216_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_4 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_4 and not isNil(var_216_3) then
				if arg_213_1.var_.characterEffect10150ui_story and not isNil(var_216_3) then
					arg_213_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_4 and arg_213_1.time_ < 0 + var_216_4 + arg_216_0 and not isNil(var_216_3) and arg_213_1.var_.characterEffect10150ui_story then
				arg_213_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_216_6 = arg_213_1.actors_["4037ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_6) and arg_213_1.var_.characterEffect4037ui_story == nil then
				arg_213_1.var_.characterEffect4037ui_story = var_216_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_7 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 and not isNil(var_216_6) then
				if arg_213_1.var_.characterEffect4037ui_story and not isNil(var_216_6) then
					arg_213_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_213_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_7)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 and not isNil(var_216_6) and arg_213_1.var_.characterEffect4037ui_story then
				arg_213_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_213_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action5_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_216_8 = 0
			local var_216_9 = 0.475

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_10 = arg_213_1:GetWordFromCfg(322121052)
				local var_216_11 = arg_213_1:FormatText(var_216_10.content)

				arg_213_1.text_.text = var_216_11

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_13 = 19 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_11) / 19)

				if (19 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_11) / 19)) > 0 and var_216_9 < var_216_13 then
					arg_213_1.talkMaxDuration = var_216_13

					if var_216_13 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_13 + var_216_8
					end
				end

				arg_213_1.text_.text = var_216_11
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121052", "story_v_out_322121.awb") ~= 0 then
					local var_216_14 = manager.audio:GetVoiceLength("story_v_out_322121", "322121052", "story_v_out_322121.awb") / 1000

					if var_216_14 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_14 + var_216_8
					end

					if var_216_10.prefab_name ~= "" and arg_213_1.actors_[var_216_10.prefab_name] ~= nil then
						local var_216_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_10.prefab_name].transform, "story_v_out_322121", "322121052", "story_v_out_322121.awb")

						arg_213_1:RecordAudio("322121052", var_216_15)
						arg_213_1:RecordAudio("322121052", var_216_15)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_322121", "322121052", "story_v_out_322121.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_322121", "322121052", "story_v_out_322121.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_16 = math.max(var_216_9, arg_213_1.talkMaxDuration)

			if var_216_8 <= arg_213_1.time_ and arg_213_1.time_ < var_216_8 + var_216_16 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_8) / var_216_16

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_8 + var_216_16 and arg_213_1.time_ < var_216_8 + var_216_16 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play322121053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 322121053
		arg_217_1.duration_ = 4.83

		local var_217_0 = {
			zh = 4.833,
			ja = 4.3
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play322121054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos4037ui_story = arg_217_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_220_0 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 then
				arg_217_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos4037ui_story, Vector3.New(0.7, -1.12, -6.2), (arg_217_1.time_ - 0) / var_220_0)
				arg_217_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["4037ui_story"].transform.position).z)
				arg_217_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["4037ui_story"].transform.localEulerAngles = arg_217_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 then
				arg_217_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -6.2)
				arg_217_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["4037ui_story"].transform.position).z)
				arg_217_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["4037ui_story"].transform.localEulerAngles = arg_217_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_220_1 = arg_217_1.actors_["4037ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect4037ui_story == nil then
				arg_217_1.var_.characterEffect4037ui_story = var_220_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_2 and not isNil(var_220_1) then
				if arg_217_1.var_.characterEffect4037ui_story and not isNil(var_220_1) then
					arg_217_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 0 + var_220_2 and arg_217_1.time_ < 0 + var_220_2 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect4037ui_story then
				arg_217_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_220_4 = arg_217_1.actors_["10150ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_4) and arg_217_1.var_.characterEffect10150ui_story == nil then
				arg_217_1.var_.characterEffect10150ui_story = var_220_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_5 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_5 and not isNil(var_220_4) then
				if arg_217_1.var_.characterEffect10150ui_story and not isNil(var_220_4) then
					arg_217_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_217_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_5)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_5 and arg_217_1.time_ < 0 + var_220_5 + arg_220_0 and not isNil(var_220_4) and arg_217_1.var_.characterEffect10150ui_story then
				arg_217_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_217_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_220_6 = 0
			local var_220_7 = 0.05

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_6 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_8 = arg_217_1:GetWordFromCfg(322121053)
				local var_220_9 = arg_217_1:FormatText(var_220_8.content)

				arg_217_1.text_.text = var_220_9

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_11 = 2 <= 0 and var_220_7 or var_220_7 * (utf8.len(var_220_9) / 2)

				if (2 <= 0 and var_220_7 or var_220_7 * (utf8.len(var_220_9) / 2)) > 0 and var_220_7 < var_220_11 then
					arg_217_1.talkMaxDuration = var_220_11

					if var_220_11 + var_220_6 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_11 + var_220_6
					end
				end

				arg_217_1.text_.text = var_220_9
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121053", "story_v_out_322121.awb") ~= 0 then
					local var_220_12 = manager.audio:GetVoiceLength("story_v_out_322121", "322121053", "story_v_out_322121.awb") / 1000

					if var_220_12 + var_220_6 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_12 + var_220_6
					end

					if var_220_8.prefab_name ~= "" and arg_217_1.actors_[var_220_8.prefab_name] ~= nil then
						local var_220_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_8.prefab_name].transform, "story_v_out_322121", "322121053", "story_v_out_322121.awb")

						arg_217_1:RecordAudio("322121053", var_220_13)
						arg_217_1:RecordAudio("322121053", var_220_13)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_322121", "322121053", "story_v_out_322121.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_322121", "322121053", "story_v_out_322121.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_14 = math.max(var_220_7, arg_217_1.talkMaxDuration)

			if var_220_6 <= arg_217_1.time_ and arg_217_1.time_ < var_220_6 + var_220_14 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_6) / var_220_14

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_6 + var_220_14 and arg_217_1.time_ < var_220_6 + var_220_14 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play322121054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 322121054
		arg_221_1.duration_ = 1.77

		local var_221_0 = {
			zh = 1.266,
			ja = 1.766
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
				arg_221_0:Play322121055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["10150ui_story"]) and arg_221_1.var_.characterEffect10150ui_story == nil then
				arg_221_1.var_.characterEffect10150ui_story = arg_221_1.actors_["10150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_0 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["10150ui_story"]) then
				if arg_221_1.var_.characterEffect10150ui_story and not isNil(arg_221_1.actors_["10150ui_story"]) then
					arg_221_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["10150ui_story"]) and arg_221_1.var_.characterEffect10150ui_story then
				arg_221_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_224_2 = arg_221_1.actors_["4037ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.characterEffect4037ui_story == nil then
				arg_221_1.var_.characterEffect4037ui_story = var_224_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_3 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_3 and not isNil(var_224_2) then
				if arg_221_1.var_.characterEffect4037ui_story and not isNil(var_224_2) then
					arg_221_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_221_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_3)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_3 and arg_221_1.time_ < 0 + var_224_3 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.characterEffect4037ui_story then
				arg_221_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_221_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_224_4 = 0
			local var_224_5 = 0.125

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_6 = arg_221_1:GetWordFromCfg(322121054)
				local var_224_7 = arg_221_1:FormatText(var_224_6.content)

				arg_221_1.text_.text = var_224_7

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_9 = 5 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 5)

				if (5 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 5)) > 0 and var_224_5 < var_224_9 then
					arg_221_1.talkMaxDuration = var_224_9

					if var_224_9 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_9 + var_224_4
					end
				end

				arg_221_1.text_.text = var_224_7
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121054", "story_v_out_322121.awb") ~= 0 then
					local var_224_10 = manager.audio:GetVoiceLength("story_v_out_322121", "322121054", "story_v_out_322121.awb") / 1000

					if var_224_10 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_4
					end

					if var_224_6.prefab_name ~= "" and arg_221_1.actors_[var_224_6.prefab_name] ~= nil then
						local var_224_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_6.prefab_name].transform, "story_v_out_322121", "322121054", "story_v_out_322121.awb")

						arg_221_1:RecordAudio("322121054", var_224_11)
						arg_221_1:RecordAudio("322121054", var_224_11)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_322121", "322121054", "story_v_out_322121.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_322121", "322121054", "story_v_out_322121.awb")
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

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play322121055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 322121055
		arg_225_1.duration_ = 5.73

		local var_225_0 = {
			zh = 4.033,
			ja = 5.733
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
				arg_225_0:Play322121056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos4037ui_story = arg_225_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_228_0 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 then
				arg_225_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos4037ui_story, Vector3.New(0.7, -1.12, -6.2), (arg_225_1.time_ - 0) / var_228_0)
				arg_225_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["4037ui_story"].transform.position).z)
				arg_225_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["4037ui_story"].transform.localEulerAngles = arg_225_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 then
				arg_225_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -6.2)
				arg_225_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["4037ui_story"].transform.position).z)
				arg_225_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["4037ui_story"].transform.localEulerAngles = arg_225_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_228_1 = arg_225_1.actors_["4037ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect4037ui_story == nil then
				arg_225_1.var_.characterEffect4037ui_story = var_228_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_2 and not isNil(var_228_1) then
				if arg_225_1.var_.characterEffect4037ui_story and not isNil(var_228_1) then
					arg_225_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_2 and arg_225_1.time_ < 0 + var_228_2 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect4037ui_story then
				arg_225_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_228_4 = arg_225_1.actors_["10150ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_4) and arg_225_1.var_.characterEffect10150ui_story == nil then
				arg_225_1.var_.characterEffect10150ui_story = var_228_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_5 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_5 and not isNil(var_228_4) then
				if arg_225_1.var_.characterEffect10150ui_story and not isNil(var_228_4) then
					arg_225_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_225_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_5)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_5 and arg_225_1.time_ < 0 + var_228_5 + arg_228_0 and not isNil(var_228_4) and arg_225_1.var_.characterEffect10150ui_story then
				arg_225_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_225_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_1")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_228_6 = 0
			local var_228_7 = 0.35

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_8 = arg_225_1:GetWordFromCfg(322121055)
				local var_228_9 = arg_225_1:FormatText(var_228_8.content)

				arg_225_1.text_.text = var_228_9

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_11 = 14 <= 0 and var_228_7 or var_228_7 * (utf8.len(var_228_9) / 14)

				if (14 <= 0 and var_228_7 or var_228_7 * (utf8.len(var_228_9) / 14)) > 0 and var_228_7 < var_228_11 then
					arg_225_1.talkMaxDuration = var_228_11

					if var_228_11 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_11 + var_228_6
					end
				end

				arg_225_1.text_.text = var_228_9
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121055", "story_v_out_322121.awb") ~= 0 then
					local var_228_12 = manager.audio:GetVoiceLength("story_v_out_322121", "322121055", "story_v_out_322121.awb") / 1000

					if var_228_12 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_12 + var_228_6
					end

					if var_228_8.prefab_name ~= "" and arg_225_1.actors_[var_228_8.prefab_name] ~= nil then
						local var_228_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_8.prefab_name].transform, "story_v_out_322121", "322121055", "story_v_out_322121.awb")

						arg_225_1:RecordAudio("322121055", var_228_13)
						arg_225_1:RecordAudio("322121055", var_228_13)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_322121", "322121055", "story_v_out_322121.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_322121", "322121055", "story_v_out_322121.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_14 = math.max(var_228_7, arg_225_1.talkMaxDuration)

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_14 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_6) / var_228_14

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_6 + var_228_14 and arg_225_1.time_ < var_228_6 + var_228_14 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play322121056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 322121056
		arg_229_1.duration_ = 4.73

		local var_229_0 = {
			zh = 4,
			ja = 4.733
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play322121057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["10150ui_story"]) and arg_229_1.var_.characterEffect10150ui_story == nil then
				arg_229_1.var_.characterEffect10150ui_story = arg_229_1.actors_["10150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["10150ui_story"]) then
				if arg_229_1.var_.characterEffect10150ui_story and not isNil(arg_229_1.actors_["10150ui_story"]) then
					arg_229_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["10150ui_story"]) and arg_229_1.var_.characterEffect10150ui_story then
				arg_229_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_232_2 = arg_229_1.actors_["4037ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.characterEffect4037ui_story == nil then
				arg_229_1.var_.characterEffect4037ui_story = var_232_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_3 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_3 and not isNil(var_232_2) then
				if arg_229_1.var_.characterEffect4037ui_story and not isNil(var_232_2) then
					arg_229_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_229_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_3)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_3 and arg_229_1.time_ < 0 + var_232_3 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.characterEffect4037ui_story then
				arg_229_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_229_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action5_2")
			end

			local var_232_4 = 0
			local var_232_5 = 0.25

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_6 = arg_229_1:GetWordFromCfg(322121056)
				local var_232_7 = arg_229_1:FormatText(var_232_6.content)

				arg_229_1.text_.text = var_232_7

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_9 = 10 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 10)

				if (10 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 10)) > 0 and var_232_5 < var_232_9 then
					arg_229_1.talkMaxDuration = var_232_9

					if var_232_9 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_9 + var_232_4
					end
				end

				arg_229_1.text_.text = var_232_7
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121056", "story_v_out_322121.awb") ~= 0 then
					local var_232_10 = manager.audio:GetVoiceLength("story_v_out_322121", "322121056", "story_v_out_322121.awb") / 1000

					if var_232_10 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_4
					end

					if var_232_6.prefab_name ~= "" and arg_229_1.actors_[var_232_6.prefab_name] ~= nil then
						local var_232_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_6.prefab_name].transform, "story_v_out_322121", "322121056", "story_v_out_322121.awb")

						arg_229_1:RecordAudio("322121056", var_232_11)
						arg_229_1:RecordAudio("322121056", var_232_11)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_322121", "322121056", "story_v_out_322121.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_322121", "322121056", "story_v_out_322121.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_12 = math.max(var_232_5, arg_229_1.talkMaxDuration)

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_12 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_4) / var_232_12

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_4 + var_232_12 and arg_229_1.time_ < var_232_4 + var_232_12 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play322121057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 322121057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play322121058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos10150ui_story = arg_233_1.actors_["10150ui_story"].transform.localPosition

				local var_236_0 = GameObjectTools.GetOrAddComponent(arg_233_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_236_0 then
					var_236_0:EnableDynamicBone(false)
				end
			end

			local var_236_1 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_1 then
				arg_233_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10150ui_story, Vector3.New(0, 100, 0), (arg_233_1.time_ - 0) / var_236_1)
				arg_233_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["10150ui_story"].transform.position).z)
				arg_233_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["10150ui_story"].transform.localEulerAngles = arg_233_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_1 and arg_233_1.time_ < 0 + var_236_1 + arg_236_0 then
				arg_233_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["10150ui_story"].transform.position).z)
				arg_233_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["10150ui_story"].transform.localEulerAngles = arg_233_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_236_2 = GameObjectTools.GetOrAddComponent(arg_233_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_236_2 then
					var_236_2:EnableDynamicBone(true)
				end
			end

			local var_236_3 = arg_233_1.actors_["4037ui_story"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos4037ui_story = var_236_3.localPosition
			end

			local var_236_4 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				var_236_3.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_233_1.time_ - 0) / var_236_4)
				var_236_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_3.position).x, (manager.ui.mainCamera.transform.position - var_236_3.position).y, (manager.ui.mainCamera.transform.position - var_236_3.position).z)
				var_236_3.localEulerAngles.z = 0
				var_236_3.localEulerAngles.x = 0
				var_236_3.localEulerAngles = var_236_3.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				var_236_3.localPosition = Vector3.New(0, 100, 0)
				var_236_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_3.position).x, (manager.ui.mainCamera.transform.position - var_236_3.position).y, (manager.ui.mainCamera.transform.position - var_236_3.position).z)
				var_236_3.localEulerAngles.z = 0
				var_236_3.localEulerAngles.x = 0
				var_236_3.localEulerAngles = var_236_3.localEulerAngles
			end

			if 0.220118200406432 < arg_233_1.time_ and arg_233_1.time_ <= 0.220118200406432 + arg_236_0 then
				arg_233_1:AudioAction("play", "effect", "se_story_activity_1_2_1", "se_story_activity_1_2_1_sword", "")
			end

			local var_236_6 = 0
			local var_236_7 = 0.95

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_6 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_8 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(322121057).content)

				arg_233_1.text_.text = var_236_8

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_10 = 38 <= 0 and var_236_7 or var_236_7 * (utf8.len(var_236_8) / 38)

				if (38 <= 0 and var_236_7 or var_236_7 * (utf8.len(var_236_8) / 38)) > 0 and var_236_7 < var_236_10 then
					arg_233_1.talkMaxDuration = var_236_10

					if var_236_10 + var_236_6 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_6
					end
				end

				arg_233_1.text_.text = var_236_8
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_11 = math.max(var_236_7, arg_233_1.talkMaxDuration)

			if var_236_6 <= arg_233_1.time_ and arg_233_1.time_ < var_236_6 + var_236_11 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_6) / var_236_11

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_6 + var_236_11 and arg_233_1.time_ < var_236_6 + var_236_11 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play322121058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 322121058
		arg_237_1.duration_ = 2.07

		local var_237_0 = {
			zh = 1.533,
			ja = 2.066
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play322121059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos4037ui_story = arg_237_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_240_0 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 then
				arg_237_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos4037ui_story, Vector3.New(-0.7, -1.12, -6.2), (arg_237_1.time_ - 0) / var_240_0)
				arg_237_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["4037ui_story"].transform.position).z)
				arg_237_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["4037ui_story"].transform.localEulerAngles = arg_237_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 then
				arg_237_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(-0.7, -1.12, -6.2)
				arg_237_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["4037ui_story"].transform.position).z)
				arg_237_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["4037ui_story"].transform.localEulerAngles = arg_237_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_240_1 = arg_237_1.actors_["4037ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect4037ui_story == nil then
				arg_237_1.var_.characterEffect4037ui_story = var_240_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 and not isNil(var_240_1) then
				if arg_237_1.var_.characterEffect4037ui_story and not isNil(var_240_1) then
					arg_237_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect4037ui_story then
				arg_237_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_240_4 = 0
			local var_240_5 = 0.15

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_4 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_6 = arg_237_1:GetWordFromCfg(322121058)
				local var_240_7 = arg_237_1:FormatText(var_240_6.content)

				arg_237_1.text_.text = var_240_7

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_9 = 6 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 6)

				if (6 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 6)) > 0 and var_240_5 < var_240_9 then
					arg_237_1.talkMaxDuration = var_240_9

					if var_240_9 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_9 + var_240_4
					end
				end

				arg_237_1.text_.text = var_240_7
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121058", "story_v_out_322121.awb") ~= 0 then
					local var_240_10 = manager.audio:GetVoiceLength("story_v_out_322121", "322121058", "story_v_out_322121.awb") / 1000

					if var_240_10 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_10 + var_240_4
					end

					if var_240_6.prefab_name ~= "" and arg_237_1.actors_[var_240_6.prefab_name] ~= nil then
						local var_240_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_6.prefab_name].transform, "story_v_out_322121", "322121058", "story_v_out_322121.awb")

						arg_237_1:RecordAudio("322121058", var_240_11)
						arg_237_1:RecordAudio("322121058", var_240_11)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_322121", "322121058", "story_v_out_322121.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_322121", "322121058", "story_v_out_322121.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_12 = math.max(var_240_5, arg_237_1.talkMaxDuration)

			if var_240_4 <= arg_237_1.time_ and arg_237_1.time_ < var_240_4 + var_240_12 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_4) / var_240_12

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_4 + var_240_12 and arg_237_1.time_ < var_240_4 + var_240_12 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play322121059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 322121059
		arg_241_1.duration_ = 6.5

		local var_241_0 = {
			zh = 5.133,
			ja = 6.5
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play322121060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos10150ui_story = arg_241_1.actors_["10150ui_story"].transform.localPosition

				local var_244_0 = GameObjectTools.GetOrAddComponent(arg_241_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_244_0 then
					var_244_0:EnableDynamicBone(false)
				end
			end

			local var_244_1 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_1 then
				arg_241_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10150ui_story, Vector3.New(0.9, -1.73, -5.5), (arg_241_1.time_ - 0) / var_244_1)
				arg_241_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["10150ui_story"].transform.position).z)
				arg_241_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["10150ui_story"].transform.localEulerAngles = arg_241_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_1 and arg_241_1.time_ < 0 + var_244_1 + arg_244_0 then
				arg_241_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(0.9, -1.73, -5.5)
				arg_241_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["10150ui_story"].transform.position).z)
				arg_241_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["10150ui_story"].transform.localEulerAngles = arg_241_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_244_2 = GameObjectTools.GetOrAddComponent(arg_241_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_244_2 then
					var_244_2:EnableDynamicBone(true)
				end
			end

			local var_244_3 = arg_241_1.actors_["10150ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_3) and arg_241_1.var_.characterEffect10150ui_story == nil then
				arg_241_1.var_.characterEffect10150ui_story = var_244_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_4 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_4 and not isNil(var_244_3) then
				if arg_241_1.var_.characterEffect10150ui_story and not isNil(var_244_3) then
					arg_241_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_4 and arg_241_1.time_ < 0 + var_244_4 + arg_244_0 and not isNil(var_244_3) and arg_241_1.var_.characterEffect10150ui_story then
				arg_241_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_244_6 = arg_241_1.actors_["4037ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_6) and arg_241_1.var_.characterEffect4037ui_story == nil then
				arg_241_1.var_.characterEffect4037ui_story = var_244_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_7 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_7 and not isNil(var_244_6) then
				if arg_241_1.var_.characterEffect4037ui_story and not isNil(var_244_6) then
					arg_241_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_241_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_7)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_7 and arg_241_1.time_ < 0 + var_244_7 + arg_244_0 and not isNil(var_244_6) and arg_241_1.var_.characterEffect4037ui_story then
				arg_241_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_241_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_244_8 = 0
			local var_244_9 = 0.525

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_8 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_10 = arg_241_1:GetWordFromCfg(322121059)
				local var_244_11 = arg_241_1:FormatText(var_244_10.content)

				arg_241_1.text_.text = var_244_11

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_13 = 21 <= 0 and var_244_9 or var_244_9 * (utf8.len(var_244_11) / 21)

				if (21 <= 0 and var_244_9 or var_244_9 * (utf8.len(var_244_11) / 21)) > 0 and var_244_9 < var_244_13 then
					arg_241_1.talkMaxDuration = var_244_13

					if var_244_13 + var_244_8 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_13 + var_244_8
					end
				end

				arg_241_1.text_.text = var_244_11
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121059", "story_v_out_322121.awb") ~= 0 then
					local var_244_14 = manager.audio:GetVoiceLength("story_v_out_322121", "322121059", "story_v_out_322121.awb") / 1000

					if var_244_14 + var_244_8 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_14 + var_244_8
					end

					if var_244_10.prefab_name ~= "" and arg_241_1.actors_[var_244_10.prefab_name] ~= nil then
						local var_244_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_10.prefab_name].transform, "story_v_out_322121", "322121059", "story_v_out_322121.awb")

						arg_241_1:RecordAudio("322121059", var_244_15)
						arg_241_1:RecordAudio("322121059", var_244_15)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_322121", "322121059", "story_v_out_322121.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_322121", "322121059", "story_v_out_322121.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_16 = math.max(var_244_9, arg_241_1.talkMaxDuration)

			if var_244_8 <= arg_241_1.time_ and arg_241_1.time_ < var_244_8 + var_244_16 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_8) / var_244_16

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_8 + var_244_16 and arg_241_1.time_ < var_244_8 + var_244_16 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play322121060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 322121060
		arg_245_1.duration_ = 4.17

		local var_245_0 = {
			zh = 2.433,
			ja = 4.166
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play322121061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos4037ui_story = arg_245_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_248_0 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 then
				arg_245_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos4037ui_story, Vector3.New(-0.7, -1.12, -6.2), (arg_245_1.time_ - 0) / var_248_0)
				arg_245_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["4037ui_story"].transform.position).z)
				arg_245_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["4037ui_story"].transform.localEulerAngles = arg_245_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 then
				arg_245_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(-0.7, -1.12, -6.2)
				arg_245_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["4037ui_story"].transform.position).z)
				arg_245_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["4037ui_story"].transform.localEulerAngles = arg_245_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_248_1 = arg_245_1.actors_["4037ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect4037ui_story == nil then
				arg_245_1.var_.characterEffect4037ui_story = var_248_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_2 and not isNil(var_248_1) then
				if arg_245_1.var_.characterEffect4037ui_story and not isNil(var_248_1) then
					arg_245_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_2 and arg_245_1.time_ < 0 + var_248_2 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect4037ui_story then
				arg_245_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_248_4 = arg_245_1.actors_["10150ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_4) and arg_245_1.var_.characterEffect10150ui_story == nil then
				arg_245_1.var_.characterEffect10150ui_story = var_248_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_5 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_5 and not isNil(var_248_4) then
				if arg_245_1.var_.characterEffect10150ui_story and not isNil(var_248_4) then
					arg_245_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_245_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_5)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_5 and arg_245_1.time_ < 0 + var_248_5 + arg_248_0 and not isNil(var_248_4) and arg_245_1.var_.characterEffect10150ui_story then
				arg_245_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_245_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_1")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_248_6 = 0
			local var_248_7 = 0.2

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_6 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_8 = arg_245_1:GetWordFromCfg(322121060)
				local var_248_9 = arg_245_1:FormatText(var_248_8.content)

				arg_245_1.text_.text = var_248_9

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_11 = 8 <= 0 and var_248_7 or var_248_7 * (utf8.len(var_248_9) / 8)

				if (8 <= 0 and var_248_7 or var_248_7 * (utf8.len(var_248_9) / 8)) > 0 and var_248_7 < var_248_11 then
					arg_245_1.talkMaxDuration = var_248_11

					if var_248_11 + var_248_6 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_11 + var_248_6
					end
				end

				arg_245_1.text_.text = var_248_9
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121060", "story_v_out_322121.awb") ~= 0 then
					local var_248_12 = manager.audio:GetVoiceLength("story_v_out_322121", "322121060", "story_v_out_322121.awb") / 1000

					if var_248_12 + var_248_6 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_12 + var_248_6
					end

					if var_248_8.prefab_name ~= "" and arg_245_1.actors_[var_248_8.prefab_name] ~= nil then
						local var_248_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_8.prefab_name].transform, "story_v_out_322121", "322121060", "story_v_out_322121.awb")

						arg_245_1:RecordAudio("322121060", var_248_13)
						arg_245_1:RecordAudio("322121060", var_248_13)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_322121", "322121060", "story_v_out_322121.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_322121", "322121060", "story_v_out_322121.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_14 = math.max(var_248_7, arg_245_1.talkMaxDuration)

			if var_248_6 <= arg_245_1.time_ and arg_245_1.time_ < var_248_6 + var_248_14 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_6) / var_248_14

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_6 + var_248_14 and arg_245_1.time_ < var_248_6 + var_248_14 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play322121061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 322121061
		arg_249_1.duration_ = 8.07

		local var_249_0 = {
			zh = 6.366,
			ja = 8.066
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play322121062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos10150ui_story = arg_249_1.actors_["10150ui_story"].transform.localPosition

				local var_252_0 = GameObjectTools.GetOrAddComponent(arg_249_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_252_0 then
					var_252_0:EnableDynamicBone(false)
				end
			end

			local var_252_1 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_1 then
				arg_249_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10150ui_story, Vector3.New(0.9, -1.73, -5.5), (arg_249_1.time_ - 0) / var_252_1)
				arg_249_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10150ui_story"].transform.position).z)
				arg_249_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["10150ui_story"].transform.localEulerAngles = arg_249_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_1 and arg_249_1.time_ < 0 + var_252_1 + arg_252_0 then
				arg_249_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(0.9, -1.73, -5.5)
				arg_249_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10150ui_story"].transform.position).z)
				arg_249_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["10150ui_story"].transform.localEulerAngles = arg_249_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_252_2 = GameObjectTools.GetOrAddComponent(arg_249_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_252_2 then
					var_252_2:EnableDynamicBone(true)
				end
			end

			local var_252_3 = arg_249_1.actors_["10150ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_3) and arg_249_1.var_.characterEffect10150ui_story == nil then
				arg_249_1.var_.characterEffect10150ui_story = var_252_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_4 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 and not isNil(var_252_3) then
				if arg_249_1.var_.characterEffect10150ui_story and not isNil(var_252_3) then
					arg_249_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 and not isNil(var_252_3) and arg_249_1.var_.characterEffect10150ui_story then
				arg_249_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_252_6 = arg_249_1.actors_["4037ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_6) and arg_249_1.var_.characterEffect4037ui_story == nil then
				arg_249_1.var_.characterEffect4037ui_story = var_252_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_7 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_7 and not isNil(var_252_6) then
				if arg_249_1.var_.characterEffect4037ui_story and not isNil(var_252_6) then
					arg_249_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_249_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_7)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_7 and arg_249_1.time_ < 0 + var_252_7 + arg_252_0 and not isNil(var_252_6) and arg_249_1.var_.characterEffect4037ui_story then
				arg_249_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_249_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_252_8 = 0
			local var_252_9 = 0.55

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_10 = arg_249_1:GetWordFromCfg(322121061)
				local var_252_11 = arg_249_1:FormatText(var_252_10.content)

				arg_249_1.text_.text = var_252_11

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_13 = 22 <= 0 and var_252_9 or var_252_9 * (utf8.len(var_252_11) / 22)

				if (22 <= 0 and var_252_9 or var_252_9 * (utf8.len(var_252_11) / 22)) > 0 and var_252_9 < var_252_13 then
					arg_249_1.talkMaxDuration = var_252_13

					if var_252_13 + var_252_8 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_13 + var_252_8
					end
				end

				arg_249_1.text_.text = var_252_11
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121061", "story_v_out_322121.awb") ~= 0 then
					local var_252_14 = manager.audio:GetVoiceLength("story_v_out_322121", "322121061", "story_v_out_322121.awb") / 1000

					if var_252_14 + var_252_8 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_14 + var_252_8
					end

					if var_252_10.prefab_name ~= "" and arg_249_1.actors_[var_252_10.prefab_name] ~= nil then
						local var_252_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_10.prefab_name].transform, "story_v_out_322121", "322121061", "story_v_out_322121.awb")

						arg_249_1:RecordAudio("322121061", var_252_15)
						arg_249_1:RecordAudio("322121061", var_252_15)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_322121", "322121061", "story_v_out_322121.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_322121", "322121061", "story_v_out_322121.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_16 = math.max(var_252_9, arg_249_1.talkMaxDuration)

			if var_252_8 <= arg_249_1.time_ and arg_249_1.time_ < var_252_8 + var_252_16 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_8) / var_252_16

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_8 + var_252_16 and arg_249_1.time_ < var_252_8 + var_252_16 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play322121062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 322121062
		arg_253_1.duration_ = 4.37

		local var_253_0 = {
			zh = 1.999999999999,
			ja = 4.366
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play322121063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos4037ui_story = arg_253_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos4037ui_story, Vector3.New(-0.7, -1.12, -6.2), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["4037ui_story"].transform.position).z)
				arg_253_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["4037ui_story"].transform.localEulerAngles = arg_253_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(-0.7, -1.12, -6.2)
				arg_253_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["4037ui_story"].transform.position).z)
				arg_253_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["4037ui_story"].transform.localEulerAngles = arg_253_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_256_1 = arg_253_1.actors_["4037ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect4037ui_story == nil then
				arg_253_1.var_.characterEffect4037ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect4037ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect4037ui_story then
				arg_253_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_256_4 = arg_253_1.actors_["10150ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_4) and arg_253_1.var_.characterEffect10150ui_story == nil then
				arg_253_1.var_.characterEffect10150ui_story = var_256_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_5 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_5 and not isNil(var_256_4) then
				if arg_253_1.var_.characterEffect10150ui_story and not isNil(var_256_4) then
					arg_253_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_253_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_5)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_5 and arg_253_1.time_ < 0 + var_256_5 + arg_256_0 and not isNil(var_256_4) and arg_253_1.var_.characterEffect10150ui_story then
				arg_253_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_253_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_2")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_256_6 = 0
			local var_256_7 = 0.175

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_6 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_8 = arg_253_1:GetWordFromCfg(322121062)
				local var_256_9 = arg_253_1:FormatText(var_256_8.content)

				arg_253_1.text_.text = var_256_9

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_11 = 7 <= 0 and var_256_7 or var_256_7 * (utf8.len(var_256_9) / 7)

				if (7 <= 0 and var_256_7 or var_256_7 * (utf8.len(var_256_9) / 7)) > 0 and var_256_7 < var_256_11 then
					arg_253_1.talkMaxDuration = var_256_11

					if var_256_11 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_11 + var_256_6
					end
				end

				arg_253_1.text_.text = var_256_9
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121062", "story_v_out_322121.awb") ~= 0 then
					local var_256_12 = manager.audio:GetVoiceLength("story_v_out_322121", "322121062", "story_v_out_322121.awb") / 1000

					if var_256_12 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_12 + var_256_6
					end

					if var_256_8.prefab_name ~= "" and arg_253_1.actors_[var_256_8.prefab_name] ~= nil then
						local var_256_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_8.prefab_name].transform, "story_v_out_322121", "322121062", "story_v_out_322121.awb")

						arg_253_1:RecordAudio("322121062", var_256_13)
						arg_253_1:RecordAudio("322121062", var_256_13)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_322121", "322121062", "story_v_out_322121.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_322121", "322121062", "story_v_out_322121.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_14 = math.max(var_256_7, arg_253_1.talkMaxDuration)

			if var_256_6 <= arg_253_1.time_ and arg_253_1.time_ < var_256_6 + var_256_14 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_6) / var_256_14

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_6 + var_256_14 and arg_253_1.time_ < var_256_6 + var_256_14 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play322121063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 322121063
		arg_257_1.duration_ = 7.9

		local var_257_0 = {
			zh = 7.133,
			ja = 7.9
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play322121064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos10150ui_story = arg_257_1.actors_["10150ui_story"].transform.localPosition

				local var_260_0 = GameObjectTools.GetOrAddComponent(arg_257_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_260_0 then
					var_260_0:EnableDynamicBone(false)
				end
			end

			local var_260_1 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_1 then
				arg_257_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos10150ui_story, Vector3.New(0.9, -1.73, -5.5), (arg_257_1.time_ - 0) / var_260_1)
				arg_257_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["10150ui_story"].transform.position).z)
				arg_257_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["10150ui_story"].transform.localEulerAngles = arg_257_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_1 and arg_257_1.time_ < 0 + var_260_1 + arg_260_0 then
				arg_257_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(0.9, -1.73, -5.5)
				arg_257_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["10150ui_story"].transform.position).z)
				arg_257_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["10150ui_story"].transform.localEulerAngles = arg_257_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_260_2 = GameObjectTools.GetOrAddComponent(arg_257_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_260_2 then
					var_260_2:EnableDynamicBone(true)
				end
			end

			local var_260_3 = arg_257_1.actors_["10150ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_3) and arg_257_1.var_.characterEffect10150ui_story == nil then
				arg_257_1.var_.characterEffect10150ui_story = var_260_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_4 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 and not isNil(var_260_3) then
				if arg_257_1.var_.characterEffect10150ui_story and not isNil(var_260_3) then
					arg_257_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 and not isNil(var_260_3) and arg_257_1.var_.characterEffect10150ui_story then
				arg_257_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_260_6 = arg_257_1.actors_["4037ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_6) and arg_257_1.var_.characterEffect4037ui_story == nil then
				arg_257_1.var_.characterEffect4037ui_story = var_260_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_7 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_7 and not isNil(var_260_6) then
				if arg_257_1.var_.characterEffect4037ui_story and not isNil(var_260_6) then
					arg_257_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_257_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_7)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_7 and arg_257_1.time_ < 0 + var_260_7 + arg_260_0 and not isNil(var_260_6) and arg_257_1.var_.characterEffect4037ui_story then
				arg_257_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_257_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action6_1")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_260_8 = 0
			local var_260_9 = 0.625

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_8 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_10 = arg_257_1:GetWordFromCfg(322121063)
				local var_260_11 = arg_257_1:FormatText(var_260_10.content)

				arg_257_1.text_.text = var_260_11

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_13 = 25 <= 0 and var_260_9 or var_260_9 * (utf8.len(var_260_11) / 25)

				if (25 <= 0 and var_260_9 or var_260_9 * (utf8.len(var_260_11) / 25)) > 0 and var_260_9 < var_260_13 then
					arg_257_1.talkMaxDuration = var_260_13

					if var_260_13 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_13 + var_260_8
					end
				end

				arg_257_1.text_.text = var_260_11
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121063", "story_v_out_322121.awb") ~= 0 then
					local var_260_14 = manager.audio:GetVoiceLength("story_v_out_322121", "322121063", "story_v_out_322121.awb") / 1000

					if var_260_14 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_14 + var_260_8
					end

					if var_260_10.prefab_name ~= "" and arg_257_1.actors_[var_260_10.prefab_name] ~= nil then
						local var_260_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_10.prefab_name].transform, "story_v_out_322121", "322121063", "story_v_out_322121.awb")

						arg_257_1:RecordAudio("322121063", var_260_15)
						arg_257_1:RecordAudio("322121063", var_260_15)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_322121", "322121063", "story_v_out_322121.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_322121", "322121063", "story_v_out_322121.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_16 = math.max(var_260_9, arg_257_1.talkMaxDuration)

			if var_260_8 <= arg_257_1.time_ and arg_257_1.time_ < var_260_8 + var_260_16 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_8) / var_260_16

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_8 + var_260_16 and arg_257_1.time_ < var_260_8 + var_260_16 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play322121064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 322121064
		arg_261_1.duration_ = 2.4

		local var_261_0 = {
			zh = 1.8,
			ja = 2.4
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play322121065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["4037ui_story"]) and arg_261_1.var_.characterEffect4037ui_story == nil then
				arg_261_1.var_.characterEffect4037ui_story = arg_261_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_0 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["4037ui_story"]) then
				if arg_261_1.var_.characterEffect4037ui_story and not isNil(arg_261_1.actors_["4037ui_story"]) then
					arg_261_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["4037ui_story"]) and arg_261_1.var_.characterEffect4037ui_story then
				arg_261_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_264_2 = arg_261_1.actors_["10150ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.characterEffect10150ui_story == nil then
				arg_261_1.var_.characterEffect10150ui_story = var_264_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_3 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_3 and not isNil(var_264_2) then
				if arg_261_1.var_.characterEffect10150ui_story and not isNil(var_264_2) then
					arg_261_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_261_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_3)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_3 and arg_261_1.time_ < 0 + var_264_3 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.characterEffect10150ui_story then
				arg_261_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_261_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			local var_264_4 = 0
			local var_264_5 = 0.125

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_6 = arg_261_1:GetWordFromCfg(322121064)
				local var_264_7 = arg_261_1:FormatText(var_264_6.content)

				arg_261_1.text_.text = var_264_7

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_9 = 5 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 5)

				if (5 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 5)) > 0 and var_264_5 < var_264_9 then
					arg_261_1.talkMaxDuration = var_264_9

					if var_264_9 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_9 + var_264_4
					end
				end

				arg_261_1.text_.text = var_264_7
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121064", "story_v_out_322121.awb") ~= 0 then
					local var_264_10 = manager.audio:GetVoiceLength("story_v_out_322121", "322121064", "story_v_out_322121.awb") / 1000

					if var_264_10 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_4
					end

					if var_264_6.prefab_name ~= "" and arg_261_1.actors_[var_264_6.prefab_name] ~= nil then
						local var_264_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_6.prefab_name].transform, "story_v_out_322121", "322121064", "story_v_out_322121.awb")

						arg_261_1:RecordAudio("322121064", var_264_11)
						arg_261_1:RecordAudio("322121064", var_264_11)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_322121", "322121064", "story_v_out_322121.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_322121", "322121064", "story_v_out_322121.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_12 = math.max(var_264_5, arg_261_1.talkMaxDuration)

			if var_264_4 <= arg_261_1.time_ and arg_261_1.time_ < var_264_4 + var_264_12 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_4) / var_264_12

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_4 + var_264_12 and arg_261_1.time_ < var_264_4 + var_264_12 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play322121065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 322121065
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play322121066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos10150ui_story = arg_265_1.actors_["10150ui_story"].transform.localPosition

				local var_268_0 = GameObjectTools.GetOrAddComponent(arg_265_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_268_0 then
					var_268_0:EnableDynamicBone(false)
				end
			end

			local var_268_1 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_1 then
				arg_265_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10150ui_story, Vector3.New(0, 100, 0), (arg_265_1.time_ - 0) / var_268_1)
				arg_265_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["10150ui_story"].transform.position).z)
				arg_265_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["10150ui_story"].transform.localEulerAngles = arg_265_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_1 and arg_265_1.time_ < 0 + var_268_1 + arg_268_0 then
				arg_265_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_265_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["10150ui_story"].transform.position).z)
				arg_265_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["10150ui_story"].transform.localEulerAngles = arg_265_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_268_2 = GameObjectTools.GetOrAddComponent(arg_265_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_268_2 then
					var_268_2:EnableDynamicBone(true)
				end
			end

			local var_268_3 = arg_265_1.actors_["4037ui_story"].transform

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos4037ui_story = var_268_3.localPosition
			end

			local var_268_4 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 then
				var_268_3.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_265_1.time_ - 0) / var_268_4)
				var_268_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_3.position).x, (manager.ui.mainCamera.transform.position - var_268_3.position).y, (manager.ui.mainCamera.transform.position - var_268_3.position).z)
				var_268_3.localEulerAngles.z = 0
				var_268_3.localEulerAngles.x = 0
				var_268_3.localEulerAngles = var_268_3.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 then
				var_268_3.localPosition = Vector3.New(0, 100, 0)
				var_268_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_3.position).x, (manager.ui.mainCamera.transform.position - var_268_3.position).y, (manager.ui.mainCamera.transform.position - var_268_3.position).z)
				var_268_3.localEulerAngles.z = 0
				var_268_3.localEulerAngles.x = 0
				var_268_3.localEulerAngles = var_268_3.localEulerAngles
			end

			local var_268_5 = 0
			local var_268_6 = 1.375

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_7 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(322121065).content)

				arg_265_1.text_.text = var_268_7

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_9 = 55 <= 0 and var_268_6 or var_268_6 * (utf8.len(var_268_7) / 55)

				if (55 <= 0 and var_268_6 or var_268_6 * (utf8.len(var_268_7) / 55)) > 0 and var_268_6 < var_268_9 then
					arg_265_1.talkMaxDuration = var_268_9

					if var_268_9 + var_268_5 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_9 + var_268_5
					end
				end

				arg_265_1.text_.text = var_268_7
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_10 = math.max(var_268_6, arg_265_1.talkMaxDuration)

			if var_268_5 <= arg_265_1.time_ and arg_265_1.time_ < var_268_5 + var_268_10 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_5) / var_268_10

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_5 + var_268_10 and arg_265_1.time_ < var_268_5 + var_268_10 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play322121066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 322121066
		arg_269_1.duration_ = 11

		local var_269_0 = {
			zh = 7.666,
			ja = 11
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play322121067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos4037ui_story = arg_269_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_272_0 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_269_1.time_ - 0) / var_272_0)
				arg_269_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["4037ui_story"].transform.position).z)
				arg_269_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["4037ui_story"].transform.localEulerAngles = arg_269_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_269_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["4037ui_story"].transform.position).z)
				arg_269_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["4037ui_story"].transform.localEulerAngles = arg_269_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_272_1 = arg_269_1.actors_["4037ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect4037ui_story == nil then
				arg_269_1.var_.characterEffect4037ui_story = var_272_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 and not isNil(var_272_1) then
				if arg_269_1.var_.characterEffect4037ui_story and not isNil(var_272_1) then
					arg_269_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect4037ui_story then
				arg_269_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_272_4 = 0
			local var_272_5 = 0.7

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_6 = arg_269_1:GetWordFromCfg(322121066)
				local var_272_7 = arg_269_1:FormatText(var_272_6.content)

				arg_269_1.text_.text = var_272_7

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_9 = 28 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 28)

				if (28 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 28)) > 0 and var_272_5 < var_272_9 then
					arg_269_1.talkMaxDuration = var_272_9

					if var_272_9 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_4
					end
				end

				arg_269_1.text_.text = var_272_7
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121066", "story_v_out_322121.awb") ~= 0 then
					local var_272_10 = manager.audio:GetVoiceLength("story_v_out_322121", "322121066", "story_v_out_322121.awb") / 1000

					if var_272_10 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_4
					end

					if var_272_6.prefab_name ~= "" and arg_269_1.actors_[var_272_6.prefab_name] ~= nil then
						local var_272_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_6.prefab_name].transform, "story_v_out_322121", "322121066", "story_v_out_322121.awb")

						arg_269_1:RecordAudio("322121066", var_272_11)
						arg_269_1:RecordAudio("322121066", var_272_11)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_322121", "322121066", "story_v_out_322121.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_322121", "322121066", "story_v_out_322121.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_12 = math.max(var_272_5, arg_269_1.talkMaxDuration)

			if var_272_4 <= arg_269_1.time_ and arg_269_1.time_ < var_272_4 + var_272_12 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_4) / var_272_12

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_4 + var_272_12 and arg_269_1.time_ < var_272_4 + var_272_12 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play322121067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 322121067
		arg_273_1.duration_ = 12.7

		local var_273_0 = {
			zh = 7,
			ja = 12.7
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play322121068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action5_1")
			end

			local var_276_0 = 0
			local var_276_1 = 0.725

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_2 = arg_273_1:GetWordFromCfg(322121067)
				local var_276_3 = arg_273_1:FormatText(var_276_2.content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 29 <= 0 and var_276_1 or var_276_1 * (utf8.len(var_276_3) / 29)

				if (29 <= 0 and var_276_1 or var_276_1 * (utf8.len(var_276_3) / 29)) > 0 and var_276_1 < var_276_5 then
					arg_273_1.talkMaxDuration = var_276_5

					if var_276_5 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + var_276_0
					end
				end

				arg_273_1.text_.text = var_276_3
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121067", "story_v_out_322121.awb") ~= 0 then
					local var_276_6 = manager.audio:GetVoiceLength("story_v_out_322121", "322121067", "story_v_out_322121.awb") / 1000

					if var_276_6 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_6 + var_276_0
					end

					if var_276_2.prefab_name ~= "" and arg_273_1.actors_[var_276_2.prefab_name] ~= nil then
						local var_276_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_2.prefab_name].transform, "story_v_out_322121", "322121067", "story_v_out_322121.awb")

						arg_273_1:RecordAudio("322121067", var_276_7)
						arg_273_1:RecordAudio("322121067", var_276_7)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_322121", "322121067", "story_v_out_322121.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_322121", "322121067", "story_v_out_322121.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_8 = math.max(var_276_1, arg_273_1.talkMaxDuration)

			if var_276_0 <= arg_273_1.time_ and arg_273_1.time_ < var_276_0 + var_276_8 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_0) / var_276_8

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_0 + var_276_8 and arg_273_1.time_ < var_276_0 + var_276_8 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play322121068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 322121068
		arg_277_1.duration_ = 11.97

		local var_277_0 = {
			zh = 8.966,
			ja = 11.966
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play322121069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.8

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_1 = arg_277_1:GetWordFromCfg(322121068)
				local var_280_2 = arg_277_1:FormatText(var_280_1.content)

				arg_277_1.text_.text = var_280_2

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 32 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 32)

				if (32 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 32)) > 0 and var_280_0 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + 0
					end
				end

				arg_277_1.text_.text = var_280_2
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121068", "story_v_out_322121.awb") ~= 0 then
					local var_280_5 = manager.audio:GetVoiceLength("story_v_out_322121", "322121068", "story_v_out_322121.awb") / 1000

					if var_280_5 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + 0
					end

					if var_280_1.prefab_name ~= "" and arg_277_1.actors_[var_280_1.prefab_name] ~= nil then
						local var_280_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_1.prefab_name].transform, "story_v_out_322121", "322121068", "story_v_out_322121.awb")

						arg_277_1:RecordAudio("322121068", var_280_6)
						arg_277_1:RecordAudio("322121068", var_280_6)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_322121", "322121068", "story_v_out_322121.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_322121", "322121068", "story_v_out_322121.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_7 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_7 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_7

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_7 and arg_277_1.time_ < 0 + var_280_7 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play322121069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 322121069
		arg_281_1.duration_ = 3.4

		local var_281_0 = {
			zh = 3.4,
			ja = 2.766
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play322121070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos10150ui_story = arg_281_1.actors_["10150ui_story"].transform.localPosition

				local var_284_0 = GameObjectTools.GetOrAddComponent(arg_281_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_284_0 then
					var_284_0:EnableDynamicBone(false)
				end
			end

			local var_284_1 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_1 then
				arg_281_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10150ui_story, Vector3.New(0, -1.73, -5.5), (arg_281_1.time_ - 0) / var_284_1)
				arg_281_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10150ui_story"].transform.position).z)
				arg_281_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["10150ui_story"].transform.localEulerAngles = arg_281_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_1 and arg_281_1.time_ < 0 + var_284_1 + arg_284_0 then
				arg_281_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(0, -1.73, -5.5)
				arg_281_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10150ui_story"].transform.position).z)
				arg_281_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["10150ui_story"].transform.localEulerAngles = arg_281_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_284_2 = GameObjectTools.GetOrAddComponent(arg_281_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_284_2 then
					var_284_2:EnableDynamicBone(true)
				end
			end

			local var_284_3 = arg_281_1.actors_["4037ui_story"].transform

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos4037ui_story = var_284_3.localPosition
			end

			local var_284_4 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_4 then
				var_284_3.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_281_1.time_ - 0) / var_284_4)
				var_284_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_3.position).x, (manager.ui.mainCamera.transform.position - var_284_3.position).y, (manager.ui.mainCamera.transform.position - var_284_3.position).z)
				var_284_3.localEulerAngles.z = 0
				var_284_3.localEulerAngles.x = 0
				var_284_3.localEulerAngles = var_284_3.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_4 and arg_281_1.time_ < 0 + var_284_4 + arg_284_0 then
				var_284_3.localPosition = Vector3.New(0, 100, 0)
				var_284_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_3.position).x, (manager.ui.mainCamera.transform.position - var_284_3.position).y, (manager.ui.mainCamera.transform.position - var_284_3.position).z)
				var_284_3.localEulerAngles.z = 0
				var_284_3.localEulerAngles.x = 0
				var_284_3.localEulerAngles = var_284_3.localEulerAngles
			end

			local var_284_5 = arg_281_1.actors_["10150ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_5) and arg_281_1.var_.characterEffect10150ui_story == nil then
				arg_281_1.var_.characterEffect10150ui_story = var_284_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_6 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_6 and not isNil(var_284_5) then
				if arg_281_1.var_.characterEffect10150ui_story and not isNil(var_284_5) then
					arg_281_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_6 and arg_281_1.time_ < 0 + var_284_6 + arg_284_0 and not isNil(var_284_5) and arg_281_1.var_.characterEffect10150ui_story then
				arg_281_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_284_8 = arg_281_1.actors_["4037ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_8) and arg_281_1.var_.characterEffect4037ui_story == nil then
				arg_281_1.var_.characterEffect4037ui_story = var_284_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_9 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_9 and not isNil(var_284_8) then
				if arg_281_1.var_.characterEffect4037ui_story and not isNil(var_284_8) then
					arg_281_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_281_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_9)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_9 and arg_281_1.time_ < 0 + var_284_9 + arg_284_0 and not isNil(var_284_8) and arg_281_1.var_.characterEffect4037ui_story then
				arg_281_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_281_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action3_1")
			end

			local var_284_10 = 0
			local var_284_11 = 0.275

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_10 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_12 = arg_281_1:GetWordFromCfg(322121069)
				local var_284_13 = arg_281_1:FormatText(var_284_12.content)

				arg_281_1.text_.text = var_284_13

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_15 = 11 <= 0 and var_284_11 or var_284_11 * (utf8.len(var_284_13) / 11)

				if (11 <= 0 and var_284_11 or var_284_11 * (utf8.len(var_284_13) / 11)) > 0 and var_284_11 < var_284_15 then
					arg_281_1.talkMaxDuration = var_284_15

					if var_284_15 + var_284_10 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_15 + var_284_10
					end
				end

				arg_281_1.text_.text = var_284_13
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121069", "story_v_out_322121.awb") ~= 0 then
					local var_284_16 = manager.audio:GetVoiceLength("story_v_out_322121", "322121069", "story_v_out_322121.awb") / 1000

					if var_284_16 + var_284_10 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_16 + var_284_10
					end

					if var_284_12.prefab_name ~= "" and arg_281_1.actors_[var_284_12.prefab_name] ~= nil then
						local var_284_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_12.prefab_name].transform, "story_v_out_322121", "322121069", "story_v_out_322121.awb")

						arg_281_1:RecordAudio("322121069", var_284_17)
						arg_281_1:RecordAudio("322121069", var_284_17)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_322121", "322121069", "story_v_out_322121.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_322121", "322121069", "story_v_out_322121.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_18 = math.max(var_284_11, arg_281_1.talkMaxDuration)

			if var_284_10 <= arg_281_1.time_ and arg_281_1.time_ < var_284_10 + var_284_18 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_10) / var_284_18

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_10 + var_284_18 and arg_281_1.time_ < var_284_10 + var_284_18 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play322121070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 322121070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play322121071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos10150ui_story = arg_285_1.actors_["10150ui_story"].transform.localPosition

				local var_288_0 = GameObjectTools.GetOrAddComponent(arg_285_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_288_0 then
					var_288_0:EnableDynamicBone(false)
				end
			end

			local var_288_1 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_1 then
				arg_285_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10150ui_story, Vector3.New(0, 100, 0), (arg_285_1.time_ - 0) / var_288_1)
				arg_285_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["10150ui_story"].transform.position).z)
				arg_285_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["10150ui_story"].transform.localEulerAngles = arg_285_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_1 and arg_285_1.time_ < 0 + var_288_1 + arg_288_0 then
				arg_285_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_285_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["10150ui_story"].transform.position).z)
				arg_285_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["10150ui_story"].transform.localEulerAngles = arg_285_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_288_2 = GameObjectTools.GetOrAddComponent(arg_285_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_288_2 then
					var_288_2:EnableDynamicBone(true)
				end
			end

			if 0.1 < arg_285_1.time_ and arg_285_1.time_ <= 0.1 + arg_288_0 then
				arg_285_1:AudioAction("play", "effect", "se_story_140", "se_story_140_drop02", "")
			end

			local var_288_4 = 0
			local var_288_5 = 1.15

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_6 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(322121070).content)

				arg_285_1.text_.text = var_288_6

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_8 = 46 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_6) / 46)

				if (46 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_6) / 46)) > 0 and var_288_5 < var_288_8 then
					arg_285_1.talkMaxDuration = var_288_8

					if var_288_8 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_8 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_6
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_9 = math.max(var_288_5, arg_285_1.talkMaxDuration)

			if var_288_4 <= arg_285_1.time_ and arg_285_1.time_ < var_288_4 + var_288_9 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_4) / var_288_9

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_4 + var_288_9 and arg_285_1.time_ < var_288_4 + var_288_9 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play322121071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 322121071
		arg_289_1.duration_ = 5.5

		local var_289_0 = {
			zh = 4.533,
			ja = 5.5
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play322121072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos4037ui_story = arg_289_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_292_0 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 then
				arg_289_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos4037ui_story, Vector3.New(-0.7, -1.12, -6.2), (arg_289_1.time_ - 0) / var_292_0)
				arg_289_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["4037ui_story"].transform.position).z)
				arg_289_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["4037ui_story"].transform.localEulerAngles = arg_289_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 then
				arg_289_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(-0.7, -1.12, -6.2)
				arg_289_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["4037ui_story"].transform.position).z)
				arg_289_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["4037ui_story"].transform.localEulerAngles = arg_289_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_292_1 = arg_289_1.actors_["4037ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect4037ui_story == nil then
				arg_289_1.var_.characterEffect4037ui_story = var_292_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_2 and not isNil(var_292_1) then
				if arg_289_1.var_.characterEffect4037ui_story and not isNil(var_292_1) then
					arg_289_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_2 and arg_289_1.time_ < 0 + var_292_2 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect4037ui_story then
				arg_289_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_292_4 = 0
			local var_292_5 = 0.35

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_6 = arg_289_1:GetWordFromCfg(322121071)
				local var_292_7 = arg_289_1:FormatText(var_292_6.content)

				arg_289_1.text_.text = var_292_7

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_9 = 14 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 14)

				if (14 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 14)) > 0 and var_292_5 < var_292_9 then
					arg_289_1.talkMaxDuration = var_292_9

					if var_292_9 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_9 + var_292_4
					end
				end

				arg_289_1.text_.text = var_292_7
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121071", "story_v_out_322121.awb") ~= 0 then
					local var_292_10 = manager.audio:GetVoiceLength("story_v_out_322121", "322121071", "story_v_out_322121.awb") / 1000

					if var_292_10 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_4
					end

					if var_292_6.prefab_name ~= "" and arg_289_1.actors_[var_292_6.prefab_name] ~= nil then
						local var_292_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_6.prefab_name].transform, "story_v_out_322121", "322121071", "story_v_out_322121.awb")

						arg_289_1:RecordAudio("322121071", var_292_11)
						arg_289_1:RecordAudio("322121071", var_292_11)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_322121", "322121071", "story_v_out_322121.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_322121", "322121071", "story_v_out_322121.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_12 = math.max(var_292_5, arg_289_1.talkMaxDuration)

			if var_292_4 <= arg_289_1.time_ and arg_289_1.time_ < var_292_4 + var_292_12 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_4) / var_292_12

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_4 + var_292_12 and arg_289_1.time_ < var_292_4 + var_292_12 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play322121072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 322121072
		arg_293_1.duration_ = 5.63

		local var_293_0 = {
			zh = 5.633,
			ja = 5.333
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play322121073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos10150ui_story = arg_293_1.actors_["10150ui_story"].transform.localPosition

				local var_296_0 = GameObjectTools.GetOrAddComponent(arg_293_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_296_0 then
					var_296_0:EnableDynamicBone(false)
				end
			end

			local var_296_1 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_1 then
				arg_293_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10150ui_story, Vector3.New(0.9, -1.73, -5.5), (arg_293_1.time_ - 0) / var_296_1)
				arg_293_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10150ui_story"].transform.position).z)
				arg_293_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["10150ui_story"].transform.localEulerAngles = arg_293_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_1 and arg_293_1.time_ < 0 + var_296_1 + arg_296_0 then
				arg_293_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(0.9, -1.73, -5.5)
				arg_293_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10150ui_story"].transform.position).z)
				arg_293_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["10150ui_story"].transform.localEulerAngles = arg_293_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_296_2 = GameObjectTools.GetOrAddComponent(arg_293_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_296_2 then
					var_296_2:EnableDynamicBone(true)
				end
			end

			local var_296_3 = arg_293_1.actors_["10150ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_3) and arg_293_1.var_.characterEffect10150ui_story == nil then
				arg_293_1.var_.characterEffect10150ui_story = var_296_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_4 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_4 and not isNil(var_296_3) then
				if arg_293_1.var_.characterEffect10150ui_story and not isNil(var_296_3) then
					arg_293_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_4 and arg_293_1.time_ < 0 + var_296_4 + arg_296_0 and not isNil(var_296_3) and arg_293_1.var_.characterEffect10150ui_story then
				arg_293_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_296_6 = arg_293_1.actors_["4037ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_6) and arg_293_1.var_.characterEffect4037ui_story == nil then
				arg_293_1.var_.characterEffect4037ui_story = var_296_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_7 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_7 and not isNil(var_296_6) then
				if arg_293_1.var_.characterEffect4037ui_story and not isNil(var_296_6) then
					arg_293_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_293_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_7)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_7 and arg_293_1.time_ < 0 + var_296_7 + arg_296_0 and not isNil(var_296_6) and arg_293_1.var_.characterEffect4037ui_story then
				arg_293_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_293_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_296_8 = 0
			local var_296_9 = 0.55

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_8 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_10 = arg_293_1:GetWordFromCfg(322121072)
				local var_296_11 = arg_293_1:FormatText(var_296_10.content)

				arg_293_1.text_.text = var_296_11

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_13 = 22 <= 0 and var_296_9 or var_296_9 * (utf8.len(var_296_11) / 22)

				if (22 <= 0 and var_296_9 or var_296_9 * (utf8.len(var_296_11) / 22)) > 0 and var_296_9 < var_296_13 then
					arg_293_1.talkMaxDuration = var_296_13

					if var_296_13 + var_296_8 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_13 + var_296_8
					end
				end

				arg_293_1.text_.text = var_296_11
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121072", "story_v_out_322121.awb") ~= 0 then
					local var_296_14 = manager.audio:GetVoiceLength("story_v_out_322121", "322121072", "story_v_out_322121.awb") / 1000

					if var_296_14 + var_296_8 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_14 + var_296_8
					end

					if var_296_10.prefab_name ~= "" and arg_293_1.actors_[var_296_10.prefab_name] ~= nil then
						local var_296_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_10.prefab_name].transform, "story_v_out_322121", "322121072", "story_v_out_322121.awb")

						arg_293_1:RecordAudio("322121072", var_296_15)
						arg_293_1:RecordAudio("322121072", var_296_15)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_322121", "322121072", "story_v_out_322121.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_322121", "322121072", "story_v_out_322121.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_16 = math.max(var_296_9, arg_293_1.talkMaxDuration)

			if var_296_8 <= arg_293_1.time_ and arg_293_1.time_ < var_296_8 + var_296_16 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_8) / var_296_16

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_8 + var_296_16 and arg_293_1.time_ < var_296_8 + var_296_16 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play322121073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 322121073
		arg_297_1.duration_ = 2.8

		local var_297_0 = {
			zh = 2.366,
			ja = 2.8
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
				arg_297_0:Play322121074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos4037ui_story = arg_297_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_300_0 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 then
				arg_297_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos4037ui_story, Vector3.New(-0.7, -1.12, -6.2), (arg_297_1.time_ - 0) / var_300_0)
				arg_297_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["4037ui_story"].transform.position).z)
				arg_297_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["4037ui_story"].transform.localEulerAngles = arg_297_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 then
				arg_297_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(-0.7, -1.12, -6.2)
				arg_297_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["4037ui_story"].transform.position).z)
				arg_297_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["4037ui_story"].transform.localEulerAngles = arg_297_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_300_1 = arg_297_1.actors_["4037ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect4037ui_story == nil then
				arg_297_1.var_.characterEffect4037ui_story = var_300_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_2 and not isNil(var_300_1) then
				if arg_297_1.var_.characterEffect4037ui_story and not isNil(var_300_1) then
					arg_297_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_2 and arg_297_1.time_ < 0 + var_300_2 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect4037ui_story then
				arg_297_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_300_4 = arg_297_1.actors_["10150ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_4) and arg_297_1.var_.characterEffect10150ui_story == nil then
				arg_297_1.var_.characterEffect10150ui_story = var_300_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_5 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_5 and not isNil(var_300_4) then
				if arg_297_1.var_.characterEffect10150ui_story and not isNil(var_300_4) then
					arg_297_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_297_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_5)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_5 and arg_297_1.time_ < 0 + var_300_5 + arg_300_0 and not isNil(var_300_4) and arg_297_1.var_.characterEffect10150ui_story then
				arg_297_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_297_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action4_1")
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_300_6 = 0
			local var_300_7 = 0.3

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_6 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_8 = arg_297_1:GetWordFromCfg(322121073)
				local var_300_9 = arg_297_1:FormatText(var_300_8.content)

				arg_297_1.text_.text = var_300_9

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_11 = 12 <= 0 and var_300_7 or var_300_7 * (utf8.len(var_300_9) / 12)

				if (12 <= 0 and var_300_7 or var_300_7 * (utf8.len(var_300_9) / 12)) > 0 and var_300_7 < var_300_11 then
					arg_297_1.talkMaxDuration = var_300_11

					if var_300_11 + var_300_6 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_11 + var_300_6
					end
				end

				arg_297_1.text_.text = var_300_9
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121073", "story_v_out_322121.awb") ~= 0 then
					local var_300_12 = manager.audio:GetVoiceLength("story_v_out_322121", "322121073", "story_v_out_322121.awb") / 1000

					if var_300_12 + var_300_6 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_12 + var_300_6
					end

					if var_300_8.prefab_name ~= "" and arg_297_1.actors_[var_300_8.prefab_name] ~= nil then
						local var_300_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_8.prefab_name].transform, "story_v_out_322121", "322121073", "story_v_out_322121.awb")

						arg_297_1:RecordAudio("322121073", var_300_13)
						arg_297_1:RecordAudio("322121073", var_300_13)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_322121", "322121073", "story_v_out_322121.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_322121", "322121073", "story_v_out_322121.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_14 = math.max(var_300_7, arg_297_1.talkMaxDuration)

			if var_300_6 <= arg_297_1.time_ and arg_297_1.time_ < var_300_6 + var_300_14 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_6) / var_300_14

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_6 + var_300_14 and arg_297_1.time_ < var_300_6 + var_300_14 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
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
	Play322121074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 322121074
		arg_301_1.duration_ = 2.63

		local var_301_0 = {
			zh = 2.633,
			ja = 2.466
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play322121075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action4_2")
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_304_0 = 0
			local var_304_1 = 0.2

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_2 = arg_301_1:GetWordFromCfg(322121074)
				local var_304_3 = arg_301_1:FormatText(var_304_2.content)

				arg_301_1.text_.text = var_304_3

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 8 <= 0 and var_304_1 or var_304_1 * (utf8.len(var_304_3) / 8)

				if (8 <= 0 and var_304_1 or var_304_1 * (utf8.len(var_304_3) / 8)) > 0 and var_304_1 < var_304_5 then
					arg_301_1.talkMaxDuration = var_304_5

					if var_304_5 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_3
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121074", "story_v_out_322121.awb") ~= 0 then
					local var_304_6 = manager.audio:GetVoiceLength("story_v_out_322121", "322121074", "story_v_out_322121.awb") / 1000

					if var_304_6 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_6 + var_304_0
					end

					if var_304_2.prefab_name ~= "" and arg_301_1.actors_[var_304_2.prefab_name] ~= nil then
						local var_304_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_2.prefab_name].transform, "story_v_out_322121", "322121074", "story_v_out_322121.awb")

						arg_301_1:RecordAudio("322121074", var_304_7)
						arg_301_1:RecordAudio("322121074", var_304_7)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_322121", "322121074", "story_v_out_322121.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_322121", "322121074", "story_v_out_322121.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_8 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_8 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_8

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_8 and arg_301_1.time_ < var_304_0 + var_304_8 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play322121075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 322121075
		arg_305_1.duration_ = 5.13

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play322121076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_9000

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos4037ui_story = arg_305_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_308_0 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 then
				arg_305_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_305_1.time_ - 0) / var_308_0)
				arg_305_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["4037ui_story"].transform.position).z)
				arg_305_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["4037ui_story"].transform.localEulerAngles = arg_305_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 then
				arg_305_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_305_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["4037ui_story"].transform.position).z)
				arg_305_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["4037ui_story"].transform.localEulerAngles = arg_305_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_308_1 = arg_305_1.actors_["10150ui_story"].transform

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos10150ui_story = var_308_1.localPosition

				local var_308_2 = GameObjectTools.GetOrAddComponent(var_308_1.gameObject, typeof(DynamicBoneHelper))

				if var_308_2 then
					var_308_2:EnableDynamicBone(false)
				end
			end

			local var_308_3 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_3 then
				var_308_1.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos10150ui_story, Vector3.New(0, 100, 0), (arg_305_1.time_ - 0) / var_308_3)
				var_308_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_308_1.position).x, (manager.ui.mainCamera.transform.position - var_308_1.position).y, (manager.ui.mainCamera.transform.position - var_308_1.position).z)
				var_308_1.localEulerAngles.z = 0
				var_308_1.localEulerAngles.x = 0
				var_308_1.localEulerAngles = var_308_1.localEulerAngles
			end

			if arg_305_1.time_ >= 0 + var_308_3 and arg_305_1.time_ < 0 + var_308_3 + arg_308_0 then
				var_308_1.localPosition = Vector3.New(0, 100, 0)
				var_308_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_308_1.position).x, (manager.ui.mainCamera.transform.position - var_308_1.position).y, (manager.ui.mainCamera.transform.position - var_308_1.position).z)
				var_308_1.localEulerAngles.z = 0
				var_308_1.localEulerAngles.x = 0
				var_308_1.localEulerAngles = var_308_1.localEulerAngles

				local var_308_4 = GameObjectTools.GetOrAddComponent(var_308_1.gameObject, typeof(DynamicBoneHelper))

				if var_308_4 then
					var_308_4:EnableDynamicBone(true)
				end
			end

			if 0.1 < arg_305_1.time_ and arg_305_1.time_ <= 0.1 + arg_308_0 then
				arg_305_1:AudioAction("play", "effect", "se_story_143", "se_story_143_flipper_attack", "")
			end

			if 0.1 < arg_305_1.time_ and arg_305_1.time_ <= 0.1 + arg_308_0 then
				local var_308_6 = arg_305_1.var_.effect1075

				if not arg_305_1.var_.effect1075 then
					var_308_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), manager.ui.mainCamera.transform)
					var_308_6.name = "1075"
					arg_305_1.var_.effect1075 = var_308_6
				else
					var_308_6.transform:SetParent(var_308_9000)
				end

				var_308_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_308_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.93333333333333 < arg_305_1.time_ and arg_305_1.time_ <= 2.93333333333333 + arg_308_0 then
				if arg_305_1.var_.effect1075 then
					Object.Destroy(arg_305_1.var_.effect1075)

					arg_305_1.var_.effect1075 = nil
				end
			end

			local var_308_9 = 0
			local var_308_10 = 1.675

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_9 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_11 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(322121075).content)

				arg_305_1.text_.text = var_308_11

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_13 = 67 <= 0 and var_308_10 or var_308_10 * (utf8.len(var_308_11) / 67)

				if (67 <= 0 and var_308_10 or var_308_10 * (utf8.len(var_308_11) / 67)) > 0 and var_308_10 < var_308_13 then
					arg_305_1.talkMaxDuration = var_308_13

					if var_308_13 + var_308_9 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_13 + var_308_9
					end
				end

				arg_305_1.text_.text = var_308_11
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_14 = math.max(var_308_10, arg_305_1.talkMaxDuration)

			if var_308_9 <= arg_305_1.time_ and arg_305_1.time_ < var_308_9 + var_308_14 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_9) / var_308_14

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_9 + var_308_14 and arg_305_1.time_ < var_308_9 + var_308_14 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10150ui_story",
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
	Play322121076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 322121076
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play322121077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_9000

			if 0.7 < arg_309_1.time_ and arg_309_1.time_ <= 0.7 + arg_312_0 then
				arg_309_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_footstep04", "")
			end

			if 0.7 < arg_309_1.time_ and arg_309_1.time_ <= 0.7 + arg_312_0 then
				local var_312_1 = arg_309_1.var_.effect1076

				if not arg_309_1.var_.effect1076 then
					var_312_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit_blue"), manager.ui.mainCamera.transform)
					var_312_1.name = "1076"
					arg_309_1.var_.effect1076 = var_312_1
				else
					var_312_1.transform:SetParent(var_312_9000)
				end

				var_312_1.transform.localPosition = Vector3.New(0.36, 0.57, 0)
				var_312_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.93333333333333 < arg_309_1.time_ and arg_309_1.time_ <= 1.93333333333333 + arg_312_0 then
				if arg_309_1.var_.effect1076 then
					Object.Destroy(arg_309_1.var_.effect1076)

					arg_309_1.var_.effect1076 = nil
				end
			end

			local var_312_4 = 0
			local var_312_5 = 1.3

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_6 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(322121076).content)

				arg_309_1.text_.text = var_312_6

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_8 = 52 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_6) / 52)

				if (52 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_6) / 52)) > 0 and var_312_5 < var_312_8 then
					arg_309_1.talkMaxDuration = var_312_8

					if var_312_8 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_8 + var_312_4
					end
				end

				arg_309_1.text_.text = var_312_6
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_9 = math.max(var_312_5, arg_309_1.talkMaxDuration)

			if var_312_4 <= arg_309_1.time_ and arg_309_1.time_ < var_312_4 + var_312_9 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_4) / var_312_9

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_4 + var_312_9 and arg_309_1.time_ < var_312_4 + var_312_9 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play322121077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 322121077
		arg_313_1.duration_ = 4.13

		local var_313_0 = {
			zh = 3.133,
			ja = 4.133
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play322121078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if arg_313_1.actors_["1043ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1043ui_story"))) then
				local var_316_0 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_313_1.stage_.transform)

				var_316_0.name = "1043ui_story"
				var_316_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_313_1.actors_["1043ui_story"] = var_316_0

				local var_316_1 = var_316_0:GetComponentInChildren(typeof(CharacterEffect))

				var_316_1.enabled = true

				local var_316_2 = GameObjectTools.GetOrAddComponent(var_316_0, typeof(DynamicBoneHelper))

				if var_316_2 then
					var_316_2:EnableDynamicBone(false)
				end

				arg_313_1:ShowWeapon(var_316_1.transform, false)

				arg_313_1.var_["1043ui_story" .. "Animator"] = var_316_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_313_1.var_["1043ui_story" .. "Animator"].applyRootMotion = true
				arg_313_1.var_["1043ui_story" .. "LipSync"] = var_316_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_316_3 = arg_313_1.actors_["1043ui_story"].transform

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1043ui_story = var_316_3.localPosition
			end

			local var_316_4 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_4 then
				var_316_3.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_313_1.time_ - 0) / var_316_4)
				var_316_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_316_3.position).x, (manager.ui.mainCamera.transform.position - var_316_3.position).y, (manager.ui.mainCamera.transform.position - var_316_3.position).z)
				var_316_3.localEulerAngles.z = 0
				var_316_3.localEulerAngles.x = 0
				var_316_3.localEulerAngles = var_316_3.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_4 and arg_313_1.time_ < 0 + var_316_4 + arg_316_0 then
				var_316_3.localPosition = Vector3.New(0.01, -1.01, -5.73)
				var_316_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_316_3.position).x, (manager.ui.mainCamera.transform.position - var_316_3.position).y, (manager.ui.mainCamera.transform.position - var_316_3.position).z)
				var_316_3.localEulerAngles.z = 0
				var_316_3.localEulerAngles.x = 0
				var_316_3.localEulerAngles = var_316_3.localEulerAngles
			end

			local var_316_5 = arg_313_1.actors_["1043ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_5) and arg_313_1.var_.characterEffect1043ui_story == nil then
				arg_313_1.var_.characterEffect1043ui_story = var_316_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_6 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_6 and not isNil(var_316_5) then
				if arg_313_1.var_.characterEffect1043ui_story and not isNil(var_316_5) then
					arg_313_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_6 and arg_313_1.time_ < 0 + var_316_6 + arg_316_0 and not isNil(var_316_5) and arg_313_1.var_.characterEffect1043ui_story then
				arg_313_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_316_8 = 0
			local var_316_9 = 0.275

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_8 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_10 = arg_313_1:GetWordFromCfg(322121077)
				local var_316_11 = arg_313_1:FormatText(var_316_10.content)

				arg_313_1.text_.text = var_316_11

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_13 = 11 <= 0 and var_316_9 or var_316_9 * (utf8.len(var_316_11) / 11)

				if (11 <= 0 and var_316_9 or var_316_9 * (utf8.len(var_316_11) / 11)) > 0 and var_316_9 < var_316_13 then
					arg_313_1.talkMaxDuration = var_316_13

					if var_316_13 + var_316_8 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_13 + var_316_8
					end
				end

				arg_313_1.text_.text = var_316_11
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121077", "story_v_out_322121.awb") ~= 0 then
					local var_316_14 = manager.audio:GetVoiceLength("story_v_out_322121", "322121077", "story_v_out_322121.awb") / 1000

					if var_316_14 + var_316_8 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_14 + var_316_8
					end

					if var_316_10.prefab_name ~= "" and arg_313_1.actors_[var_316_10.prefab_name] ~= nil then
						local var_316_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_10.prefab_name].transform, "story_v_out_322121", "322121077", "story_v_out_322121.awb")

						arg_313_1:RecordAudio("322121077", var_316_15)
						arg_313_1:RecordAudio("322121077", var_316_15)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_322121", "322121077", "story_v_out_322121.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_322121", "322121077", "story_v_out_322121.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_16 = math.max(var_316_9, arg_313_1.talkMaxDuration)

			if var_316_8 <= arg_313_1.time_ and arg_313_1.time_ < var_316_8 + var_316_16 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_8) / var_316_16

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_8 + var_316_16 and arg_313_1.time_ < var_316_8 + var_316_16 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play322121078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 322121078
		arg_317_1.duration_ = 7.13

		local var_317_0 = {
			zh = 6.666,
			ja = 7.133
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play322121079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos4037ui_story = arg_317_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_320_0 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 then
				arg_317_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos4037ui_story, Vector3.New(0.7, -1.12, -6.2), (arg_317_1.time_ - 0) / var_320_0)
				arg_317_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["4037ui_story"].transform.position).z)
				arg_317_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["4037ui_story"].transform.localEulerAngles = arg_317_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 then
				arg_317_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -6.2)
				arg_317_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["4037ui_story"].transform.position).z)
				arg_317_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["4037ui_story"].transform.localEulerAngles = arg_317_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_320_1 = arg_317_1.actors_["1043ui_story"].transform

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1043ui_story = var_320_1.localPosition
			end

			local var_320_2 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_2 then
				var_320_1.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1043ui_story, Vector3.New(-0.92, -1.01, -5.73), (arg_317_1.time_ - 0) / var_320_2)
				var_320_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_320_1.position).x, (manager.ui.mainCamera.transform.position - var_320_1.position).y, (manager.ui.mainCamera.transform.position - var_320_1.position).z)
				var_320_1.localEulerAngles.z = 0
				var_320_1.localEulerAngles.x = 0
				var_320_1.localEulerAngles = var_320_1.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_2 and arg_317_1.time_ < 0 + var_320_2 + arg_320_0 then
				var_320_1.localPosition = Vector3.New(-0.92, -1.01, -5.73)
				var_320_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_320_1.position).x, (manager.ui.mainCamera.transform.position - var_320_1.position).y, (manager.ui.mainCamera.transform.position - var_320_1.position).z)
				var_320_1.localEulerAngles.z = 0
				var_320_1.localEulerAngles.x = 0
				var_320_1.localEulerAngles = var_320_1.localEulerAngles
			end

			local var_320_3 = arg_317_1.actors_["4037ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_3) and arg_317_1.var_.characterEffect4037ui_story == nil then
				arg_317_1.var_.characterEffect4037ui_story = var_320_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_4 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 and not isNil(var_320_3) then
				if arg_317_1.var_.characterEffect4037ui_story and not isNil(var_320_3) then
					arg_317_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 and not isNil(var_320_3) and arg_317_1.var_.characterEffect4037ui_story then
				arg_317_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_320_6 = arg_317_1.actors_["1043ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_6) and arg_317_1.var_.characterEffect1043ui_story == nil then
				arg_317_1.var_.characterEffect1043ui_story = var_320_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_7 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_7 and not isNil(var_320_6) then
				if arg_317_1.var_.characterEffect1043ui_story and not isNil(var_320_6) then
					arg_317_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_7)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_7 and arg_317_1.time_ < 0 + var_320_7 + arg_320_0 and not isNil(var_320_6) and arg_317_1.var_.characterEffect1043ui_story then
				arg_317_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_320_8 = 0
			local var_320_9 = 0.475

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_8 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_10 = arg_317_1:GetWordFromCfg(322121078)
				local var_320_11 = arg_317_1:FormatText(var_320_10.content)

				arg_317_1.text_.text = var_320_11

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_13 = 19 <= 0 and var_320_9 or var_320_9 * (utf8.len(var_320_11) / 19)

				if (19 <= 0 and var_320_9 or var_320_9 * (utf8.len(var_320_11) / 19)) > 0 and var_320_9 < var_320_13 then
					arg_317_1.talkMaxDuration = var_320_13

					if var_320_13 + var_320_8 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_13 + var_320_8
					end
				end

				arg_317_1.text_.text = var_320_11
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121078", "story_v_out_322121.awb") ~= 0 then
					local var_320_14 = manager.audio:GetVoiceLength("story_v_out_322121", "322121078", "story_v_out_322121.awb") / 1000

					if var_320_14 + var_320_8 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_14 + var_320_8
					end

					if var_320_10.prefab_name ~= "" and arg_317_1.actors_[var_320_10.prefab_name] ~= nil then
						local var_320_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_10.prefab_name].transform, "story_v_out_322121", "322121078", "story_v_out_322121.awb")

						arg_317_1:RecordAudio("322121078", var_320_15)
						arg_317_1:RecordAudio("322121078", var_320_15)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_322121", "322121078", "story_v_out_322121.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_322121", "322121078", "story_v_out_322121.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_16 = math.max(var_320_9, arg_317_1.talkMaxDuration)

			if var_320_8 <= arg_317_1.time_ and arg_317_1.time_ < var_320_8 + var_320_16 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_8) / var_320_16

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_8 + var_320_16 and arg_317_1.time_ < var_320_8 + var_320_16 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
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
	Play322121079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 322121079
		arg_321_1.duration_ = 7

		local var_321_0 = {
			zh = 3.366,
			ja = 7
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play322121080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.35

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_1 = arg_321_1:GetWordFromCfg(322121079)
				local var_324_2 = arg_321_1:FormatText(var_324_1.content)

				arg_321_1.text_.text = var_324_2

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_4 = 14 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 14)

				if (14 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 14)) > 0 and var_324_0 < var_324_4 then
					arg_321_1.talkMaxDuration = var_324_4

					if var_324_4 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_4 + 0
					end
				end

				arg_321_1.text_.text = var_324_2
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121079", "story_v_out_322121.awb") ~= 0 then
					local var_324_5 = manager.audio:GetVoiceLength("story_v_out_322121", "322121079", "story_v_out_322121.awb") / 1000

					if var_324_5 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + 0
					end

					if var_324_1.prefab_name ~= "" and arg_321_1.actors_[var_324_1.prefab_name] ~= nil then
						local var_324_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_1.prefab_name].transform, "story_v_out_322121", "322121079", "story_v_out_322121.awb")

						arg_321_1:RecordAudio("322121079", var_324_6)
						arg_321_1:RecordAudio("322121079", var_324_6)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_322121", "322121079", "story_v_out_322121.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_322121", "322121079", "story_v_out_322121.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_7 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_7 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_7

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_7 and arg_321_1.time_ < 0 + var_324_7 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play322121080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 322121080
		arg_325_1.duration_ = 3.73

		local var_325_0 = {
			zh = 3.7,
			ja = 3.733
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play322121081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action3_1")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_328_0 = 0
			local var_328_1 = 0.25

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_2 = arg_325_1:GetWordFromCfg(322121080)
				local var_328_3 = arg_325_1:FormatText(var_328_2.content)

				arg_325_1.text_.text = var_328_3

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 10 <= 0 and var_328_1 or var_328_1 * (utf8.len(var_328_3) / 10)

				if (10 <= 0 and var_328_1 or var_328_1 * (utf8.len(var_328_3) / 10)) > 0 and var_328_1 < var_328_5 then
					arg_325_1.talkMaxDuration = var_328_5

					if var_328_5 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + var_328_0
					end
				end

				arg_325_1.text_.text = var_328_3
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121080", "story_v_out_322121.awb") ~= 0 then
					local var_328_6 = manager.audio:GetVoiceLength("story_v_out_322121", "322121080", "story_v_out_322121.awb") / 1000

					if var_328_6 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_6 + var_328_0
					end

					if var_328_2.prefab_name ~= "" and arg_325_1.actors_[var_328_2.prefab_name] ~= nil then
						local var_328_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_2.prefab_name].transform, "story_v_out_322121", "322121080", "story_v_out_322121.awb")

						arg_325_1:RecordAudio("322121080", var_328_7)
						arg_325_1:RecordAudio("322121080", var_328_7)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_322121", "322121080", "story_v_out_322121.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_322121", "322121080", "story_v_out_322121.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_8 = math.max(var_328_1, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_8 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_0) / var_328_8

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_8 and arg_325_1.time_ < var_328_0 + var_328_8 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play322121081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 322121081
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play322121082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1043ui_story = arg_329_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_332_0 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 then
				arg_329_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_329_1.time_ - 0) / var_332_0)
				arg_329_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1043ui_story"].transform.position).z)
				arg_329_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1043ui_story"].transform.localEulerAngles = arg_329_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 then
				arg_329_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_329_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1043ui_story"].transform.position).z)
				arg_329_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1043ui_story"].transform.localEulerAngles = arg_329_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_332_1 = arg_329_1.actors_["4037ui_story"].transform

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos4037ui_story = var_332_1.localPosition
			end

			local var_332_2 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_2 then
				var_332_1.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_329_1.time_ - 0) / var_332_2)
				var_332_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_1.position).x, (manager.ui.mainCamera.transform.position - var_332_1.position).y, (manager.ui.mainCamera.transform.position - var_332_1.position).z)
				var_332_1.localEulerAngles.z = 0
				var_332_1.localEulerAngles.x = 0
				var_332_1.localEulerAngles = var_332_1.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_2 and arg_329_1.time_ < 0 + var_332_2 + arg_332_0 then
				var_332_1.localPosition = Vector3.New(0, 100, 0)
				var_332_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_1.position).x, (manager.ui.mainCamera.transform.position - var_332_1.position).y, (manager.ui.mainCamera.transform.position - var_332_1.position).z)
				var_332_1.localEulerAngles.z = 0
				var_332_1.localEulerAngles.x = 0
				var_332_1.localEulerAngles = var_332_1.localEulerAngles
			end

			local var_332_3 = 0
			local var_332_4 = 1.625

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_3 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_5 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(322121081).content)

				arg_329_1.text_.text = var_332_5

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_7 = 65 <= 0 and var_332_4 or var_332_4 * (utf8.len(var_332_5) / 65)

				if (65 <= 0 and var_332_4 or var_332_4 * (utf8.len(var_332_5) / 65)) > 0 and var_332_4 < var_332_7 then
					arg_329_1.talkMaxDuration = var_332_7

					if var_332_7 + var_332_3 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_7 + var_332_3
					end
				end

				arg_329_1.text_.text = var_332_5
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_8 = math.max(var_332_4, arg_329_1.talkMaxDuration)

			if var_332_3 <= arg_329_1.time_ and arg_329_1.time_ < var_332_3 + var_332_8 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_3) / var_332_8

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_3 + var_332_8 and arg_329_1.time_ < var_332_3 + var_332_8 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
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
	Play322121082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 322121082
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play322121083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 1.05

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_1 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(322121082).content)

				arg_333_1.text_.text = var_336_1

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_3 = 42 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_1) / 42)

				if (42 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_1) / 42)) > 0 and var_336_0 < var_336_3 then
					arg_333_1.talkMaxDuration = var_336_3

					if var_336_3 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_3 + 0
					end
				end

				arg_333_1.text_.text = var_336_1
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_4 = math.max(var_336_0, arg_333_1.talkMaxDuration)

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_4 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - 0) / var_336_4

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= 0 + var_336_4 and arg_333_1.time_ < 0 + var_336_4 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play322121083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 322121083
		arg_337_1.duration_ = 2

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play322121084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos10150ui_story = arg_337_1.actors_["10150ui_story"].transform.localPosition

				local var_340_0 = GameObjectTools.GetOrAddComponent(arg_337_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_340_0 then
					var_340_0:EnableDynamicBone(false)
				end
			end

			local var_340_1 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_1 then
				arg_337_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos10150ui_story, Vector3.New(0, -1.73, -5.5), (arg_337_1.time_ - 0) / var_340_1)
				arg_337_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["10150ui_story"].transform.position).z)
				arg_337_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["10150ui_story"].transform.localEulerAngles = arg_337_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_337_1.time_ >= 0 + var_340_1 and arg_337_1.time_ < 0 + var_340_1 + arg_340_0 then
				arg_337_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(0, -1.73, -5.5)
				arg_337_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["10150ui_story"].transform.position).z)
				arg_337_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["10150ui_story"].transform.localEulerAngles = arg_337_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_340_2 = GameObjectTools.GetOrAddComponent(arg_337_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_340_2 then
					var_340_2:EnableDynamicBone(true)
				end
			end

			local var_340_3 = arg_337_1.actors_["10150ui_story"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_3) and arg_337_1.var_.characterEffect10150ui_story == nil then
				arg_337_1.var_.characterEffect10150ui_story = var_340_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_4 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_4 and not isNil(var_340_3) then
				if arg_337_1.var_.characterEffect10150ui_story and not isNil(var_340_3) then
					arg_337_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= 0 + var_340_4 and arg_337_1.time_ < 0 + var_340_4 + arg_340_0 and not isNil(var_340_3) and arg_337_1.var_.characterEffect10150ui_story then
				arg_337_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action3_1")
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:AudioAction("play", "music", "bgm_activity_4_5_story_serious", "battle", "bgm_activity_4_5_story_serious.awb")

				local var_340_8 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "battle")

				if "" ~= "" then
					if arg_337_1.bgmTxt_.text ~= var_340_8 and arg_337_1.bgmTxt_.text ~= "" then
						if arg_337_1.bgmTxt2_.text ~= "" then
							arg_337_1.bgmTxt_.text = arg_337_1.bgmTxt2_.text
						end

						arg_337_1.bgmTxt2_.text = var_340_8

						arg_337_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_337_1.bgmTxt_.text = var_340_8
						arg_337_1.bgmTxt2_.text = var_340_8
					end

					if arg_337_1.bgmTimer then
						arg_337_1.bgmTimer:Stop()

						arg_337_1.bgmTimer = nil
					end

					if arg_337_1.settingData.show_music_name == 1 then
						arg_337_1.musicController:SetSelectedState("show")
						arg_337_1.musicAnimator_:Play("open", 0, 0)

						if arg_337_1.settingData.music_time ~= 0 then
							arg_337_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_337_1.settingData.music_time), function()
								if arg_337_1 == nil or isNil(arg_337_1.bgmTxt_) then
									return
								end

								arg_337_1.musicController:SetSelectedState("hide")
								arg_337_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_340_9 = 0
			local var_340_10 = 0.1

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_9 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_11 = arg_337_1:GetWordFromCfg(322121083)
				local var_340_12 = arg_337_1:FormatText(var_340_11.content)

				arg_337_1.text_.text = var_340_12

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_14 = 4 <= 0 and var_340_10 or var_340_10 * (utf8.len(var_340_12) / 4)

				if (4 <= 0 and var_340_10 or var_340_10 * (utf8.len(var_340_12) / 4)) > 0 and var_340_10 < var_340_14 then
					arg_337_1.talkMaxDuration = var_340_14

					if var_340_14 + var_340_9 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_14 + var_340_9
					end
				end

				arg_337_1.text_.text = var_340_12
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121083", "story_v_out_322121.awb") ~= 0 then
					local var_340_15 = manager.audio:GetVoiceLength("story_v_out_322121", "322121083", "story_v_out_322121.awb") / 1000

					if var_340_15 + var_340_9 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_15 + var_340_9
					end

					if var_340_11.prefab_name ~= "" and arg_337_1.actors_[var_340_11.prefab_name] ~= nil then
						local var_340_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_11.prefab_name].transform, "story_v_out_322121", "322121083", "story_v_out_322121.awb")

						arg_337_1:RecordAudio("322121083", var_340_16)
						arg_337_1:RecordAudio("322121083", var_340_16)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_322121", "322121083", "story_v_out_322121.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_322121", "322121083", "story_v_out_322121.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_17 = math.max(var_340_10, arg_337_1.talkMaxDuration)

			if var_340_9 <= arg_337_1.time_ and arg_337_1.time_ < var_340_9 + var_340_17 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_9) / var_340_17

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_9 + var_340_17 and arg_337_1.time_ < var_340_9 + var_340_17 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_337_1:InitPlayNodeList()
	end,
	Play322121084 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 322121084
		arg_342_1.duration_ = 2.8

		local var_342_0 = {
			zh = 1.999999999999,
			ja = 2.8
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
			arg_342_1.auto_ = false
		end

		function arg_342_1.playNext_(arg_344_0)
			arg_342_1.onStoryFinished_()
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.var_.moveOldPos1043ui_story = arg_342_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_345_0 = 0.001

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 then
				arg_342_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_342_1.time_ - 0) / var_345_0)
				arg_342_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_342_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["1043ui_story"].transform.position).z)
				arg_342_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_342_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_342_1.actors_["1043ui_story"].transform.localEulerAngles = arg_342_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 then
				arg_342_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.81, -1.01, -5.73)
				arg_342_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_342_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["1043ui_story"].transform.position).z)
				arg_342_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_342_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_342_1.actors_["1043ui_story"].transform.localEulerAngles = arg_342_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_345_1 = arg_342_1.actors_["10150ui_story"].transform

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.var_.moveOldPos10150ui_story = var_345_1.localPosition

				local var_345_2 = GameObjectTools.GetOrAddComponent(var_345_1.gameObject, typeof(DynamicBoneHelper))

				if var_345_2 then
					var_345_2:EnableDynamicBone(false)
				end
			end

			local var_345_3 = 0.001

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_3 then
				var_345_1.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos10150ui_story, Vector3.New(-0.9, -1.73, -5.5), (arg_342_1.time_ - 0) / var_345_3)
				var_345_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_345_1.position).x, (manager.ui.mainCamera.transform.position - var_345_1.position).y, (manager.ui.mainCamera.transform.position - var_345_1.position).z)
				var_345_1.localEulerAngles.z = 0
				var_345_1.localEulerAngles.x = 0
				var_345_1.localEulerAngles = var_345_1.localEulerAngles
			end

			if arg_342_1.time_ >= 0 + var_345_3 and arg_342_1.time_ < 0 + var_345_3 + arg_345_0 then
				var_345_1.localPosition = Vector3.New(-0.9, -1.73, -5.5)
				var_345_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_345_1.position).x, (manager.ui.mainCamera.transform.position - var_345_1.position).y, (manager.ui.mainCamera.transform.position - var_345_1.position).z)
				var_345_1.localEulerAngles.z = 0
				var_345_1.localEulerAngles.x = 0
				var_345_1.localEulerAngles = var_345_1.localEulerAngles

				local var_345_4 = GameObjectTools.GetOrAddComponent(var_345_1.gameObject, typeof(DynamicBoneHelper))

				if var_345_4 then
					var_345_4:EnableDynamicBone(true)
				end
			end

			local var_345_5 = arg_342_1.actors_["1043ui_story"]

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(var_345_5) and arg_342_1.var_.characterEffect1043ui_story == nil then
				arg_342_1.var_.characterEffect1043ui_story = var_345_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_6 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_6 and not isNil(var_345_5) then
				if arg_342_1.var_.characterEffect1043ui_story and not isNil(var_345_5) then
					arg_342_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_342_1.time_ >= 0 + var_345_6 and arg_342_1.time_ < 0 + var_345_6 + arg_345_0 and not isNil(var_345_5) and arg_342_1.var_.characterEffect1043ui_story then
				arg_342_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_345_8 = arg_342_1.actors_["10150ui_story"]

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(var_345_8) and arg_342_1.var_.characterEffect10150ui_story == nil then
				arg_342_1.var_.characterEffect10150ui_story = var_345_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_9 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_9 and not isNil(var_345_8) then
				if arg_342_1.var_.characterEffect10150ui_story and not isNil(var_345_8) then
					arg_342_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_342_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_342_1.time_ - 0) / var_345_9)
				end
			end

			if arg_342_1.time_ >= 0 + var_345_9 and arg_342_1.time_ < 0 + var_345_9 + arg_345_0 and not isNil(var_345_8) and arg_342_1.var_.characterEffect10150ui_story then
				arg_342_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_342_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action2_1")
			end

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_345_10 = 0
			local var_345_11 = 0.2

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_10 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_12 = arg_342_1:GetWordFromCfg(322121084)
				local var_345_13 = arg_342_1:FormatText(var_345_12.content)

				arg_342_1.text_.text = var_345_13

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_15 = 8 <= 0 and var_345_11 or var_345_11 * (utf8.len(var_345_13) / 8)

				if (8 <= 0 and var_345_11 or var_345_11 * (utf8.len(var_345_13) / 8)) > 0 and var_345_11 < var_345_15 then
					arg_342_1.talkMaxDuration = var_345_15

					if var_345_15 + var_345_10 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_15 + var_345_10
					end
				end

				arg_342_1.text_.text = var_345_13
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322121", "322121084", "story_v_out_322121.awb") ~= 0 then
					local var_345_16 = manager.audio:GetVoiceLength("story_v_out_322121", "322121084", "story_v_out_322121.awb") / 1000

					if var_345_16 + var_345_10 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_16 + var_345_10
					end

					if var_345_12.prefab_name ~= "" and arg_342_1.actors_[var_345_12.prefab_name] ~= nil then
						local var_345_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_12.prefab_name].transform, "story_v_out_322121", "322121084", "story_v_out_322121.awb")

						arg_342_1:RecordAudio("322121084", var_345_17)
						arg_342_1:RecordAudio("322121084", var_345_17)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_322121", "322121084", "story_v_out_322121.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_322121", "322121084", "story_v_out_322121.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_18 = math.max(var_345_11, arg_342_1.talkMaxDuration)

			if var_345_10 <= arg_342_1.time_ and arg_342_1.time_ < var_345_10 + var_345_18 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_10) / var_345_18

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_10 + var_345_18 and arg_342_1.time_ < var_345_10 + var_345_18 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L14f",
		"TextureConfig/Background/L17f"
	},
	voices = {
		"story_v_out_322121.awb"
	}
}
