return {
	Play1104906001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1104906001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1104906002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST06 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST06")
				var_4_0.name = "ST06"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST06 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST06

				arg_1_1.bgs_.ST06.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST06" then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quietre.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			if 0.125 < arg_1_1.time_ and arg_1_1.time_ <= 0.125 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 2
			local var_4_17 = 0.675

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_18 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_18:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1104906001).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 27 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 27)

				if (27 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 27)) > 0 and var_4_17 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_16 = var_4_16 + 0.3

					if var_4_21 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_16 + 0.3
			local var_4_23 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_22) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1104906002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1104906002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1104906003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1104906002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 40 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 40)

				if (40 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 40)) > 0 and var_12_0 < var_12_3 then
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
	Play1104906003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1104906003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1104906004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.7

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1104906003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 28 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 28)

				if (28 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 28)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play1104906004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1104906004
		arg_17_1.duration_ = 2.23

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1104906005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1049ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1049ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1049ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1049ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1049ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1049ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1049ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1049ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["1049ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1049ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0, -1.2, -6)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["1049ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1049ui_story == nil then
				arg_17_1.var_.characterEffect1049ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect1049ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1049ui_story then
				arg_17_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_20_8 = 0
			local var_20_9 = 0.225

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(1104906004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 9 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 9)

				if (9 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 9)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906004", "story_v_side_new_1104906.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906004", "story_v_side_new_1104906.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_side_new_1104906", "1104906004", "story_v_side_new_1104906.awb")

						arg_17_1:RecordAudio("1104906004", var_20_15)
						arg_17_1:RecordAudio("1104906004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906004", "story_v_side_new_1104906.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906004", "story_v_side_new_1104906.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_16 and arg_17_1.time_ < var_20_8 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play1104906005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1104906005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1104906006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1049ui_story"]) and arg_21_1.var_.characterEffect1049ui_story == nil then
				arg_21_1.var_.characterEffect1049ui_story = arg_21_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1049ui_story"]) then
				if arg_21_1.var_.characterEffect1049ui_story and not isNil(arg_21_1.actors_["1049ui_story"]) then
					arg_21_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1049ui_story"]) and arg_21_1.var_.characterEffect1049ui_story then
				arg_21_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 0.4

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1104906005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 16 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 16)

				if (16 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 16)) > 0 and var_24_2 < var_24_5 then
					arg_21_1.talkMaxDuration = var_24_5

					if var_24_5 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_6 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_6 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_6

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_6 and arg_21_1.time_ < var_24_1 + var_24_6 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1104906006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1104906006
		arg_25_1.duration_ = 2.37

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1104906007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1049ui_story"]) and arg_25_1.var_.characterEffect1049ui_story == nil then
				arg_25_1.var_.characterEffect1049ui_story = arg_25_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1049ui_story"]) then
				if arg_25_1.var_.characterEffect1049ui_story and not isNil(arg_25_1.actors_["1049ui_story"]) then
					arg_25_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1049ui_story"]) and arg_25_1.var_.characterEffect1049ui_story then
				arg_25_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_28_2 = 0
			local var_28_3 = 0.275

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_4 = arg_25_1:GetWordFromCfg(1104906006)
				local var_28_5 = arg_25_1:FormatText(var_28_4.content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 11 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 11)

				if (11 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 11)) > 0 and var_28_3 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_2
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906006", "story_v_side_new_1104906.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906006", "story_v_side_new_1104906.awb") / 1000

					if var_28_8 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_2
					end

					if var_28_4.prefab_name ~= "" and arg_25_1.actors_[var_28_4.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_4.prefab_name].transform, "story_v_side_new_1104906", "1104906006", "story_v_side_new_1104906.awb")

						arg_25_1:RecordAudio("1104906006", var_28_9)
						arg_25_1:RecordAudio("1104906006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906006", "story_v_side_new_1104906.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906006", "story_v_side_new_1104906.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_3, arg_25_1.talkMaxDuration)

			if var_28_2 <= arg_25_1.time_ and arg_25_1.time_ < var_28_2 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_2) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_2 + var_28_10 and arg_25_1.time_ < var_28_2 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1104906007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1104906007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1104906008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1049ui_story"]) and arg_29_1.var_.characterEffect1049ui_story == nil then
				arg_29_1.var_.characterEffect1049ui_story = arg_29_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1049ui_story"]) then
				if arg_29_1.var_.characterEffect1049ui_story and not isNil(arg_29_1.actors_["1049ui_story"]) then
					arg_29_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1049ui_story"]) and arg_29_1.var_.characterEffect1049ui_story then
				arg_29_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_32_1 = 0
			local var_32_2 = 0.4

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(1104906007).content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 16 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 16)

				if (16 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 16)) > 0 and var_32_2 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_6 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_6 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_6

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_6 and arg_29_1.time_ < var_32_1 + var_32_6 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1104906008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1104906008
		arg_33_1.duration_ = 2.9

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1104906009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1049ui_story"]) and arg_33_1.var_.characterEffect1049ui_story == nil then
				arg_33_1.var_.characterEffect1049ui_story = arg_33_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1049ui_story"]) then
				if arg_33_1.var_.characterEffect1049ui_story and not isNil(arg_33_1.actors_["1049ui_story"]) then
					arg_33_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1049ui_story"]) and arg_33_1.var_.characterEffect1049ui_story then
				arg_33_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story104901/story1049actionlink/1049action426")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_36_2 = 0
			local var_36_3 = 0.2

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_4 = arg_33_1:GetWordFromCfg(1104906008)
				local var_36_5 = arg_33_1:FormatText(var_36_4.content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 8 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 8)

				if (8 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 8)) > 0 and var_36_3 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906008", "story_v_side_new_1104906.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906008", "story_v_side_new_1104906.awb") / 1000

					if var_36_8 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_2
					end

					if var_36_4.prefab_name ~= "" and arg_33_1.actors_[var_36_4.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_4.prefab_name].transform, "story_v_side_new_1104906", "1104906008", "story_v_side_new_1104906.awb")

						arg_33_1:RecordAudio("1104906008", var_36_9)
						arg_33_1:RecordAudio("1104906008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906008", "story_v_side_new_1104906.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906008", "story_v_side_new_1104906.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_10 and arg_33_1.time_ < var_36_2 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1104906009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1104906009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1104906010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1049ui_story"]) and arg_37_1.var_.characterEffect1049ui_story == nil then
				arg_37_1.var_.characterEffect1049ui_story = arg_37_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1049ui_story"]) then
				if arg_37_1.var_.characterEffect1049ui_story and not isNil(arg_37_1.actors_["1049ui_story"]) then
					arg_37_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1049ui_story"]) and arg_37_1.var_.characterEffect1049ui_story then
				arg_37_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.15

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(1104906009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 6 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 6)

				if (6 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 6)) > 0 and var_40_2 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_6 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_6 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_6

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_6 and arg_37_1.time_ < var_40_1 + var_40_6 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1104906010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1104906010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1104906011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 1.05

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

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(1104906010).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 42 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 42)

				if (42 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 42)) > 0 and var_44_0 < var_44_3 then
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
	Play1104906011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1104906011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1104906012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 1.125

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(1104906011).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 45 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 45)

				if (45 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 45)) > 0 and var_48_0 < var_48_3 then
					arg_45_1.talkMaxDuration = var_48_3

					if var_48_3 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_3 + 0
					end
				end

				arg_45_1.text_.text = var_48_1
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_4 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_4

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play1104906012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1104906012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1104906013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.25

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(1104906012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 10 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 10)

				if (10 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 10)) > 0 and var_52_0 < var_52_3 then
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
	Play1104906013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1104906013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1104906014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.7

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(1104906013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 28 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 28)

				if (28 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 28)) > 0 and var_56_0 < var_56_3 then
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
	Play1104906014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1104906014
		arg_57_1.duration_ = 10.5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1104906015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1049ui_story"]) and arg_57_1.var_.characterEffect1049ui_story == nil then
				arg_57_1.var_.characterEffect1049ui_story = arg_57_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1049ui_story"]) then
				if arg_57_1.var_.characterEffect1049ui_story and not isNil(arg_57_1.actors_["1049ui_story"]) then
					arg_57_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1049ui_story"]) and arg_57_1.var_.characterEffect1049ui_story then
				arg_57_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049actionlink/1049action464")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_60_2 = 0
			local var_60_3 = 1

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:GetWordFromCfg(1104906014)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 40 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 40)

				if (40 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 40)) > 0 and var_60_3 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906014", "story_v_side_new_1104906.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906014", "story_v_side_new_1104906.awb") / 1000

					if var_60_8 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_2
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_side_new_1104906", "1104906014", "story_v_side_new_1104906.awb")

						arg_57_1:RecordAudio("1104906014", var_60_9)
						arg_57_1:RecordAudio("1104906014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906014", "story_v_side_new_1104906.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906014", "story_v_side_new_1104906.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_10 and arg_57_1.time_ < var_60_2 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1104906015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1104906015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1104906016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1049ui_story"]) and arg_61_1.var_.characterEffect1049ui_story == nil then
				arg_61_1.var_.characterEffect1049ui_story = arg_61_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1049ui_story"]) then
				if arg_61_1.var_.characterEffect1049ui_story and not isNil(arg_61_1.actors_["1049ui_story"]) then
					arg_61_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1049ui_story"]) and arg_61_1.var_.characterEffect1049ui_story then
				arg_61_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_64_1 = 0
			local var_64_2 = 0.275

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(1104906015).content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 11 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 11)

				if (11 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 11)) > 0 and var_64_2 < var_64_5 then
					arg_61_1.talkMaxDuration = var_64_5

					if var_64_5 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_6 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_6 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_6

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_6 and arg_61_1.time_ < var_64_1 + var_64_6 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1104906016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1104906016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1104906017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 1.35

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(1104906016).content)

				arg_65_1.text_.text = var_68_1

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_3 = 54 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 54)

				if (54 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 54)) > 0 and var_68_0 < var_68_3 then
					arg_65_1.talkMaxDuration = var_68_3

					if var_68_3 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_3 + 0
					end
				end

				arg_65_1.text_.text = var_68_1
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_4 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_4

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play1104906017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1104906017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1104906018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 1.075

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(1104906017).content)

				arg_69_1.text_.text = var_72_1

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_3 = 43 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 43)

				if (43 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 43)) > 0 and var_72_0 < var_72_3 then
					arg_69_1.talkMaxDuration = var_72_3

					if var_72_3 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_3 + 0
					end
				end

				arg_69_1.text_.text = var_72_1
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_4 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_4

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1104906018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1104906018
		arg_73_1.duration_ = 2

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1104906019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1049ui_story"]) and arg_73_1.var_.characterEffect1049ui_story == nil then
				arg_73_1.var_.characterEffect1049ui_story = arg_73_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1049ui_story"]) then
				if arg_73_1.var_.characterEffect1049ui_story and not isNil(arg_73_1.actors_["1049ui_story"]) then
					arg_73_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1049ui_story"]) and arg_73_1.var_.characterEffect1049ui_story then
				arg_73_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action4_2")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_76_2 = 0
			local var_76_3 = 0.125

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:GetWordFromCfg(1104906018)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 5 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 5)

				if (5 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 5)) > 0 and var_76_3 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906018", "story_v_side_new_1104906.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906018", "story_v_side_new_1104906.awb") / 1000

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_side_new_1104906", "1104906018", "story_v_side_new_1104906.awb")

						arg_73_1:RecordAudio("1104906018", var_76_9)
						arg_73_1:RecordAudio("1104906018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906018", "story_v_side_new_1104906.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906018", "story_v_side_new_1104906.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_10 and arg_73_1.time_ < var_76_2 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play1104906019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1104906019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1104906020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1049ui_story"]) and arg_77_1.var_.characterEffect1049ui_story == nil then
				arg_77_1.var_.characterEffect1049ui_story = arg_77_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1049ui_story"]) then
				if arg_77_1.var_.characterEffect1049ui_story and not isNil(arg_77_1.actors_["1049ui_story"]) then
					arg_77_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1049ui_story"]) and arg_77_1.var_.characterEffect1049ui_story then
				arg_77_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_80_1 = 0
			local var_80_2 = 0.225

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(1104906019).content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 9 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 9)

				if (9 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 9)) > 0 and var_80_2 < var_80_5 then
					arg_77_1.talkMaxDuration = var_80_5

					if var_80_5 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + var_80_1
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_6 = math.max(var_80_2, arg_77_1.talkMaxDuration)

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_6 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_1) / var_80_6

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_1 + var_80_6 and arg_77_1.time_ < var_80_1 + var_80_6 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play1104906020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1104906020
		arg_81_1.duration_ = 4.9

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1104906021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1049ui_story"]) and arg_81_1.var_.characterEffect1049ui_story == nil then
				arg_81_1.var_.characterEffect1049ui_story = arg_81_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1049ui_story"]) then
				if arg_81_1.var_.characterEffect1049ui_story and not isNil(arg_81_1.actors_["1049ui_story"]) then
					arg_81_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1049ui_story"]) and arg_81_1.var_.characterEffect1049ui_story then
				arg_81_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_84_2 = 0
			local var_84_3 = 0.4

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_4 = arg_81_1:GetWordFromCfg(1104906020)
				local var_84_5 = arg_81_1:FormatText(var_84_4.content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 16 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 16)

				if (16 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 16)) > 0 and var_84_3 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_2
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906020", "story_v_side_new_1104906.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906020", "story_v_side_new_1104906.awb") / 1000

					if var_84_8 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_2
					end

					if var_84_4.prefab_name ~= "" and arg_81_1.actors_[var_84_4.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_4.prefab_name].transform, "story_v_side_new_1104906", "1104906020", "story_v_side_new_1104906.awb")

						arg_81_1:RecordAudio("1104906020", var_84_9)
						arg_81_1:RecordAudio("1104906020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906020", "story_v_side_new_1104906.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906020", "story_v_side_new_1104906.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_3, arg_81_1.talkMaxDuration)

			if var_84_2 <= arg_81_1.time_ and arg_81_1.time_ < var_84_2 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_2) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_2 + var_84_10 and arg_81_1.time_ < var_84_2 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1104906021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1104906021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1104906022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1049ui_story"]) and arg_85_1.var_.characterEffect1049ui_story == nil then
				arg_85_1.var_.characterEffect1049ui_story = arg_85_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1049ui_story"]) then
				if arg_85_1.var_.characterEffect1049ui_story and not isNil(arg_85_1.actors_["1049ui_story"]) then
					arg_85_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1049ui_story"]) and arg_85_1.var_.characterEffect1049ui_story then
				arg_85_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_88_1 = 0
			local var_88_2 = 0.65

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(1104906021).content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 26 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 26)

				if (26 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 26)) > 0 and var_88_2 < var_88_5 then
					arg_85_1.talkMaxDuration = var_88_5

					if var_88_5 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_6 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_6 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_6

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_6 and arg_85_1.time_ < var_88_1 + var_88_6 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1104906022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1104906022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1104906023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1049ui_story = arg_89_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1049ui_story"].transform.position).z)
				arg_89_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1049ui_story"].transform.localEulerAngles = arg_89_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1049ui_story"].transform.position).z)
				arg_89_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1049ui_story"].transform.localEulerAngles = arg_89_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_92_1 = 0
			local var_92_2 = 0.725

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

				local var_92_3 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(1104906022).content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 29 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 29)

				if (29 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 29)) > 0 and var_92_2 < var_92_5 then
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

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play1104906023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1104906023
		arg_93_1.duration_ = 4.83

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1104906024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1049ui_story = arg_93_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1049ui_story"].transform.position).z)
				arg_93_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1049ui_story"].transform.localEulerAngles = arg_93_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_93_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1049ui_story"].transform.position).z)
				arg_93_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1049ui_story"].transform.localEulerAngles = arg_93_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["1049ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1049ui_story == nil then
				arg_93_1.var_.characterEffect1049ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect1049ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1049ui_story then
				arg_93_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_96_4 = 0
			local var_96_5 = 0.5

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(1104906023)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 20 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 20)

				if (20 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 20)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906023", "story_v_side_new_1104906.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906023", "story_v_side_new_1104906.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_side_new_1104906", "1104906023", "story_v_side_new_1104906.awb")

						arg_93_1:RecordAudio("1104906023", var_96_11)
						arg_93_1:RecordAudio("1104906023", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906023", "story_v_side_new_1104906.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906023", "story_v_side_new_1104906.awb")
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
				actorName = "1049ui_story",
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
	Play1104906024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1104906024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1104906025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1049ui_story"]) and arg_97_1.var_.characterEffect1049ui_story == nil then
				arg_97_1.var_.characterEffect1049ui_story = arg_97_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1049ui_story"]) then
				if arg_97_1.var_.characterEffect1049ui_story and not isNil(arg_97_1.actors_["1049ui_story"]) then
					arg_97_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1049ui_story"]) and arg_97_1.var_.characterEffect1049ui_story then
				arg_97_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_100_1 = 0
			local var_100_2 = 0.15

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(1104906024).content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 6 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 6)

				if (6 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 6)) > 0 and var_100_2 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_6 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_6 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_6

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_6 and arg_97_1.time_ < var_100_1 + var_100_6 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1104906025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1104906025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1104906026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1049ui_story = arg_101_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1049ui_story"].transform.position).z)
				arg_101_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1049ui_story"].transform.localEulerAngles = arg_101_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1049ui_story"].transform.position).z)
				arg_101_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1049ui_story"].transform.localEulerAngles = arg_101_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_104_1 = 0
			local var_104_2 = 1.4

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(1104906025).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 56 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 56)

				if (56 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 56)) > 0 and var_104_2 < var_104_5 then
					arg_101_1.talkMaxDuration = var_104_5

					if var_104_5 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_6 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_6 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_6

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_6 and arg_101_1.time_ < var_104_1 + var_104_6 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play1104906026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1104906026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1104906027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0.333333333333333 < arg_105_1.time_ and arg_105_1.time_ <= 0.333333333333333 + arg_108_0 then
				arg_105_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_108_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_105_1.bgmTxt_.text ~= var_108_2 and arg_105_1.bgmTxt_.text ~= "" then
						if arg_105_1.bgmTxt2_.text ~= "" then
							arg_105_1.bgmTxt_.text = arg_105_1.bgmTxt2_.text
						end

						arg_105_1.bgmTxt2_.text = var_108_2

						arg_105_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_105_1.bgmTxt_.text = var_108_2
						arg_105_1.bgmTxt2_.text = var_108_2
					end

					if arg_105_1.bgmTimer then
						arg_105_1.bgmTimer:Stop()

						arg_105_1.bgmTimer = nil
					end

					if arg_105_1.settingData.show_music_name == 1 then
						arg_105_1.musicController:SetSelectedState("show")
						arg_105_1.musicAnimator_:Play("open", 0, 0)

						if arg_105_1.settingData.music_time ~= 0 then
							arg_105_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_105_1.settingData.music_time), function()
								if arg_105_1 == nil or isNil(arg_105_1.bgmTxt_) then
									return
								end

								arg_105_1.musicController:SetSelectedState("hide")
								arg_105_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.125 < arg_105_1.time_ and arg_105_1.time_ <= 0.125 + arg_108_0 then
				arg_105_1:AudioAction("play", "effect", "se_story_side_1080", "se_story_1080_knock", "")
			end

			local var_108_4 = 0
			local var_108_5 = 1.3

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(1104906026).content)

				arg_105_1.text_.text = var_108_6

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_8 = 52 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_6) / 52)

				if (52 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_6) / 52)) > 0 and var_108_5 < var_108_8 then
					arg_105_1.talkMaxDuration = var_108_8

					if var_108_8 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_6
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_9 = math.max(var_108_5, arg_105_1.talkMaxDuration)

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_9 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_4) / var_108_9

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_4 + var_108_9 and arg_105_1.time_ < var_108_4 + var_108_9 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play1104906027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 1104906027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play1104906028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.525

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_1 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(1104906027).content)

				arg_110_1.text_.text = var_113_1

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_3 = 21 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_1) / 21)

				if (21 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_1) / 21)) > 0 and var_113_0 < var_113_3 then
					arg_110_1.talkMaxDuration = var_113_3

					if var_113_3 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_3 + 0
					end
				end

				arg_110_1.text_.text = var_113_1
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_4 = math.max(var_113_0, arg_110_1.talkMaxDuration)

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_4 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - 0) / var_113_4

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= 0 + var_113_4 and arg_110_1.time_ < 0 + var_113_4 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play1104906028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 1104906028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play1104906029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0.075

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_1 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(1104906028).content)

				arg_114_1.text_.text = var_117_1

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_3 = 3 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_1) / 3)

				if (3 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_1) / 3)) > 0 and var_117_0 < var_117_3 then
					arg_114_1.talkMaxDuration = var_117_3

					if var_117_3 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_3 + 0
					end
				end

				arg_114_1.text_.text = var_117_1
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_4 = math.max(var_117_0, arg_114_1.talkMaxDuration)

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_4 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - 0) / var_117_4

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= 0 + var_117_4 and arg_114_1.time_ < 0 + var_117_4 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play1104906029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 1104906029
		arg_118_1.duration_ = 5.3

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play1104906030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos1049ui_story = arg_118_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_121_0 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 then
				arg_118_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_118_1.time_ - 0) / var_121_0)
				arg_118_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1049ui_story"].transform.position).z)
				arg_118_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["1049ui_story"].transform.localEulerAngles = arg_118_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 then
				arg_118_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_118_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1049ui_story"].transform.position).z)
				arg_118_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["1049ui_story"].transform.localEulerAngles = arg_118_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_121_1 = arg_118_1.actors_["1049ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_1) and arg_118_1.var_.characterEffect1049ui_story == nil then
				arg_118_1.var_.characterEffect1049ui_story = var_121_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_2 and not isNil(var_121_1) then
				if arg_118_1.var_.characterEffect1049ui_story and not isNil(var_121_1) then
					arg_118_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_2 and arg_118_1.time_ < 0 + var_121_2 + arg_121_0 and not isNil(var_121_1) and arg_118_1.var_.characterEffect1049ui_story then
				arg_118_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_2")
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_121_4 = 0
			local var_121_5 = 0.4

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_6 = arg_118_1:GetWordFromCfg(1104906029)
				local var_121_7 = arg_118_1:FormatText(var_121_6.content)

				arg_118_1.text_.text = var_121_7

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_9 = 16 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 16)

				if (16 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 16)) > 0 and var_121_5 < var_121_9 then
					arg_118_1.talkMaxDuration = var_121_9

					if var_121_9 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_9 + var_121_4
					end
				end

				arg_118_1.text_.text = var_121_7
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906029", "story_v_side_new_1104906.awb") ~= 0 then
					local var_121_10 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906029", "story_v_side_new_1104906.awb") / 1000

					if var_121_10 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_10 + var_121_4
					end

					if var_121_6.prefab_name ~= "" and arg_118_1.actors_[var_121_6.prefab_name] ~= nil then
						local var_121_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_6.prefab_name].transform, "story_v_side_new_1104906", "1104906029", "story_v_side_new_1104906.awb")

						arg_118_1:RecordAudio("1104906029", var_121_11)
						arg_118_1:RecordAudio("1104906029", var_121_11)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906029", "story_v_side_new_1104906.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906029", "story_v_side_new_1104906.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_12 = math.max(var_121_5, arg_118_1.talkMaxDuration)

			if var_121_4 <= arg_118_1.time_ and arg_118_1.time_ < var_121_4 + var_121_12 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_4) / var_121_12

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_4 + var_121_12 and arg_118_1.time_ < var_121_4 + var_121_12 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play1104906030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 1104906030
		arg_122_1.duration_ = 9

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play1104906031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if arg_122_1.bgs_.ST58 == nil then
				local var_125_0 = Object.Instantiate(arg_122_1.paintGo_)

				var_125_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST58")
				var_125_0.name = "ST58"
				var_125_0.transform.parent = arg_122_1.stage_.transform
				var_125_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_122_1.bgs_.ST58 = var_125_0
			end

			if 2 < arg_122_1.time_ and arg_122_1.time_ <= 2 + arg_125_0 then
				local var_125_1 = arg_122_1.bgs_.ST58

				arg_122_1.bgs_.ST58.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_125_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_125_2 = var_125_1:GetComponent("SpriteRenderer")

				if var_125_2 and var_125_2.sprite then
					local var_125_3 = 2 * (var_125_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_125_1.transform.localScale = Vector3.New(var_125_3 / var_125_2.sprite.bounds.size.y < var_125_3 * manager.ui.mainCameraCom_.aspect / var_125_2.sprite.bounds.size.x and var_125_3 * manager.ui.mainCameraCom_.aspect / var_125_2.sprite.bounds.size.x or var_125_3 / var_125_2.sprite.bounds.size.y, var_125_3 / var_125_2.sprite.bounds.size.y < var_125_3 * manager.ui.mainCameraCom_.aspect / var_125_2.sprite.bounds.size.x and var_125_3 * manager.ui.mainCameraCom_.aspect / var_125_2.sprite.bounds.size.x or var_125_3 / var_125_2.sprite.bounds.size.y, 0)
				end

				for iter_125_0, iter_125_1 in pairs(arg_122_1.bgs_) do
					if iter_125_0 ~= "ST58" then
						iter_125_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_125_4 = 4

			if 4 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1.allBtn_.enabled = false
			end

			if arg_122_1.time_ >= var_125_4 + 0.3 and arg_122_1.time_ < var_125_4 + 0.3 + arg_125_0 then
				arg_122_1.allBtn_.enabled = true
			end

			local var_125_5 = 0

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_5 + arg_125_0 then
				arg_122_1.mask_.enabled = true
				arg_122_1.mask_.raycastTarget = true

				arg_122_1:SetGaussion(false)
			end

			local var_125_6 = 2

			if var_125_5 <= arg_122_1.time_ and arg_122_1.time_ < var_125_5 + var_125_6 then
				local var_125_7 = Color.New(0, 0, 0)

				var_125_7.a = Mathf.Lerp(0, 1, (arg_122_1.time_ - var_125_5) / var_125_6)
				arg_122_1.mask_.color = var_125_7
			end

			if arg_122_1.time_ >= var_125_5 + var_125_6 and arg_122_1.time_ < var_125_5 + var_125_6 + arg_125_0 then
				local var_125_8 = Color.New(0, 0, 0)

				var_125_8.a = 1
				arg_122_1.mask_.color = var_125_8
			end

			local var_125_9 = 2

			if 2 < arg_122_1.time_ and arg_122_1.time_ <= var_125_9 + arg_125_0 then
				arg_122_1.mask_.enabled = true
				arg_122_1.mask_.raycastTarget = true

				arg_122_1:SetGaussion(false)
			end

			local var_125_10 = 2

			if var_125_9 <= arg_122_1.time_ and arg_122_1.time_ < var_125_9 + var_125_10 then
				local var_125_11 = Color.New(0, 0, 0)

				var_125_11.a = Mathf.Lerp(1, 0, (arg_122_1.time_ - var_125_9) / var_125_10)
				arg_122_1.mask_.color = var_125_11
			end

			if arg_122_1.time_ >= var_125_9 + var_125_10 and arg_122_1.time_ < var_125_9 + var_125_10 + arg_125_0 then
				local var_125_12 = Color.New(0, 0, 0)

				arg_122_1.mask_.enabled = false
				var_125_12.a = 0
				arg_122_1.mask_.color = var_125_12
			end

			local var_125_13 = arg_122_1.actors_["1049ui_story"].transform

			if 1.96599999815226 < arg_122_1.time_ and arg_122_1.time_ <= 1.96599999815226 + arg_125_0 then
				arg_122_1.var_.moveOldPos1049ui_story = var_125_13.localPosition
			end

			local var_125_14 = 0.001

			if 1.96599999815226 <= arg_122_1.time_ and arg_122_1.time_ < 1.96599999815226 + var_125_14 then
				var_125_13.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_122_1.time_ - 1.96599999815226) / var_125_14)
				var_125_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_13.position).x, (manager.ui.mainCamera.transform.position - var_125_13.position).y, (manager.ui.mainCamera.transform.position - var_125_13.position).z)
				var_125_13.localEulerAngles.z = 0
				var_125_13.localEulerAngles.x = 0
				var_125_13.localEulerAngles = var_125_13.localEulerAngles
			end

			if arg_122_1.time_ >= 1.96599999815226 + var_125_14 and arg_122_1.time_ < 1.96599999815226 + var_125_14 + arg_125_0 then
				var_125_13.localPosition = Vector3.New(0, 100, 0)
				var_125_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_13.position).x, (manager.ui.mainCamera.transform.position - var_125_13.position).y, (manager.ui.mainCamera.transform.position - var_125_13.position).z)
				var_125_13.localEulerAngles.z = 0
				var_125_13.localEulerAngles.x = 0
				var_125_13.localEulerAngles = var_125_13.localEulerAngles
			end

			local var_125_15 = arg_122_1.actors_["1049ui_story"]

			if 1.96599999815226 < arg_122_1.time_ and arg_122_1.time_ <= 1.96599999815226 + arg_125_0 and not isNil(var_125_15) and arg_122_1.var_.characterEffect1049ui_story == nil then
				arg_122_1.var_.characterEffect1049ui_story = var_125_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_16 = 0.034000001847744

			if 1.96599999815226 <= arg_122_1.time_ and arg_122_1.time_ < 1.96599999815226 + var_125_16 and not isNil(var_125_15) then
				if arg_122_1.var_.characterEffect1049ui_story and not isNil(var_125_15) then
					arg_122_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 1.96599999815226) / var_125_16)
				end
			end

			if arg_122_1.time_ >= 1.96599999815226 + var_125_16 and arg_122_1.time_ < 1.96599999815226 + var_125_16 + arg_125_0 and not isNil(var_125_15) and arg_122_1.var_.characterEffect1049ui_story then
				arg_122_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			if 0.266666666666667 < arg_122_1.time_ and arg_122_1.time_ <= 0.266666666666667 + arg_125_0 then
				arg_122_1:AudioAction("stop", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if 1.63333333333333 < arg_122_1.time_ and arg_122_1.time_ <= 1.63333333333333 + arg_125_0 then
				arg_122_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_125_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_122_1.bgmTxt_.text ~= var_125_21 and arg_122_1.bgmTxt_.text ~= "" then
						if arg_122_1.bgmTxt2_.text ~= "" then
							arg_122_1.bgmTxt_.text = arg_122_1.bgmTxt2_.text
						end

						arg_122_1.bgmTxt2_.text = var_125_21

						arg_122_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_122_1.bgmTxt_.text = var_125_21
						arg_122_1.bgmTxt2_.text = var_125_21
					end

					if arg_122_1.bgmTimer then
						arg_122_1.bgmTimer:Stop()

						arg_122_1.bgmTimer = nil
					end

					if arg_122_1.settingData.show_music_name == 1 then
						arg_122_1.musicController:SetSelectedState("show")
						arg_122_1.musicAnimator_:Play("open", 0, 0)

						if arg_122_1.settingData.music_time ~= 0 then
							arg_122_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_122_1.settingData.music_time), function()
								if arg_122_1 == nil or isNil(arg_122_1.bgmTxt_) then
									return
								end

								arg_122_1.musicController:SetSelectedState("hide")
								arg_122_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_122_1.time_ and arg_122_1.time_ <= 0.4 + arg_125_0 then
				arg_122_1:AudioAction("play", "music", "bgm_activity_2_6_story_sasanami_quiet", "bgm_activity_2_6_story_sasanami_quiet", "bgm_activity_2_6_story_sasanami_quiet.awb")

				local var_125_24 = manager.audio:GetAudioName("bgm_activity_2_6_story_sasanami_quiet", "bgm_activity_2_6_story_sasanami_quiet")

				if "" ~= "" then
					if arg_122_1.bgmTxt_.text ~= var_125_24 and arg_122_1.bgmTxt_.text ~= "" then
						if arg_122_1.bgmTxt2_.text ~= "" then
							arg_122_1.bgmTxt_.text = arg_122_1.bgmTxt2_.text
						end

						arg_122_1.bgmTxt2_.text = var_125_24

						arg_122_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_122_1.bgmTxt_.text = var_125_24
						arg_122_1.bgmTxt2_.text = var_125_24
					end

					if arg_122_1.bgmTimer then
						arg_122_1.bgmTimer:Stop()

						arg_122_1.bgmTimer = nil
					end

					if arg_122_1.settingData.show_music_name == 1 then
						arg_122_1.musicController:SetSelectedState("show")
						arg_122_1.musicAnimator_:Play("open", 0, 0)

						if arg_122_1.settingData.music_time ~= 0 then
							arg_122_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_122_1.settingData.music_time), function()
								if arg_122_1 == nil or isNil(arg_122_1.bgmTxt_) then
									return
								end

								arg_122_1.musicController:SetSelectedState("hide")
								arg_122_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_122_1.frameCnt_ <= 1 then
				arg_122_1.dialog_:SetActive(false)
			end

			local var_125_25 = 4
			local var_125_26 = 0.175

			if 4 < arg_122_1.time_ and arg_122_1.time_ <= var_125_25 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0

				arg_122_1.dialog_:SetActive(true)

				arg_122_1.dialogCg_.alpha = 0

				local var_125_27 = LeanTween.value(arg_122_1.dialog_, 0, 1, 0.3)

				var_125_27:setOnUpdate(LuaHelper.FloatAction(function(arg_128_0)
					arg_122_1.dialogCg_.alpha = arg_128_0
				end))
				var_125_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_122_1.dialog_)
					var_125_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_122_1.duration_ = arg_122_1.duration_ + 0.3

				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_28 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(1104906030).content)

				arg_122_1.text_.text = var_125_28

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_30 = 7 <= 0 and var_125_26 or var_125_26 * (utf8.len(var_125_28) / 7)

				if (7 <= 0 and var_125_26 or var_125_26 * (utf8.len(var_125_28) / 7)) > 0 and var_125_26 < var_125_30 then
					arg_122_1.talkMaxDuration = var_125_30
					var_125_25 = var_125_25 + 0.3

					if var_125_30 + var_125_25 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_30 + var_125_25
					end
				end

				arg_122_1.text_.text = var_125_28
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_31 = var_125_25 + 0.3
			local var_125_32 = math.max(var_125_26, arg_122_1.talkMaxDuration)

			if var_125_25 + 0.3 <= arg_122_1.time_ and arg_122_1.time_ < var_125_31 + var_125_32 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_31) / var_125_32

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_31 + var_125_32 and arg_122_1.time_ < var_125_31 + var_125_32 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play1104906031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 1104906031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play1104906032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0.5

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_1 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(1104906031).content)

				arg_130_1.text_.text = var_133_1

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_3 = 20 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_1) / 20)

				if (20 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_1) / 20)) > 0 and var_133_0 < var_133_3 then
					arg_130_1.talkMaxDuration = var_133_3

					if var_133_3 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_3 + 0
					end
				end

				arg_130_1.text_.text = var_133_1
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_4 = math.max(var_133_0, arg_130_1.talkMaxDuration)

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_4 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - 0) / var_133_4

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= 0 + var_133_4 and arg_130_1.time_ < 0 + var_133_4 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play1104906032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 1104906032
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play1104906033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 1

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_1 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(1104906032).content)

				arg_134_1.text_.text = var_137_1

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_3 = 40 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_1) / 40)

				if (40 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_1) / 40)) > 0 and var_137_0 < var_137_3 then
					arg_134_1.talkMaxDuration = var_137_3

					if var_137_3 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_3 + 0
					end
				end

				arg_134_1.text_.text = var_137_1
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_4 = math.max(var_137_0, arg_134_1.talkMaxDuration)

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_4 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - 0) / var_137_4

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= 0 + var_137_4 and arg_134_1.time_ < 0 + var_137_4 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play1104906033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 1104906033
		arg_138_1.duration_ = 8.2

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play1104906034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 1.025

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[1201].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_1 = arg_138_1:GetWordFromCfg(1104906033)
				local var_141_2 = arg_138_1:FormatText(var_141_1.content)

				arg_138_1.text_.text = var_141_2

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_4 = 41 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_2) / 41)

				if (41 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_2) / 41)) > 0 and var_141_0 < var_141_4 then
					arg_138_1.talkMaxDuration = var_141_4

					if var_141_4 + 0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_4 + 0
					end
				end

				arg_138_1.text_.text = var_141_2
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906033", "story_v_side_new_1104906.awb") ~= 0 then
					local var_141_5 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906033", "story_v_side_new_1104906.awb") / 1000

					if var_141_5 + 0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_5 + 0
					end

					if var_141_1.prefab_name ~= "" and arg_138_1.actors_[var_141_1.prefab_name] ~= nil then
						local var_141_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_1.prefab_name].transform, "story_v_side_new_1104906", "1104906033", "story_v_side_new_1104906.awb")

						arg_138_1:RecordAudio("1104906033", var_141_6)
						arg_138_1:RecordAudio("1104906033", var_141_6)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906033", "story_v_side_new_1104906.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906033", "story_v_side_new_1104906.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_7 = math.max(var_141_0, arg_138_1.talkMaxDuration)

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_7 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - 0) / var_141_7

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= 0 + var_141_7 and arg_138_1.time_ < 0 + var_141_7 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play1104906034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 1104906034
		arg_142_1.duration_ = 8.9

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play1104906035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 1.15

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[1201].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_1 = arg_142_1:GetWordFromCfg(1104906034)
				local var_145_2 = arg_142_1:FormatText(var_145_1.content)

				arg_142_1.text_.text = var_145_2

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_4 = 46 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_2) / 46)

				if (46 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_2) / 46)) > 0 and var_145_0 < var_145_4 then
					arg_142_1.talkMaxDuration = var_145_4

					if var_145_4 + 0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_4 + 0
					end
				end

				arg_142_1.text_.text = var_145_2
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906034", "story_v_side_new_1104906.awb") ~= 0 then
					local var_145_5 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906034", "story_v_side_new_1104906.awb") / 1000

					if var_145_5 + 0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_5 + 0
					end

					if var_145_1.prefab_name ~= "" and arg_142_1.actors_[var_145_1.prefab_name] ~= nil then
						local var_145_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_1.prefab_name].transform, "story_v_side_new_1104906", "1104906034", "story_v_side_new_1104906.awb")

						arg_142_1:RecordAudio("1104906034", var_145_6)
						arg_142_1:RecordAudio("1104906034", var_145_6)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906034", "story_v_side_new_1104906.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906034", "story_v_side_new_1104906.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_7 = math.max(var_145_0, arg_142_1.talkMaxDuration)

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_7 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - 0) / var_145_7

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= 0 + var_145_7 and arg_142_1.time_ < 0 + var_145_7 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play1104906035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 1104906035
		arg_146_1.duration_ = 9.4

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play1104906036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 1.125

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[1201].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_1 = arg_146_1:GetWordFromCfg(1104906035)
				local var_149_2 = arg_146_1:FormatText(var_149_1.content)

				arg_146_1.text_.text = var_149_2

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_4 = 45 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_2) / 45)

				if (45 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_2) / 45)) > 0 and var_149_0 < var_149_4 then
					arg_146_1.talkMaxDuration = var_149_4

					if var_149_4 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_4 + 0
					end
				end

				arg_146_1.text_.text = var_149_2
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906035", "story_v_side_new_1104906.awb") ~= 0 then
					local var_149_5 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906035", "story_v_side_new_1104906.awb") / 1000

					if var_149_5 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_5 + 0
					end

					if var_149_1.prefab_name ~= "" and arg_146_1.actors_[var_149_1.prefab_name] ~= nil then
						local var_149_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_1.prefab_name].transform, "story_v_side_new_1104906", "1104906035", "story_v_side_new_1104906.awb")

						arg_146_1:RecordAudio("1104906035", var_149_6)
						arg_146_1:RecordAudio("1104906035", var_149_6)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906035", "story_v_side_new_1104906.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906035", "story_v_side_new_1104906.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_7 = math.max(var_149_0, arg_146_1.talkMaxDuration)

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_7 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - 0) / var_149_7

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= 0 + var_149_7 and arg_146_1.time_ < 0 + var_149_7 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play1104906036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 1104906036
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play1104906037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0.625

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_1 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(1104906036).content)

				arg_150_1.text_.text = var_153_1

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_3 = 25 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_1) / 25)

				if (25 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_1) / 25)) > 0 and var_153_0 < var_153_3 then
					arg_150_1.talkMaxDuration = var_153_3

					if var_153_3 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_3 + 0
					end
				end

				arg_150_1.text_.text = var_153_1
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_4 = math.max(var_153_0, arg_150_1.talkMaxDuration)

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_4 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - 0) / var_153_4

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= 0 + var_153_4 and arg_150_1.time_ < 0 + var_153_4 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play1104906037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 1104906037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play1104906038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0.225

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_1 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(1104906037).content)

				arg_154_1.text_.text = var_157_1

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_3 = 9 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 9)

				if (9 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 9)) > 0 and var_157_0 < var_157_3 then
					arg_154_1.talkMaxDuration = var_157_3

					if var_157_3 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_3 + 0
					end
				end

				arg_154_1.text_.text = var_157_1
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_4 = math.max(var_157_0, arg_154_1.talkMaxDuration)

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_4 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - 0) / var_157_4

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= 0 + var_157_4 and arg_154_1.time_ < 0 + var_157_4 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play1104906038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 1104906038
		arg_158_1.duration_ = 2.97

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play1104906039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0.075

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[1201].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_1 = arg_158_1:GetWordFromCfg(1104906038)
				local var_161_2 = arg_158_1:FormatText(var_161_1.content)

				arg_158_1.text_.text = var_161_2

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_4 = 3 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_2) / 3)

				if (3 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_2) / 3)) > 0 and var_161_0 < var_161_4 then
					arg_158_1.talkMaxDuration = var_161_4

					if var_161_4 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_4 + 0
					end
				end

				arg_158_1.text_.text = var_161_2
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906038", "story_v_side_new_1104906.awb") ~= 0 then
					local var_161_5 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906038", "story_v_side_new_1104906.awb") / 1000

					if var_161_5 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_5 + 0
					end

					if var_161_1.prefab_name ~= "" and arg_158_1.actors_[var_161_1.prefab_name] ~= nil then
						local var_161_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_1.prefab_name].transform, "story_v_side_new_1104906", "1104906038", "story_v_side_new_1104906.awb")

						arg_158_1:RecordAudio("1104906038", var_161_6)
						arg_158_1:RecordAudio("1104906038", var_161_6)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906038", "story_v_side_new_1104906.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906038", "story_v_side_new_1104906.awb")
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
	Play1104906039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 1104906039
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play1104906040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 1.075

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_1 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(1104906039).content)

				arg_162_1.text_.text = var_165_1

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_3 = 43 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 43)

				if (43 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 43)) > 0 and var_165_0 < var_165_3 then
					arg_162_1.talkMaxDuration = var_165_3

					if var_165_3 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_3 + 0
					end
				end

				arg_162_1.text_.text = var_165_1
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_4 = math.max(var_165_0, arg_162_1.talkMaxDuration)

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_4 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - 0) / var_165_4

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= 0 + var_165_4 and arg_162_1.time_ < 0 + var_165_4 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play1104906040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 1104906040
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play1104906041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0.9

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_1 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(1104906040).content)

				arg_166_1.text_.text = var_169_1

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_3 = 36 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_1) / 36)

				if (36 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_1) / 36)) > 0 and var_169_0 < var_169_3 then
					arg_166_1.talkMaxDuration = var_169_3

					if var_169_3 + 0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_3 + 0
					end
				end

				arg_166_1.text_.text = var_169_1
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_4 = math.max(var_169_0, arg_166_1.talkMaxDuration)

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_4 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - 0) / var_169_4

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= 0 + var_169_4 and arg_166_1.time_ < 0 + var_169_4 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play1104906041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 1104906041
		arg_170_1.duration_ = 4.4

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play1104906042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos1049ui_story = arg_170_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_173_0 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 then
				arg_170_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_170_1.time_ - 0) / var_173_0)
				arg_170_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1049ui_story"].transform.position).z)
				arg_170_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["1049ui_story"].transform.localEulerAngles = arg_170_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 then
				arg_170_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_170_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1049ui_story"].transform.position).z)
				arg_170_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["1049ui_story"].transform.localEulerAngles = arg_170_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_173_1 = arg_170_1.actors_["1049ui_story"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_1) and arg_170_1.var_.characterEffect1049ui_story == nil then
				arg_170_1.var_.characterEffect1049ui_story = var_173_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_2 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_2 and not isNil(var_173_1) then
				if arg_170_1.var_.characterEffect1049ui_story and not isNil(var_173_1) then
					arg_170_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= 0 + var_173_2 and arg_170_1.time_ < 0 + var_173_2 + arg_173_0 and not isNil(var_173_1) and arg_170_1.var_.characterEffect1049ui_story then
				arg_170_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_173_4 = 0
			local var_173_5 = 0.45

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_4 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_6 = arg_170_1:GetWordFromCfg(1104906041)
				local var_173_7 = arg_170_1:FormatText(var_173_6.content)

				arg_170_1.text_.text = var_173_7

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_9 = 18 <= 0 and var_173_5 or var_173_5 * (utf8.len(var_173_7) / 18)

				if (18 <= 0 and var_173_5 or var_173_5 * (utf8.len(var_173_7) / 18)) > 0 and var_173_5 < var_173_9 then
					arg_170_1.talkMaxDuration = var_173_9

					if var_173_9 + var_173_4 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_9 + var_173_4
					end
				end

				arg_170_1.text_.text = var_173_7
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906041", "story_v_side_new_1104906.awb") ~= 0 then
					local var_173_10 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906041", "story_v_side_new_1104906.awb") / 1000

					if var_173_10 + var_173_4 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_10 + var_173_4
					end

					if var_173_6.prefab_name ~= "" and arg_170_1.actors_[var_173_6.prefab_name] ~= nil then
						local var_173_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_6.prefab_name].transform, "story_v_side_new_1104906", "1104906041", "story_v_side_new_1104906.awb")

						arg_170_1:RecordAudio("1104906041", var_173_11)
						arg_170_1:RecordAudio("1104906041", var_173_11)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906041", "story_v_side_new_1104906.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906041", "story_v_side_new_1104906.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_12 = math.max(var_173_5, arg_170_1.talkMaxDuration)

			if var_173_4 <= arg_170_1.time_ and arg_170_1.time_ < var_173_4 + var_173_12 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_4) / var_173_12

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_4 + var_173_12 and arg_170_1.time_ < var_173_4 + var_173_12 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play1104906042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 1104906042
		arg_174_1.duration_ = 4.77

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play1104906043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_177_0 = 0
			local var_177_1 = 0.475

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_2 = arg_174_1:GetWordFromCfg(1104906042)
				local var_177_3 = arg_174_1:FormatText(var_177_2.content)

				arg_174_1.text_.text = var_177_3

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_5 = 19 <= 0 and var_177_1 or var_177_1 * (utf8.len(var_177_3) / 19)

				if (19 <= 0 and var_177_1 or var_177_1 * (utf8.len(var_177_3) / 19)) > 0 and var_177_1 < var_177_5 then
					arg_174_1.talkMaxDuration = var_177_5

					if var_177_5 + var_177_0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_5 + var_177_0
					end
				end

				arg_174_1.text_.text = var_177_3
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906042", "story_v_side_new_1104906.awb") ~= 0 then
					local var_177_6 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906042", "story_v_side_new_1104906.awb") / 1000

					if var_177_6 + var_177_0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_6 + var_177_0
					end

					if var_177_2.prefab_name ~= "" and arg_174_1.actors_[var_177_2.prefab_name] ~= nil then
						local var_177_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_2.prefab_name].transform, "story_v_side_new_1104906", "1104906042", "story_v_side_new_1104906.awb")

						arg_174_1:RecordAudio("1104906042", var_177_7)
						arg_174_1:RecordAudio("1104906042", var_177_7)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906042", "story_v_side_new_1104906.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906042", "story_v_side_new_1104906.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_8 = math.max(var_177_1, arg_174_1.talkMaxDuration)

			if var_177_0 <= arg_174_1.time_ and arg_174_1.time_ < var_177_0 + var_177_8 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_0) / var_177_8

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_0 + var_177_8 and arg_174_1.time_ < var_177_0 + var_177_8 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play1104906043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 1104906043
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play1104906044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["1049ui_story"]) and arg_178_1.var_.characterEffect1049ui_story == nil then
				arg_178_1.var_.characterEffect1049ui_story = arg_178_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_0 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["1049ui_story"]) then
				if arg_178_1.var_.characterEffect1049ui_story and not isNil(arg_178_1.actors_["1049ui_story"]) then
					arg_178_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_178_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_178_1.time_ - 0) / var_181_0)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["1049ui_story"]) and arg_178_1.var_.characterEffect1049ui_story then
				arg_178_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_178_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_181_1 = 0
			local var_181_2 = 1.275

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_3 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(1104906043).content)

				arg_178_1.text_.text = var_181_3

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 51 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_3) / 51)

				if (51 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_3) / 51)) > 0 and var_181_2 < var_181_5 then
					arg_178_1.talkMaxDuration = var_181_5

					if var_181_5 + var_181_1 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_5 + var_181_1
					end
				end

				arg_178_1.text_.text = var_181_3
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_6 = math.max(var_181_2, arg_178_1.talkMaxDuration)

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_6 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_1) / var_181_6

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_1 + var_181_6 and arg_178_1.time_ < var_181_1 + var_181_6 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play1104906044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 1104906044
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play1104906045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0.65

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_1 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(1104906044).content)

				arg_182_1.text_.text = var_185_1

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_3 = 26 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_1) / 26)

				if (26 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_1) / 26)) > 0 and var_185_0 < var_185_3 then
					arg_182_1.talkMaxDuration = var_185_3

					if var_185_3 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_3 + 0
					end
				end

				arg_182_1.text_.text = var_185_1
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_4 = math.max(var_185_0, arg_182_1.talkMaxDuration)

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_4 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - 0) / var_185_4

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= 0 + var_185_4 and arg_182_1.time_ < 0 + var_185_4 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play1104906045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 1104906045
		arg_186_1.duration_ = 5.07

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play1104906046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["1049ui_story"]) and arg_186_1.var_.characterEffect1049ui_story == nil then
				arg_186_1.var_.characterEffect1049ui_story = arg_186_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_0 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["1049ui_story"]) then
				if arg_186_1.var_.characterEffect1049ui_story and not isNil(arg_186_1.actors_["1049ui_story"]) then
					arg_186_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["1049ui_story"]) and arg_186_1.var_.characterEffect1049ui_story then
				arg_186_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_2")
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_189_2 = 0
			local var_189_3 = 0.575

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_2 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_4 = arg_186_1:GetWordFromCfg(1104906045)
				local var_189_5 = arg_186_1:FormatText(var_189_4.content)

				arg_186_1.text_.text = var_189_5

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_7 = 23 <= 0 and var_189_3 or var_189_3 * (utf8.len(var_189_5) / 23)

				if (23 <= 0 and var_189_3 or var_189_3 * (utf8.len(var_189_5) / 23)) > 0 and var_189_3 < var_189_7 then
					arg_186_1.talkMaxDuration = var_189_7

					if var_189_7 + var_189_2 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_7 + var_189_2
					end
				end

				arg_186_1.text_.text = var_189_5
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906045", "story_v_side_new_1104906.awb") ~= 0 then
					local var_189_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906045", "story_v_side_new_1104906.awb") / 1000

					if var_189_8 + var_189_2 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_8 + var_189_2
					end

					if var_189_4.prefab_name ~= "" and arg_186_1.actors_[var_189_4.prefab_name] ~= nil then
						local var_189_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_4.prefab_name].transform, "story_v_side_new_1104906", "1104906045", "story_v_side_new_1104906.awb")

						arg_186_1:RecordAudio("1104906045", var_189_9)
						arg_186_1:RecordAudio("1104906045", var_189_9)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906045", "story_v_side_new_1104906.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906045", "story_v_side_new_1104906.awb")
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
	Play1104906046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 1104906046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play1104906047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["1049ui_story"]) and arg_190_1.var_.characterEffect1049ui_story == nil then
				arg_190_1.var_.characterEffect1049ui_story = arg_190_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["1049ui_story"]) then
				if arg_190_1.var_.characterEffect1049ui_story and not isNil(arg_190_1.actors_["1049ui_story"]) then
					arg_190_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 0) / var_193_0)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["1049ui_story"]) and arg_190_1.var_.characterEffect1049ui_story then
				arg_190_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_193_1 = 0
			local var_193_2 = 0.125

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_3 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(1104906046).content)

				arg_190_1.text_.text = var_193_3

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 5 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 5)

				if (5 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 5)) > 0 and var_193_2 < var_193_5 then
					arg_190_1.talkMaxDuration = var_193_5

					if var_193_5 + var_193_1 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_5 + var_193_1
					end
				end

				arg_190_1.text_.text = var_193_3
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_6 = math.max(var_193_2, arg_190_1.talkMaxDuration)

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_6 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_1) / var_193_6

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_1 + var_193_6 and arg_190_1.time_ < var_193_1 + var_193_6 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play1104906047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 1104906047
		arg_194_1.duration_ = 12.2

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play1104906048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["1049ui_story"]) and arg_194_1.var_.characterEffect1049ui_story == nil then
				arg_194_1.var_.characterEffect1049ui_story = arg_194_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_0 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["1049ui_story"]) then
				if arg_194_1.var_.characterEffect1049ui_story and not isNil(arg_194_1.actors_["1049ui_story"]) then
					arg_194_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["1049ui_story"]) and arg_194_1.var_.characterEffect1049ui_story then
				arg_194_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_197_2 = 0
			local var_197_3 = 1.15

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_2 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_4 = arg_194_1:GetWordFromCfg(1104906047)
				local var_197_5 = arg_194_1:FormatText(var_197_4.content)

				arg_194_1.text_.text = var_197_5

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_7 = 46 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_5) / 46)

				if (46 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_5) / 46)) > 0 and var_197_3 < var_197_7 then
					arg_194_1.talkMaxDuration = var_197_7

					if var_197_7 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_7 + var_197_2
					end
				end

				arg_194_1.text_.text = var_197_5
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906047", "story_v_side_new_1104906.awb") ~= 0 then
					local var_197_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906047", "story_v_side_new_1104906.awb") / 1000

					if var_197_8 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_8 + var_197_2
					end

					if var_197_4.prefab_name ~= "" and arg_194_1.actors_[var_197_4.prefab_name] ~= nil then
						local var_197_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_4.prefab_name].transform, "story_v_side_new_1104906", "1104906047", "story_v_side_new_1104906.awb")

						arg_194_1:RecordAudio("1104906047", var_197_9)
						arg_194_1:RecordAudio("1104906047", var_197_9)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906047", "story_v_side_new_1104906.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906047", "story_v_side_new_1104906.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_10 = math.max(var_197_3, arg_194_1.talkMaxDuration)

			if var_197_2 <= arg_194_1.time_ and arg_194_1.time_ < var_197_2 + var_197_10 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_2) / var_197_10

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_2 + var_197_10 and arg_194_1.time_ < var_197_2 + var_197_10 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play1104906048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 1104906048
		arg_198_1.duration_ = 8

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play1104906049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_201_0 = 0
			local var_201_1 = 0.6

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_2 = arg_198_1:GetWordFromCfg(1104906048)
				local var_201_3 = arg_198_1:FormatText(var_201_2.content)

				arg_198_1.text_.text = var_201_3

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_5 = 24 <= 0 and var_201_1 or var_201_1 * (utf8.len(var_201_3) / 24)

				if (24 <= 0 and var_201_1 or var_201_1 * (utf8.len(var_201_3) / 24)) > 0 and var_201_1 < var_201_5 then
					arg_198_1.talkMaxDuration = var_201_5

					if var_201_5 + var_201_0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_5 + var_201_0
					end
				end

				arg_198_1.text_.text = var_201_3
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906048", "story_v_side_new_1104906.awb") ~= 0 then
					local var_201_6 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906048", "story_v_side_new_1104906.awb") / 1000

					if var_201_6 + var_201_0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_6 + var_201_0
					end

					if var_201_2.prefab_name ~= "" and arg_198_1.actors_[var_201_2.prefab_name] ~= nil then
						local var_201_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_2.prefab_name].transform, "story_v_side_new_1104906", "1104906048", "story_v_side_new_1104906.awb")

						arg_198_1:RecordAudio("1104906048", var_201_7)
						arg_198_1:RecordAudio("1104906048", var_201_7)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906048", "story_v_side_new_1104906.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906048", "story_v_side_new_1104906.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_8 = math.max(var_201_1, arg_198_1.talkMaxDuration)

			if var_201_0 <= arg_198_1.time_ and arg_198_1.time_ < var_201_0 + var_201_8 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_0) / var_201_8

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_0 + var_201_8 and arg_198_1.time_ < var_201_0 + var_201_8 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play1104906049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 1104906049
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play1104906050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos1049ui_story = arg_202_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_205_0 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 then
				arg_202_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_202_1.time_ - 0) / var_205_0)
				arg_202_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_202_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1049ui_story"].transform.position).z)
				arg_202_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_202_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_202_1.actors_["1049ui_story"].transform.localEulerAngles = arg_202_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 then
				arg_202_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_202_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_202_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1049ui_story"].transform.position).z)
				arg_202_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_202_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_202_1.actors_["1049ui_story"].transform.localEulerAngles = arg_202_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_205_1 = arg_202_1.actors_["1049ui_story"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_1) and arg_202_1.var_.characterEffect1049ui_story == nil then
				arg_202_1.var_.characterEffect1049ui_story = var_205_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_2 and not isNil(var_205_1) then
				if arg_202_1.var_.characterEffect1049ui_story and not isNil(var_205_1) then
					arg_202_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_2)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_2 and arg_202_1.time_ < 0 + var_205_2 + arg_205_0 and not isNil(var_205_1) and arg_202_1.var_.characterEffect1049ui_story then
				arg_202_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_205_3 = 0
			local var_205_4 = 1.05

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_3 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_5 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(1104906049).content)

				arg_202_1.text_.text = var_205_5

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_7 = 42 <= 0 and var_205_4 or var_205_4 * (utf8.len(var_205_5) / 42)

				if (42 <= 0 and var_205_4 or var_205_4 * (utf8.len(var_205_5) / 42)) > 0 and var_205_4 < var_205_7 then
					arg_202_1.talkMaxDuration = var_205_7

					if var_205_7 + var_205_3 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_3
					end
				end

				arg_202_1.text_.text = var_205_5
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_8 = math.max(var_205_4, arg_202_1.talkMaxDuration)

			if var_205_3 <= arg_202_1.time_ and arg_202_1.time_ < var_205_3 + var_205_8 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_3) / var_205_8

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_3 + var_205_8 and arg_202_1.time_ < var_205_3 + var_205_8 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play1104906050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 1104906050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play1104906051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0.55

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_1 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(1104906050).content)

				arg_206_1.text_.text = var_209_1

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_3 = 22 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_1) / 22)

				if (22 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_1) / 22)) > 0 and var_209_0 < var_209_3 then
					arg_206_1.talkMaxDuration = var_209_3

					if var_209_3 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_3 + 0
					end
				end

				arg_206_1.text_.text = var_209_1
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_4 = math.max(var_209_0, arg_206_1.talkMaxDuration)

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_4 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - 0) / var_209_4

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= 0 + var_209_4 and arg_206_1.time_ < 0 + var_209_4 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play1104906051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 1104906051
		arg_210_1.duration_ = 1

		SetActive(arg_210_1.tipsGo_, true)

		arg_210_1.tipsText_.text = StoryTipsCfg[104901].name

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"

			SetActive(arg_210_1.choicesGo_, true)

			for iter_211_0, iter_211_1 in ipairs(arg_210_1.choices_) do
				SetActive(iter_211_1.go, iter_211_0 <= 2)
			end

			arg_210_1.choices_[1].txt.text = arg_210_1:FormatText(StoryChoiceCfg[1185].name)
			arg_210_1.choices_[2].txt.text = arg_210_1:FormatText(StoryChoiceCfg[1186].name)
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				PlayerAction.UseStoryTrigger(1049013, 210490106, 1104906051, 1)
				arg_210_0:Play1104906052(arg_210_1)
			end

			if arg_212_0 == 2 then
				arg_210_0:Play1104906053(arg_210_1)
			end

			arg_210_1:RecordChoiceLog(1104906051, 1185, 1186)
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.allBtn_.enabled = false
			end

			if arg_210_1.time_ >= 0 + 0.6 and arg_210_1.time_ < 0 + 0.6 + arg_213_0 then
				arg_210_1.allBtn_.enabled = true
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play1104906052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 1104906052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play1104906054(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0.975

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_1 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(1104906052).content)

				arg_214_1.text_.text = var_217_1

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_3 = 39 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 39)

				if (39 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 39)) > 0 and var_217_0 < var_217_3 then
					arg_214_1.talkMaxDuration = var_217_3

					if var_217_3 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_3 + 0
					end
				end

				arg_214_1.text_.text = var_217_1
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_4 = math.max(var_217_0, arg_214_1.talkMaxDuration)

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_4 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - 0) / var_217_4

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= 0 + var_217_4 and arg_214_1.time_ < 0 + var_217_4 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play1104906054 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 1104906054
		arg_218_1.duration_ = 9.07

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play1104906055(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["1049ui_story"]) and arg_218_1.var_.characterEffect1049ui_story == nil then
				arg_218_1.var_.characterEffect1049ui_story = arg_218_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_0 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["1049ui_story"]) then
				if arg_218_1.var_.characterEffect1049ui_story and not isNil(arg_218_1.actors_["1049ui_story"]) then
					arg_218_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["1049ui_story"]) and arg_218_1.var_.characterEffect1049ui_story then
				arg_218_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_221_2 = arg_218_1.actors_["1049ui_story"].transform

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos1049ui_story = var_221_2.localPosition
			end

			local var_221_3 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_3 then
				var_221_2.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_218_1.time_ - 0) / var_221_3)
				var_221_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_2.position).x, (manager.ui.mainCamera.transform.position - var_221_2.position).y, (manager.ui.mainCamera.transform.position - var_221_2.position).z)
				var_221_2.localEulerAngles.z = 0
				var_221_2.localEulerAngles.x = 0
				var_221_2.localEulerAngles = var_221_2.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_3 and arg_218_1.time_ < 0 + var_221_3 + arg_221_0 then
				var_221_2.localPosition = Vector3.New(0, -1.2, -6)
				var_221_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_2.position).x, (manager.ui.mainCamera.transform.position - var_221_2.position).y, (manager.ui.mainCamera.transform.position - var_221_2.position).z)
				var_221_2.localEulerAngles.z = 0
				var_221_2.localEulerAngles.x = 0
				var_221_2.localEulerAngles = var_221_2.localEulerAngles
			end

			local var_221_4 = 0
			local var_221_5 = 0.55

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_4 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_6 = arg_218_1:GetWordFromCfg(1104906054)
				local var_221_7 = arg_218_1:FormatText(var_221_6.content)

				arg_218_1.text_.text = var_221_7

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_9 = 22 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 22)

				if (22 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 22)) > 0 and var_221_5 < var_221_9 then
					arg_218_1.talkMaxDuration = var_221_9

					if var_221_9 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_9 + var_221_4
					end
				end

				arg_218_1.text_.text = var_221_7
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906054", "story_v_side_new_1104906.awb") ~= 0 then
					local var_221_10 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906054", "story_v_side_new_1104906.awb") / 1000

					if var_221_10 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_10 + var_221_4
					end

					if var_221_6.prefab_name ~= "" and arg_218_1.actors_[var_221_6.prefab_name] ~= nil then
						local var_221_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_6.prefab_name].transform, "story_v_side_new_1104906", "1104906054", "story_v_side_new_1104906.awb")

						arg_218_1:RecordAudio("1104906054", var_221_11)
						arg_218_1:RecordAudio("1104906054", var_221_11)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906054", "story_v_side_new_1104906.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906054", "story_v_side_new_1104906.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_12 = math.max(var_221_5, arg_218_1.talkMaxDuration)

			if var_221_4 <= arg_218_1.time_ and arg_218_1.time_ < var_221_4 + var_221_12 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_4) / var_221_12

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_4 + var_221_12 and arg_218_1.time_ < var_221_4 + var_221_12 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play1104906055 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1104906055
		arg_222_1.duration_ = 9

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play1104906056(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 2 < arg_222_1.time_ and arg_222_1.time_ <= 2 + arg_225_0 then
				local var_225_0 = arg_222_1.bgs_.ST58

				arg_222_1.bgs_.ST58.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_225_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_225_1 = var_225_0:GetComponent("SpriteRenderer")

				if var_225_1 and var_225_1.sprite then
					local var_225_2 = 2 * (var_225_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_225_0.transform.localScale = Vector3.New(var_225_2 / var_225_1.sprite.bounds.size.y < var_225_2 * manager.ui.mainCameraCom_.aspect / var_225_1.sprite.bounds.size.x and var_225_2 * manager.ui.mainCameraCom_.aspect / var_225_1.sprite.bounds.size.x or var_225_2 / var_225_1.sprite.bounds.size.y, var_225_2 / var_225_1.sprite.bounds.size.y < var_225_2 * manager.ui.mainCameraCom_.aspect / var_225_1.sprite.bounds.size.x and var_225_2 * manager.ui.mainCameraCom_.aspect / var_225_1.sprite.bounds.size.x or var_225_2 / var_225_1.sprite.bounds.size.y, 0)
				end

				for iter_225_0, iter_225_1 in pairs(arg_222_1.bgs_) do
					if iter_225_0 ~= "ST58" then
						iter_225_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_225_3 = 4

			if 4 < arg_222_1.time_ and arg_222_1.time_ <= var_225_3 + arg_225_0 then
				arg_222_1.allBtn_.enabled = false
			end

			if arg_222_1.time_ >= var_225_3 + 0.3 and arg_222_1.time_ < var_225_3 + 0.3 + arg_225_0 then
				arg_222_1.allBtn_.enabled = true
			end

			local var_225_4 = 0

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_4 + arg_225_0 then
				arg_222_1.mask_.enabled = true
				arg_222_1.mask_.raycastTarget = true

				arg_222_1:SetGaussion(false)
			end

			local var_225_5 = 2

			if var_225_4 <= arg_222_1.time_ and arg_222_1.time_ < var_225_4 + var_225_5 then
				local var_225_6 = Color.New(0, 0, 0)

				var_225_6.a = Mathf.Lerp(0, 1, (arg_222_1.time_ - var_225_4) / var_225_5)
				arg_222_1.mask_.color = var_225_6
			end

			if arg_222_1.time_ >= var_225_4 + var_225_5 and arg_222_1.time_ < var_225_4 + var_225_5 + arg_225_0 then
				local var_225_7 = Color.New(0, 0, 0)

				var_225_7.a = 1
				arg_222_1.mask_.color = var_225_7
			end

			local var_225_8 = 2

			if 2 < arg_222_1.time_ and arg_222_1.time_ <= var_225_8 + arg_225_0 then
				arg_222_1.mask_.enabled = true
				arg_222_1.mask_.raycastTarget = true

				arg_222_1:SetGaussion(false)
			end

			local var_225_9 = 2

			if var_225_8 <= arg_222_1.time_ and arg_222_1.time_ < var_225_8 + var_225_9 then
				local var_225_10 = Color.New(0, 0, 0)

				var_225_10.a = Mathf.Lerp(1, 0, (arg_222_1.time_ - var_225_8) / var_225_9)
				arg_222_1.mask_.color = var_225_10
			end

			if arg_222_1.time_ >= var_225_8 + var_225_9 and arg_222_1.time_ < var_225_8 + var_225_9 + arg_225_0 then
				local var_225_11 = Color.New(0, 0, 0)

				arg_222_1.mask_.enabled = false
				var_225_11.a = 0
				arg_222_1.mask_.color = var_225_11
			end

			local var_225_12 = arg_222_1.actors_["1049ui_story"].transform

			if 1.96599999815226 < arg_222_1.time_ and arg_222_1.time_ <= 1.96599999815226 + arg_225_0 then
				arg_222_1.var_.moveOldPos1049ui_story = var_225_12.localPosition
			end

			local var_225_13 = 0.001

			if 1.96599999815226 <= arg_222_1.time_ and arg_222_1.time_ < 1.96599999815226 + var_225_13 then
				var_225_12.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_222_1.time_ - 1.96599999815226) / var_225_13)
				var_225_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_225_12.position).x, (manager.ui.mainCamera.transform.position - var_225_12.position).y, (manager.ui.mainCamera.transform.position - var_225_12.position).z)
				var_225_12.localEulerAngles.z = 0
				var_225_12.localEulerAngles.x = 0
				var_225_12.localEulerAngles = var_225_12.localEulerAngles
			end

			if arg_222_1.time_ >= 1.96599999815226 + var_225_13 and arg_222_1.time_ < 1.96599999815226 + var_225_13 + arg_225_0 then
				var_225_12.localPosition = Vector3.New(0, 100, 0)
				var_225_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_225_12.position).x, (manager.ui.mainCamera.transform.position - var_225_12.position).y, (manager.ui.mainCamera.transform.position - var_225_12.position).z)
				var_225_12.localEulerAngles.z = 0
				var_225_12.localEulerAngles.x = 0
				var_225_12.localEulerAngles = var_225_12.localEulerAngles
			end

			local var_225_14 = arg_222_1.actors_["1049ui_story"]

			if 1.96599999815226 < arg_222_1.time_ and arg_222_1.time_ <= 1.96599999815226 + arg_225_0 and not isNil(var_225_14) and arg_222_1.var_.characterEffect1049ui_story == nil then
				arg_222_1.var_.characterEffect1049ui_story = var_225_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_15 = 0.034000001847744

			if 1.96599999815226 <= arg_222_1.time_ and arg_222_1.time_ < 1.96599999815226 + var_225_15 and not isNil(var_225_14) then
				if arg_222_1.var_.characterEffect1049ui_story and not isNil(var_225_14) then
					arg_222_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_222_1.time_ - 1.96599999815226) / var_225_15)
				end
			end

			if arg_222_1.time_ >= 1.96599999815226 + var_225_15 and arg_222_1.time_ < 1.96599999815226 + var_225_15 + arg_225_0 and not isNil(var_225_14) and arg_222_1.var_.characterEffect1049ui_story then
				arg_222_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			if arg_222_1.frameCnt_ <= 1 then
				arg_222_1.dialog_:SetActive(false)
			end

			local var_225_16 = 4
			local var_225_17 = 0.575

			if 4 < arg_222_1.time_ and arg_222_1.time_ <= var_225_16 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0

				arg_222_1.dialog_:SetActive(true)

				arg_222_1.dialogCg_.alpha = 0

				local var_225_18 = LeanTween.value(arg_222_1.dialog_, 0, 1, 0.3)

				var_225_18:setOnUpdate(LuaHelper.FloatAction(function(arg_226_0)
					arg_222_1.dialogCg_.alpha = arg_226_0
				end))
				var_225_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_222_1.dialog_)
					var_225_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_222_1.duration_ = arg_222_1.duration_ + 0.3

				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_19 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(1104906055).content)

				arg_222_1.text_.text = var_225_19

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_21 = 23 <= 0 and var_225_17 or var_225_17 * (utf8.len(var_225_19) / 23)

				if (23 <= 0 and var_225_17 or var_225_17 * (utf8.len(var_225_19) / 23)) > 0 and var_225_17 < var_225_21 then
					arg_222_1.talkMaxDuration = var_225_21
					var_225_16 = var_225_16 + 0.3

					if var_225_21 + var_225_16 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_21 + var_225_16
					end
				end

				arg_222_1.text_.text = var_225_19
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_22 = var_225_16 + 0.3
			local var_225_23 = math.max(var_225_17, arg_222_1.talkMaxDuration)

			if var_225_16 + 0.3 <= arg_222_1.time_ and arg_222_1.time_ < var_225_22 + var_225_23 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_22) / var_225_23

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_22 + var_225_23 and arg_222_1.time_ < var_225_22 + var_225_23 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play1104906056 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 1104906056
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play1104906057(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 1.1

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, false)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_1 = arg_228_1:FormatText(arg_228_1:GetWordFromCfg(1104906056).content)

				arg_228_1.text_.text = var_231_1

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_3 = 44 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_1) / 44)

				if (44 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_1) / 44)) > 0 and var_231_0 < var_231_3 then
					arg_228_1.talkMaxDuration = var_231_3

					if var_231_3 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_3 + 0
					end
				end

				arg_228_1.text_.text = var_231_1
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_4 = math.max(var_231_0, arg_228_1.talkMaxDuration)

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_4 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - 0) / var_231_4

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= 0 + var_231_4 and arg_228_1.time_ < 0 + var_231_4 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play1104906057 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 1104906057
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play1104906058(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 1.425

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, true)
				arg_232_1.iconController_:SetSelectedState("hero")

				arg_232_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_232_1.callingController_:SetSelectedState("normal")

				arg_232_1.keyicon_.color = Color.New(1, 1, 1)
				arg_232_1.icon_.color = Color.New(1, 1, 1)

				local var_235_1 = arg_232_1:FormatText(arg_232_1:GetWordFromCfg(1104906057).content)

				arg_232_1.text_.text = var_235_1

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_3 = 57 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_1) / 57)

				if (57 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_1) / 57)) > 0 and var_235_0 < var_235_3 then
					arg_232_1.talkMaxDuration = var_235_3

					if var_235_3 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_3 + 0
					end
				end

				arg_232_1.text_.text = var_235_1
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_4 = math.max(var_235_0, arg_232_1.talkMaxDuration)

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_4 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - 0) / var_235_4

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= 0 + var_235_4 and arg_232_1.time_ < 0 + var_235_4 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play1104906058 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 1104906058
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play1104906059(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0.1

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_1 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(1104906058).content)

				arg_236_1.text_.text = var_239_1

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_3 = 4 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_1) / 4)

				if (4 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_1) / 4)) > 0 and var_239_0 < var_239_3 then
					arg_236_1.talkMaxDuration = var_239_3

					if var_239_3 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_3 + 0
					end
				end

				arg_236_1.text_.text = var_239_1
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_4 = math.max(var_239_0, arg_236_1.talkMaxDuration)

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_4 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - 0) / var_239_4

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= 0 + var_239_4 and arg_236_1.time_ < 0 + var_239_4 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play1104906059 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 1104906059
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play1104906060(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0.15

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_1 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(1104906059).content)

				arg_240_1.text_.text = var_243_1

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_3 = 6 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_1) / 6)

				if (6 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_1) / 6)) > 0 and var_243_0 < var_243_3 then
					arg_240_1.talkMaxDuration = var_243_3

					if var_243_3 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_3 + 0
					end
				end

				arg_240_1.text_.text = var_243_1
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_4 = math.max(var_243_0, arg_240_1.talkMaxDuration)

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_4 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - 0) / var_243_4

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= 0 + var_243_4 and arg_240_1.time_ < 0 + var_243_4 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play1104906060 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 1104906060
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play1104906061(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0.1

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_1 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(1104906060).content)

				arg_244_1.text_.text = var_247_1

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_3 = 4 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_1) / 4)

				if (4 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_1) / 4)) > 0 and var_247_0 < var_247_3 then
					arg_244_1.talkMaxDuration = var_247_3

					if var_247_3 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_3 + 0
					end
				end

				arg_244_1.text_.text = var_247_1
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_4 = math.max(var_247_0, arg_244_1.talkMaxDuration)

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_4 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - 0) / var_247_4

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= 0 + var_247_4 and arg_244_1.time_ < 0 + var_247_4 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play1104906061 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 1104906061
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play1104906062(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0.15

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_1 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(1104906061).content)

				arg_248_1.text_.text = var_251_1

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_3 = 6 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_1) / 6)

				if (6 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_1) / 6)) > 0 and var_251_0 < var_251_3 then
					arg_248_1.talkMaxDuration = var_251_3

					if var_251_3 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_3 + 0
					end
				end

				arg_248_1.text_.text = var_251_1
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_4 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_4 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_4

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_4 and arg_248_1.time_ < 0 + var_251_4 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play1104906062 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 1104906062
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play1104906063(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0.625

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_1 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(1104906062).content)

				arg_252_1.text_.text = var_255_1

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_3 = 25 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_1) / 25)

				if (25 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_1) / 25)) > 0 and var_255_0 < var_255_3 then
					arg_252_1.talkMaxDuration = var_255_3

					if var_255_3 + 0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_3 + 0
					end
				end

				arg_252_1.text_.text = var_255_1
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_4 = math.max(var_255_0, arg_252_1.talkMaxDuration)

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_4 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - 0) / var_255_4

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= 0 + var_255_4 and arg_252_1.time_ < 0 + var_255_4 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play1104906063 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 1104906063
		arg_256_1.duration_ = 7.17

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play1104906064(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if arg_256_1.bgs_.STblack == nil then
				local var_259_0 = Object.Instantiate(arg_256_1.paintGo_)

				var_259_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_259_0.name = "STblack"
				var_259_0.transform.parent = arg_256_1.stage_.transform
				var_259_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_256_1.bgs_.STblack = var_259_0
			end

			if 3 < arg_256_1.time_ and arg_256_1.time_ <= 3 + arg_259_0 then
				local var_259_1 = arg_256_1.bgs_.STblack

				arg_256_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_259_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_259_2 = var_259_1:GetComponent("SpriteRenderer")

				if var_259_2 and var_259_2.sprite then
					local var_259_3 = 2 * (var_259_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_259_1.transform.localScale = Vector3.New(var_259_3 / var_259_2.sprite.bounds.size.y < var_259_3 * manager.ui.mainCameraCom_.aspect / var_259_2.sprite.bounds.size.x and var_259_3 * manager.ui.mainCameraCom_.aspect / var_259_2.sprite.bounds.size.x or var_259_3 / var_259_2.sprite.bounds.size.y, var_259_3 / var_259_2.sprite.bounds.size.y < var_259_3 * manager.ui.mainCameraCom_.aspect / var_259_2.sprite.bounds.size.x and var_259_3 * manager.ui.mainCameraCom_.aspect / var_259_2.sprite.bounds.size.x or var_259_3 / var_259_2.sprite.bounds.size.y, 0)
				end

				for iter_259_0, iter_259_1 in pairs(arg_256_1.bgs_) do
					if iter_259_0 ~= "STblack" then
						iter_259_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_259_4 = 5.999999999999

			if 5.999999999999 < arg_256_1.time_ and arg_256_1.time_ <= var_259_4 + arg_259_0 then
				arg_256_1.allBtn_.enabled = false
			end

			if arg_256_1.time_ >= var_259_4 + 0.3 and arg_256_1.time_ < var_259_4 + 0.3 + arg_259_0 then
				arg_256_1.allBtn_.enabled = true
			end

			local var_259_5 = 0

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_5 + arg_259_0 then
				arg_256_1.mask_.enabled = true
				arg_256_1.mask_.raycastTarget = true

				arg_256_1:SetGaussion(false)
			end

			local var_259_6 = 3

			if var_259_5 <= arg_256_1.time_ and arg_256_1.time_ < var_259_5 + var_259_6 then
				local var_259_7 = Color.New(0, 0, 0)

				var_259_7.a = Mathf.Lerp(0, 1, (arg_256_1.time_ - var_259_5) / var_259_6)
				arg_256_1.mask_.color = var_259_7
			end

			if arg_256_1.time_ >= var_259_5 + var_259_6 and arg_256_1.time_ < var_259_5 + var_259_6 + arg_259_0 then
				local var_259_8 = Color.New(0, 0, 0)

				var_259_8.a = 1
				arg_256_1.mask_.color = var_259_8
			end

			local var_259_9 = 3

			if 3 < arg_256_1.time_ and arg_256_1.time_ <= var_259_9 + arg_259_0 then
				arg_256_1.mask_.enabled = true
				arg_256_1.mask_.raycastTarget = true

				arg_256_1:SetGaussion(false)
			end

			local var_259_10 = 3

			if var_259_9 <= arg_256_1.time_ and arg_256_1.time_ < var_259_9 + var_259_10 then
				local var_259_11 = Color.New(0, 0, 0)

				var_259_11.a = Mathf.Lerp(1, 0, (arg_256_1.time_ - var_259_9) / var_259_10)
				arg_256_1.mask_.color = var_259_11
			end

			if arg_256_1.time_ >= var_259_9 + var_259_10 and arg_256_1.time_ < var_259_9 + var_259_10 + arg_259_0 then
				local var_259_12 = Color.New(0, 0, 0)

				arg_256_1.mask_.enabled = false
				var_259_12.a = 0
				arg_256_1.mask_.color = var_259_12
			end

			local var_259_13 = arg_256_1.actors_["1049ui_story"]

			if 2.98333333333333 < arg_256_1.time_ and arg_256_1.time_ <= 2.98333333333333 + arg_259_0 and not isNil(var_259_13) and arg_256_1.var_.characterEffect1049ui_story == nil then
				arg_256_1.var_.characterEffect1049ui_story = var_259_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_14 = 0.0166666666666666

			if 2.98333333333333 <= arg_256_1.time_ and arg_256_1.time_ < 2.98333333333333 + var_259_14 and not isNil(var_259_13) then
				if arg_256_1.var_.characterEffect1049ui_story and not isNil(var_259_13) then
					arg_256_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= 2.98333333333333 + var_259_14 and arg_256_1.time_ < 2.98333333333333 + var_259_14 + arg_259_0 and not isNil(var_259_13) and arg_256_1.var_.characterEffect1049ui_story then
				arg_256_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 1.1 < arg_256_1.time_ and arg_256_1.time_ <= 1.1 + arg_259_0 then
				arg_256_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_259_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_256_1.bgmTxt_.text ~= var_259_18 and arg_256_1.bgmTxt_.text ~= "" then
						if arg_256_1.bgmTxt2_.text ~= "" then
							arg_256_1.bgmTxt_.text = arg_256_1.bgmTxt2_.text
						end

						arg_256_1.bgmTxt2_.text = var_259_18

						arg_256_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_256_1.bgmTxt_.text = var_259_18
						arg_256_1.bgmTxt2_.text = var_259_18
					end

					if arg_256_1.bgmTimer then
						arg_256_1.bgmTimer:Stop()

						arg_256_1.bgmTimer = nil
					end

					if arg_256_1.settingData.show_music_name == 1 then
						arg_256_1.musicController:SetSelectedState("show")
						arg_256_1.musicAnimator_:Play("open", 0, 0)

						if arg_256_1.settingData.music_time ~= 0 then
							arg_256_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_256_1.settingData.music_time), function()
								if arg_256_1 == nil or isNil(arg_256_1.bgmTxt_) then
									return
								end

								arg_256_1.musicController:SetSelectedState("hide")
								arg_256_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_256_1.frameCnt_ <= 1 then
				arg_256_1.dialog_:SetActive(false)
			end

			local var_259_19 = 5.8
			local var_259_20 = 0.125

			if 5.8 < arg_256_1.time_ and arg_256_1.time_ <= var_259_19 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0

				arg_256_1.dialog_:SetActive(true)

				arg_256_1.dialogCg_.alpha = 0

				local var_259_21 = LeanTween.value(arg_256_1.dialog_, 0, 1, 0.3)

				var_259_21:setOnUpdate(LuaHelper.FloatAction(function(arg_261_0)
					arg_256_1.dialogCg_.alpha = arg_261_0
				end))
				var_259_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_256_1.dialog_)
					var_259_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_256_1.duration_ = arg_256_1.duration_ + 0.3

				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_22 = arg_256_1:GetWordFromCfg(1104906063)
				local var_259_23 = arg_256_1:FormatText(var_259_22.content)

				arg_256_1.text_.text = var_259_23

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_25 = 5 <= 0 and var_259_20 or var_259_20 * (utf8.len(var_259_23) / 5)

				if (5 <= 0 and var_259_20 or var_259_20 * (utf8.len(var_259_23) / 5)) > 0 and var_259_20 < var_259_25 then
					arg_256_1.talkMaxDuration = var_259_25
					var_259_19 = var_259_19 + 0.3

					if var_259_25 + var_259_19 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_25 + var_259_19
					end
				end

				arg_256_1.text_.text = var_259_23
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906063", "story_v_side_new_1104906.awb") ~= 0 then
					local var_259_26 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906063", "story_v_side_new_1104906.awb") / 1000

					if var_259_26 + var_259_19 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_26 + var_259_19
					end

					if var_259_22.prefab_name ~= "" and arg_256_1.actors_[var_259_22.prefab_name] ~= nil then
						local var_259_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_22.prefab_name].transform, "story_v_side_new_1104906", "1104906063", "story_v_side_new_1104906.awb")

						arg_256_1:RecordAudio("1104906063", var_259_27)
						arg_256_1:RecordAudio("1104906063", var_259_27)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906063", "story_v_side_new_1104906.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906063", "story_v_side_new_1104906.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_28 = var_259_19 + 0.3
			local var_259_29 = math.max(var_259_20, arg_256_1.talkMaxDuration)

			if var_259_19 + 0.3 <= arg_256_1.time_ and arg_256_1.time_ < var_259_28 + var_259_29 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_28) / var_259_29

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_28 + var_259_29 and arg_256_1.time_ < var_259_28 + var_259_29 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play1104906064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1104906064
		arg_263_1.duration_ = 7

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1104906065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if arg_263_1.bgs_.K11f == nil then
				local var_266_0 = Object.Instantiate(arg_263_1.paintGo_)

				var_266_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K11f")
				var_266_0.name = "K11f"
				var_266_0.transform.parent = arg_263_1.stage_.transform
				var_266_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_263_1.bgs_.K11f = var_266_0
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				local var_266_1 = arg_263_1.bgs_.K11f

				arg_263_1.bgs_.K11f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_266_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_266_2 = var_266_1:GetComponent("SpriteRenderer")

				if var_266_2 and var_266_2.sprite then
					local var_266_3 = 2 * (var_266_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_266_1.transform.localScale = Vector3.New(var_266_3 / var_266_2.sprite.bounds.size.y < var_266_3 * manager.ui.mainCameraCom_.aspect / var_266_2.sprite.bounds.size.x and var_266_3 * manager.ui.mainCameraCom_.aspect / var_266_2.sprite.bounds.size.x or var_266_3 / var_266_2.sprite.bounds.size.y, var_266_3 / var_266_2.sprite.bounds.size.y < var_266_3 * manager.ui.mainCameraCom_.aspect / var_266_2.sprite.bounds.size.x and var_266_3 * manager.ui.mainCameraCom_.aspect / var_266_2.sprite.bounds.size.x or var_266_3 / var_266_2.sprite.bounds.size.y, 0)
				end

				for iter_266_0, iter_266_1 in pairs(arg_263_1.bgs_) do
					if iter_266_0 ~= "K11f" then
						iter_266_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_266_4 = 2

			if 2 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1.allBtn_.enabled = false
			end

			if arg_263_1.time_ >= var_266_4 + 0.3 and arg_263_1.time_ < var_266_4 + 0.3 + arg_266_0 then
				arg_263_1.allBtn_.enabled = true
			end

			local var_266_5 = 0

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_5 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_6 = 2

			if var_266_5 <= arg_263_1.time_ and arg_263_1.time_ < var_266_5 + var_266_6 then
				local var_266_7 = Color.New(0, 0, 0)

				var_266_7.a = Mathf.Lerp(1, 0, (arg_263_1.time_ - var_266_5) / var_266_6)
				arg_263_1.mask_.color = var_266_7
			end

			if arg_263_1.time_ >= var_266_5 + var_266_6 and arg_263_1.time_ < var_266_5 + var_266_6 + arg_266_0 then
				local var_266_8 = Color.New(0, 0, 0)

				arg_263_1.mask_.enabled = false
				var_266_8.a = 0
				arg_263_1.mask_.color = var_266_8
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:AudioAction("stop", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_266_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_263_1.bgmTxt_.text ~= var_266_13 and arg_263_1.bgmTxt_.text ~= "" then
						if arg_263_1.bgmTxt2_.text ~= "" then
							arg_263_1.bgmTxt_.text = arg_263_1.bgmTxt2_.text
						end

						arg_263_1.bgmTxt2_.text = var_266_13

						arg_263_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_263_1.bgmTxt_.text = var_266_13
						arg_263_1.bgmTxt2_.text = var_266_13
					end

					if arg_263_1.bgmTimer then
						arg_263_1.bgmTimer:Stop()

						arg_263_1.bgmTimer = nil
					end

					if arg_263_1.settingData.show_music_name == 1 then
						arg_263_1.musicController:SetSelectedState("show")
						arg_263_1.musicAnimator_:Play("open", 0, 0)

						if arg_263_1.settingData.music_time ~= 0 then
							arg_263_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_263_1.settingData.music_time), function()
								if arg_263_1 == nil or isNil(arg_263_1.bgmTxt_) then
									return
								end

								arg_263_1.musicController:SetSelectedState("hide")
								arg_263_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_263_1.time_ and arg_263_1.time_ <= 0.4 + arg_266_0 then
				arg_263_1:AudioAction("play", "music", "bgm_side_daily07", "bgm_side_daily07", "bgm_side_daily07.awb")

				local var_266_16 = manager.audio:GetAudioName("bgm_side_daily07", "bgm_side_daily07")

				if "" ~= "" then
					if arg_263_1.bgmTxt_.text ~= var_266_16 and arg_263_1.bgmTxt_.text ~= "" then
						if arg_263_1.bgmTxt2_.text ~= "" then
							arg_263_1.bgmTxt_.text = arg_263_1.bgmTxt2_.text
						end

						arg_263_1.bgmTxt2_.text = var_266_16

						arg_263_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_263_1.bgmTxt_.text = var_266_16
						arg_263_1.bgmTxt2_.text = var_266_16
					end

					if arg_263_1.bgmTimer then
						arg_263_1.bgmTimer:Stop()

						arg_263_1.bgmTimer = nil
					end

					if arg_263_1.settingData.show_music_name == 1 then
						arg_263_1.musicController:SetSelectedState("show")
						arg_263_1.musicAnimator_:Play("open", 0, 0)

						if arg_263_1.settingData.music_time ~= 0 then
							arg_263_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_263_1.settingData.music_time), function()
								if arg_263_1 == nil or isNil(arg_263_1.bgmTxt_) then
									return
								end

								arg_263_1.musicController:SetSelectedState("hide")
								arg_263_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_263_1.frameCnt_ <= 1 then
				arg_263_1.dialog_:SetActive(false)
			end

			local var_266_17 = 2
			local var_266_18 = 0.225

			if 2 < arg_263_1.time_ and arg_263_1.time_ <= var_266_17 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0

				arg_263_1.dialog_:SetActive(true)

				arg_263_1.dialogCg_.alpha = 0

				local var_266_19 = LeanTween.value(arg_263_1.dialog_, 0, 1, 0.3)

				var_266_19:setOnUpdate(LuaHelper.FloatAction(function(arg_269_0)
					arg_263_1.dialogCg_.alpha = arg_269_0
				end))
				var_266_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_263_1.dialog_)
					var_266_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_263_1.duration_ = arg_263_1.duration_ + 0.3

				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_20 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(1104906064).content)

				arg_263_1.text_.text = var_266_20

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_22 = 9 <= 0 and var_266_18 or var_266_18 * (utf8.len(var_266_20) / 9)

				if (9 <= 0 and var_266_18 or var_266_18 * (utf8.len(var_266_20) / 9)) > 0 and var_266_18 < var_266_22 then
					arg_263_1.talkMaxDuration = var_266_22
					var_266_17 = var_266_17 + 0.3

					if var_266_22 + var_266_17 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_22 + var_266_17
					end
				end

				arg_263_1.text_.text = var_266_20
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_23 = var_266_17 + 0.3
			local var_266_24 = math.max(var_266_18, arg_263_1.talkMaxDuration)

			if var_266_17 + 0.3 <= arg_263_1.time_ and arg_263_1.time_ < var_266_23 + var_266_24 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_23) / var_266_24

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_23 + var_266_24 and arg_263_1.time_ < var_266_23 + var_266_24 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play1104906065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1104906065
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1104906066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 1.3

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_1 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(1104906065).content)

				arg_271_1.text_.text = var_274_1

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_3 = 52 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 52)

				if (52 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 52)) > 0 and var_274_0 < var_274_3 then
					arg_271_1.talkMaxDuration = var_274_3

					if var_274_3 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_3 + 0
					end
				end

				arg_271_1.text_.text = var_274_1
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_4 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_4

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play1104906066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1104906066
		arg_275_1.duration_ = 3.4

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play1104906067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos1049ui_story = arg_275_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_278_0 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 then
				arg_275_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_275_1.time_ - 0) / var_278_0)
				arg_275_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1049ui_story"].transform.position).z)
				arg_275_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1049ui_story"].transform.localEulerAngles = arg_275_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 then
				arg_275_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_275_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1049ui_story"].transform.position).z)
				arg_275_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1049ui_story"].transform.localEulerAngles = arg_275_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_278_1 = arg_275_1.actors_["1049ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1049ui_story == nil then
				arg_275_1.var_.characterEffect1049ui_story = var_278_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_2 and not isNil(var_278_1) then
				if arg_275_1.var_.characterEffect1049ui_story and not isNil(var_278_1) then
					arg_275_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_2 and arg_275_1.time_ < 0 + var_278_2 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1049ui_story then
				arg_275_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_278_4 = 0
			local var_278_5 = 0.325

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_4 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_6 = arg_275_1:GetWordFromCfg(1104906066)
				local var_278_7 = arg_275_1:FormatText(var_278_6.content)

				arg_275_1.text_.text = var_278_7

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_9 = 13 <= 0 and var_278_5 or var_278_5 * (utf8.len(var_278_7) / 13)

				if (13 <= 0 and var_278_5 or var_278_5 * (utf8.len(var_278_7) / 13)) > 0 and var_278_5 < var_278_9 then
					arg_275_1.talkMaxDuration = var_278_9

					if var_278_9 + var_278_4 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_9 + var_278_4
					end
				end

				arg_275_1.text_.text = var_278_7
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906066", "story_v_side_new_1104906.awb") ~= 0 then
					local var_278_10 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906066", "story_v_side_new_1104906.awb") / 1000

					if var_278_10 + var_278_4 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_10 + var_278_4
					end

					if var_278_6.prefab_name ~= "" and arg_275_1.actors_[var_278_6.prefab_name] ~= nil then
						local var_278_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_6.prefab_name].transform, "story_v_side_new_1104906", "1104906066", "story_v_side_new_1104906.awb")

						arg_275_1:RecordAudio("1104906066", var_278_11)
						arg_275_1:RecordAudio("1104906066", var_278_11)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906066", "story_v_side_new_1104906.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906066", "story_v_side_new_1104906.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_12 = math.max(var_278_5, arg_275_1.talkMaxDuration)

			if var_278_4 <= arg_275_1.time_ and arg_275_1.time_ < var_278_4 + var_278_12 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_4) / var_278_12

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_4 + var_278_12 and arg_275_1.time_ < var_278_4 + var_278_12 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play1104906067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1104906067
		arg_279_1.duration_ = 1

		SetActive(arg_279_1.tipsGo_, true)

		arg_279_1.tipsText_.text = StoryTipsCfg[104901].name

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"

			SetActive(arg_279_1.choicesGo_, true)

			for iter_280_0, iter_280_1 in ipairs(arg_279_1.choices_) do
				SetActive(iter_280_1.go, iter_280_0 <= 2)
			end

			arg_279_1.choices_[1].txt.text = arg_279_1:FormatText(StoryChoiceCfg[1187].name)
			arg_279_1.choices_[2].txt.text = arg_279_1:FormatText(StoryChoiceCfg[1188].name)
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1104906068(arg_279_1)
			end

			if arg_281_0 == 2 then
				PlayerAction.UseStoryTrigger(1049014, 210490106, 1104906067, 2)
				arg_279_0:Play1104906069(arg_279_1)
			end

			arg_279_1:RecordChoiceLog(1104906067, 1187, 1188)
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["1049ui_story"]) and arg_279_1.var_.characterEffect1049ui_story == nil then
				arg_279_1.var_.characterEffect1049ui_story = arg_279_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["1049ui_story"]) then
				if arg_279_1.var_.characterEffect1049ui_story and not isNil(arg_279_1.actors_["1049ui_story"]) then
					arg_279_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_0)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["1049ui_story"]) and arg_279_1.var_.characterEffect1049ui_story then
				arg_279_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_282_1 = 0

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.allBtn_.enabled = false
			end

			if arg_279_1.time_ >= var_282_1 + 0.6 and arg_279_1.time_ < var_282_1 + 0.6 + arg_282_0 then
				arg_279_1.allBtn_.enabled = true
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play1104906068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1104906068
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1104906070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0.775

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_1 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(1104906068).content)

				arg_283_1.text_.text = var_286_1

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_3 = 31 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 31)

				if (31 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 31)) > 0 and var_286_0 < var_286_3 then
					arg_283_1.talkMaxDuration = var_286_3

					if var_286_3 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_3 + 0
					end
				end

				arg_283_1.text_.text = var_286_1
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_4 = math.max(var_286_0, arg_283_1.talkMaxDuration)

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_4 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - 0) / var_286_4

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= 0 + var_286_4 and arg_283_1.time_ < 0 + var_286_4 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play1104906070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1104906070
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play1104906071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0.775

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_1 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(1104906070).content)

				arg_287_1.text_.text = var_290_1

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_3 = 31 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_1) / 31)

				if (31 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_1) / 31)) > 0 and var_290_0 < var_290_3 then
					arg_287_1.talkMaxDuration = var_290_3

					if var_290_3 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_3 + 0
					end
				end

				arg_287_1.text_.text = var_290_1
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_4 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_4 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_4

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_4 and arg_287_1.time_ < 0 + var_290_4 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play1104906071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1104906071
		arg_291_1.duration_ = 3.03

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1104906072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["1049ui_story"]) and arg_291_1.var_.characterEffect1049ui_story == nil then
				arg_291_1.var_.characterEffect1049ui_story = arg_291_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_0 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["1049ui_story"]) then
				if arg_291_1.var_.characterEffect1049ui_story and not isNil(arg_291_1.actors_["1049ui_story"]) then
					arg_291_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["1049ui_story"]) and arg_291_1.var_.characterEffect1049ui_story then
				arg_291_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_2")
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_294_2 = 0
			local var_294_3 = 0.325

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_2 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_4 = arg_291_1:GetWordFromCfg(1104906071)
				local var_294_5 = arg_291_1:FormatText(var_294_4.content)

				arg_291_1.text_.text = var_294_5

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_7 = 13 <= 0 and var_294_3 or var_294_3 * (utf8.len(var_294_5) / 13)

				if (13 <= 0 and var_294_3 or var_294_3 * (utf8.len(var_294_5) / 13)) > 0 and var_294_3 < var_294_7 then
					arg_291_1.talkMaxDuration = var_294_7

					if var_294_7 + var_294_2 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_7 + var_294_2
					end
				end

				arg_291_1.text_.text = var_294_5
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906071", "story_v_side_new_1104906.awb") ~= 0 then
					local var_294_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906071", "story_v_side_new_1104906.awb") / 1000

					if var_294_8 + var_294_2 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_8 + var_294_2
					end

					if var_294_4.prefab_name ~= "" and arg_291_1.actors_[var_294_4.prefab_name] ~= nil then
						local var_294_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_4.prefab_name].transform, "story_v_side_new_1104906", "1104906071", "story_v_side_new_1104906.awb")

						arg_291_1:RecordAudio("1104906071", var_294_9)
						arg_291_1:RecordAudio("1104906071", var_294_9)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906071", "story_v_side_new_1104906.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906071", "story_v_side_new_1104906.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_10 = math.max(var_294_3, arg_291_1.talkMaxDuration)

			if var_294_2 <= arg_291_1.time_ and arg_291_1.time_ < var_294_2 + var_294_10 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_2) / var_294_10

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_2 + var_294_10 and arg_291_1.time_ < var_294_2 + var_294_10 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play1104906072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1104906072
		arg_295_1.duration_ = 3.5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1104906073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_298_0 = 0
			local var_298_1 = 0.3

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_2 = arg_295_1:GetWordFromCfg(1104906072)
				local var_298_3 = arg_295_1:FormatText(var_298_2.content)

				arg_295_1.text_.text = var_298_3

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 12 <= 0 and var_298_1 or var_298_1 * (utf8.len(var_298_3) / 12)

				if (12 <= 0 and var_298_1 or var_298_1 * (utf8.len(var_298_3) / 12)) > 0 and var_298_1 < var_298_5 then
					arg_295_1.talkMaxDuration = var_298_5

					if var_298_5 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + var_298_0
					end
				end

				arg_295_1.text_.text = var_298_3
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906072", "story_v_side_new_1104906.awb") ~= 0 then
					local var_298_6 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906072", "story_v_side_new_1104906.awb") / 1000

					if var_298_6 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_6 + var_298_0
					end

					if var_298_2.prefab_name ~= "" and arg_295_1.actors_[var_298_2.prefab_name] ~= nil then
						local var_298_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_2.prefab_name].transform, "story_v_side_new_1104906", "1104906072", "story_v_side_new_1104906.awb")

						arg_295_1:RecordAudio("1104906072", var_298_7)
						arg_295_1:RecordAudio("1104906072", var_298_7)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906072", "story_v_side_new_1104906.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906072", "story_v_side_new_1104906.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_8 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_8 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_8

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_8 and arg_295_1.time_ < var_298_0 + var_298_8 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play1104906073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1104906073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1104906074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos1049ui_story = arg_299_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_302_0 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 then
				arg_299_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_299_1.time_ - 0) / var_302_0)
				arg_299_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1049ui_story"].transform.position).z)
				arg_299_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["1049ui_story"].transform.localEulerAngles = arg_299_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 then
				arg_299_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_299_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1049ui_story"].transform.position).z)
				arg_299_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["1049ui_story"].transform.localEulerAngles = arg_299_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_302_1 = arg_299_1.actors_["1049ui_story"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect1049ui_story == nil then
				arg_299_1.var_.characterEffect1049ui_story = var_302_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_2 and not isNil(var_302_1) then
				if arg_299_1.var_.characterEffect1049ui_story and not isNil(var_302_1) then
					arg_299_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_299_1.time_ - 0) / var_302_2)
				end
			end

			if arg_299_1.time_ >= 0 + var_302_2 and arg_299_1.time_ < 0 + var_302_2 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect1049ui_story then
				arg_299_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_302_3 = 0
			local var_302_4 = 1.675

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_3 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_5 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(1104906073).content)

				arg_299_1.text_.text = var_302_5

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_7 = 67 <= 0 and var_302_4 or var_302_4 * (utf8.len(var_302_5) / 67)

				if (67 <= 0 and var_302_4 or var_302_4 * (utf8.len(var_302_5) / 67)) > 0 and var_302_4 < var_302_7 then
					arg_299_1.talkMaxDuration = var_302_7

					if var_302_7 + var_302_3 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_7 + var_302_3
					end
				end

				arg_299_1.text_.text = var_302_5
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_8 = math.max(var_302_4, arg_299_1.talkMaxDuration)

			if var_302_3 <= arg_299_1.time_ and arg_299_1.time_ < var_302_3 + var_302_8 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_3) / var_302_8

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_3 + var_302_8 and arg_299_1.time_ < var_302_3 + var_302_8 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play1104906074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1104906074
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1104906075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0.075

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_1 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(1104906074).content)

				arg_303_1.text_.text = var_306_1

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_3 = 3 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 3)

				if (3 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 3)) > 0 and var_306_0 < var_306_3 then
					arg_303_1.talkMaxDuration = var_306_3

					if var_306_3 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_3 + 0
					end
				end

				arg_303_1.text_.text = var_306_1
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_4 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_4 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_4

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_4 and arg_303_1.time_ < 0 + var_306_4 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play1104906075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1104906075
		arg_307_1.duration_ = 4.3

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1104906076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["1049ui_story"]) and arg_307_1.var_.characterEffect1049ui_story == nil then
				arg_307_1.var_.characterEffect1049ui_story = arg_307_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_0 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["1049ui_story"]) then
				if arg_307_1.var_.characterEffect1049ui_story and not isNil(arg_307_1.actors_["1049ui_story"]) then
					arg_307_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["1049ui_story"]) and arg_307_1.var_.characterEffect1049ui_story then
				arg_307_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_310_2 = 0
			local var_310_3 = 0.425

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_2 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_4 = arg_307_1:GetWordFromCfg(1104906075)
				local var_310_5 = arg_307_1:FormatText(var_310_4.content)

				arg_307_1.text_.text = var_310_5

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_7 = 17 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_5) / 17)

				if (17 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_5) / 17)) > 0 and var_310_3 < var_310_7 then
					arg_307_1.talkMaxDuration = var_310_7

					if var_310_7 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_7 + var_310_2
					end
				end

				arg_307_1.text_.text = var_310_5
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906075", "story_v_side_new_1104906.awb") ~= 0 then
					local var_310_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906075", "story_v_side_new_1104906.awb") / 1000

					if var_310_8 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_8 + var_310_2
					end

					if var_310_4.prefab_name ~= "" and arg_307_1.actors_[var_310_4.prefab_name] ~= nil then
						local var_310_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_4.prefab_name].transform, "story_v_side_new_1104906", "1104906075", "story_v_side_new_1104906.awb")

						arg_307_1:RecordAudio("1104906075", var_310_9)
						arg_307_1:RecordAudio("1104906075", var_310_9)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906075", "story_v_side_new_1104906.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906075", "story_v_side_new_1104906.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_10 = math.max(var_310_3, arg_307_1.talkMaxDuration)

			if var_310_2 <= arg_307_1.time_ and arg_307_1.time_ < var_310_2 + var_310_10 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_2) / var_310_10

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_2 + var_310_10 and arg_307_1.time_ < var_310_2 + var_310_10 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play1104906076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1104906076
		arg_311_1.duration_ = 6.77

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1104906077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.375

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_1 = arg_311_1:GetWordFromCfg(1104906076)
				local var_314_2 = arg_311_1:FormatText(var_314_1.content)

				arg_311_1.text_.text = var_314_2

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_4 = 15 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 15)

				if (15 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 15)) > 0 and var_314_0 < var_314_4 then
					arg_311_1.talkMaxDuration = var_314_4

					if var_314_4 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_4 + 0
					end
				end

				arg_311_1.text_.text = var_314_2
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906076", "story_v_side_new_1104906.awb") ~= 0 then
					local var_314_5 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906076", "story_v_side_new_1104906.awb") / 1000

					if var_314_5 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + 0
					end

					if var_314_1.prefab_name ~= "" and arg_311_1.actors_[var_314_1.prefab_name] ~= nil then
						local var_314_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_1.prefab_name].transform, "story_v_side_new_1104906", "1104906076", "story_v_side_new_1104906.awb")

						arg_311_1:RecordAudio("1104906076", var_314_6)
						arg_311_1:RecordAudio("1104906076", var_314_6)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906076", "story_v_side_new_1104906.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906076", "story_v_side_new_1104906.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_7 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_7 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_7

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_7 and arg_311_1.time_ < 0 + var_314_7 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play1104906077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1104906077
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1104906078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1049ui_story"]) and arg_315_1.var_.characterEffect1049ui_story == nil then
				arg_315_1.var_.characterEffect1049ui_story = arg_315_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1049ui_story"]) then
				if arg_315_1.var_.characterEffect1049ui_story and not isNil(arg_315_1.actors_["1049ui_story"]) then
					arg_315_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_0)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1049ui_story"]) and arg_315_1.var_.characterEffect1049ui_story then
				arg_315_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_318_1 = 0
			local var_318_2 = 0.15

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_3 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(1104906077).content)

				arg_315_1.text_.text = var_318_3

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 6 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 6)

				if (6 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 6)) > 0 and var_318_2 < var_318_5 then
					arg_315_1.talkMaxDuration = var_318_5

					if var_318_5 + var_318_1 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_5 + var_318_1
					end
				end

				arg_315_1.text_.text = var_318_3
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_6 = math.max(var_318_2, arg_315_1.talkMaxDuration)

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_6 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_1) / var_318_6

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_1 + var_318_6 and arg_315_1.time_ < var_318_1 + var_318_6 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play1104906078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1104906078
		arg_319_1.duration_ = 6.93

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play1104906079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["1049ui_story"]) and arg_319_1.var_.characterEffect1049ui_story == nil then
				arg_319_1.var_.characterEffect1049ui_story = arg_319_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_0 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["1049ui_story"]) then
				if arg_319_1.var_.characterEffect1049ui_story and not isNil(arg_319_1.actors_["1049ui_story"]) then
					arg_319_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["1049ui_story"]) and arg_319_1.var_.characterEffect1049ui_story then
				arg_319_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_322_2 = 0
			local var_322_3 = 0.5

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_2 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_4 = arg_319_1:GetWordFromCfg(1104906078)
				local var_322_5 = arg_319_1:FormatText(var_322_4.content)

				arg_319_1.text_.text = var_322_5

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_7 = 20 <= 0 and var_322_3 or var_322_3 * (utf8.len(var_322_5) / 20)

				if (20 <= 0 and var_322_3 or var_322_3 * (utf8.len(var_322_5) / 20)) > 0 and var_322_3 < var_322_7 then
					arg_319_1.talkMaxDuration = var_322_7

					if var_322_7 + var_322_2 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_7 + var_322_2
					end
				end

				arg_319_1.text_.text = var_322_5
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906078", "story_v_side_new_1104906.awb") ~= 0 then
					local var_322_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906078", "story_v_side_new_1104906.awb") / 1000

					if var_322_8 + var_322_2 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_8 + var_322_2
					end

					if var_322_4.prefab_name ~= "" and arg_319_1.actors_[var_322_4.prefab_name] ~= nil then
						local var_322_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_4.prefab_name].transform, "story_v_side_new_1104906", "1104906078", "story_v_side_new_1104906.awb")

						arg_319_1:RecordAudio("1104906078", var_322_9)
						arg_319_1:RecordAudio("1104906078", var_322_9)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906078", "story_v_side_new_1104906.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906078", "story_v_side_new_1104906.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_10 = math.max(var_322_3, arg_319_1.talkMaxDuration)

			if var_322_2 <= arg_319_1.time_ and arg_319_1.time_ < var_322_2 + var_322_10 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_2) / var_322_10

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_2 + var_322_10 and arg_319_1.time_ < var_322_2 + var_322_10 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play1104906079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1104906079
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play1104906080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["1049ui_story"]) and arg_323_1.var_.characterEffect1049ui_story == nil then
				arg_323_1.var_.characterEffect1049ui_story = arg_323_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_0 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["1049ui_story"]) then
				if arg_323_1.var_.characterEffect1049ui_story and not isNil(arg_323_1.actors_["1049ui_story"]) then
					arg_323_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_323_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_323_1.time_ - 0) / var_326_0)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["1049ui_story"]) and arg_323_1.var_.characterEffect1049ui_story then
				arg_323_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_323_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_326_1 = 0
			local var_326_2 = 0.925

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, false)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_3 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(1104906079).content)

				arg_323_1.text_.text = var_326_3

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_5 = 37 <= 0 and var_326_2 or var_326_2 * (utf8.len(var_326_3) / 37)

				if (37 <= 0 and var_326_2 or var_326_2 * (utf8.len(var_326_3) / 37)) > 0 and var_326_2 < var_326_5 then
					arg_323_1.talkMaxDuration = var_326_5

					if var_326_5 + var_326_1 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_5 + var_326_1
					end
				end

				arg_323_1.text_.text = var_326_3
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_6 = math.max(var_326_2, arg_323_1.talkMaxDuration)

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_6 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_1) / var_326_6

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_1 + var_326_6 and arg_323_1.time_ < var_326_1 + var_326_6 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play1104906080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 1104906080
		arg_327_1.duration_ = 9.2

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play1104906081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["1049ui_story"]) and arg_327_1.var_.characterEffect1049ui_story == nil then
				arg_327_1.var_.characterEffect1049ui_story = arg_327_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_0 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["1049ui_story"]) then
				if arg_327_1.var_.characterEffect1049ui_story and not isNil(arg_327_1.actors_["1049ui_story"]) then
					arg_327_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["1049ui_story"]) and arg_327_1.var_.characterEffect1049ui_story then
				arg_327_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_330_2 = 0
			local var_330_3 = 0.6

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_2 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_4 = arg_327_1:GetWordFromCfg(1104906080)
				local var_330_5 = arg_327_1:FormatText(var_330_4.content)

				arg_327_1.text_.text = var_330_5

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_7 = 24 <= 0 and var_330_3 or var_330_3 * (utf8.len(var_330_5) / 24)

				if (24 <= 0 and var_330_3 or var_330_3 * (utf8.len(var_330_5) / 24)) > 0 and var_330_3 < var_330_7 then
					arg_327_1.talkMaxDuration = var_330_7

					if var_330_7 + var_330_2 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_7 + var_330_2
					end
				end

				arg_327_1.text_.text = var_330_5
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906080", "story_v_side_new_1104906.awb") ~= 0 then
					local var_330_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906080", "story_v_side_new_1104906.awb") / 1000

					if var_330_8 + var_330_2 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_8 + var_330_2
					end

					if var_330_4.prefab_name ~= "" and arg_327_1.actors_[var_330_4.prefab_name] ~= nil then
						local var_330_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_4.prefab_name].transform, "story_v_side_new_1104906", "1104906080", "story_v_side_new_1104906.awb")

						arg_327_1:RecordAudio("1104906080", var_330_9)
						arg_327_1:RecordAudio("1104906080", var_330_9)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906080", "story_v_side_new_1104906.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906080", "story_v_side_new_1104906.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_10 = math.max(var_330_3, arg_327_1.talkMaxDuration)

			if var_330_2 <= arg_327_1.time_ and arg_327_1.time_ < var_330_2 + var_330_10 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_2) / var_330_10

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_2 + var_330_10 and arg_327_1.time_ < var_330_2 + var_330_10 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play1104906081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1104906081
		arg_331_1.duration_ = 7.03

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play1104906082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0.725

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_1 = arg_331_1:GetWordFromCfg(1104906081)
				local var_334_2 = arg_331_1:FormatText(var_334_1.content)

				arg_331_1.text_.text = var_334_2

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_4 = 29 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 29)

				if (29 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 29)) > 0 and var_334_0 < var_334_4 then
					arg_331_1.talkMaxDuration = var_334_4

					if var_334_4 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_4 + 0
					end
				end

				arg_331_1.text_.text = var_334_2
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906081", "story_v_side_new_1104906.awb") ~= 0 then
					local var_334_5 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906081", "story_v_side_new_1104906.awb") / 1000

					if var_334_5 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_5 + 0
					end

					if var_334_1.prefab_name ~= "" and arg_331_1.actors_[var_334_1.prefab_name] ~= nil then
						local var_334_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_1.prefab_name].transform, "story_v_side_new_1104906", "1104906081", "story_v_side_new_1104906.awb")

						arg_331_1:RecordAudio("1104906081", var_334_6)
						arg_331_1:RecordAudio("1104906081", var_334_6)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906081", "story_v_side_new_1104906.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906081", "story_v_side_new_1104906.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_7 = math.max(var_334_0, arg_331_1.talkMaxDuration)

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_7 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - 0) / var_334_7

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= 0 + var_334_7 and arg_331_1.time_ < 0 + var_334_7 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play1104906082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 1104906082
		arg_335_1.duration_ = 1

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"

			SetActive(arg_335_1.choicesGo_, true)

			for iter_336_0, iter_336_1 in ipairs(arg_335_1.choices_) do
				SetActive(iter_336_1.go, iter_336_0 <= 1)
			end

			arg_335_1.choices_[1].txt.text = arg_335_1:FormatText(StoryChoiceCfg[1189].name)
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play1104906083(arg_335_1)
			end

			arg_335_1:RecordChoiceLog(1104906082, 1189)
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["1049ui_story"]) and arg_335_1.var_.characterEffect1049ui_story == nil then
				arg_335_1.var_.characterEffect1049ui_story = arg_335_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_0 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["1049ui_story"]) then
				if arg_335_1.var_.characterEffect1049ui_story and not isNil(arg_335_1.actors_["1049ui_story"]) then
					arg_335_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_335_1.time_ - 0) / var_338_0)
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["1049ui_story"]) and arg_335_1.var_.characterEffect1049ui_story then
				arg_335_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_338_1 = 0

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 then
				arg_335_1.allBtn_.enabled = false
			end

			if arg_335_1.time_ >= var_338_1 + 0.6 and arg_335_1.time_ < var_338_1 + 0.6 + arg_338_0 then
				arg_335_1.allBtn_.enabled = true
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play1104906083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1104906083
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1104906084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0.5

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_1 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(1104906083).content)

				arg_339_1.text_.text = var_342_1

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_3 = 20 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_1) / 20)

				if (20 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_1) / 20)) > 0 and var_342_0 < var_342_3 then
					arg_339_1.talkMaxDuration = var_342_3

					if var_342_3 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_3 + 0
					end
				end

				arg_339_1.text_.text = var_342_1
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_4 = math.max(var_342_0, arg_339_1.talkMaxDuration)

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_4 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - 0) / var_342_4

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= 0 + var_342_4 and arg_339_1.time_ < 0 + var_342_4 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play1104906084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1104906084
		arg_343_1.duration_ = 1.77

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1104906085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["1049ui_story"]) and arg_343_1.var_.characterEffect1049ui_story == nil then
				arg_343_1.var_.characterEffect1049ui_story = arg_343_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_0 = 0.200000002980232

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["1049ui_story"]) then
				if arg_343_1.var_.characterEffect1049ui_story and not isNil(arg_343_1.actors_["1049ui_story"]) then
					arg_343_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["1049ui_story"]) and arg_343_1.var_.characterEffect1049ui_story then
				arg_343_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_346_2 = 0
			local var_346_3 = 0.225

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_2 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_4 = arg_343_1:GetWordFromCfg(1104906084)
				local var_346_5 = arg_343_1:FormatText(var_346_4.content)

				arg_343_1.text_.text = var_346_5

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_7 = 9 <= 0 and var_346_3 or var_346_3 * (utf8.len(var_346_5) / 9)

				if (9 <= 0 and var_346_3 or var_346_3 * (utf8.len(var_346_5) / 9)) > 0 and var_346_3 < var_346_7 then
					arg_343_1.talkMaxDuration = var_346_7

					if var_346_7 + var_346_2 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_7 + var_346_2
					end
				end

				arg_343_1.text_.text = var_346_5
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906084", "story_v_side_new_1104906.awb") ~= 0 then
					local var_346_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906084", "story_v_side_new_1104906.awb") / 1000

					if var_346_8 + var_346_2 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_8 + var_346_2
					end

					if var_346_4.prefab_name ~= "" and arg_343_1.actors_[var_346_4.prefab_name] ~= nil then
						local var_346_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_4.prefab_name].transform, "story_v_side_new_1104906", "1104906084", "story_v_side_new_1104906.awb")

						arg_343_1:RecordAudio("1104906084", var_346_9)
						arg_343_1:RecordAudio("1104906084", var_346_9)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906084", "story_v_side_new_1104906.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906084", "story_v_side_new_1104906.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_10 = math.max(var_346_3, arg_343_1.talkMaxDuration)

			if var_346_2 <= arg_343_1.time_ and arg_343_1.time_ < var_346_2 + var_346_10 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_2) / var_346_10

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_2 + var_346_10 and arg_343_1.time_ < var_346_2 + var_346_10 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play1104906085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1104906085
		arg_347_1.duration_ = 9.3

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play1104906086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0.725

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_1 = arg_347_1:GetWordFromCfg(1104906085)
				local var_350_2 = arg_347_1:FormatText(var_350_1.content)

				arg_347_1.text_.text = var_350_2

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_4 = 29 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 29)

				if (29 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 29)) > 0 and var_350_0 < var_350_4 then
					arg_347_1.talkMaxDuration = var_350_4

					if var_350_4 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_4 + 0
					end
				end

				arg_347_1.text_.text = var_350_2
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906085", "story_v_side_new_1104906.awb") ~= 0 then
					local var_350_5 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906085", "story_v_side_new_1104906.awb") / 1000

					if var_350_5 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + 0
					end

					if var_350_1.prefab_name ~= "" and arg_347_1.actors_[var_350_1.prefab_name] ~= nil then
						local var_350_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_1.prefab_name].transform, "story_v_side_new_1104906", "1104906085", "story_v_side_new_1104906.awb")

						arg_347_1:RecordAudio("1104906085", var_350_6)
						arg_347_1:RecordAudio("1104906085", var_350_6)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906085", "story_v_side_new_1104906.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906085", "story_v_side_new_1104906.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_7 = math.max(var_350_0, arg_347_1.talkMaxDuration)

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_7 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - 0) / var_350_7

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= 0 + var_350_7 and arg_347_1.time_ < 0 + var_350_7 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play1104906086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1104906086
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1104906087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["1049ui_story"]) and arg_351_1.var_.characterEffect1049ui_story == nil then
				arg_351_1.var_.characterEffect1049ui_story = arg_351_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_0 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["1049ui_story"]) then
				if arg_351_1.var_.characterEffect1049ui_story and not isNil(arg_351_1.actors_["1049ui_story"]) then
					arg_351_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_351_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_351_1.time_ - 0) / var_354_0)
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["1049ui_story"]) and arg_351_1.var_.characterEffect1049ui_story then
				arg_351_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_351_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_354_1 = 0
			local var_354_2 = 0.25

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_3 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(1104906086).content)

				arg_351_1.text_.text = var_354_3

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_5 = 10 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_3) / 10)

				if (10 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_3) / 10)) > 0 and var_354_2 < var_354_5 then
					arg_351_1.talkMaxDuration = var_354_5

					if var_354_5 + var_354_1 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_5 + var_354_1
					end
				end

				arg_351_1.text_.text = var_354_3
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_6 = math.max(var_354_2, arg_351_1.talkMaxDuration)

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_6 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_1) / var_354_6

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_1 + var_354_6 and arg_351_1.time_ < var_354_1 + var_354_6 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play1104906087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1104906087
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1104906088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0.25

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_1 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(1104906087).content)

				arg_355_1.text_.text = var_358_1

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_3 = 10 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 10)

				if (10 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 10)) > 0 and var_358_0 < var_358_3 then
					arg_355_1.talkMaxDuration = var_358_3

					if var_358_3 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_3 + 0
					end
				end

				arg_355_1.text_.text = var_358_1
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_4 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_4 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_4

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_4 and arg_355_1.time_ < 0 + var_358_4 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play1104906088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1104906088
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1104906089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 1.075

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_1 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(1104906088).content)

				arg_359_1.text_.text = var_362_1

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_3 = 43 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_1) / 43)

				if (43 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_1) / 43)) > 0 and var_362_0 < var_362_3 then
					arg_359_1.talkMaxDuration = var_362_3

					if var_362_3 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_3 + 0
					end
				end

				arg_359_1.text_.text = var_362_1
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_4 = math.max(var_362_0, arg_359_1.talkMaxDuration)

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_4 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - 0) / var_362_4

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= 0 + var_362_4 and arg_359_1.time_ < 0 + var_362_4 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play1104906089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1104906089
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1104906090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 1.025

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_1 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(1104906089).content)

				arg_363_1.text_.text = var_366_1

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_3 = 41 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_1) / 41)

				if (41 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_1) / 41)) > 0 and var_366_0 < var_366_3 then
					arg_363_1.talkMaxDuration = var_366_3

					if var_366_3 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_3 + 0
					end
				end

				arg_363_1.text_.text = var_366_1
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_4 = math.max(var_366_0, arg_363_1.talkMaxDuration)

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_4 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - 0) / var_366_4

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= 0 + var_366_4 and arg_363_1.time_ < 0 + var_366_4 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1104906090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1104906090
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1104906091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0.625

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
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

				local var_370_1 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(1104906090).content)

				arg_367_1.text_.text = var_370_1

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_3 = 25 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 25)

				if (25 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 25)) > 0 and var_370_0 < var_370_3 then
					arg_367_1.talkMaxDuration = var_370_3

					if var_370_3 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_3 + 0
					end
				end

				arg_367_1.text_.text = var_370_1
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_4 = math.max(var_370_0, arg_367_1.talkMaxDuration)

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_4 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - 0) / var_370_4

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= 0 + var_370_4 and arg_367_1.time_ < 0 + var_370_4 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play1104906091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1104906091
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1104906092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0.525

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

				local var_374_1 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(1104906091).content)

				arg_371_1.text_.text = var_374_1

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_3 = 26 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 26)

				if (26 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 26)) > 0 and var_374_0 < var_374_3 then
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
	Play1104906092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1104906092
		arg_375_1.duration_ = 4.77

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1104906093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos1049ui_story = arg_375_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_378_0 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 then
				arg_375_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_375_1.time_ - 0) / var_378_0)
				arg_375_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1049ui_story"].transform.position).z)
				arg_375_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1049ui_story"].transform.localEulerAngles = arg_375_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 then
				arg_375_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_375_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1049ui_story"].transform.position).z)
				arg_375_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1049ui_story"].transform.localEulerAngles = arg_375_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_378_1 = arg_375_1.actors_["1049ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1049ui_story == nil then
				arg_375_1.var_.characterEffect1049ui_story = var_378_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_2 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_2 and not isNil(var_378_1) then
				if arg_375_1.var_.characterEffect1049ui_story and not isNil(var_378_1) then
					arg_375_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= 0 + var_378_2 and arg_375_1.time_ < 0 + var_378_2 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1049ui_story then
				arg_375_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_378_4 = 0
			local var_378_5 = 0.35

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_4 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_6 = arg_375_1:GetWordFromCfg(1104906092)
				local var_378_7 = arg_375_1:FormatText(var_378_6.content)

				arg_375_1.text_.text = var_378_7

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_9 = 14 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 14)

				if (14 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 14)) > 0 and var_378_5 < var_378_9 then
					arg_375_1.talkMaxDuration = var_378_9

					if var_378_9 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_9 + var_378_4
					end
				end

				arg_375_1.text_.text = var_378_7
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906092", "story_v_side_new_1104906.awb") ~= 0 then
					local var_378_10 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906092", "story_v_side_new_1104906.awb") / 1000

					if var_378_10 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_10 + var_378_4
					end

					if var_378_6.prefab_name ~= "" and arg_375_1.actors_[var_378_6.prefab_name] ~= nil then
						local var_378_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_6.prefab_name].transform, "story_v_side_new_1104906", "1104906092", "story_v_side_new_1104906.awb")

						arg_375_1:RecordAudio("1104906092", var_378_11)
						arg_375_1:RecordAudio("1104906092", var_378_11)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906092", "story_v_side_new_1104906.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906092", "story_v_side_new_1104906.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_12 = math.max(var_378_5, arg_375_1.talkMaxDuration)

			if var_378_4 <= arg_375_1.time_ and arg_375_1.time_ < var_378_4 + var_378_12 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_4) / var_378_12

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_4 + var_378_12 and arg_375_1.time_ < var_378_4 + var_378_12 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play1104906093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1104906093
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1104906094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(arg_379_1.actors_["1049ui_story"]) and arg_379_1.var_.characterEffect1049ui_story == nil then
				arg_379_1.var_.characterEffect1049ui_story = arg_379_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_0 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 and not isNil(arg_379_1.actors_["1049ui_story"]) then
				if arg_379_1.var_.characterEffect1049ui_story and not isNil(arg_379_1.actors_["1049ui_story"]) then
					arg_379_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_379_1.time_ - 0) / var_382_0)
				end
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 and not isNil(arg_379_1.actors_["1049ui_story"]) and arg_379_1.var_.characterEffect1049ui_story then
				arg_379_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_382_1 = 0
			local var_382_2 = 0.925

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, false)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_3 = arg_379_1:FormatText(arg_379_1:GetWordFromCfg(1104906093).content)

				arg_379_1.text_.text = var_382_3

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_5 = 37 <= 0 and var_382_2 or var_382_2 * (utf8.len(var_382_3) / 37)

				if (37 <= 0 and var_382_2 or var_382_2 * (utf8.len(var_382_3) / 37)) > 0 and var_382_2 < var_382_5 then
					arg_379_1.talkMaxDuration = var_382_5

					if var_382_5 + var_382_1 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_5 + var_382_1
					end
				end

				arg_379_1.text_.text = var_382_3
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_6 = math.max(var_382_2, arg_379_1.talkMaxDuration)

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_6 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_1) / var_382_6

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_1 + var_382_6 and arg_379_1.time_ < var_382_1 + var_382_6 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play1104906094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1104906094
		arg_383_1.duration_ = 2.37

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1104906095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(arg_383_1.actors_["1049ui_story"]) and arg_383_1.var_.characterEffect1049ui_story == nil then
				arg_383_1.var_.characterEffect1049ui_story = arg_383_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_0 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 and not isNil(arg_383_1.actors_["1049ui_story"]) then
				if arg_383_1.var_.characterEffect1049ui_story and not isNil(arg_383_1.actors_["1049ui_story"]) then
					arg_383_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 and not isNil(arg_383_1.actors_["1049ui_story"]) and arg_383_1.var_.characterEffect1049ui_story then
				arg_383_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_386_2 = 0
			local var_386_3 = 0.2

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_2 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_4 = arg_383_1:GetWordFromCfg(1104906094)
				local var_386_5 = arg_383_1:FormatText(var_386_4.content)

				arg_383_1.text_.text = var_386_5

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_7 = 8 <= 0 and var_386_3 or var_386_3 * (utf8.len(var_386_5) / 8)

				if (8 <= 0 and var_386_3 or var_386_3 * (utf8.len(var_386_5) / 8)) > 0 and var_386_3 < var_386_7 then
					arg_383_1.talkMaxDuration = var_386_7

					if var_386_7 + var_386_2 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_7 + var_386_2
					end
				end

				arg_383_1.text_.text = var_386_5
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906094", "story_v_side_new_1104906.awb") ~= 0 then
					local var_386_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906094", "story_v_side_new_1104906.awb") / 1000

					if var_386_8 + var_386_2 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_8 + var_386_2
					end

					if var_386_4.prefab_name ~= "" and arg_383_1.actors_[var_386_4.prefab_name] ~= nil then
						local var_386_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_4.prefab_name].transform, "story_v_side_new_1104906", "1104906094", "story_v_side_new_1104906.awb")

						arg_383_1:RecordAudio("1104906094", var_386_9)
						arg_383_1:RecordAudio("1104906094", var_386_9)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906094", "story_v_side_new_1104906.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906094", "story_v_side_new_1104906.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_10 = math.max(var_386_3, arg_383_1.talkMaxDuration)

			if var_386_2 <= arg_383_1.time_ and arg_383_1.time_ < var_386_2 + var_386_10 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_2) / var_386_10

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_2 + var_386_10 and arg_383_1.time_ < var_386_2 + var_386_10 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play1104906095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1104906095
		arg_387_1.duration_ = 2.57

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1104906096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_2")
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_390_0 = 0
			local var_390_1 = 0.375

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_2 = arg_387_1:GetWordFromCfg(1104906095)
				local var_390_3 = arg_387_1:FormatText(var_390_2.content)

				arg_387_1.text_.text = var_390_3

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_5 = 15 <= 0 and var_390_1 or var_390_1 * (utf8.len(var_390_3) / 15)

				if (15 <= 0 and var_390_1 or var_390_1 * (utf8.len(var_390_3) / 15)) > 0 and var_390_1 < var_390_5 then
					arg_387_1.talkMaxDuration = var_390_5

					if var_390_5 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_5 + var_390_0
					end
				end

				arg_387_1.text_.text = var_390_3
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906095", "story_v_side_new_1104906.awb") ~= 0 then
					local var_390_6 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906095", "story_v_side_new_1104906.awb") / 1000

					if var_390_6 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_6 + var_390_0
					end

					if var_390_2.prefab_name ~= "" and arg_387_1.actors_[var_390_2.prefab_name] ~= nil then
						local var_390_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_2.prefab_name].transform, "story_v_side_new_1104906", "1104906095", "story_v_side_new_1104906.awb")

						arg_387_1:RecordAudio("1104906095", var_390_7)
						arg_387_1:RecordAudio("1104906095", var_390_7)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906095", "story_v_side_new_1104906.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906095", "story_v_side_new_1104906.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_8 = math.max(var_390_1, arg_387_1.talkMaxDuration)

			if var_390_0 <= arg_387_1.time_ and arg_387_1.time_ < var_390_0 + var_390_8 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_0) / var_390_8

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_0 + var_390_8 and arg_387_1.time_ < var_390_0 + var_390_8 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play1104906096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1104906096
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1104906097(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(arg_391_1.actors_["1049ui_story"]) and arg_391_1.var_.characterEffect1049ui_story == nil then
				arg_391_1.var_.characterEffect1049ui_story = arg_391_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_0 = 0.200000002980232

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 and not isNil(arg_391_1.actors_["1049ui_story"]) then
				if arg_391_1.var_.characterEffect1049ui_story and not isNil(arg_391_1.actors_["1049ui_story"]) then
					arg_391_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_391_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_391_1.time_ - 0) / var_394_0)
				end
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 and not isNil(arg_391_1.actors_["1049ui_story"]) and arg_391_1.var_.characterEffect1049ui_story then
				arg_391_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_391_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_394_1 = 0
			local var_394_2 = 0.125

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_3 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(1104906096).content)

				arg_391_1.text_.text = var_394_3

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_5 = 5 <= 0 and var_394_2 or var_394_2 * (utf8.len(var_394_3) / 5)

				if (5 <= 0 and var_394_2 or var_394_2 * (utf8.len(var_394_3) / 5)) > 0 and var_394_2 < var_394_5 then
					arg_391_1.talkMaxDuration = var_394_5

					if var_394_5 + var_394_1 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_5 + var_394_1
					end
				end

				arg_391_1.text_.text = var_394_3
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_6 = math.max(var_394_2, arg_391_1.talkMaxDuration)

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_6 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_1) / var_394_6

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_1 + var_394_6 and arg_391_1.time_ < var_394_1 + var_394_6 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play1104906097 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1104906097
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play1104906098(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0.55

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, true)
				arg_395_1.iconController_:SetSelectedState("hero")

				arg_395_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_395_1.callingController_:SetSelectedState("normal")

				arg_395_1.keyicon_.color = Color.New(1, 1, 1)
				arg_395_1.icon_.color = Color.New(1, 1, 1)

				local var_398_1 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(1104906097).content)

				arg_395_1.text_.text = var_398_1

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_3 = 22 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_1) / 22)

				if (22 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_1) / 22)) > 0 and var_398_0 < var_398_3 then
					arg_395_1.talkMaxDuration = var_398_3

					if var_398_3 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_3 + 0
					end
				end

				arg_395_1.text_.text = var_398_1
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_4 = math.max(var_398_0, arg_395_1.talkMaxDuration)

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_4 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - 0) / var_398_4

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= 0 + var_398_4 and arg_395_1.time_ < 0 + var_398_4 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play1104906098 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1104906098
		arg_399_1.duration_ = 4.2

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1104906099(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(arg_399_1.actors_["1049ui_story"]) and arg_399_1.var_.characterEffect1049ui_story == nil then
				arg_399_1.var_.characterEffect1049ui_story = arg_399_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_0 = 0.200000002980232

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 and not isNil(arg_399_1.actors_["1049ui_story"]) then
				if arg_399_1.var_.characterEffect1049ui_story and not isNil(arg_399_1.actors_["1049ui_story"]) then
					arg_399_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 and not isNil(arg_399_1.actors_["1049ui_story"]) and arg_399_1.var_.characterEffect1049ui_story then
				arg_399_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_402_2 = 0
			local var_402_3 = 0.375

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_2 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_4 = arg_399_1:GetWordFromCfg(1104906098)
				local var_402_5 = arg_399_1:FormatText(var_402_4.content)

				arg_399_1.text_.text = var_402_5

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_7 = 15 <= 0 and var_402_3 or var_402_3 * (utf8.len(var_402_5) / 15)

				if (15 <= 0 and var_402_3 or var_402_3 * (utf8.len(var_402_5) / 15)) > 0 and var_402_3 < var_402_7 then
					arg_399_1.talkMaxDuration = var_402_7

					if var_402_7 + var_402_2 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_7 + var_402_2
					end
				end

				arg_399_1.text_.text = var_402_5
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906098", "story_v_side_new_1104906.awb") ~= 0 then
					local var_402_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906098", "story_v_side_new_1104906.awb") / 1000

					if var_402_8 + var_402_2 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_8 + var_402_2
					end

					if var_402_4.prefab_name ~= "" and arg_399_1.actors_[var_402_4.prefab_name] ~= nil then
						local var_402_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_4.prefab_name].transform, "story_v_side_new_1104906", "1104906098", "story_v_side_new_1104906.awb")

						arg_399_1:RecordAudio("1104906098", var_402_9)
						arg_399_1:RecordAudio("1104906098", var_402_9)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906098", "story_v_side_new_1104906.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906098", "story_v_side_new_1104906.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_10 = math.max(var_402_3, arg_399_1.talkMaxDuration)

			if var_402_2 <= arg_399_1.time_ and arg_399_1.time_ < var_402_2 + var_402_10 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_2) / var_402_10

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_2 + var_402_10 and arg_399_1.time_ < var_402_2 + var_402_10 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play1104906099 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1104906099
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1104906100(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(arg_403_1.actors_["1049ui_story"]) and arg_403_1.var_.characterEffect1049ui_story == nil then
				arg_403_1.var_.characterEffect1049ui_story = arg_403_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_0 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 and not isNil(arg_403_1.actors_["1049ui_story"]) then
				if arg_403_1.var_.characterEffect1049ui_story and not isNil(arg_403_1.actors_["1049ui_story"]) then
					arg_403_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_403_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_403_1.time_ - 0) / var_406_0)
				end
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 and not isNil(arg_403_1.actors_["1049ui_story"]) and arg_403_1.var_.characterEffect1049ui_story then
				arg_403_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_403_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_406_1 = 0
			local var_406_2 = 0.325

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, true)
				arg_403_1.iconController_:SetSelectedState("hero")

				arg_403_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_403_1.callingController_:SetSelectedState("normal")

				arg_403_1.keyicon_.color = Color.New(1, 1, 1)
				arg_403_1.icon_.color = Color.New(1, 1, 1)

				local var_406_3 = arg_403_1:FormatText(arg_403_1:GetWordFromCfg(1104906099).content)

				arg_403_1.text_.text = var_406_3

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_5 = 13 <= 0 and var_406_2 or var_406_2 * (utf8.len(var_406_3) / 13)

				if (13 <= 0 and var_406_2 or var_406_2 * (utf8.len(var_406_3) / 13)) > 0 and var_406_2 < var_406_5 then
					arg_403_1.talkMaxDuration = var_406_5

					if var_406_5 + var_406_1 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_5 + var_406_1
					end
				end

				arg_403_1.text_.text = var_406_3
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_6 = math.max(var_406_2, arg_403_1.talkMaxDuration)

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_6 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_1) / var_406_6

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_1 + var_406_6 and arg_403_1.time_ < var_406_1 + var_406_6 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play1104906100 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1104906100
		arg_407_1.duration_ = 4.47

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1104906101(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(arg_407_1.actors_["1049ui_story"]) and arg_407_1.var_.characterEffect1049ui_story == nil then
				arg_407_1.var_.characterEffect1049ui_story = arg_407_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_0 = 0.200000002980232

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 and not isNil(arg_407_1.actors_["1049ui_story"]) then
				if arg_407_1.var_.characterEffect1049ui_story and not isNil(arg_407_1.actors_["1049ui_story"]) then
					arg_407_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 and not isNil(arg_407_1.actors_["1049ui_story"]) and arg_407_1.var_.characterEffect1049ui_story then
				arg_407_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action6_1")
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_410_2 = 0
			local var_410_3 = 0.375

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_2 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_4 = arg_407_1:GetWordFromCfg(1104906100)
				local var_410_5 = arg_407_1:FormatText(var_410_4.content)

				arg_407_1.text_.text = var_410_5

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_7 = 15 <= 0 and var_410_3 or var_410_3 * (utf8.len(var_410_5) / 15)

				if (15 <= 0 and var_410_3 or var_410_3 * (utf8.len(var_410_5) / 15)) > 0 and var_410_3 < var_410_7 then
					arg_407_1.talkMaxDuration = var_410_7

					if var_410_7 + var_410_2 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_7 + var_410_2
					end
				end

				arg_407_1.text_.text = var_410_5
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906100", "story_v_side_new_1104906.awb") ~= 0 then
					local var_410_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906100", "story_v_side_new_1104906.awb") / 1000

					if var_410_8 + var_410_2 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_8 + var_410_2
					end

					if var_410_4.prefab_name ~= "" and arg_407_1.actors_[var_410_4.prefab_name] ~= nil then
						local var_410_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_4.prefab_name].transform, "story_v_side_new_1104906", "1104906100", "story_v_side_new_1104906.awb")

						arg_407_1:RecordAudio("1104906100", var_410_9)
						arg_407_1:RecordAudio("1104906100", var_410_9)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906100", "story_v_side_new_1104906.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906100", "story_v_side_new_1104906.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_10 = math.max(var_410_3, arg_407_1.talkMaxDuration)

			if var_410_2 <= arg_407_1.time_ and arg_407_1.time_ < var_410_2 + var_410_10 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_2) / var_410_10

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_2 + var_410_10 and arg_407_1.time_ < var_410_2 + var_410_10 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play1104906101 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1104906101
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1104906102(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(arg_411_1.actors_["1049ui_story"]) and arg_411_1.var_.characterEffect1049ui_story == nil then
				arg_411_1.var_.characterEffect1049ui_story = arg_411_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_0 = 0.200000002980232

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_0 and not isNil(arg_411_1.actors_["1049ui_story"]) then
				if arg_411_1.var_.characterEffect1049ui_story and not isNil(arg_411_1.actors_["1049ui_story"]) then
					arg_411_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_411_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_411_1.time_ - 0) / var_414_0)
				end
			end

			if arg_411_1.time_ >= 0 + var_414_0 and arg_411_1.time_ < 0 + var_414_0 + arg_414_0 and not isNil(arg_411_1.actors_["1049ui_story"]) and arg_411_1.var_.characterEffect1049ui_story then
				arg_411_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_411_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_414_1 = 0
			local var_414_2 = 0.075

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_3 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(1104906101).content)

				arg_411_1.text_.text = var_414_3

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_5 = 3 <= 0 and var_414_2 or var_414_2 * (utf8.len(var_414_3) / 3)

				if (3 <= 0 and var_414_2 or var_414_2 * (utf8.len(var_414_3) / 3)) > 0 and var_414_2 < var_414_5 then
					arg_411_1.talkMaxDuration = var_414_5

					if var_414_5 + var_414_1 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_5 + var_414_1
					end
				end

				arg_411_1.text_.text = var_414_3
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_6 = math.max(var_414_2, arg_411_1.talkMaxDuration)

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_6 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_1) / var_414_6

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_1 + var_414_6 and arg_411_1.time_ < var_414_1 + var_414_6 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play1104906102 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1104906102
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1104906103(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.var_.moveOldPos1049ui_story = arg_415_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_418_0 = 0.001

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 then
				arg_415_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_415_1.time_ - 0) / var_418_0)
				arg_415_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_415_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1049ui_story"].transform.position).z)
				arg_415_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_415_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_415_1.actors_["1049ui_story"].transform.localEulerAngles = arg_415_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 then
				arg_415_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_415_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_415_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1049ui_story"].transform.position).z)
				arg_415_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_415_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_415_1.actors_["1049ui_story"].transform.localEulerAngles = arg_415_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if 0.533333333333333 < arg_415_1.time_ and arg_415_1.time_ <= 0.533333333333333 + arg_418_0 then
				arg_415_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_hold", "")
			end

			local var_418_2 = 0
			local var_418_3 = 0.7

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_2 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, false)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_4 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(1104906102).content)

				arg_415_1.text_.text = var_418_4

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_6 = 28 <= 0 and var_418_3 or var_418_3 * (utf8.len(var_418_4) / 28)

				if (28 <= 0 and var_418_3 or var_418_3 * (utf8.len(var_418_4) / 28)) > 0 and var_418_3 < var_418_6 then
					arg_415_1.talkMaxDuration = var_418_6

					if var_418_6 + var_418_2 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_6 + var_418_2
					end
				end

				arg_415_1.text_.text = var_418_4
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_7 = math.max(var_418_3, arg_415_1.talkMaxDuration)

			if var_418_2 <= arg_415_1.time_ and arg_415_1.time_ < var_418_2 + var_418_7 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_2) / var_418_7

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_2 + var_418_7 and arg_415_1.time_ < var_418_2 + var_418_7 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play1104906103 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 1104906103
		arg_419_1.duration_ = 3.63

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play1104906104(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.var_.moveOldPos1049ui_story = arg_419_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_422_0 = 0.001

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 then
				arg_419_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_419_1.time_ - 0) / var_422_0)
				arg_419_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1049ui_story"].transform.position).z)
				arg_419_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["1049ui_story"].transform.localEulerAngles = arg_419_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 then
				arg_419_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_419_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1049ui_story"].transform.position).z)
				arg_419_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["1049ui_story"].transform.localEulerAngles = arg_419_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_422_1 = arg_419_1.actors_["1049ui_story"]

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(var_422_1) and arg_419_1.var_.characterEffect1049ui_story == nil then
				arg_419_1.var_.characterEffect1049ui_story = var_422_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_2 = 0.200000002980232

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_2 and not isNil(var_422_1) then
				if arg_419_1.var_.characterEffect1049ui_story and not isNil(var_422_1) then
					arg_419_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= 0 + var_422_2 and arg_419_1.time_ < 0 + var_422_2 + arg_422_0 and not isNil(var_422_1) and arg_419_1.var_.characterEffect1049ui_story then
				arg_419_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action6_2")
			end

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_422_4 = 0
			local var_422_5 = 0.4

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_4 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_6 = arg_419_1:GetWordFromCfg(1104906103)
				local var_422_7 = arg_419_1:FormatText(var_422_6.content)

				arg_419_1.text_.text = var_422_7

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_9 = 16 <= 0 and var_422_5 or var_422_5 * (utf8.len(var_422_7) / 16)

				if (16 <= 0 and var_422_5 or var_422_5 * (utf8.len(var_422_7) / 16)) > 0 and var_422_5 < var_422_9 then
					arg_419_1.talkMaxDuration = var_422_9

					if var_422_9 + var_422_4 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_9 + var_422_4
					end
				end

				arg_419_1.text_.text = var_422_7
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906103", "story_v_side_new_1104906.awb") ~= 0 then
					local var_422_10 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906103", "story_v_side_new_1104906.awb") / 1000

					if var_422_10 + var_422_4 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_10 + var_422_4
					end

					if var_422_6.prefab_name ~= "" and arg_419_1.actors_[var_422_6.prefab_name] ~= nil then
						local var_422_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_6.prefab_name].transform, "story_v_side_new_1104906", "1104906103", "story_v_side_new_1104906.awb")

						arg_419_1:RecordAudio("1104906103", var_422_11)
						arg_419_1:RecordAudio("1104906103", var_422_11)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906103", "story_v_side_new_1104906.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906103", "story_v_side_new_1104906.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_12 = math.max(var_422_5, arg_419_1.talkMaxDuration)

			if var_422_4 <= arg_419_1.time_ and arg_419_1.time_ < var_422_4 + var_422_12 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_4) / var_422_12

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_4 + var_422_12 and arg_419_1.time_ < var_422_4 + var_422_12 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play1104906104 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1104906104
		arg_423_1.duration_ = 8.8

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play1104906105(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 2 < arg_423_1.time_ and arg_423_1.time_ <= 2 + arg_426_0 then
				local var_426_0 = arg_423_1.bgs_.ST58

				arg_423_1.bgs_.ST58.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_426_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_426_1 = var_426_0:GetComponent("SpriteRenderer")

				if var_426_1 and var_426_1.sprite then
					local var_426_2 = 2 * (var_426_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_426_0.transform.localScale = Vector3.New(var_426_2 / var_426_1.sprite.bounds.size.y < var_426_2 * manager.ui.mainCameraCom_.aspect / var_426_1.sprite.bounds.size.x and var_426_2 * manager.ui.mainCameraCom_.aspect / var_426_1.sprite.bounds.size.x or var_426_2 / var_426_1.sprite.bounds.size.y, var_426_2 / var_426_1.sprite.bounds.size.y < var_426_2 * manager.ui.mainCameraCom_.aspect / var_426_1.sprite.bounds.size.x and var_426_2 * manager.ui.mainCameraCom_.aspect / var_426_1.sprite.bounds.size.x or var_426_2 / var_426_1.sprite.bounds.size.y, 0)
				end

				for iter_426_0, iter_426_1 in pairs(arg_423_1.bgs_) do
					if iter_426_0 ~= "ST58" then
						iter_426_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_426_3 = 4

			if 4 < arg_423_1.time_ and arg_423_1.time_ <= var_426_3 + arg_426_0 then
				arg_423_1.allBtn_.enabled = false
			end

			if arg_423_1.time_ >= var_426_3 + 0.3 and arg_423_1.time_ < var_426_3 + 0.3 + arg_426_0 then
				arg_423_1.allBtn_.enabled = true
			end

			local var_426_4 = 0

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_4 + arg_426_0 then
				arg_423_1.mask_.enabled = true
				arg_423_1.mask_.raycastTarget = true

				arg_423_1:SetGaussion(false)
			end

			local var_426_5 = 2

			if var_426_4 <= arg_423_1.time_ and arg_423_1.time_ < var_426_4 + var_426_5 then
				local var_426_6 = Color.New(0, 0, 0)

				var_426_6.a = Mathf.Lerp(0, 1, (arg_423_1.time_ - var_426_4) / var_426_5)
				arg_423_1.mask_.color = var_426_6
			end

			if arg_423_1.time_ >= var_426_4 + var_426_5 and arg_423_1.time_ < var_426_4 + var_426_5 + arg_426_0 then
				local var_426_7 = Color.New(0, 0, 0)

				var_426_7.a = 1
				arg_423_1.mask_.color = var_426_7
			end

			local var_426_8 = 2

			if 2 < arg_423_1.time_ and arg_423_1.time_ <= var_426_8 + arg_426_0 then
				arg_423_1.mask_.enabled = true
				arg_423_1.mask_.raycastTarget = true

				arg_423_1:SetGaussion(false)
			end

			local var_426_9 = 2

			if var_426_8 <= arg_423_1.time_ and arg_423_1.time_ < var_426_8 + var_426_9 then
				local var_426_10 = Color.New(0, 0, 0)

				var_426_10.a = Mathf.Lerp(1, 0, (arg_423_1.time_ - var_426_8) / var_426_9)
				arg_423_1.mask_.color = var_426_10
			end

			if arg_423_1.time_ >= var_426_8 + var_426_9 and arg_423_1.time_ < var_426_8 + var_426_9 + arg_426_0 then
				local var_426_11 = Color.New(0, 0, 0)

				arg_423_1.mask_.enabled = false
				var_426_11.a = 0
				arg_423_1.mask_.color = var_426_11
			end

			local var_426_12 = arg_423_1.actors_["1049ui_story"].transform

			if 1.96599999815226 < arg_423_1.time_ and arg_423_1.time_ <= 1.96599999815226 + arg_426_0 then
				arg_423_1.var_.moveOldPos1049ui_story = var_426_12.localPosition
			end

			local var_426_13 = 0.001

			if 1.96599999815226 <= arg_423_1.time_ and arg_423_1.time_ < 1.96599999815226 + var_426_13 then
				var_426_12.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_423_1.time_ - 1.96599999815226) / var_426_13)
				var_426_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_426_12.position).x, (manager.ui.mainCamera.transform.position - var_426_12.position).y, (manager.ui.mainCamera.transform.position - var_426_12.position).z)
				var_426_12.localEulerAngles.z = 0
				var_426_12.localEulerAngles.x = 0
				var_426_12.localEulerAngles = var_426_12.localEulerAngles
			end

			if arg_423_1.time_ >= 1.96599999815226 + var_426_13 and arg_423_1.time_ < 1.96599999815226 + var_426_13 + arg_426_0 then
				var_426_12.localPosition = Vector3.New(0, 100, 0)
				var_426_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_426_12.position).x, (manager.ui.mainCamera.transform.position - var_426_12.position).y, (manager.ui.mainCamera.transform.position - var_426_12.position).z)
				var_426_12.localEulerAngles.z = 0
				var_426_12.localEulerAngles.x = 0
				var_426_12.localEulerAngles = var_426_12.localEulerAngles
			end

			local var_426_14 = arg_423_1.actors_["1049ui_story"]

			if 1.96599999815226 < arg_423_1.time_ and arg_423_1.time_ <= 1.96599999815226 + arg_426_0 and not isNil(var_426_14) and arg_423_1.var_.characterEffect1049ui_story == nil then
				arg_423_1.var_.characterEffect1049ui_story = var_426_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_15 = 0.0166666666666667

			if 1.96599999815226 <= arg_423_1.time_ and arg_423_1.time_ < 1.96599999815226 + var_426_15 and not isNil(var_426_14) then
				if arg_423_1.var_.characterEffect1049ui_story and not isNil(var_426_14) then
					arg_423_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_423_1.time_ - 1.96599999815226) / var_426_15)
				end
			end

			if arg_423_1.time_ >= 1.96599999815226 + var_426_15 and arg_423_1.time_ < 1.96599999815226 + var_426_15 + arg_426_0 and not isNil(var_426_14) and arg_423_1.var_.characterEffect1049ui_story then
				arg_423_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			if 0.125 < arg_423_1.time_ and arg_423_1.time_ <= 0.125 + arg_426_0 then
				arg_423_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if 1.53333333333333 < arg_423_1.time_ and arg_423_1.time_ <= 1.53333333333333 + arg_426_0 then
				arg_423_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if arg_423_1.frameCnt_ <= 1 then
				arg_423_1.dialog_:SetActive(false)
			end

			local var_426_18 = 3.8
			local var_426_19 = 0.35

			if 3.8 < arg_423_1.time_ and arg_423_1.time_ <= var_426_18 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0

				arg_423_1.dialog_:SetActive(true)

				arg_423_1.dialogCg_.alpha = 0

				local var_426_20 = LeanTween.value(arg_423_1.dialog_, 0, 1, 0.3)

				var_426_20:setOnUpdate(LuaHelper.FloatAction(function(arg_427_0)
					arg_423_1.dialogCg_.alpha = arg_427_0
				end))
				var_426_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_423_1.dialog_)
					var_426_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_423_1.duration_ = arg_423_1.duration_ + 0.3

				SetActive(arg_423_1.leftNameGo_, false)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_21 = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(1104906104).content)

				arg_423_1.text_.text = var_426_21

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_23 = 14 <= 0 and var_426_19 or var_426_19 * (utf8.len(var_426_21) / 14)

				if (14 <= 0 and var_426_19 or var_426_19 * (utf8.len(var_426_21) / 14)) > 0 and var_426_19 < var_426_23 then
					arg_423_1.talkMaxDuration = var_426_23
					var_426_18 = var_426_18 + 0.3

					if var_426_23 + var_426_18 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_23 + var_426_18
					end
				end

				arg_423_1.text_.text = var_426_21
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_24 = var_426_18 + 0.3
			local var_426_25 = math.max(var_426_19, arg_423_1.talkMaxDuration)

			if var_426_18 + 0.3 <= arg_423_1.time_ and arg_423_1.time_ < var_426_24 + var_426_25 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_24) / var_426_25

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_24 + var_426_25 and arg_423_1.time_ < var_426_24 + var_426_25 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_423_1:InitPlayNodeList()
	end,
	Play1104906105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1104906105
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play1104906106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 1.65

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_1 = arg_429_1:FormatText(arg_429_1:GetWordFromCfg(1104906105).content)

				arg_429_1.text_.text = var_432_1

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_3 = 66 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_1) / 66)

				if (66 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_1) / 66)) > 0 and var_432_0 < var_432_3 then
					arg_429_1.talkMaxDuration = var_432_3

					if var_432_3 + 0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_3 + 0
					end
				end

				arg_429_1.text_.text = var_432_1
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_4 = math.max(var_432_0, arg_429_1.talkMaxDuration)

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_4 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - 0) / var_432_4

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= 0 + var_432_4 and arg_429_1.time_ < 0 + var_432_4 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play1104906106 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1104906106
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play1104906107(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 1.4

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, false)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_1 = arg_433_1:FormatText(arg_433_1:GetWordFromCfg(1104906106).content)

				arg_433_1.text_.text = var_436_1

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_3 = 56 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_1) / 56)

				if (56 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_1) / 56)) > 0 and var_436_0 < var_436_3 then
					arg_433_1.talkMaxDuration = var_436_3

					if var_436_3 + 0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_3 + 0
					end
				end

				arg_433_1.text_.text = var_436_1
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_4 = math.max(var_436_0, arg_433_1.talkMaxDuration)

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_4 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - 0) / var_436_4

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= 0 + var_436_4 and arg_433_1.time_ < 0 + var_436_4 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play1104906107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1104906107
		arg_437_1.duration_ = 1.8

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1104906108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.var_.moveOldPos1049ui_story = arg_437_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_440_0 = 0.001

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 then
				arg_437_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_437_1.time_ - 0) / var_440_0)
				arg_437_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1049ui_story"].transform.position).z)
				arg_437_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["1049ui_story"].transform.localEulerAngles = arg_437_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 then
				arg_437_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_437_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1049ui_story"].transform.position).z)
				arg_437_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["1049ui_story"].transform.localEulerAngles = arg_437_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_440_1 = arg_437_1.actors_["1049ui_story"]

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect1049ui_story == nil then
				arg_437_1.var_.characterEffect1049ui_story = var_440_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_2 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_2 and not isNil(var_440_1) then
				if arg_437_1.var_.characterEffect1049ui_story and not isNil(var_440_1) then
					arg_437_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= 0 + var_440_2 and arg_437_1.time_ < 0 + var_440_2 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect1049ui_story then
				arg_437_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_440_4 = 0
			local var_440_5 = 0.2

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_4 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_6 = arg_437_1:GetWordFromCfg(1104906107)
				local var_440_7 = arg_437_1:FormatText(var_440_6.content)

				arg_437_1.text_.text = var_440_7

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_9 = 8 <= 0 and var_440_5 or var_440_5 * (utf8.len(var_440_7) / 8)

				if (8 <= 0 and var_440_5 or var_440_5 * (utf8.len(var_440_7) / 8)) > 0 and var_440_5 < var_440_9 then
					arg_437_1.talkMaxDuration = var_440_9

					if var_440_9 + var_440_4 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_9 + var_440_4
					end
				end

				arg_437_1.text_.text = var_440_7
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906107", "story_v_side_new_1104906.awb") ~= 0 then
					local var_440_10 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906107", "story_v_side_new_1104906.awb") / 1000

					if var_440_10 + var_440_4 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_10 + var_440_4
					end

					if var_440_6.prefab_name ~= "" and arg_437_1.actors_[var_440_6.prefab_name] ~= nil then
						local var_440_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_6.prefab_name].transform, "story_v_side_new_1104906", "1104906107", "story_v_side_new_1104906.awb")

						arg_437_1:RecordAudio("1104906107", var_440_11)
						arg_437_1:RecordAudio("1104906107", var_440_11)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906107", "story_v_side_new_1104906.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906107", "story_v_side_new_1104906.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_12 = math.max(var_440_5, arg_437_1.talkMaxDuration)

			if var_440_4 <= arg_437_1.time_ and arg_437_1.time_ < var_440_4 + var_440_12 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_4) / var_440_12

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_4 + var_440_12 and arg_437_1.time_ < var_440_4 + var_440_12 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_437_1:InitPlayNodeList()
	end,
	Play1104906108 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1104906108
		arg_441_1.duration_ = 4

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1104906109(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_444_0 = 0
			local var_444_1 = 0.4

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_2 = arg_441_1:GetWordFromCfg(1104906108)
				local var_444_3 = arg_441_1:FormatText(var_444_2.content)

				arg_441_1.text_.text = var_444_3

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_5 = 16 <= 0 and var_444_1 or var_444_1 * (utf8.len(var_444_3) / 16)

				if (16 <= 0 and var_444_1 or var_444_1 * (utf8.len(var_444_3) / 16)) > 0 and var_444_1 < var_444_5 then
					arg_441_1.talkMaxDuration = var_444_5

					if var_444_5 + var_444_0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_5 + var_444_0
					end
				end

				arg_441_1.text_.text = var_444_3
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906108", "story_v_side_new_1104906.awb") ~= 0 then
					local var_444_6 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906108", "story_v_side_new_1104906.awb") / 1000

					if var_444_6 + var_444_0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_6 + var_444_0
					end

					if var_444_2.prefab_name ~= "" and arg_441_1.actors_[var_444_2.prefab_name] ~= nil then
						local var_444_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_2.prefab_name].transform, "story_v_side_new_1104906", "1104906108", "story_v_side_new_1104906.awb")

						arg_441_1:RecordAudio("1104906108", var_444_7)
						arg_441_1:RecordAudio("1104906108", var_444_7)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906108", "story_v_side_new_1104906.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906108", "story_v_side_new_1104906.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_8 = math.max(var_444_1, arg_441_1.talkMaxDuration)

			if var_444_0 <= arg_441_1.time_ and arg_441_1.time_ < var_444_0 + var_444_8 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_0) / var_444_8

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_0 + var_444_8 and arg_441_1.time_ < var_444_0 + var_444_8 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play1104906109 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1104906109
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1104906110(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(arg_445_1.actors_["1049ui_story"]) and arg_445_1.var_.characterEffect1049ui_story == nil then
				arg_445_1.var_.characterEffect1049ui_story = arg_445_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_0 = 0.200000002980232

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 and not isNil(arg_445_1.actors_["1049ui_story"]) then
				if arg_445_1.var_.characterEffect1049ui_story and not isNil(arg_445_1.actors_["1049ui_story"]) then
					arg_445_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_445_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_445_1.time_ - 0) / var_448_0)
				end
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 and not isNil(arg_445_1.actors_["1049ui_story"]) and arg_445_1.var_.characterEffect1049ui_story then
				arg_445_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_445_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_448_1 = 0
			local var_448_2 = 1.075

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, true)
				arg_445_1.iconController_:SetSelectedState("hero")

				arg_445_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_445_1.callingController_:SetSelectedState("normal")

				arg_445_1.keyicon_.color = Color.New(1, 1, 1)
				arg_445_1.icon_.color = Color.New(1, 1, 1)

				local var_448_3 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(1104906109).content)

				arg_445_1.text_.text = var_448_3

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_5 = 43 <= 0 and var_448_2 or var_448_2 * (utf8.len(var_448_3) / 43)

				if (43 <= 0 and var_448_2 or var_448_2 * (utf8.len(var_448_3) / 43)) > 0 and var_448_2 < var_448_5 then
					arg_445_1.talkMaxDuration = var_448_5

					if var_448_5 + var_448_1 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_5 + var_448_1
					end
				end

				arg_445_1.text_.text = var_448_3
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_6 = math.max(var_448_2, arg_445_1.talkMaxDuration)

			if var_448_1 <= arg_445_1.time_ and arg_445_1.time_ < var_448_1 + var_448_6 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_1) / var_448_6

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_1 + var_448_6 and arg_445_1.time_ < var_448_1 + var_448_6 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play1104906110 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1104906110
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1104906111(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 1.225

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_1 = arg_449_1:FormatText(arg_449_1:GetWordFromCfg(1104906110).content)

				arg_449_1.text_.text = var_452_1

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_3 = 49 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_1) / 49)

				if (49 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_1) / 49)) > 0 and var_452_0 < var_452_3 then
					arg_449_1.talkMaxDuration = var_452_3

					if var_452_3 + 0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_3 + 0
					end
				end

				arg_449_1.text_.text = var_452_1
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_4 = math.max(var_452_0, arg_449_1.talkMaxDuration)

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_4 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - 0) / var_452_4

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= 0 + var_452_4 and arg_449_1.time_ < 0 + var_452_4 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play1104906111 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1104906111
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1104906112(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 1.1

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, true)
				arg_453_1.iconController_:SetSelectedState("hero")

				arg_453_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_453_1.callingController_:SetSelectedState("normal")

				arg_453_1.keyicon_.color = Color.New(1, 1, 1)
				arg_453_1.icon_.color = Color.New(1, 1, 1)

				local var_456_1 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(1104906111).content)

				arg_453_1.text_.text = var_456_1

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_3 = 44 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_1) / 44)

				if (44 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_1) / 44)) > 0 and var_456_0 < var_456_3 then
					arg_453_1.talkMaxDuration = var_456_3

					if var_456_3 + 0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_3 + 0
					end
				end

				arg_453_1.text_.text = var_456_1
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_4 = math.max(var_456_0, arg_453_1.talkMaxDuration)

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_4 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - 0) / var_456_4

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= 0 + var_456_4 and arg_453_1.time_ < 0 + var_456_4 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play1104906112 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1104906112
		arg_457_1.duration_ = 3.57

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1104906113(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(arg_457_1.actors_["1049ui_story"]) and arg_457_1.var_.characterEffect1049ui_story == nil then
				arg_457_1.var_.characterEffect1049ui_story = arg_457_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_0 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 and not isNil(arg_457_1.actors_["1049ui_story"]) then
				if arg_457_1.var_.characterEffect1049ui_story and not isNil(arg_457_1.actors_["1049ui_story"]) then
					arg_457_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 and not isNil(arg_457_1.actors_["1049ui_story"]) and arg_457_1.var_.characterEffect1049ui_story then
				arg_457_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_2")
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_460_2 = 0
			local var_460_3 = 0.35

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_2 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_4 = arg_457_1:GetWordFromCfg(1104906112)
				local var_460_5 = arg_457_1:FormatText(var_460_4.content)

				arg_457_1.text_.text = var_460_5

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_7 = 14 <= 0 and var_460_3 or var_460_3 * (utf8.len(var_460_5) / 14)

				if (14 <= 0 and var_460_3 or var_460_3 * (utf8.len(var_460_5) / 14)) > 0 and var_460_3 < var_460_7 then
					arg_457_1.talkMaxDuration = var_460_7

					if var_460_7 + var_460_2 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_7 + var_460_2
					end
				end

				arg_457_1.text_.text = var_460_5
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906112", "story_v_side_new_1104906.awb") ~= 0 then
					local var_460_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906112", "story_v_side_new_1104906.awb") / 1000

					if var_460_8 + var_460_2 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_8 + var_460_2
					end

					if var_460_4.prefab_name ~= "" and arg_457_1.actors_[var_460_4.prefab_name] ~= nil then
						local var_460_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_4.prefab_name].transform, "story_v_side_new_1104906", "1104906112", "story_v_side_new_1104906.awb")

						arg_457_1:RecordAudio("1104906112", var_460_9)
						arg_457_1:RecordAudio("1104906112", var_460_9)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906112", "story_v_side_new_1104906.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906112", "story_v_side_new_1104906.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_10 = math.max(var_460_3, arg_457_1.talkMaxDuration)

			if var_460_2 <= arg_457_1.time_ and arg_457_1.time_ < var_460_2 + var_460_10 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_2) / var_460_10

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_2 + var_460_10 and arg_457_1.time_ < var_460_2 + var_460_10 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play1104906113 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1104906113
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1104906114(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.var_.moveOldPos1049ui_story = arg_461_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_464_0 = 0.001

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 then
				arg_461_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_461_1.time_ - 0) / var_464_0)
				arg_461_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_461_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1049ui_story"].transform.position).z)
				arg_461_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_461_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_461_1.actors_["1049ui_story"].transform.localEulerAngles = arg_461_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 then
				arg_461_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_461_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_461_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1049ui_story"].transform.position).z)
				arg_461_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_461_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_461_1.actors_["1049ui_story"].transform.localEulerAngles = arg_461_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_464_1 = arg_461_1.actors_["1049ui_story"]

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(var_464_1) and arg_461_1.var_.characterEffect1049ui_story == nil then
				arg_461_1.var_.characterEffect1049ui_story = var_464_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_2 = 0.200000002980232

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_2 and not isNil(var_464_1) then
				if arg_461_1.var_.characterEffect1049ui_story and not isNil(var_464_1) then
					arg_461_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_461_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_461_1.time_ - 0) / var_464_2)
				end
			end

			if arg_461_1.time_ >= 0 + var_464_2 and arg_461_1.time_ < 0 + var_464_2 + arg_464_0 and not isNil(var_464_1) and arg_461_1.var_.characterEffect1049ui_story then
				arg_461_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_461_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_464_3 = 0
			local var_464_4 = 0.65

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_3 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_5 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(1104906113).content)

				arg_461_1.text_.text = var_464_5

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_7 = 26 <= 0 and var_464_4 or var_464_4 * (utf8.len(var_464_5) / 26)

				if (26 <= 0 and var_464_4 or var_464_4 * (utf8.len(var_464_5) / 26)) > 0 and var_464_4 < var_464_7 then
					arg_461_1.talkMaxDuration = var_464_7

					if var_464_7 + var_464_3 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_7 + var_464_3
					end
				end

				arg_461_1.text_.text = var_464_5
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_8 = math.max(var_464_4, arg_461_1.talkMaxDuration)

			if var_464_3 <= arg_461_1.time_ and arg_461_1.time_ < var_464_3 + var_464_8 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_3) / var_464_8

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_3 + var_464_8 and arg_461_1.time_ < var_464_3 + var_464_8 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play1104906114 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1104906114
		arg_465_1.duration_ = 4

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1104906115(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.var_.moveOldPos1049ui_story = arg_465_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_468_0 = 0.001

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 then
				arg_465_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_465_1.time_ - 0) / var_468_0)
				arg_465_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1049ui_story"].transform.position).z)
				arg_465_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["1049ui_story"].transform.localEulerAngles = arg_465_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 then
				arg_465_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_465_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1049ui_story"].transform.position).z)
				arg_465_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["1049ui_story"].transform.localEulerAngles = arg_465_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_468_1 = arg_465_1.actors_["1049ui_story"]

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(var_468_1) and arg_465_1.var_.characterEffect1049ui_story == nil then
				arg_465_1.var_.characterEffect1049ui_story = var_468_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_2 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_2 and not isNil(var_468_1) then
				if arg_465_1.var_.characterEffect1049ui_story and not isNil(var_468_1) then
					arg_465_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= 0 + var_468_2 and arg_465_1.time_ < 0 + var_468_2 + arg_468_0 and not isNil(var_468_1) and arg_465_1.var_.characterEffect1049ui_story then
				arg_465_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action5_1")
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_468_4 = 0
			local var_468_5 = 0.375

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_4 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_6 = arg_465_1:GetWordFromCfg(1104906114)
				local var_468_7 = arg_465_1:FormatText(var_468_6.content)

				arg_465_1.text_.text = var_468_7

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_9 = 15 <= 0 and var_468_5 or var_468_5 * (utf8.len(var_468_7) / 15)

				if (15 <= 0 and var_468_5 or var_468_5 * (utf8.len(var_468_7) / 15)) > 0 and var_468_5 < var_468_9 then
					arg_465_1.talkMaxDuration = var_468_9

					if var_468_9 + var_468_4 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_9 + var_468_4
					end
				end

				arg_465_1.text_.text = var_468_7
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906114", "story_v_side_new_1104906.awb") ~= 0 then
					local var_468_10 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906114", "story_v_side_new_1104906.awb") / 1000

					if var_468_10 + var_468_4 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_10 + var_468_4
					end

					if var_468_6.prefab_name ~= "" and arg_465_1.actors_[var_468_6.prefab_name] ~= nil then
						local var_468_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_6.prefab_name].transform, "story_v_side_new_1104906", "1104906114", "story_v_side_new_1104906.awb")

						arg_465_1:RecordAudio("1104906114", var_468_11)
						arg_465_1:RecordAudio("1104906114", var_468_11)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906114", "story_v_side_new_1104906.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906114", "story_v_side_new_1104906.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_12 = math.max(var_468_5, arg_465_1.talkMaxDuration)

			if var_468_4 <= arg_465_1.time_ and arg_465_1.time_ < var_468_4 + var_468_12 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_4) / var_468_12

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_4 + var_468_12 and arg_465_1.time_ < var_468_4 + var_468_12 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_465_1:InitPlayNodeList()
	end,
	Play1104906115 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1104906115
		arg_469_1.duration_ = 4.83

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play1104906116(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049actionlink/1049action452")
			end

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_472_0 = 0
			local var_472_1 = 0.4

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_2 = arg_469_1:GetWordFromCfg(1104906115)
				local var_472_3 = arg_469_1:FormatText(var_472_2.content)

				arg_469_1.text_.text = var_472_3

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 16 <= 0 and var_472_1 or var_472_1 * (utf8.len(var_472_3) / 16)

				if (16 <= 0 and var_472_1 or var_472_1 * (utf8.len(var_472_3) / 16)) > 0 and var_472_1 < var_472_5 then
					arg_469_1.talkMaxDuration = var_472_5

					if var_472_5 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_5 + var_472_0
					end
				end

				arg_469_1.text_.text = var_472_3
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906115", "story_v_side_new_1104906.awb") ~= 0 then
					local var_472_6 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906115", "story_v_side_new_1104906.awb") / 1000

					if var_472_6 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_6 + var_472_0
					end

					if var_472_2.prefab_name ~= "" and arg_469_1.actors_[var_472_2.prefab_name] ~= nil then
						local var_472_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_2.prefab_name].transform, "story_v_side_new_1104906", "1104906115", "story_v_side_new_1104906.awb")

						arg_469_1:RecordAudio("1104906115", var_472_7)
						arg_469_1:RecordAudio("1104906115", var_472_7)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906115", "story_v_side_new_1104906.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906115", "story_v_side_new_1104906.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_8 = math.max(var_472_1, arg_469_1.talkMaxDuration)

			if var_472_0 <= arg_469_1.time_ and arg_469_1.time_ < var_472_0 + var_472_8 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_0) / var_472_8

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_0 + var_472_8 and arg_469_1.time_ < var_472_0 + var_472_8 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play1104906116 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1104906116
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1104906117(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.var_.moveOldPos1049ui_story = arg_473_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_476_0 = 0.001

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 then
				arg_473_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_473_1.time_ - 0) / var_476_0)
				arg_473_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1049ui_story"].transform.position).z)
				arg_473_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["1049ui_story"].transform.localEulerAngles = arg_473_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 then
				arg_473_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_473_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1049ui_story"].transform.position).z)
				arg_473_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["1049ui_story"].transform.localEulerAngles = arg_473_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_476_1 = arg_473_1.actors_["1049ui_story"]

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect1049ui_story == nil then
				arg_473_1.var_.characterEffect1049ui_story = var_476_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_2 = 0.200000002980232

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_2 and not isNil(var_476_1) then
				if arg_473_1.var_.characterEffect1049ui_story and not isNil(var_476_1) then
					arg_473_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_473_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_473_1.time_ - 0) / var_476_2)
				end
			end

			if arg_473_1.time_ >= 0 + var_476_2 and arg_473_1.time_ < 0 + var_476_2 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect1049ui_story then
				arg_473_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_473_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_476_3 = 0
			local var_476_4 = 1.125

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_3 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_5 = arg_473_1:FormatText(arg_473_1:GetWordFromCfg(1104906116).content)

				arg_473_1.text_.text = var_476_5

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_7 = 45 <= 0 and var_476_4 or var_476_4 * (utf8.len(var_476_5) / 45)

				if (45 <= 0 and var_476_4 or var_476_4 * (utf8.len(var_476_5) / 45)) > 0 and var_476_4 < var_476_7 then
					arg_473_1.talkMaxDuration = var_476_7

					if var_476_7 + var_476_3 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_7 + var_476_3
					end
				end

				arg_473_1.text_.text = var_476_5
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_8 = math.max(var_476_4, arg_473_1.talkMaxDuration)

			if var_476_3 <= arg_473_1.time_ and arg_473_1.time_ < var_476_3 + var_476_8 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_3) / var_476_8

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_3 + var_476_8 and arg_473_1.time_ < var_476_3 + var_476_8 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_473_1:InitPlayNodeList()
	end,
	Play1104906117 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1104906117
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1104906118(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0.85

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, false)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_1 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(1104906117).content)

				arg_477_1.text_.text = var_480_1

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_3 = 34 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_1) / 34)

				if (34 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_1) / 34)) > 0 and var_480_0 < var_480_3 then
					arg_477_1.talkMaxDuration = var_480_3

					if var_480_3 + 0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_3 + 0
					end
				end

				arg_477_1.text_.text = var_480_1
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_4 = math.max(var_480_0, arg_477_1.talkMaxDuration)

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_4 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - 0) / var_480_4

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= 0 + var_480_4 and arg_477_1.time_ < 0 + var_480_4 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play1104906118 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1104906118
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1104906119(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0.475

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, false)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_1 = arg_481_1:FormatText(arg_481_1:GetWordFromCfg(1104906118).content)

				arg_481_1.text_.text = var_484_1

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_3 = 19 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_1) / 19)

				if (19 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_1) / 19)) > 0 and var_484_0 < var_484_3 then
					arg_481_1.talkMaxDuration = var_484_3

					if var_484_3 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_3 + 0
					end
				end

				arg_481_1.text_.text = var_484_1
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_4 = math.max(var_484_0, arg_481_1.talkMaxDuration)

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_4 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - 0) / var_484_4

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= 0 + var_484_4 and arg_481_1.time_ < 0 + var_484_4 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play1104906119 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1104906119
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1104906120(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0.675

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, false)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_1 = arg_485_1:FormatText(arg_485_1:GetWordFromCfg(1104906119).content)

				arg_485_1.text_.text = var_488_1

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_3 = 27 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_1) / 27)

				if (27 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_1) / 27)) > 0 and var_488_0 < var_488_3 then
					arg_485_1.talkMaxDuration = var_488_3

					if var_488_3 + 0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_3 + 0
					end
				end

				arg_485_1.text_.text = var_488_1
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_4 = math.max(var_488_0, arg_485_1.talkMaxDuration)

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_4 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - 0) / var_488_4

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= 0 + var_488_4 and arg_485_1.time_ < 0 + var_488_4 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play1104906120 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1104906120
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1104906121(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0.375

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_1 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(1104906120).content)

				arg_489_1.text_.text = var_492_1

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_3 = 15 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_1) / 15)

				if (15 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_1) / 15)) > 0 and var_492_0 < var_492_3 then
					arg_489_1.talkMaxDuration = var_492_3

					if var_492_3 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_3 + 0
					end
				end

				arg_489_1.text_.text = var_492_1
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_4 = math.max(var_492_0, arg_489_1.talkMaxDuration)

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_4 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - 0) / var_492_4

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= 0 + var_492_4 and arg_489_1.time_ < 0 + var_492_4 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play1104906121 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1104906121
		arg_493_1.duration_ = 2

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1104906122(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.var_.moveOldPos1049ui_story = arg_493_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_496_0 = 0.001

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_0 then
				arg_493_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_493_1.time_ - 0) / var_496_0)
				arg_493_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1049ui_story"].transform.position).z)
				arg_493_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["1049ui_story"].transform.localEulerAngles = arg_493_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_493_1.time_ >= 0 + var_496_0 and arg_493_1.time_ < 0 + var_496_0 + arg_496_0 then
				arg_493_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_493_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1049ui_story"].transform.position).z)
				arg_493_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["1049ui_story"].transform.localEulerAngles = arg_493_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_496_1 = arg_493_1.actors_["1049ui_story"]

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(var_496_1) and arg_493_1.var_.characterEffect1049ui_story == nil then
				arg_493_1.var_.characterEffect1049ui_story = var_496_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_2 = 0.200000002980232

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_2 and not isNil(var_496_1) then
				if arg_493_1.var_.characterEffect1049ui_story and not isNil(var_496_1) then
					arg_493_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_493_1.time_ >= 0 + var_496_2 and arg_493_1.time_ < 0 + var_496_2 + arg_496_0 and not isNil(var_496_1) and arg_493_1.var_.characterEffect1049ui_story then
				arg_493_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_2")
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_496_4 = 0
			local var_496_5 = 0.175

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_4 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_6 = arg_493_1:GetWordFromCfg(1104906121)
				local var_496_7 = arg_493_1:FormatText(var_496_6.content)

				arg_493_1.text_.text = var_496_7

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_9 = 7 <= 0 and var_496_5 or var_496_5 * (utf8.len(var_496_7) / 7)

				if (7 <= 0 and var_496_5 or var_496_5 * (utf8.len(var_496_7) / 7)) > 0 and var_496_5 < var_496_9 then
					arg_493_1.talkMaxDuration = var_496_9

					if var_496_9 + var_496_4 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_9 + var_496_4
					end
				end

				arg_493_1.text_.text = var_496_7
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906121", "story_v_side_new_1104906.awb") ~= 0 then
					local var_496_10 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906121", "story_v_side_new_1104906.awb") / 1000

					if var_496_10 + var_496_4 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_10 + var_496_4
					end

					if var_496_6.prefab_name ~= "" and arg_493_1.actors_[var_496_6.prefab_name] ~= nil then
						local var_496_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_6.prefab_name].transform, "story_v_side_new_1104906", "1104906121", "story_v_side_new_1104906.awb")

						arg_493_1:RecordAudio("1104906121", var_496_11)
						arg_493_1:RecordAudio("1104906121", var_496_11)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906121", "story_v_side_new_1104906.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906121", "story_v_side_new_1104906.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_12 = math.max(var_496_5, arg_493_1.talkMaxDuration)

			if var_496_4 <= arg_493_1.time_ and arg_493_1.time_ < var_496_4 + var_496_12 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_4) / var_496_12

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_4 + var_496_12 and arg_493_1.time_ < var_496_4 + var_496_12 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_493_1:InitPlayNodeList()
	end,
	Play1104906122 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1104906122
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1104906123(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 and not isNil(arg_497_1.actors_["1049ui_story"]) and arg_497_1.var_.characterEffect1049ui_story == nil then
				arg_497_1.var_.characterEffect1049ui_story = arg_497_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_0 = 0.200000002980232

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_0 and not isNil(arg_497_1.actors_["1049ui_story"]) then
				if arg_497_1.var_.characterEffect1049ui_story and not isNil(arg_497_1.actors_["1049ui_story"]) then
					arg_497_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_497_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_497_1.time_ - 0) / var_500_0)
				end
			end

			if arg_497_1.time_ >= 0 + var_500_0 and arg_497_1.time_ < 0 + var_500_0 + arg_500_0 and not isNil(arg_497_1.actors_["1049ui_story"]) and arg_497_1.var_.characterEffect1049ui_story then
				arg_497_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_497_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_500_1 = 0
			local var_500_2 = 0.425

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, true)
				arg_497_1.iconController_:SetSelectedState("hero")

				arg_497_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_497_1.callingController_:SetSelectedState("normal")

				arg_497_1.keyicon_.color = Color.New(1, 1, 1)
				arg_497_1.icon_.color = Color.New(1, 1, 1)

				local var_500_3 = arg_497_1:FormatText(arg_497_1:GetWordFromCfg(1104906122).content)

				arg_497_1.text_.text = var_500_3

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_5 = 17 <= 0 and var_500_2 or var_500_2 * (utf8.len(var_500_3) / 17)

				if (17 <= 0 and var_500_2 or var_500_2 * (utf8.len(var_500_3) / 17)) > 0 and var_500_2 < var_500_5 then
					arg_497_1.talkMaxDuration = var_500_5

					if var_500_5 + var_500_1 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_5 + var_500_1
					end
				end

				arg_497_1.text_.text = var_500_3
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_6 = math.max(var_500_2, arg_497_1.talkMaxDuration)

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_6 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_1) / var_500_6

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_1 + var_500_6 and arg_497_1.time_ < var_500_1 + var_500_6 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play1104906123 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1104906123
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1104906124(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.var_.moveOldPos1049ui_story = arg_501_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_504_0 = 0.001

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_0 then
				arg_501_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_501_1.time_ - 0) / var_504_0)
				arg_501_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_501_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1049ui_story"].transform.position).z)
				arg_501_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_501_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_501_1.actors_["1049ui_story"].transform.localEulerAngles = arg_501_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_501_1.time_ >= 0 + var_504_0 and arg_501_1.time_ < 0 + var_504_0 + arg_504_0 then
				arg_501_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_501_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_501_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1049ui_story"].transform.position).z)
				arg_501_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_501_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_501_1.actors_["1049ui_story"].transform.localEulerAngles = arg_501_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_504_1 = 0
			local var_504_2 = 1.25

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_1 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, false)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_3 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(1104906123).content)

				arg_501_1.text_.text = var_504_3

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_5 = 50 <= 0 and var_504_2 or var_504_2 * (utf8.len(var_504_3) / 50)

				if (50 <= 0 and var_504_2 or var_504_2 * (utf8.len(var_504_3) / 50)) > 0 and var_504_2 < var_504_5 then
					arg_501_1.talkMaxDuration = var_504_5

					if var_504_5 + var_504_1 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_5 + var_504_1
					end
				end

				arg_501_1.text_.text = var_504_3
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_6 = math.max(var_504_2, arg_501_1.talkMaxDuration)

			if var_504_1 <= arg_501_1.time_ and arg_501_1.time_ < var_504_1 + var_504_6 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_1) / var_504_6

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_1 + var_504_6 and arg_501_1.time_ < var_504_1 + var_504_6 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_501_1:InitPlayNodeList()
	end,
	Play1104906124 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1104906124
		arg_505_1.duration_ = 9

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1104906125(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			if arg_505_1.bgs_.R4902 == nil then
				local var_508_0 = Object.Instantiate(arg_505_1.paintGo_)

				var_508_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R4902")
				var_508_0.name = "R4902"
				var_508_0.transform.parent = arg_505_1.stage_.transform
				var_508_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_505_1.bgs_.R4902 = var_508_0
			end

			if 2 < arg_505_1.time_ and arg_505_1.time_ <= 2 + arg_508_0 then
				local var_508_1 = arg_505_1.bgs_.R4902

				arg_505_1.bgs_.R4902.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_508_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_508_2 = var_508_1:GetComponent("SpriteRenderer")

				if var_508_2 and var_508_2.sprite then
					local var_508_3 = 2 * (var_508_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_508_1.transform.localScale = Vector3.New(var_508_3 / var_508_2.sprite.bounds.size.y < var_508_3 * manager.ui.mainCameraCom_.aspect / var_508_2.sprite.bounds.size.x and var_508_3 * manager.ui.mainCameraCom_.aspect / var_508_2.sprite.bounds.size.x or var_508_3 / var_508_2.sprite.bounds.size.y, var_508_3 / var_508_2.sprite.bounds.size.y < var_508_3 * manager.ui.mainCameraCom_.aspect / var_508_2.sprite.bounds.size.x and var_508_3 * manager.ui.mainCameraCom_.aspect / var_508_2.sprite.bounds.size.x or var_508_3 / var_508_2.sprite.bounds.size.y, 0)
				end

				for iter_508_0, iter_508_1 in pairs(arg_505_1.bgs_) do
					if iter_508_0 ~= "R4902" then
						iter_508_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_508_4 = 3.999999999999

			if 3.999999999999 < arg_505_1.time_ and arg_505_1.time_ <= var_508_4 + arg_508_0 then
				arg_505_1.allBtn_.enabled = false
			end

			if arg_505_1.time_ >= var_508_4 + 0.3 and arg_505_1.time_ < var_508_4 + 0.3 + arg_508_0 then
				arg_505_1.allBtn_.enabled = true
			end

			local var_508_5 = 0

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_5 + arg_508_0 then
				arg_505_1.mask_.enabled = true
				arg_505_1.mask_.raycastTarget = true

				arg_505_1:SetGaussion(false)
			end

			local var_508_6 = 2

			if var_508_5 <= arg_505_1.time_ and arg_505_1.time_ < var_508_5 + var_508_6 then
				local var_508_7 = Color.New(0, 0, 0)

				var_508_7.a = Mathf.Lerp(0, 1, (arg_505_1.time_ - var_508_5) / var_508_6)
				arg_505_1.mask_.color = var_508_7
			end

			if arg_505_1.time_ >= var_508_5 + var_508_6 and arg_505_1.time_ < var_508_5 + var_508_6 + arg_508_0 then
				local var_508_8 = Color.New(0, 0, 0)

				var_508_8.a = 1
				arg_505_1.mask_.color = var_508_8
			end

			local var_508_9 = 2

			if 2 < arg_505_1.time_ and arg_505_1.time_ <= var_508_9 + arg_508_0 then
				arg_505_1.mask_.enabled = true
				arg_505_1.mask_.raycastTarget = true

				arg_505_1:SetGaussion(false)
			end

			local var_508_10 = 2

			if var_508_9 <= arg_505_1.time_ and arg_505_1.time_ < var_508_9 + var_508_10 then
				local var_508_11 = Color.New(0, 0, 0)

				var_508_11.a = Mathf.Lerp(1, 0, (arg_505_1.time_ - var_508_9) / var_508_10)
				arg_505_1.mask_.color = var_508_11
			end

			if arg_505_1.time_ >= var_508_9 + var_508_10 and arg_505_1.time_ < var_508_9 + var_508_10 + arg_508_0 then
				local var_508_12 = Color.New(0, 0, 0)

				arg_505_1.mask_.enabled = false
				var_508_12.a = 0
				arg_505_1.mask_.color = var_508_12
			end

			local var_508_13 = arg_505_1.bgs_.R4902.transform

			if 2 < arg_505_1.time_ and arg_505_1.time_ <= 2 + arg_508_0 then
				arg_505_1.var_.moveOldPosR4902 = var_508_13.localPosition
			end

			local var_508_14 = 0.001

			if 2 <= arg_505_1.time_ and arg_505_1.time_ < 2 + var_508_14 then
				var_508_13.localPosition = Vector3.Lerp(arg_505_1.var_.moveOldPosR4902, Vector3.New(0, 0.5, 0), (arg_505_1.time_ - 2) / var_508_14)
			end

			if arg_505_1.time_ >= 2 + var_508_14 and arg_505_1.time_ < 2 + var_508_14 + arg_508_0 then
				var_508_13.localPosition = Vector3.New(0, 0.5, 0)
			end

			local var_508_15 = arg_505_1.bgs_.R4902.transform

			if 2.03333333333333 < arg_505_1.time_ and arg_505_1.time_ <= 2.03333333333333 + arg_508_0 then
				arg_505_1.var_.moveOldPosR4902 = var_508_15.localPosition
			end

			local var_508_16 = 3.6

			if 2.03333333333333 <= arg_505_1.time_ and arg_505_1.time_ < 2.03333333333333 + var_508_16 then
				var_508_15.localPosition = Vector3.Lerp(arg_505_1.var_.moveOldPosR4902, Vector3.New(0, 0, 0), (arg_505_1.time_ - 2.03333333333333) / var_508_16)
			end

			if arg_505_1.time_ >= 2.03333333333333 + var_508_16 and arg_505_1.time_ < 2.03333333333333 + var_508_16 + arg_508_0 then
				var_508_15.localPosition = Vector3.New(0, 0, 0)
			end

			local var_508_17 = 4

			if 4 < arg_505_1.time_ and arg_505_1.time_ <= var_508_17 + arg_508_0 then
				arg_505_1.allBtn_.enabled = false
			end

			if arg_505_1.time_ >= var_508_17 + 1.63333333333333 and arg_505_1.time_ < var_508_17 + 1.63333333333333 + arg_508_0 then
				arg_505_1.allBtn_.enabled = true
			end

			if arg_505_1.frameCnt_ <= 1 then
				arg_505_1.dialog_:SetActive(false)
			end

			local var_508_18 = 4
			local var_508_19 = 0.65

			if 4 < arg_505_1.time_ and arg_505_1.time_ <= var_508_18 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0

				arg_505_1.dialog_:SetActive(true)

				arg_505_1.dialogCg_.alpha = 0

				local var_508_20 = LeanTween.value(arg_505_1.dialog_, 0, 1, 0.3)

				var_508_20:setOnUpdate(LuaHelper.FloatAction(function(arg_509_0)
					arg_505_1.dialogCg_.alpha = arg_509_0
				end))
				var_508_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_505_1.dialog_)
					var_508_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_505_1.duration_ = arg_505_1.duration_ + 0.3

				SetActive(arg_505_1.leftNameGo_, false)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_21 = arg_505_1:FormatText(arg_505_1:GetWordFromCfg(1104906124).content)

				arg_505_1.text_.text = var_508_21

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_23 = 26 <= 0 and var_508_19 or var_508_19 * (utf8.len(var_508_21) / 26)

				if (26 <= 0 and var_508_19 or var_508_19 * (utf8.len(var_508_21) / 26)) > 0 and var_508_19 < var_508_23 then
					arg_505_1.talkMaxDuration = var_508_23
					var_508_18 = var_508_18 + 0.3

					if var_508_23 + var_508_18 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_23 + var_508_18
					end
				end

				arg_505_1.text_.text = var_508_21
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_24 = var_508_18 + 0.3
			local var_508_25 = math.max(var_508_19, arg_505_1.talkMaxDuration)

			if var_508_18 + 0.3 <= arg_505_1.time_ and arg_505_1.time_ < var_508_24 + var_508_25 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_24) / var_508_25

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_24 + var_508_25 and arg_505_1.time_ < var_508_24 + var_508_25 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R4902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333332,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R4902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.6,
				className = "StoryMoveNode",
				startTime = 2.03333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_505_1:InitPlayNodeList()
	end,
	Play1104906125 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 1104906125
		arg_511_1.duration_ = 3.07

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play1104906126(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(arg_511_1.actors_["1049ui_story"]) and arg_511_1.var_.characterEffect1049ui_story == nil then
				arg_511_1.var_.characterEffect1049ui_story = arg_511_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_0 = 0.200000002980232

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_0 and not isNil(arg_511_1.actors_["1049ui_story"]) then
				if arg_511_1.var_.characterEffect1049ui_story and not isNil(arg_511_1.actors_["1049ui_story"]) then
					arg_511_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_511_1.time_ >= 0 + var_514_0 and arg_511_1.time_ < 0 + var_514_0 + arg_514_0 and not isNil(arg_511_1.actors_["1049ui_story"]) and arg_511_1.var_.characterEffect1049ui_story then
				arg_511_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_514_2 = 0
			local var_514_3 = 0.3

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_2 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_4 = arg_511_1:GetWordFromCfg(1104906125)
				local var_514_5 = arg_511_1:FormatText(var_514_4.content)

				arg_511_1.text_.text = var_514_5

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_7 = 12 <= 0 and var_514_3 or var_514_3 * (utf8.len(var_514_5) / 12)

				if (12 <= 0 and var_514_3 or var_514_3 * (utf8.len(var_514_5) / 12)) > 0 and var_514_3 < var_514_7 then
					arg_511_1.talkMaxDuration = var_514_7

					if var_514_7 + var_514_2 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_7 + var_514_2
					end
				end

				arg_511_1.text_.text = var_514_5
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906125", "story_v_side_new_1104906.awb") ~= 0 then
					local var_514_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906125", "story_v_side_new_1104906.awb") / 1000

					if var_514_8 + var_514_2 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_8 + var_514_2
					end

					if var_514_4.prefab_name ~= "" and arg_511_1.actors_[var_514_4.prefab_name] ~= nil then
						local var_514_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_4.prefab_name].transform, "story_v_side_new_1104906", "1104906125", "story_v_side_new_1104906.awb")

						arg_511_1:RecordAudio("1104906125", var_514_9)
						arg_511_1:RecordAudio("1104906125", var_514_9)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906125", "story_v_side_new_1104906.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906125", "story_v_side_new_1104906.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_10 = math.max(var_514_3, arg_511_1.talkMaxDuration)

			if var_514_2 <= arg_511_1.time_ and arg_511_1.time_ < var_514_2 + var_514_10 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_2) / var_514_10

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_2 + var_514_10 and arg_511_1.time_ < var_514_2 + var_514_10 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play1104906126 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 1104906126
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play1104906127(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(arg_515_1.actors_["1049ui_story"]) and arg_515_1.var_.characterEffect1049ui_story == nil then
				arg_515_1.var_.characterEffect1049ui_story = arg_515_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_0 = 0.200000002980232

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_0 and not isNil(arg_515_1.actors_["1049ui_story"]) then
				if arg_515_1.var_.characterEffect1049ui_story and not isNil(arg_515_1.actors_["1049ui_story"]) then
					arg_515_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_515_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_515_1.time_ - 0) / var_518_0)
				end
			end

			if arg_515_1.time_ >= 0 + var_518_0 and arg_515_1.time_ < 0 + var_518_0 + arg_518_0 and not isNil(arg_515_1.actors_["1049ui_story"]) and arg_515_1.var_.characterEffect1049ui_story then
				arg_515_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_515_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_518_1 = 0
			local var_518_2 = 0.4

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, true)
				arg_515_1.iconController_:SetSelectedState("hero")

				arg_515_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_515_1.callingController_:SetSelectedState("normal")

				arg_515_1.keyicon_.color = Color.New(1, 1, 1)
				arg_515_1.icon_.color = Color.New(1, 1, 1)

				local var_518_3 = arg_515_1:FormatText(arg_515_1:GetWordFromCfg(1104906126).content)

				arg_515_1.text_.text = var_518_3

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_5 = 16 <= 0 and var_518_2 or var_518_2 * (utf8.len(var_518_3) / 16)

				if (16 <= 0 and var_518_2 or var_518_2 * (utf8.len(var_518_3) / 16)) > 0 and var_518_2 < var_518_5 then
					arg_515_1.talkMaxDuration = var_518_5

					if var_518_5 + var_518_1 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_5 + var_518_1
					end
				end

				arg_515_1.text_.text = var_518_3
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_6 = math.max(var_518_2, arg_515_1.talkMaxDuration)

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_6 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_1) / var_518_6

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_1 + var_518_6 and arg_515_1.time_ < var_518_1 + var_518_6 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play1104906127 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 1104906127
		arg_519_1.duration_ = 5

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play1104906128(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = 0.675

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, true)
				arg_519_1.iconController_:SetSelectedState("hero")

				arg_519_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_519_1.callingController_:SetSelectedState("normal")

				arg_519_1.keyicon_.color = Color.New(1, 1, 1)
				arg_519_1.icon_.color = Color.New(1, 1, 1)

				local var_522_1 = arg_519_1:FormatText(arg_519_1:GetWordFromCfg(1104906127).content)

				arg_519_1.text_.text = var_522_1

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_3 = 27 <= 0 and var_522_0 or var_522_0 * (utf8.len(var_522_1) / 27)

				if (27 <= 0 and var_522_0 or var_522_0 * (utf8.len(var_522_1) / 27)) > 0 and var_522_0 < var_522_3 then
					arg_519_1.talkMaxDuration = var_522_3

					if var_522_3 + 0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_3 + 0
					end
				end

				arg_519_1.text_.text = var_522_1
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)
				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_4 = math.max(var_522_0, arg_519_1.talkMaxDuration)

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_4 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - 0) / var_522_4

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= 0 + var_522_4 and arg_519_1.time_ < 0 + var_522_4 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play1104906128 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 1104906128
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play1104906129(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 0.625

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
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

				local var_526_1 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(1104906128).content)

				arg_523_1.text_.text = var_526_1

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_3 = 25 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_1) / 25)

				if (25 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_1) / 25)) > 0 and var_526_0 < var_526_3 then
					arg_523_1.talkMaxDuration = var_526_3

					if var_526_3 + 0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_3 + 0
					end
				end

				arg_523_1.text_.text = var_526_1
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_4 = math.max(var_526_0, arg_523_1.talkMaxDuration)

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_4 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - 0) / var_526_4

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= 0 + var_526_4 and arg_523_1.time_ < 0 + var_526_4 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play1104906129 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 1104906129
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play1104906130(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0.75

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, false)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_1 = arg_527_1:FormatText(arg_527_1:GetWordFromCfg(1104906129).content)

				arg_527_1.text_.text = var_530_1

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_3 = 30 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_1) / 30)

				if (30 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_1) / 30)) > 0 and var_530_0 < var_530_3 then
					arg_527_1.talkMaxDuration = var_530_3

					if var_530_3 + 0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_3 + 0
					end
				end

				arg_527_1.text_.text = var_530_1
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_4 = math.max(var_530_0, arg_527_1.talkMaxDuration)

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_4 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - 0) / var_530_4

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= 0 + var_530_4 and arg_527_1.time_ < 0 + var_530_4 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play1104906130 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1104906130
		arg_531_1.duration_ = 4.3

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1104906131(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 and not isNil(arg_531_1.actors_["1049ui_story"]) and arg_531_1.var_.characterEffect1049ui_story == nil then
				arg_531_1.var_.characterEffect1049ui_story = arg_531_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_0 = 0.200000002980232

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_0 and not isNil(arg_531_1.actors_["1049ui_story"]) then
				if arg_531_1.var_.characterEffect1049ui_story and not isNil(arg_531_1.actors_["1049ui_story"]) then
					arg_531_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_531_1.time_ >= 0 + var_534_0 and arg_531_1.time_ < 0 + var_534_0 + arg_534_0 and not isNil(arg_531_1.actors_["1049ui_story"]) and arg_531_1.var_.characterEffect1049ui_story then
				arg_531_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_534_2 = 0
			local var_534_3 = 0.475

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_2 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_4 = arg_531_1:GetWordFromCfg(1104906130)
				local var_534_5 = arg_531_1:FormatText(var_534_4.content)

				arg_531_1.text_.text = var_534_5

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_7 = 19 <= 0 and var_534_3 or var_534_3 * (utf8.len(var_534_5) / 19)

				if (19 <= 0 and var_534_3 or var_534_3 * (utf8.len(var_534_5) / 19)) > 0 and var_534_3 < var_534_7 then
					arg_531_1.talkMaxDuration = var_534_7

					if var_534_7 + var_534_2 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_7 + var_534_2
					end
				end

				arg_531_1.text_.text = var_534_5
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906130", "story_v_side_new_1104906.awb") ~= 0 then
					local var_534_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906130", "story_v_side_new_1104906.awb") / 1000

					if var_534_8 + var_534_2 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_8 + var_534_2
					end

					if var_534_4.prefab_name ~= "" and arg_531_1.actors_[var_534_4.prefab_name] ~= nil then
						local var_534_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_4.prefab_name].transform, "story_v_side_new_1104906", "1104906130", "story_v_side_new_1104906.awb")

						arg_531_1:RecordAudio("1104906130", var_534_9)
						arg_531_1:RecordAudio("1104906130", var_534_9)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906130", "story_v_side_new_1104906.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906130", "story_v_side_new_1104906.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_10 = math.max(var_534_3, arg_531_1.talkMaxDuration)

			if var_534_2 <= arg_531_1.time_ and arg_531_1.time_ < var_534_2 + var_534_10 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_2) / var_534_10

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_2 + var_534_10 and arg_531_1.time_ < var_534_2 + var_534_10 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play1104906131 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 1104906131
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play1104906132(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(arg_535_1.actors_["1049ui_story"]) and arg_535_1.var_.characterEffect1049ui_story == nil then
				arg_535_1.var_.characterEffect1049ui_story = arg_535_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_0 = 0.200000002980232

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_0 and not isNil(arg_535_1.actors_["1049ui_story"]) then
				if arg_535_1.var_.characterEffect1049ui_story and not isNil(arg_535_1.actors_["1049ui_story"]) then
					arg_535_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_535_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_535_1.time_ - 0) / var_538_0)
				end
			end

			if arg_535_1.time_ >= 0 + var_538_0 and arg_535_1.time_ < 0 + var_538_0 + arg_538_0 and not isNil(arg_535_1.actors_["1049ui_story"]) and arg_535_1.var_.characterEffect1049ui_story then
				arg_535_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_535_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_538_1 = 0
			local var_538_2 = 0.875

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_1 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, true)
				arg_535_1.iconController_:SetSelectedState("hero")

				arg_535_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_535_1.callingController_:SetSelectedState("normal")

				arg_535_1.keyicon_.color = Color.New(1, 1, 1)
				arg_535_1.icon_.color = Color.New(1, 1, 1)

				local var_538_3 = arg_535_1:FormatText(arg_535_1:GetWordFromCfg(1104906131).content)

				arg_535_1.text_.text = var_538_3

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_5 = 35 <= 0 and var_538_2 or var_538_2 * (utf8.len(var_538_3) / 35)

				if (35 <= 0 and var_538_2 or var_538_2 * (utf8.len(var_538_3) / 35)) > 0 and var_538_2 < var_538_5 then
					arg_535_1.talkMaxDuration = var_538_5

					if var_538_5 + var_538_1 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_5 + var_538_1
					end
				end

				arg_535_1.text_.text = var_538_3
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_6 = math.max(var_538_2, arg_535_1.talkMaxDuration)

			if var_538_1 <= arg_535_1.time_ and arg_535_1.time_ < var_538_1 + var_538_6 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_1) / var_538_6

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_1 + var_538_6 and arg_535_1.time_ < var_538_1 + var_538_6 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play1104906132 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 1104906132
		arg_539_1.duration_ = 8.23

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play1104906133(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 and not isNil(arg_539_1.actors_["1049ui_story"]) and arg_539_1.var_.characterEffect1049ui_story == nil then
				arg_539_1.var_.characterEffect1049ui_story = arg_539_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_542_0 = 0.200000002980232

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_0 and not isNil(arg_539_1.actors_["1049ui_story"]) then
				if arg_539_1.var_.characterEffect1049ui_story and not isNil(arg_539_1.actors_["1049ui_story"]) then
					arg_539_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_539_1.time_ >= 0 + var_542_0 and arg_539_1.time_ < 0 + var_542_0 + arg_542_0 and not isNil(arg_539_1.actors_["1049ui_story"]) and arg_539_1.var_.characterEffect1049ui_story then
				arg_539_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_542_2 = 0
			local var_542_3 = 0.7

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_2 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				arg_539_1.leftNameTxt_.text = arg_539_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_4 = arg_539_1:GetWordFromCfg(1104906132)
				local var_542_5 = arg_539_1:FormatText(var_542_4.content)

				arg_539_1.text_.text = var_542_5

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_7 = 28 <= 0 and var_542_3 or var_542_3 * (utf8.len(var_542_5) / 28)

				if (28 <= 0 and var_542_3 or var_542_3 * (utf8.len(var_542_5) / 28)) > 0 and var_542_3 < var_542_7 then
					arg_539_1.talkMaxDuration = var_542_7

					if var_542_7 + var_542_2 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_7 + var_542_2
					end
				end

				arg_539_1.text_.text = var_542_5
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906132", "story_v_side_new_1104906.awb") ~= 0 then
					local var_542_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906132", "story_v_side_new_1104906.awb") / 1000

					if var_542_8 + var_542_2 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_8 + var_542_2
					end

					if var_542_4.prefab_name ~= "" and arg_539_1.actors_[var_542_4.prefab_name] ~= nil then
						local var_542_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_4.prefab_name].transform, "story_v_side_new_1104906", "1104906132", "story_v_side_new_1104906.awb")

						arg_539_1:RecordAudio("1104906132", var_542_9)
						arg_539_1:RecordAudio("1104906132", var_542_9)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906132", "story_v_side_new_1104906.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906132", "story_v_side_new_1104906.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_10 = math.max(var_542_3, arg_539_1.talkMaxDuration)

			if var_542_2 <= arg_539_1.time_ and arg_539_1.time_ < var_542_2 + var_542_10 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_2) / var_542_10

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_2 + var_542_10 and arg_539_1.time_ < var_542_2 + var_542_10 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play1104906133 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 1104906133
		arg_543_1.duration_ = 4.17

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play1104906134(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = 0.325

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				arg_543_1.leftNameTxt_.text = arg_543_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_1 = arg_543_1:GetWordFromCfg(1104906133)
				local var_546_2 = arg_543_1:FormatText(var_546_1.content)

				arg_543_1.text_.text = var_546_2

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_4 = 13 <= 0 and var_546_0 or var_546_0 * (utf8.len(var_546_2) / 13)

				if (13 <= 0 and var_546_0 or var_546_0 * (utf8.len(var_546_2) / 13)) > 0 and var_546_0 < var_546_4 then
					arg_543_1.talkMaxDuration = var_546_4

					if var_546_4 + 0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_4 + 0
					end
				end

				arg_543_1.text_.text = var_546_2
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906133", "story_v_side_new_1104906.awb") ~= 0 then
					local var_546_5 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906133", "story_v_side_new_1104906.awb") / 1000

					if var_546_5 + 0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_5 + 0
					end

					if var_546_1.prefab_name ~= "" and arg_543_1.actors_[var_546_1.prefab_name] ~= nil then
						local var_546_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_1.prefab_name].transform, "story_v_side_new_1104906", "1104906133", "story_v_side_new_1104906.awb")

						arg_543_1:RecordAudio("1104906133", var_546_6)
						arg_543_1:RecordAudio("1104906133", var_546_6)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906133", "story_v_side_new_1104906.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906133", "story_v_side_new_1104906.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_7 = math.max(var_546_0, arg_543_1.talkMaxDuration)

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_7 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - 0) / var_546_7

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= 0 + var_546_7 and arg_543_1.time_ < 0 + var_546_7 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play1104906134 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 1104906134
		arg_547_1.duration_ = 5

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play1104906135(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 and not isNil(arg_547_1.actors_["1049ui_story"]) and arg_547_1.var_.characterEffect1049ui_story == nil then
				arg_547_1.var_.characterEffect1049ui_story = arg_547_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_550_0 = 0.200000002980232

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_0 and not isNil(arg_547_1.actors_["1049ui_story"]) then
				if arg_547_1.var_.characterEffect1049ui_story and not isNil(arg_547_1.actors_["1049ui_story"]) then
					arg_547_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_547_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_547_1.time_ - 0) / var_550_0)
				end
			end

			if arg_547_1.time_ >= 0 + var_550_0 and arg_547_1.time_ < 0 + var_550_0 + arg_550_0 and not isNil(arg_547_1.actors_["1049ui_story"]) and arg_547_1.var_.characterEffect1049ui_story then
				arg_547_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_547_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_550_1 = 0
			local var_550_2 = 0.1

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= var_550_1 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				arg_547_1.leftNameTxt_.text = arg_547_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, true)
				arg_547_1.iconController_:SetSelectedState("hero")

				arg_547_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_547_1.callingController_:SetSelectedState("normal")

				arg_547_1.keyicon_.color = Color.New(1, 1, 1)
				arg_547_1.icon_.color = Color.New(1, 1, 1)

				local var_550_3 = arg_547_1:FormatText(arg_547_1:GetWordFromCfg(1104906134).content)

				arg_547_1.text_.text = var_550_3

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_5 = 4 <= 0 and var_550_2 or var_550_2 * (utf8.len(var_550_3) / 4)

				if (4 <= 0 and var_550_2 or var_550_2 * (utf8.len(var_550_3) / 4)) > 0 and var_550_2 < var_550_5 then
					arg_547_1.talkMaxDuration = var_550_5

					if var_550_5 + var_550_1 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_5 + var_550_1
					end
				end

				arg_547_1.text_.text = var_550_3
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_6 = math.max(var_550_2, arg_547_1.talkMaxDuration)

			if var_550_1 <= arg_547_1.time_ and arg_547_1.time_ < var_550_1 + var_550_6 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_1) / var_550_6

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_1 + var_550_6 and arg_547_1.time_ < var_550_1 + var_550_6 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play1104906135 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 1104906135
		arg_551_1.duration_ = 4.5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play1104906136(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 and not isNil(arg_551_1.actors_["1049ui_story"]) and arg_551_1.var_.characterEffect1049ui_story == nil then
				arg_551_1.var_.characterEffect1049ui_story = arg_551_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_554_0 = 0.200000002980232

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_0 and not isNil(arg_551_1.actors_["1049ui_story"]) then
				if arg_551_1.var_.characterEffect1049ui_story and not isNil(arg_551_1.actors_["1049ui_story"]) then
					arg_551_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_551_1.time_ >= 0 + var_554_0 and arg_551_1.time_ < 0 + var_554_0 + arg_554_0 and not isNil(arg_551_1.actors_["1049ui_story"]) and arg_551_1.var_.characterEffect1049ui_story then
				arg_551_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_554_2 = 0
			local var_554_3 = 0.475

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= var_554_2 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				arg_551_1.leftNameTxt_.text = arg_551_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_4 = arg_551_1:GetWordFromCfg(1104906135)
				local var_554_5 = arg_551_1:FormatText(var_554_4.content)

				arg_551_1.text_.text = var_554_5

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_7 = 19 <= 0 and var_554_3 or var_554_3 * (utf8.len(var_554_5) / 19)

				if (19 <= 0 and var_554_3 or var_554_3 * (utf8.len(var_554_5) / 19)) > 0 and var_554_3 < var_554_7 then
					arg_551_1.talkMaxDuration = var_554_7

					if var_554_7 + var_554_2 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_7 + var_554_2
					end
				end

				arg_551_1.text_.text = var_554_5
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906135", "story_v_side_new_1104906.awb") ~= 0 then
					local var_554_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906135", "story_v_side_new_1104906.awb") / 1000

					if var_554_8 + var_554_2 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_8 + var_554_2
					end

					if var_554_4.prefab_name ~= "" and arg_551_1.actors_[var_554_4.prefab_name] ~= nil then
						local var_554_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_4.prefab_name].transform, "story_v_side_new_1104906", "1104906135", "story_v_side_new_1104906.awb")

						arg_551_1:RecordAudio("1104906135", var_554_9)
						arg_551_1:RecordAudio("1104906135", var_554_9)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906135", "story_v_side_new_1104906.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906135", "story_v_side_new_1104906.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_10 = math.max(var_554_3, arg_551_1.talkMaxDuration)

			if var_554_2 <= arg_551_1.time_ and arg_551_1.time_ < var_554_2 + var_554_10 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_2) / var_554_10

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_2 + var_554_10 and arg_551_1.time_ < var_554_2 + var_554_10 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play1104906136 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 1104906136
		arg_555_1.duration_ = 11.9

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play1104906137(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = 1.125

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				arg_555_1.leftNameTxt_.text = arg_555_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_1 = arg_555_1:GetWordFromCfg(1104906136)
				local var_558_2 = arg_555_1:FormatText(var_558_1.content)

				arg_555_1.text_.text = var_558_2

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_4 = 45 <= 0 and var_558_0 or var_558_0 * (utf8.len(var_558_2) / 45)

				if (45 <= 0 and var_558_0 or var_558_0 * (utf8.len(var_558_2) / 45)) > 0 and var_558_0 < var_558_4 then
					arg_555_1.talkMaxDuration = var_558_4

					if var_558_4 + 0 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_4 + 0
					end
				end

				arg_555_1.text_.text = var_558_2
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906136", "story_v_side_new_1104906.awb") ~= 0 then
					local var_558_5 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906136", "story_v_side_new_1104906.awb") / 1000

					if var_558_5 + 0 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_5 + 0
					end

					if var_558_1.prefab_name ~= "" and arg_555_1.actors_[var_558_1.prefab_name] ~= nil then
						local var_558_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_555_1.actors_[var_558_1.prefab_name].transform, "story_v_side_new_1104906", "1104906136", "story_v_side_new_1104906.awb")

						arg_555_1:RecordAudio("1104906136", var_558_6)
						arg_555_1:RecordAudio("1104906136", var_558_6)
					else
						arg_555_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906136", "story_v_side_new_1104906.awb")
					end

					arg_555_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906136", "story_v_side_new_1104906.awb")
				end

				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_7 = math.max(var_558_0, arg_555_1.talkMaxDuration)

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_7 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - 0) / var_558_7

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= 0 + var_558_7 and arg_555_1.time_ < 0 + var_558_7 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play1104906137 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 1104906137
		arg_559_1.duration_ = 5.8

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play1104906138(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 0.475

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				arg_559_1.leftNameTxt_.text = arg_559_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_1 = arg_559_1:GetWordFromCfg(1104906137)
				local var_562_2 = arg_559_1:FormatText(var_562_1.content)

				arg_559_1.text_.text = var_562_2

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_4 = 19 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_2) / 19)

				if (19 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_2) / 19)) > 0 and var_562_0 < var_562_4 then
					arg_559_1.talkMaxDuration = var_562_4

					if var_562_4 + 0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_4 + 0
					end
				end

				arg_559_1.text_.text = var_562_2
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906137", "story_v_side_new_1104906.awb") ~= 0 then
					local var_562_5 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906137", "story_v_side_new_1104906.awb") / 1000

					if var_562_5 + 0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_5 + 0
					end

					if var_562_1.prefab_name ~= "" and arg_559_1.actors_[var_562_1.prefab_name] ~= nil then
						local var_562_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_559_1.actors_[var_562_1.prefab_name].transform, "story_v_side_new_1104906", "1104906137", "story_v_side_new_1104906.awb")

						arg_559_1:RecordAudio("1104906137", var_562_6)
						arg_559_1:RecordAudio("1104906137", var_562_6)
					else
						arg_559_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906137", "story_v_side_new_1104906.awb")
					end

					arg_559_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906137", "story_v_side_new_1104906.awb")
				end

				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_7 = math.max(var_562_0, arg_559_1.talkMaxDuration)

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_7 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - 0) / var_562_7

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= 0 + var_562_7 and arg_559_1.time_ < 0 + var_562_7 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play1104906138 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 1104906138
		arg_563_1.duration_ = 11

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play1104906139(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = 1.025

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				arg_563_1.leftNameTxt_.text = arg_563_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_1 = arg_563_1:GetWordFromCfg(1104906138)
				local var_566_2 = arg_563_1:FormatText(var_566_1.content)

				arg_563_1.text_.text = var_566_2

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_4 = 41 <= 0 and var_566_0 or var_566_0 * (utf8.len(var_566_2) / 41)

				if (41 <= 0 and var_566_0 or var_566_0 * (utf8.len(var_566_2) / 41)) > 0 and var_566_0 < var_566_4 then
					arg_563_1.talkMaxDuration = var_566_4

					if var_566_4 + 0 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_4 + 0
					end
				end

				arg_563_1.text_.text = var_566_2
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906138", "story_v_side_new_1104906.awb") ~= 0 then
					local var_566_5 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906138", "story_v_side_new_1104906.awb") / 1000

					if var_566_5 + 0 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_5 + 0
					end

					if var_566_1.prefab_name ~= "" and arg_563_1.actors_[var_566_1.prefab_name] ~= nil then
						local var_566_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_1.prefab_name].transform, "story_v_side_new_1104906", "1104906138", "story_v_side_new_1104906.awb")

						arg_563_1:RecordAudio("1104906138", var_566_6)
						arg_563_1:RecordAudio("1104906138", var_566_6)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906138", "story_v_side_new_1104906.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906138", "story_v_side_new_1104906.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_7 = math.max(var_566_0, arg_563_1.talkMaxDuration)

			if 0 <= arg_563_1.time_ and arg_563_1.time_ < 0 + var_566_7 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - 0) / var_566_7

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= 0 + var_566_7 and arg_563_1.time_ < 0 + var_566_7 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play1104906139 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 1104906139
		arg_567_1.duration_ = 5

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play1104906140(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 and not isNil(arg_567_1.actors_["1049ui_story"]) and arg_567_1.var_.characterEffect1049ui_story == nil then
				arg_567_1.var_.characterEffect1049ui_story = arg_567_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_570_0 = 0.200000002980232

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_0 and not isNil(arg_567_1.actors_["1049ui_story"]) then
				if arg_567_1.var_.characterEffect1049ui_story and not isNil(arg_567_1.actors_["1049ui_story"]) then
					arg_567_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_567_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_567_1.time_ - 0) / var_570_0)
				end
			end

			if arg_567_1.time_ >= 0 + var_570_0 and arg_567_1.time_ < 0 + var_570_0 + arg_570_0 and not isNil(arg_567_1.actors_["1049ui_story"]) and arg_567_1.var_.characterEffect1049ui_story then
				arg_567_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_567_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_570_1 = 0
			local var_570_2 = 1.025

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_1 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				arg_567_1.leftNameTxt_.text = arg_567_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, true)
				arg_567_1.iconController_:SetSelectedState("hero")

				arg_567_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_567_1.callingController_:SetSelectedState("normal")

				arg_567_1.keyicon_.color = Color.New(1, 1, 1)
				arg_567_1.icon_.color = Color.New(1, 1, 1)

				local var_570_3 = arg_567_1:FormatText(arg_567_1:GetWordFromCfg(1104906139).content)

				arg_567_1.text_.text = var_570_3

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_5 = 41 <= 0 and var_570_2 or var_570_2 * (utf8.len(var_570_3) / 41)

				if (41 <= 0 and var_570_2 or var_570_2 * (utf8.len(var_570_3) / 41)) > 0 and var_570_2 < var_570_5 then
					arg_567_1.talkMaxDuration = var_570_5

					if var_570_5 + var_570_1 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_5 + var_570_1
					end
				end

				arg_567_1.text_.text = var_570_3
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_6 = math.max(var_570_2, arg_567_1.talkMaxDuration)

			if var_570_1 <= arg_567_1.time_ and arg_567_1.time_ < var_570_1 + var_570_6 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_1) / var_570_6

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_1 + var_570_6 and arg_567_1.time_ < var_570_1 + var_570_6 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play1104906140 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 1104906140
		arg_571_1.duration_ = 4.5

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play1104906141(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 and not isNil(arg_571_1.actors_["1049ui_story"]) and arg_571_1.var_.characterEffect1049ui_story == nil then
				arg_571_1.var_.characterEffect1049ui_story = arg_571_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_574_0 = 0.200000002980232

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_0 and not isNil(arg_571_1.actors_["1049ui_story"]) then
				if arg_571_1.var_.characterEffect1049ui_story and not isNil(arg_571_1.actors_["1049ui_story"]) then
					arg_571_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_571_1.time_ >= 0 + var_574_0 and arg_571_1.time_ < 0 + var_574_0 + arg_574_0 and not isNil(arg_571_1.actors_["1049ui_story"]) and arg_571_1.var_.characterEffect1049ui_story then
				arg_571_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_574_2 = 0
			local var_574_3 = 0.475

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_2 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				arg_571_1.leftNameTxt_.text = arg_571_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_4 = arg_571_1:GetWordFromCfg(1104906140)
				local var_574_5 = arg_571_1:FormatText(var_574_4.content)

				arg_571_1.text_.text = var_574_5

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_7 = 19 <= 0 and var_574_3 or var_574_3 * (utf8.len(var_574_5) / 19)

				if (19 <= 0 and var_574_3 or var_574_3 * (utf8.len(var_574_5) / 19)) > 0 and var_574_3 < var_574_7 then
					arg_571_1.talkMaxDuration = var_574_7

					if var_574_7 + var_574_2 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_7 + var_574_2
					end
				end

				arg_571_1.text_.text = var_574_5
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906140", "story_v_side_new_1104906.awb") ~= 0 then
					local var_574_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906140", "story_v_side_new_1104906.awb") / 1000

					if var_574_8 + var_574_2 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_8 + var_574_2
					end

					if var_574_4.prefab_name ~= "" and arg_571_1.actors_[var_574_4.prefab_name] ~= nil then
						local var_574_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_571_1.actors_[var_574_4.prefab_name].transform, "story_v_side_new_1104906", "1104906140", "story_v_side_new_1104906.awb")

						arg_571_1:RecordAudio("1104906140", var_574_9)
						arg_571_1:RecordAudio("1104906140", var_574_9)
					else
						arg_571_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906140", "story_v_side_new_1104906.awb")
					end

					arg_571_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906140", "story_v_side_new_1104906.awb")
				end

				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_10 = math.max(var_574_3, arg_571_1.talkMaxDuration)

			if var_574_2 <= arg_571_1.time_ and arg_571_1.time_ < var_574_2 + var_574_10 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_2) / var_574_10

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_2 + var_574_10 and arg_571_1.time_ < var_574_2 + var_574_10 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play1104906141 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 1104906141
		arg_575_1.duration_ = 5.23

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play1104906142(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = 0.4

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				arg_575_1.leftNameTxt_.text = arg_575_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_1 = arg_575_1:GetWordFromCfg(1104906141)
				local var_578_2 = arg_575_1:FormatText(var_578_1.content)

				arg_575_1.text_.text = var_578_2

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_4 = 16 <= 0 and var_578_0 or var_578_0 * (utf8.len(var_578_2) / 16)

				if (16 <= 0 and var_578_0 or var_578_0 * (utf8.len(var_578_2) / 16)) > 0 and var_578_0 < var_578_4 then
					arg_575_1.talkMaxDuration = var_578_4

					if var_578_4 + 0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_4 + 0
					end
				end

				arg_575_1.text_.text = var_578_2
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906141", "story_v_side_new_1104906.awb") ~= 0 then
					local var_578_5 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906141", "story_v_side_new_1104906.awb") / 1000

					if var_578_5 + 0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_5 + 0
					end

					if var_578_1.prefab_name ~= "" and arg_575_1.actors_[var_578_1.prefab_name] ~= nil then
						local var_578_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_1.prefab_name].transform, "story_v_side_new_1104906", "1104906141", "story_v_side_new_1104906.awb")

						arg_575_1:RecordAudio("1104906141", var_578_6)
						arg_575_1:RecordAudio("1104906141", var_578_6)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906141", "story_v_side_new_1104906.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906141", "story_v_side_new_1104906.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_7 = math.max(var_578_0, arg_575_1.talkMaxDuration)

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_7 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - 0) / var_578_7

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= 0 + var_578_7 and arg_575_1.time_ < 0 + var_578_7 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play1104906142 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 1104906142
		arg_579_1.duration_ = 7.15

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play1104906143(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			if arg_579_1.bgs_.R4902a == nil then
				local var_582_0 = Object.Instantiate(arg_579_1.paintGo_)

				var_582_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R4902a")
				var_582_0.name = "R4902a"
				var_582_0.transform.parent = arg_579_1.stage_.transform
				var_582_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_579_1.bgs_.R4902a = var_582_0
			end

			if 1 < arg_579_1.time_ and arg_579_1.time_ <= 1 + arg_582_0 then
				local var_582_1 = arg_579_1.bgs_.R4902a

				arg_579_1.bgs_.R4902a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_582_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_582_2 = var_582_1:GetComponent("SpriteRenderer")

				if var_582_2 and var_582_2.sprite then
					local var_582_3 = 2 * (var_582_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_582_1.transform.localScale = Vector3.New(var_582_3 / var_582_2.sprite.bounds.size.y < var_582_3 * manager.ui.mainCameraCom_.aspect / var_582_2.sprite.bounds.size.x and var_582_3 * manager.ui.mainCameraCom_.aspect / var_582_2.sprite.bounds.size.x or var_582_3 / var_582_2.sprite.bounds.size.y, var_582_3 / var_582_2.sprite.bounds.size.y < var_582_3 * manager.ui.mainCameraCom_.aspect / var_582_2.sprite.bounds.size.x and var_582_3 * manager.ui.mainCameraCom_.aspect / var_582_2.sprite.bounds.size.x or var_582_3 / var_582_2.sprite.bounds.size.y, 0)
				end

				for iter_582_0, iter_582_1 in pairs(arg_579_1.bgs_) do
					if iter_582_0 ~= "R4902a" then
						iter_582_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_582_4 = 1.999999999999

			if 1.999999999999 < arg_579_1.time_ and arg_579_1.time_ <= var_582_4 + arg_582_0 then
				arg_579_1.allBtn_.enabled = false
			end

			if arg_579_1.time_ >= var_582_4 + 2.51666666666767 and arg_579_1.time_ < var_582_4 + 2.51666666666767 + arg_582_0 then
				arg_579_1.allBtn_.enabled = true
			end

			local var_582_5 = 0

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_5 + arg_582_0 then
				arg_579_1.mask_.enabled = true
				arg_579_1.mask_.raycastTarget = true

				arg_579_1:SetGaussion(false)
			end

			local var_582_6 = 1

			if var_582_5 <= arg_579_1.time_ and arg_579_1.time_ < var_582_5 + var_582_6 then
				local var_582_7 = Color.New(1, 1, 1)

				var_582_7.a = Mathf.Lerp(0, 1, (arg_579_1.time_ - var_582_5) / var_582_6)
				arg_579_1.mask_.color = var_582_7
			end

			if arg_579_1.time_ >= var_582_5 + var_582_6 and arg_579_1.time_ < var_582_5 + var_582_6 + arg_582_0 then
				local var_582_8 = Color.New(1, 1, 1)

				var_582_8.a = 1
				arg_579_1.mask_.color = var_582_8
			end

			local var_582_9 = 1

			if 1 < arg_579_1.time_ and arg_579_1.time_ <= var_582_9 + arg_582_0 then
				arg_579_1.mask_.enabled = true
				arg_579_1.mask_.raycastTarget = true

				arg_579_1:SetGaussion(false)
			end

			local var_582_10 = 1

			if var_582_9 <= arg_579_1.time_ and arg_579_1.time_ < var_582_9 + var_582_10 then
				local var_582_11 = Color.New(1, 1, 1)

				var_582_11.a = Mathf.Lerp(1, 0, (arg_579_1.time_ - var_582_9) / var_582_10)
				arg_579_1.mask_.color = var_582_11
			end

			if arg_579_1.time_ >= var_582_9 + var_582_10 and arg_579_1.time_ < var_582_9 + var_582_10 + arg_582_0 then
				local var_582_12 = Color.New(1, 1, 1)

				arg_579_1.mask_.enabled = false
				var_582_12.a = 0
				arg_579_1.mask_.color = var_582_12
			end

			local var_582_13 = arg_579_1.bgs_.R4902a.transform

			if 1 < arg_579_1.time_ and arg_579_1.time_ <= 1 + arg_582_0 then
				arg_579_1.var_.moveOldPosR4902a = var_582_13.localPosition
			end

			local var_582_14 = 0.001

			if 1 <= arg_579_1.time_ and arg_579_1.time_ < 1 + var_582_14 then
				var_582_13.localPosition = Vector3.Lerp(arg_579_1.var_.moveOldPosR4902a, Vector3.New(0, 1, 9.5), (arg_579_1.time_ - 1) / var_582_14)
			end

			if arg_579_1.time_ >= 1 + var_582_14 and arg_579_1.time_ < 1 + var_582_14 + arg_582_0 then
				var_582_13.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_582_15 = arg_579_1.bgs_.R4902a.transform

			if 1.01666666666667 < arg_579_1.time_ and arg_579_1.time_ <= 1.01666666666667 + arg_582_0 then
				arg_579_1.var_.moveOldPosR4902a = var_582_15.localPosition
			end

			local var_582_16 = 3.5

			if 1.01666666666667 <= arg_579_1.time_ and arg_579_1.time_ < 1.01666666666667 + var_582_16 then
				var_582_15.localPosition = Vector3.Lerp(arg_579_1.var_.moveOldPosR4902a, Vector3.New(0, 1, 10), (arg_579_1.time_ - 1.01666666666667) / var_582_16)
			end

			if arg_579_1.time_ >= 1.01666666666667 + var_582_16 and arg_579_1.time_ < 1.01666666666667 + var_582_16 + arg_582_0 then
				var_582_15.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_579_1.frameCnt_ <= 1 then
				arg_579_1.dialog_:SetActive(false)
			end

			local var_582_17 = 2.15
			local var_582_18 = 0.85

			if 2.15 < arg_579_1.time_ and arg_579_1.time_ <= var_582_17 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0

				arg_579_1.dialog_:SetActive(true)

				arg_579_1.dialogCg_.alpha = 0

				local var_582_19 = LeanTween.value(arg_579_1.dialog_, 0, 1, 0.3)

				var_582_19:setOnUpdate(LuaHelper.FloatAction(function(arg_583_0)
					arg_579_1.dialogCg_.alpha = arg_583_0
				end))
				var_582_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_579_1.dialog_)
					var_582_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_579_1.duration_ = arg_579_1.duration_ + 0.3

				SetActive(arg_579_1.leftNameGo_, false)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_20 = arg_579_1:FormatText(arg_579_1:GetWordFromCfg(1104906142).content)

				arg_579_1.text_.text = var_582_20

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_22 = 34 <= 0 and var_582_18 or var_582_18 * (utf8.len(var_582_20) / 34)

				if (34 <= 0 and var_582_18 or var_582_18 * (utf8.len(var_582_20) / 34)) > 0 and var_582_18 < var_582_22 then
					arg_579_1.talkMaxDuration = var_582_22
					var_582_17 = var_582_17 + 0.3

					if var_582_22 + var_582_17 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_22 + var_582_17
					end
				end

				arg_579_1.text_.text = var_582_20
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)
				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_23 = var_582_17 + 0.3
			local var_582_24 = math.max(var_582_18, arg_579_1.talkMaxDuration)

			if var_582_17 + 0.3 <= arg_579_1.time_ and arg_579_1.time_ < var_582_23 + var_582_24 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_23) / var_582_24

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_23 + var_582_24 and arg_579_1.time_ < var_582_23 + var_582_24 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R4902a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R4902a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 1.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_579_1:InitPlayNodeList()
	end,
	Play1104906143 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 1104906143
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play1104906144(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = 0.4

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, false)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_1 = arg_585_1:FormatText(arg_585_1:GetWordFromCfg(1104906143).content)

				arg_585_1.text_.text = var_588_1

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_3 = 16 <= 0 and var_588_0 or var_588_0 * (utf8.len(var_588_1) / 16)

				if (16 <= 0 and var_588_0 or var_588_0 * (utf8.len(var_588_1) / 16)) > 0 and var_588_0 < var_588_3 then
					arg_585_1.talkMaxDuration = var_588_3

					if var_588_3 + 0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_3 + 0
					end
				end

				arg_585_1.text_.text = var_588_1
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_4 = math.max(var_588_0, arg_585_1.talkMaxDuration)

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_4 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - 0) / var_588_4

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= 0 + var_588_4 and arg_585_1.time_ < 0 + var_588_4 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play1104906144 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 1104906144
		arg_589_1.duration_ = 5

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play1104906145(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = 0.825

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				arg_589_1.leftNameTxt_.text = arg_589_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, true)
				arg_589_1.iconController_:SetSelectedState("hero")

				arg_589_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_589_1.callingController_:SetSelectedState("normal")

				arg_589_1.keyicon_.color = Color.New(1, 1, 1)
				arg_589_1.icon_.color = Color.New(1, 1, 1)

				local var_592_1 = arg_589_1:FormatText(arg_589_1:GetWordFromCfg(1104906144).content)

				arg_589_1.text_.text = var_592_1

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_3 = 33 <= 0 and var_592_0 or var_592_0 * (utf8.len(var_592_1) / 33)

				if (33 <= 0 and var_592_0 or var_592_0 * (utf8.len(var_592_1) / 33)) > 0 and var_592_0 < var_592_3 then
					arg_589_1.talkMaxDuration = var_592_3

					if var_592_3 + 0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_3 + 0
					end
				end

				arg_589_1.text_.text = var_592_1
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)
				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_4 = math.max(var_592_0, arg_589_1.talkMaxDuration)

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_4 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - 0) / var_592_4

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= 0 + var_592_4 and arg_589_1.time_ < 0 + var_592_4 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play1104906145 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 1104906145
		arg_593_1.duration_ = 1.73

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play1104906146(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 and not isNil(arg_593_1.actors_["1049ui_story"]) and arg_593_1.var_.characterEffect1049ui_story == nil then
				arg_593_1.var_.characterEffect1049ui_story = arg_593_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_596_0 = 0.200000002980232

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_0 and not isNil(arg_593_1.actors_["1049ui_story"]) then
				if arg_593_1.var_.characterEffect1049ui_story and not isNil(arg_593_1.actors_["1049ui_story"]) then
					arg_593_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_593_1.time_ >= 0 + var_596_0 and arg_593_1.time_ < 0 + var_596_0 + arg_596_0 and not isNil(arg_593_1.actors_["1049ui_story"]) and arg_593_1.var_.characterEffect1049ui_story then
				arg_593_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_596_2 = 0
			local var_596_3 = 0.175

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= var_596_2 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				arg_593_1.leftNameTxt_.text = arg_593_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_4 = arg_593_1:GetWordFromCfg(1104906145)
				local var_596_5 = arg_593_1:FormatText(var_596_4.content)

				arg_593_1.text_.text = var_596_5

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_7 = 7 <= 0 and var_596_3 or var_596_3 * (utf8.len(var_596_5) / 7)

				if (7 <= 0 and var_596_3 or var_596_3 * (utf8.len(var_596_5) / 7)) > 0 and var_596_3 < var_596_7 then
					arg_593_1.talkMaxDuration = var_596_7

					if var_596_7 + var_596_2 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_7 + var_596_2
					end
				end

				arg_593_1.text_.text = var_596_5
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906145", "story_v_side_new_1104906.awb") ~= 0 then
					local var_596_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906145", "story_v_side_new_1104906.awb") / 1000

					if var_596_8 + var_596_2 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_8 + var_596_2
					end

					if var_596_4.prefab_name ~= "" and arg_593_1.actors_[var_596_4.prefab_name] ~= nil then
						local var_596_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_593_1.actors_[var_596_4.prefab_name].transform, "story_v_side_new_1104906", "1104906145", "story_v_side_new_1104906.awb")

						arg_593_1:RecordAudio("1104906145", var_596_9)
						arg_593_1:RecordAudio("1104906145", var_596_9)
					else
						arg_593_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906145", "story_v_side_new_1104906.awb")
					end

					arg_593_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906145", "story_v_side_new_1104906.awb")
				end

				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_10 = math.max(var_596_3, arg_593_1.talkMaxDuration)

			if var_596_2 <= arg_593_1.time_ and arg_593_1.time_ < var_596_2 + var_596_10 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_2) / var_596_10

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_2 + var_596_10 and arg_593_1.time_ < var_596_2 + var_596_10 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play1104906146 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 1104906146
		arg_597_1.duration_ = 5

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play1104906147(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 and not isNil(arg_597_1.actors_["1049ui_story"]) and arg_597_1.var_.characterEffect1049ui_story == nil then
				arg_597_1.var_.characterEffect1049ui_story = arg_597_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_600_0 = 0.200000002980232

			if 0 <= arg_597_1.time_ and arg_597_1.time_ < 0 + var_600_0 and not isNil(arg_597_1.actors_["1049ui_story"]) then
				if arg_597_1.var_.characterEffect1049ui_story and not isNil(arg_597_1.actors_["1049ui_story"]) then
					arg_597_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_597_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_597_1.time_ - 0) / var_600_0)
				end
			end

			if arg_597_1.time_ >= 0 + var_600_0 and arg_597_1.time_ < 0 + var_600_0 + arg_600_0 and not isNil(arg_597_1.actors_["1049ui_story"]) and arg_597_1.var_.characterEffect1049ui_story then
				arg_597_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_597_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_600_1 = 0
			local var_600_2 = 1.075

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_1 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, false)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_3 = arg_597_1:FormatText(arg_597_1:GetWordFromCfg(1104906146).content)

				arg_597_1.text_.text = var_600_3

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_5 = 43 <= 0 and var_600_2 or var_600_2 * (utf8.len(var_600_3) / 43)

				if (43 <= 0 and var_600_2 or var_600_2 * (utf8.len(var_600_3) / 43)) > 0 and var_600_2 < var_600_5 then
					arg_597_1.talkMaxDuration = var_600_5

					if var_600_5 + var_600_1 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_5 + var_600_1
					end
				end

				arg_597_1.text_.text = var_600_3
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)
				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_6 = math.max(var_600_2, arg_597_1.talkMaxDuration)

			if var_600_1 <= arg_597_1.time_ and arg_597_1.time_ < var_600_1 + var_600_6 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_1) / var_600_6

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_1 + var_600_6 and arg_597_1.time_ < var_600_1 + var_600_6 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play1104906147 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 1104906147
		arg_601_1.duration_ = 7.77

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play1104906148(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 and not isNil(arg_601_1.actors_["1049ui_story"]) and arg_601_1.var_.characterEffect1049ui_story == nil then
				arg_601_1.var_.characterEffect1049ui_story = arg_601_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_604_0 = 0.200000002980232

			if 0 <= arg_601_1.time_ and arg_601_1.time_ < 0 + var_604_0 and not isNil(arg_601_1.actors_["1049ui_story"]) then
				if arg_601_1.var_.characterEffect1049ui_story and not isNil(arg_601_1.actors_["1049ui_story"]) then
					arg_601_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_601_1.time_ >= 0 + var_604_0 and arg_601_1.time_ < 0 + var_604_0 + arg_604_0 and not isNil(arg_601_1.actors_["1049ui_story"]) and arg_601_1.var_.characterEffect1049ui_story then
				arg_601_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_604_2 = 0
			local var_604_3 = 0.55

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= var_604_2 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				arg_601_1.leftNameTxt_.text = arg_601_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, false)
				arg_601_1.callingController_:SetSelectedState("normal")

				local var_604_4 = arg_601_1:GetWordFromCfg(1104906147)
				local var_604_5 = arg_601_1:FormatText(var_604_4.content)

				arg_601_1.text_.text = var_604_5

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_7 = 22 <= 0 and var_604_3 or var_604_3 * (utf8.len(var_604_5) / 22)

				if (22 <= 0 and var_604_3 or var_604_3 * (utf8.len(var_604_5) / 22)) > 0 and var_604_3 < var_604_7 then
					arg_601_1.talkMaxDuration = var_604_7

					if var_604_7 + var_604_2 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_7 + var_604_2
					end
				end

				arg_601_1.text_.text = var_604_5
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906147", "story_v_side_new_1104906.awb") ~= 0 then
					local var_604_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906147", "story_v_side_new_1104906.awb") / 1000

					if var_604_8 + var_604_2 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_8 + var_604_2
					end

					if var_604_4.prefab_name ~= "" and arg_601_1.actors_[var_604_4.prefab_name] ~= nil then
						local var_604_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_601_1.actors_[var_604_4.prefab_name].transform, "story_v_side_new_1104906", "1104906147", "story_v_side_new_1104906.awb")

						arg_601_1:RecordAudio("1104906147", var_604_9)
						arg_601_1:RecordAudio("1104906147", var_604_9)
					else
						arg_601_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906147", "story_v_side_new_1104906.awb")
					end

					arg_601_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906147", "story_v_side_new_1104906.awb")
				end

				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_10 = math.max(var_604_3, arg_601_1.talkMaxDuration)

			if var_604_2 <= arg_601_1.time_ and arg_601_1.time_ < var_604_2 + var_604_10 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_2) / var_604_10

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_2 + var_604_10 and arg_601_1.time_ < var_604_2 + var_604_10 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play1104906148 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 1104906148
		arg_605_1.duration_ = 4.4

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play1104906149(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = 0.225

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				arg_605_1.leftNameTxt_.text = arg_605_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_1 = arg_605_1:GetWordFromCfg(1104906148)
				local var_608_2 = arg_605_1:FormatText(var_608_1.content)

				arg_605_1.text_.text = var_608_2

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_4 = 9 <= 0 and var_608_0 or var_608_0 * (utf8.len(var_608_2) / 9)

				if (9 <= 0 and var_608_0 or var_608_0 * (utf8.len(var_608_2) / 9)) > 0 and var_608_0 < var_608_4 then
					arg_605_1.talkMaxDuration = var_608_4

					if var_608_4 + 0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_4 + 0
					end
				end

				arg_605_1.text_.text = var_608_2
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906148", "story_v_side_new_1104906.awb") ~= 0 then
					local var_608_5 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906148", "story_v_side_new_1104906.awb") / 1000

					if var_608_5 + 0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_5 + 0
					end

					if var_608_1.prefab_name ~= "" and arg_605_1.actors_[var_608_1.prefab_name] ~= nil then
						local var_608_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_605_1.actors_[var_608_1.prefab_name].transform, "story_v_side_new_1104906", "1104906148", "story_v_side_new_1104906.awb")

						arg_605_1:RecordAudio("1104906148", var_608_6)
						arg_605_1:RecordAudio("1104906148", var_608_6)
					else
						arg_605_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906148", "story_v_side_new_1104906.awb")
					end

					arg_605_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906148", "story_v_side_new_1104906.awb")
				end

				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_7 = math.max(var_608_0, arg_605_1.talkMaxDuration)

			if 0 <= arg_605_1.time_ and arg_605_1.time_ < 0 + var_608_7 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - 0) / var_608_7

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= 0 + var_608_7 and arg_605_1.time_ < 0 + var_608_7 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play1104906149 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 1104906149
		arg_609_1.duration_ = 8

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play1104906150(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			if 1.5 < arg_609_1.time_ and arg_609_1.time_ <= 1.5 + arg_612_0 then
				local var_612_0 = arg_609_1.bgs_.STblack

				arg_609_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_612_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_612_1 = var_612_0:GetComponent("SpriteRenderer")

				if var_612_1 and var_612_1.sprite then
					local var_612_2 = 2 * (var_612_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_612_0.transform.localScale = Vector3.New(var_612_2 / var_612_1.sprite.bounds.size.y < var_612_2 * manager.ui.mainCameraCom_.aspect / var_612_1.sprite.bounds.size.x and var_612_2 * manager.ui.mainCameraCom_.aspect / var_612_1.sprite.bounds.size.x or var_612_2 / var_612_1.sprite.bounds.size.y, var_612_2 / var_612_1.sprite.bounds.size.y < var_612_2 * manager.ui.mainCameraCom_.aspect / var_612_1.sprite.bounds.size.x and var_612_2 * manager.ui.mainCameraCom_.aspect / var_612_1.sprite.bounds.size.x or var_612_2 / var_612_1.sprite.bounds.size.y, 0)
				end

				for iter_612_0, iter_612_1 in pairs(arg_609_1.bgs_) do
					if iter_612_0 ~= "STblack" then
						iter_612_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_612_3 = arg_609_1.actors_["1049ui_story"]

			if 2.999999999999 < arg_609_1.time_ and arg_609_1.time_ <= 2.999999999999 + arg_612_0 and not isNil(var_612_3) and arg_609_1.var_.characterEffect1049ui_story == nil then
				arg_609_1.var_.characterEffect1049ui_story = var_612_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_612_4 = 0.200000002980232

			if 2.999999999999 <= arg_609_1.time_ and arg_609_1.time_ < 2.999999999999 + var_612_4 and not isNil(var_612_3) then
				if arg_609_1.var_.characterEffect1049ui_story and not isNil(var_612_3) then
					arg_609_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_609_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_609_1.time_ - 2.999999999999) / var_612_4)
				end
			end

			if arg_609_1.time_ >= 2.999999999999 + var_612_4 and arg_609_1.time_ < 2.999999999999 + var_612_4 + arg_612_0 and not isNil(var_612_3) and arg_609_1.var_.characterEffect1049ui_story then
				arg_609_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_609_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_612_5 = 0

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= var_612_5 + arg_612_0 then
				arg_609_1.mask_.enabled = true
				arg_609_1.mask_.raycastTarget = true

				arg_609_1:SetGaussion(false)
			end

			local var_612_6 = 1.5

			if var_612_5 <= arg_609_1.time_ and arg_609_1.time_ < var_612_5 + var_612_6 then
				local var_612_7 = Color.New(0, 0, 0)

				var_612_7.a = Mathf.Lerp(0, 1, (arg_609_1.time_ - var_612_5) / var_612_6)
				arg_609_1.mask_.color = var_612_7
			end

			if arg_609_1.time_ >= var_612_5 + var_612_6 and arg_609_1.time_ < var_612_5 + var_612_6 + arg_612_0 then
				local var_612_8 = Color.New(0, 0, 0)

				var_612_8.a = 1
				arg_609_1.mask_.color = var_612_8
			end

			local var_612_9 = 1.5

			if 1.5 < arg_609_1.time_ and arg_609_1.time_ <= var_612_9 + arg_612_0 then
				arg_609_1.mask_.enabled = true
				arg_609_1.mask_.raycastTarget = true

				arg_609_1:SetGaussion(false)
			end

			local var_612_10 = 1.5

			if var_612_9 <= arg_609_1.time_ and arg_609_1.time_ < var_612_9 + var_612_10 then
				local var_612_11 = Color.New(0, 0, 0)

				var_612_11.a = Mathf.Lerp(1, 0, (arg_609_1.time_ - var_612_9) / var_612_10)
				arg_609_1.mask_.color = var_612_11
			end

			if arg_609_1.time_ >= var_612_9 + var_612_10 and arg_609_1.time_ < var_612_9 + var_612_10 + arg_612_0 then
				local var_612_12 = Color.New(0, 0, 0)

				arg_609_1.mask_.enabled = false
				var_612_12.a = 0
				arg_609_1.mask_.color = var_612_12
			end

			local var_612_13 = 3
			local var_612_14 = 0.5

			if 3 < arg_609_1.time_ and arg_609_1.time_ <= var_612_13 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, false)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_15 = arg_609_1:FormatText(arg_609_1:GetWordFromCfg(1104906149).content)

				arg_609_1.text_.text = var_612_15

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_17 = 20 <= 0 and var_612_14 or var_612_14 * (utf8.len(var_612_15) / 20)

				if (20 <= 0 and var_612_14 or var_612_14 * (utf8.len(var_612_15) / 20)) > 0 and var_612_14 < var_612_17 then
					arg_609_1.talkMaxDuration = var_612_17

					if var_612_17 + var_612_13 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_17 + var_612_13
					end
				end

				arg_609_1.text_.text = var_612_15
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)
				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_18 = math.max(var_612_14, arg_609_1.talkMaxDuration)

			if var_612_13 <= arg_609_1.time_ and arg_609_1.time_ < var_612_13 + var_612_18 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_13) / var_612_18

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_13 + var_612_18 and arg_609_1.time_ < var_612_13 + var_612_18 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {}

		arg_609_1:InitPlayNodeList()
	end,
	Play1104906150 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 1104906150
		arg_613_1.duration_ = 7

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play1104906151(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			if arg_613_1.bgs_.K11g == nil then
				local var_616_0 = Object.Instantiate(arg_613_1.paintGo_)

				var_616_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K11g")
				var_616_0.name = "K11g"
				var_616_0.transform.parent = arg_613_1.stage_.transform
				var_616_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_613_1.bgs_.K11g = var_616_0
			end

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 then
				local var_616_1 = arg_613_1.bgs_.K11g

				arg_613_1.bgs_.K11g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_616_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_616_2 = var_616_1:GetComponent("SpriteRenderer")

				if var_616_2 and var_616_2.sprite then
					local var_616_3 = 2 * (var_616_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_616_1.transform.localScale = Vector3.New(var_616_3 / var_616_2.sprite.bounds.size.y < var_616_3 * manager.ui.mainCameraCom_.aspect / var_616_2.sprite.bounds.size.x and var_616_3 * manager.ui.mainCameraCom_.aspect / var_616_2.sprite.bounds.size.x or var_616_3 / var_616_2.sprite.bounds.size.y, var_616_3 / var_616_2.sprite.bounds.size.y < var_616_3 * manager.ui.mainCameraCom_.aspect / var_616_2.sprite.bounds.size.x and var_616_3 * manager.ui.mainCameraCom_.aspect / var_616_2.sprite.bounds.size.x or var_616_3 / var_616_2.sprite.bounds.size.y, 0)
				end

				for iter_616_0, iter_616_1 in pairs(arg_613_1.bgs_) do
					if iter_616_0 ~= "K11g" then
						iter_616_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_616_4 = 2

			if 2 < arg_613_1.time_ and arg_613_1.time_ <= var_616_4 + arg_616_0 then
				arg_613_1.allBtn_.enabled = false
			end

			if arg_613_1.time_ >= var_616_4 + 0.275 and arg_613_1.time_ < var_616_4 + 0.275 + arg_616_0 then
				arg_613_1.allBtn_.enabled = true
			end

			local var_616_5 = 0

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= var_616_5 + arg_616_0 then
				arg_613_1.mask_.enabled = true
				arg_613_1.mask_.raycastTarget = true

				arg_613_1:SetGaussion(false)
			end

			local var_616_6 = 2

			if var_616_5 <= arg_613_1.time_ and arg_613_1.time_ < var_616_5 + var_616_6 then
				local var_616_7 = Color.New(0, 0, 0)

				var_616_7.a = Mathf.Lerp(1, 0, (arg_613_1.time_ - var_616_5) / var_616_6)
				arg_613_1.mask_.color = var_616_7
			end

			if arg_613_1.time_ >= var_616_5 + var_616_6 and arg_613_1.time_ < var_616_5 + var_616_6 + arg_616_0 then
				local var_616_8 = Color.New(0, 0, 0)

				arg_613_1.mask_.enabled = false
				var_616_8.a = 0
				arg_613_1.mask_.color = var_616_8
			end

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 then
				arg_613_1:AudioAction("stop", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 then
				arg_613_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_amb_wind_leaves", "")
			end

			if arg_613_1.frameCnt_ <= 1 then
				arg_613_1.dialog_:SetActive(false)
			end

			local var_616_11 = 1.999999999999
			local var_616_12 = 0.275

			if 1.999999999999 < arg_613_1.time_ and arg_613_1.time_ <= var_616_11 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0

				arg_613_1.dialog_:SetActive(true)

				arg_613_1.dialogCg_.alpha = 0

				local var_616_13 = LeanTween.value(arg_613_1.dialog_, 0, 1, 0.3)

				var_616_13:setOnUpdate(LuaHelper.FloatAction(function(arg_617_0)
					arg_613_1.dialogCg_.alpha = arg_617_0
				end))
				var_616_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_613_1.dialog_)
					var_616_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_613_1.duration_ = arg_613_1.duration_ + 0.3

				SetActive(arg_613_1.leftNameGo_, false)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_613_1.iconTrs_.gameObject, false)
				arg_613_1.callingController_:SetSelectedState("normal")

				local var_616_14 = arg_613_1:FormatText(arg_613_1:GetWordFromCfg(1104906150).content)

				arg_613_1.text_.text = var_616_14

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_16 = 11 <= 0 and var_616_12 or var_616_12 * (utf8.len(var_616_14) / 11)

				if (11 <= 0 and var_616_12 or var_616_12 * (utf8.len(var_616_14) / 11)) > 0 and var_616_12 < var_616_16 then
					arg_613_1.talkMaxDuration = var_616_16
					var_616_11 = var_616_11 + 0.3

					if var_616_16 + var_616_11 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_16 + var_616_11
					end
				end

				arg_613_1.text_.text = var_616_14
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)
				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_17 = var_616_11 + 0.3
			local var_616_18 = math.max(var_616_12, arg_613_1.talkMaxDuration)

			if var_616_11 + 0.3 <= arg_613_1.time_ and arg_613_1.time_ < var_616_17 + var_616_18 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_17) / var_616_18

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_17 + var_616_18 and arg_613_1.time_ < var_616_17 + var_616_18 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play1104906151 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 1104906151
		arg_619_1.duration_ = 5

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play1104906152(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			local var_622_0 = 1.475

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, false)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_619_1.iconTrs_.gameObject, false)
				arg_619_1.callingController_:SetSelectedState("normal")

				local var_622_1 = arg_619_1:FormatText(arg_619_1:GetWordFromCfg(1104906151).content)

				arg_619_1.text_.text = var_622_1

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_3 = 59 <= 0 and var_622_0 or var_622_0 * (utf8.len(var_622_1) / 59)

				if (59 <= 0 and var_622_0 or var_622_0 * (utf8.len(var_622_1) / 59)) > 0 and var_622_0 < var_622_3 then
					arg_619_1.talkMaxDuration = var_622_3

					if var_622_3 + 0 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_3 + 0
					end
				end

				arg_619_1.text_.text = var_622_1
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)
				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_4 = math.max(var_622_0, arg_619_1.talkMaxDuration)

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_4 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - 0) / var_622_4

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= 0 + var_622_4 and arg_619_1.time_ < 0 + var_622_4 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {}

		arg_619_1:InitPlayNodeList()
	end,
	Play1104906152 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 1104906152
		arg_623_1.duration_ = 5

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play1104906153(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			if 1 < arg_623_1.time_ and arg_623_1.time_ <= 1 + arg_626_0 then
				arg_623_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_hold", "")
			end

			local var_626_1 = 0
			local var_626_2 = 1.25

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= var_626_1 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, false)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_3 = arg_623_1:FormatText(arg_623_1:GetWordFromCfg(1104906152).content)

				arg_623_1.text_.text = var_626_3

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_5 = 50 <= 0 and var_626_2 or var_626_2 * (utf8.len(var_626_3) / 50)

				if (50 <= 0 and var_626_2 or var_626_2 * (utf8.len(var_626_3) / 50)) > 0 and var_626_2 < var_626_5 then
					arg_623_1.talkMaxDuration = var_626_5

					if var_626_5 + var_626_1 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_5 + var_626_1
					end
				end

				arg_623_1.text_.text = var_626_3
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)
				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_6 = math.max(var_626_2, arg_623_1.talkMaxDuration)

			if var_626_1 <= arg_623_1.time_ and arg_623_1.time_ < var_626_1 + var_626_6 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_1) / var_626_6

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_1 + var_626_6 and arg_623_1.time_ < var_626_1 + var_626_6 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {}

		arg_623_1:InitPlayNodeList()
	end,
	Play1104906153 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 1104906153
		arg_627_1.duration_ = 3

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play1104906154(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 then
				arg_627_1.var_.moveOldPos1049ui_story = arg_627_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_630_0 = 0.001

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_0 then
				arg_627_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_627_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_627_1.time_ - 0) / var_630_0)
				arg_627_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_627_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_627_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_627_1.actors_["1049ui_story"].transform.position).z)
				arg_627_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_627_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_627_1.actors_["1049ui_story"].transform.localEulerAngles = arg_627_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_627_1.time_ >= 0 + var_630_0 and arg_627_1.time_ < 0 + var_630_0 + arg_630_0 then
				arg_627_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_627_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_627_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_627_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_627_1.actors_["1049ui_story"].transform.position).z)
				arg_627_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_627_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_627_1.actors_["1049ui_story"].transform.localEulerAngles = arg_627_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_630_1 = arg_627_1.actors_["1049ui_story"]

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 and not isNil(var_630_1) and arg_627_1.var_.characterEffect1049ui_story == nil then
				arg_627_1.var_.characterEffect1049ui_story = var_630_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_630_2 = 0.200000002980232

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_2 and not isNil(var_630_1) then
				if arg_627_1.var_.characterEffect1049ui_story and not isNil(var_630_1) then
					arg_627_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_627_1.time_ >= 0 + var_630_2 and arg_627_1.time_ < 0 + var_630_2 + arg_630_0 and not isNil(var_630_1) and arg_627_1.var_.characterEffect1049ui_story then
				arg_627_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 then
				arg_627_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 then
				arg_627_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_630_4 = 0
			local var_630_5 = 0.325

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= var_630_4 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				arg_627_1.leftNameTxt_.text = arg_627_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, false)
				arg_627_1.callingController_:SetSelectedState("normal")

				local var_630_6 = arg_627_1:GetWordFromCfg(1104906153)
				local var_630_7 = arg_627_1:FormatText(var_630_6.content)

				arg_627_1.text_.text = var_630_7

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_9 = 13 <= 0 and var_630_5 or var_630_5 * (utf8.len(var_630_7) / 13)

				if (13 <= 0 and var_630_5 or var_630_5 * (utf8.len(var_630_7) / 13)) > 0 and var_630_5 < var_630_9 then
					arg_627_1.talkMaxDuration = var_630_9

					if var_630_9 + var_630_4 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_9 + var_630_4
					end
				end

				arg_627_1.text_.text = var_630_7
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906153", "story_v_side_new_1104906.awb") ~= 0 then
					local var_630_10 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906153", "story_v_side_new_1104906.awb") / 1000

					if var_630_10 + var_630_4 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_10 + var_630_4
					end

					if var_630_6.prefab_name ~= "" and arg_627_1.actors_[var_630_6.prefab_name] ~= nil then
						local var_630_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_627_1.actors_[var_630_6.prefab_name].transform, "story_v_side_new_1104906", "1104906153", "story_v_side_new_1104906.awb")

						arg_627_1:RecordAudio("1104906153", var_630_11)
						arg_627_1:RecordAudio("1104906153", var_630_11)
					else
						arg_627_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906153", "story_v_side_new_1104906.awb")
					end

					arg_627_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906153", "story_v_side_new_1104906.awb")
				end

				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_12 = math.max(var_630_5, arg_627_1.talkMaxDuration)

			if var_630_4 <= arg_627_1.time_ and arg_627_1.time_ < var_630_4 + var_630_12 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_4) / var_630_12

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_4 + var_630_12 and arg_627_1.time_ < var_630_4 + var_630_12 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_627_1:InitPlayNodeList()
	end,
	Play1104906154 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 1104906154
		arg_631_1.duration_ = 5

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play1104906155(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 and not isNil(arg_631_1.actors_["1049ui_story"]) and arg_631_1.var_.characterEffect1049ui_story == nil then
				arg_631_1.var_.characterEffect1049ui_story = arg_631_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_634_0 = 0.200000002980232

			if 0 <= arg_631_1.time_ and arg_631_1.time_ < 0 + var_634_0 and not isNil(arg_631_1.actors_["1049ui_story"]) then
				if arg_631_1.var_.characterEffect1049ui_story and not isNil(arg_631_1.actors_["1049ui_story"]) then
					arg_631_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_631_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_631_1.time_ - 0) / var_634_0)
				end
			end

			if arg_631_1.time_ >= 0 + var_634_0 and arg_631_1.time_ < 0 + var_634_0 + arg_634_0 and not isNil(arg_631_1.actors_["1049ui_story"]) and arg_631_1.var_.characterEffect1049ui_story then
				arg_631_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_631_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_634_1 = 0
			local var_634_2 = 0.15

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= var_634_1 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				arg_631_1.leftNameTxt_.text = arg_631_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, true)
				arg_631_1.iconController_:SetSelectedState("hero")

				arg_631_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_631_1.callingController_:SetSelectedState("normal")

				arg_631_1.keyicon_.color = Color.New(1, 1, 1)
				arg_631_1.icon_.color = Color.New(1, 1, 1)

				local var_634_3 = arg_631_1:FormatText(arg_631_1:GetWordFromCfg(1104906154).content)

				arg_631_1.text_.text = var_634_3

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_5 = 6 <= 0 and var_634_2 or var_634_2 * (utf8.len(var_634_3) / 6)

				if (6 <= 0 and var_634_2 or var_634_2 * (utf8.len(var_634_3) / 6)) > 0 and var_634_2 < var_634_5 then
					arg_631_1.talkMaxDuration = var_634_5

					if var_634_5 + var_634_1 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_5 + var_634_1
					end
				end

				arg_631_1.text_.text = var_634_3
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)
				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_6 = math.max(var_634_2, arg_631_1.talkMaxDuration)

			if var_634_1 <= arg_631_1.time_ and arg_631_1.time_ < var_634_1 + var_634_6 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_1) / var_634_6

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_1 + var_634_6 and arg_631_1.time_ < var_634_1 + var_634_6 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play1104906155 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 1104906155
		arg_635_1.duration_ = 2.27

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play1104906156(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 and not isNil(arg_635_1.actors_["1049ui_story"]) and arg_635_1.var_.characterEffect1049ui_story == nil then
				arg_635_1.var_.characterEffect1049ui_story = arg_635_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_638_0 = 0.200000002980232

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_0 and not isNil(arg_635_1.actors_["1049ui_story"]) then
				if arg_635_1.var_.characterEffect1049ui_story and not isNil(arg_635_1.actors_["1049ui_story"]) then
					arg_635_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_635_1.time_ >= 0 + var_638_0 and arg_635_1.time_ < 0 + var_638_0 + arg_638_0 and not isNil(arg_635_1.actors_["1049ui_story"]) and arg_635_1.var_.characterEffect1049ui_story then
				arg_635_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_638_2 = 0
			local var_638_3 = 0.225

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= var_638_2 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, true)

				arg_635_1.leftNameTxt_.text = arg_635_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_635_1.leftNameTxt_.transform)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1.leftNameTxt_.text)
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_4 = arg_635_1:GetWordFromCfg(1104906155)
				local var_638_5 = arg_635_1:FormatText(var_638_4.content)

				arg_635_1.text_.text = var_638_5

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_7 = 9 <= 0 and var_638_3 or var_638_3 * (utf8.len(var_638_5) / 9)

				if (9 <= 0 and var_638_3 or var_638_3 * (utf8.len(var_638_5) / 9)) > 0 and var_638_3 < var_638_7 then
					arg_635_1.talkMaxDuration = var_638_7

					if var_638_7 + var_638_2 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_7 + var_638_2
					end
				end

				arg_635_1.text_.text = var_638_5
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906155", "story_v_side_new_1104906.awb") ~= 0 then
					local var_638_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906155", "story_v_side_new_1104906.awb") / 1000

					if var_638_8 + var_638_2 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_8 + var_638_2
					end

					if var_638_4.prefab_name ~= "" and arg_635_1.actors_[var_638_4.prefab_name] ~= nil then
						local var_638_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_635_1.actors_[var_638_4.prefab_name].transform, "story_v_side_new_1104906", "1104906155", "story_v_side_new_1104906.awb")

						arg_635_1:RecordAudio("1104906155", var_638_9)
						arg_635_1:RecordAudio("1104906155", var_638_9)
					else
						arg_635_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906155", "story_v_side_new_1104906.awb")
					end

					arg_635_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906155", "story_v_side_new_1104906.awb")
				end

				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_10 = math.max(var_638_3, arg_635_1.talkMaxDuration)

			if var_638_2 <= arg_635_1.time_ and arg_635_1.time_ < var_638_2 + var_638_10 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_2) / var_638_10

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_2 + var_638_10 and arg_635_1.time_ < var_638_2 + var_638_10 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play1104906156 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 1104906156
		arg_639_1.duration_ = 6.43

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play1104906157(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 then
				arg_639_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 then
				arg_639_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_642_0 = 0
			local var_642_1 = 0.675

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= var_642_0 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, true)

				arg_639_1.leftNameTxt_.text = arg_639_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_639_1.leftNameTxt_.transform)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1.leftNameTxt_.text)
				SetActive(arg_639_1.iconTrs_.gameObject, false)
				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_2 = arg_639_1:GetWordFromCfg(1104906156)
				local var_642_3 = arg_639_1:FormatText(var_642_2.content)

				arg_639_1.text_.text = var_642_3

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_5 = 27 <= 0 and var_642_1 or var_642_1 * (utf8.len(var_642_3) / 27)

				if (27 <= 0 and var_642_1 or var_642_1 * (utf8.len(var_642_3) / 27)) > 0 and var_642_1 < var_642_5 then
					arg_639_1.talkMaxDuration = var_642_5

					if var_642_5 + var_642_0 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_5 + var_642_0
					end
				end

				arg_639_1.text_.text = var_642_3
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906156", "story_v_side_new_1104906.awb") ~= 0 then
					local var_642_6 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906156", "story_v_side_new_1104906.awb") / 1000

					if var_642_6 + var_642_0 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_6 + var_642_0
					end

					if var_642_2.prefab_name ~= "" and arg_639_1.actors_[var_642_2.prefab_name] ~= nil then
						local var_642_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_639_1.actors_[var_642_2.prefab_name].transform, "story_v_side_new_1104906", "1104906156", "story_v_side_new_1104906.awb")

						arg_639_1:RecordAudio("1104906156", var_642_7)
						arg_639_1:RecordAudio("1104906156", var_642_7)
					else
						arg_639_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906156", "story_v_side_new_1104906.awb")
					end

					arg_639_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906156", "story_v_side_new_1104906.awb")
				end

				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_8 = math.max(var_642_1, arg_639_1.talkMaxDuration)

			if var_642_0 <= arg_639_1.time_ and arg_639_1.time_ < var_642_0 + var_642_8 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_0) / var_642_8

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_0 + var_642_8 and arg_639_1.time_ < var_642_0 + var_642_8 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {}

		arg_639_1:InitPlayNodeList()
	end,
	Play1104906157 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 1104906157
		arg_643_1.duration_ = 9.02

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play1104906158(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			if arg_643_1.bgs_.K01h == nil then
				local var_646_0 = Object.Instantiate(arg_643_1.paintGo_)

				var_646_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K01h")
				var_646_0.name = "K01h"
				var_646_0.transform.parent = arg_643_1.stage_.transform
				var_646_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_643_1.bgs_.K01h = var_646_0
			end

			if 2.01733333333333 < arg_643_1.time_ and arg_643_1.time_ <= 2.01733333333333 + arg_646_0 then
				local var_646_1 = arg_643_1.bgs_.K01h

				arg_643_1.bgs_.K01h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_646_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_646_2 = var_646_1:GetComponent("SpriteRenderer")

				if var_646_2 and var_646_2.sprite then
					local var_646_3 = 2 * (var_646_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_646_1.transform.localScale = Vector3.New(var_646_3 / var_646_2.sprite.bounds.size.y < var_646_3 * manager.ui.mainCameraCom_.aspect / var_646_2.sprite.bounds.size.x and var_646_3 * manager.ui.mainCameraCom_.aspect / var_646_2.sprite.bounds.size.x or var_646_3 / var_646_2.sprite.bounds.size.y, var_646_3 / var_646_2.sprite.bounds.size.y < var_646_3 * manager.ui.mainCameraCom_.aspect / var_646_2.sprite.bounds.size.x and var_646_3 * manager.ui.mainCameraCom_.aspect / var_646_2.sprite.bounds.size.x or var_646_3 / var_646_2.sprite.bounds.size.y, 0)
				end

				for iter_646_0, iter_646_1 in pairs(arg_643_1.bgs_) do
					if iter_646_0 ~= "K01h" then
						iter_646_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_646_4 = 3.999999999999

			if 3.999999999999 < arg_643_1.time_ and arg_643_1.time_ <= var_646_4 + arg_646_0 then
				arg_643_1.allBtn_.enabled = false
			end

			if arg_643_1.time_ >= var_646_4 + 0.3 and arg_643_1.time_ < var_646_4 + 0.3 + arg_646_0 then
				arg_643_1.allBtn_.enabled = true
			end

			local var_646_5 = 0

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= var_646_5 + arg_646_0 then
				arg_643_1.mask_.enabled = true
				arg_643_1.mask_.raycastTarget = true

				arg_643_1:SetGaussion(false)
			end

			local var_646_6 = 2

			if var_646_5 <= arg_643_1.time_ and arg_643_1.time_ < var_646_5 + var_646_6 then
				local var_646_7 = Color.New(0, 0, 0)

				var_646_7.a = Mathf.Lerp(0, 1, (arg_643_1.time_ - var_646_5) / var_646_6)
				arg_643_1.mask_.color = var_646_7
			end

			if arg_643_1.time_ >= var_646_5 + var_646_6 and arg_643_1.time_ < var_646_5 + var_646_6 + arg_646_0 then
				local var_646_8 = Color.New(0, 0, 0)

				var_646_8.a = 1
				arg_643_1.mask_.color = var_646_8
			end

			local var_646_9 = 2

			if 2 < arg_643_1.time_ and arg_643_1.time_ <= var_646_9 + arg_646_0 then
				arg_643_1.mask_.enabled = true
				arg_643_1.mask_.raycastTarget = true

				arg_643_1:SetGaussion(false)
			end

			local var_646_10 = 2

			if var_646_9 <= arg_643_1.time_ and arg_643_1.time_ < var_646_9 + var_646_10 then
				local var_646_11 = Color.New(0, 0, 0)

				var_646_11.a = Mathf.Lerp(1, 0, (arg_643_1.time_ - var_646_9) / var_646_10)
				arg_643_1.mask_.color = var_646_11
			end

			if arg_643_1.time_ >= var_646_9 + var_646_10 and arg_643_1.time_ < var_646_9 + var_646_10 + arg_646_0 then
				local var_646_12 = Color.New(0, 0, 0)

				arg_643_1.mask_.enabled = false
				var_646_12.a = 0
				arg_643_1.mask_.color = var_646_12
			end

			local var_646_13 = arg_643_1.actors_["1049ui_story"]

			if 1.98333333333333 < arg_643_1.time_ and arg_643_1.time_ <= 1.98333333333333 + arg_646_0 and not isNil(var_646_13) and arg_643_1.var_.characterEffect1049ui_story == nil then
				arg_643_1.var_.characterEffect1049ui_story = var_646_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_646_14 = 0.0166666666666666

			if 1.98333333333333 <= arg_643_1.time_ and arg_643_1.time_ < 1.98333333333333 + var_646_14 and not isNil(var_646_13) then
				if arg_643_1.var_.characterEffect1049ui_story and not isNil(var_646_13) then
					arg_643_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_643_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_643_1.time_ - 1.98333333333333) / var_646_14)
				end
			end

			if arg_643_1.time_ >= 1.98333333333333 + var_646_14 and arg_643_1.time_ < 1.98333333333333 + var_646_14 + arg_646_0 and not isNil(var_646_13) and arg_643_1.var_.characterEffect1049ui_story then
				arg_643_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_643_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_646_15 = arg_643_1.actors_["1049ui_story"].transform

			if 1.98333333333333 < arg_643_1.time_ and arg_643_1.time_ <= 1.98333333333333 + arg_646_0 then
				arg_643_1.var_.moveOldPos1049ui_story = var_646_15.localPosition
			end

			local var_646_16 = 0.001

			if 1.98333333333333 <= arg_643_1.time_ and arg_643_1.time_ < 1.98333333333333 + var_646_16 then
				var_646_15.localPosition = Vector3.Lerp(arg_643_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_643_1.time_ - 1.98333333333333) / var_646_16)
				var_646_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_646_15.position).x, (manager.ui.mainCamera.transform.position - var_646_15.position).y, (manager.ui.mainCamera.transform.position - var_646_15.position).z)
				var_646_15.localEulerAngles.z = 0
				var_646_15.localEulerAngles.x = 0
				var_646_15.localEulerAngles = var_646_15.localEulerAngles
			end

			if arg_643_1.time_ >= 1.98333333333333 + var_646_16 and arg_643_1.time_ < 1.98333333333333 + var_646_16 + arg_646_0 then
				var_646_15.localPosition = Vector3.New(0, 100, 0)
				var_646_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_646_15.position).x, (manager.ui.mainCamera.transform.position - var_646_15.position).y, (manager.ui.mainCamera.transform.position - var_646_15.position).z)
				var_646_15.localEulerAngles.z = 0
				var_646_15.localEulerAngles.x = 0
				var_646_15.localEulerAngles = var_646_15.localEulerAngles
			end

			if 0.466666666666667 < arg_643_1.time_ and arg_643_1.time_ <= 0.466666666666667 + arg_646_0 then
				arg_643_1:AudioAction("stop", "effect", "se_story_side_1049", "se_story_side_1049_amb_wind_leaves", "")
			end

			if 1.7 < arg_643_1.time_ and arg_643_1.time_ <= 1.7 + arg_646_0 then
				arg_643_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_valley", "")
			end

			if arg_643_1.frameCnt_ <= 1 then
				arg_643_1.dialog_:SetActive(false)
			end

			local var_646_19 = 4.01733333333333
			local var_646_20 = 0.875

			if 4.01733333333333 < arg_643_1.time_ and arg_643_1.time_ <= var_646_19 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0

				arg_643_1.dialog_:SetActive(true)

				arg_643_1.dialogCg_.alpha = 0

				local var_646_21 = LeanTween.value(arg_643_1.dialog_, 0, 1, 0.3)

				var_646_21:setOnUpdate(LuaHelper.FloatAction(function(arg_647_0)
					arg_643_1.dialogCg_.alpha = arg_647_0
				end))
				var_646_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_643_1.dialog_)
					var_646_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_643_1.duration_ = arg_643_1.duration_ + 0.3

				SetActive(arg_643_1.leftNameGo_, false)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_22 = arg_643_1:FormatText(arg_643_1:GetWordFromCfg(1104906157).content)

				arg_643_1.text_.text = var_646_22

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_24 = 35 <= 0 and var_646_20 or var_646_20 * (utf8.len(var_646_22) / 35)

				if (35 <= 0 and var_646_20 or var_646_20 * (utf8.len(var_646_22) / 35)) > 0 and var_646_20 < var_646_24 then
					arg_643_1.talkMaxDuration = var_646_24
					var_646_19 = var_646_19 + 0.3

					if var_646_24 + var_646_19 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_24 + var_646_19
					end
				end

				arg_643_1.text_.text = var_646_22
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)
				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_25 = var_646_19 + 0.3
			local var_646_26 = math.max(var_646_20, arg_643_1.talkMaxDuration)

			if var_646_19 + 0.3 <= arg_643_1.time_ and arg_643_1.time_ < var_646_25 + var_646_26 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_25) / var_646_26

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_25 + var_646_26 and arg_643_1.time_ < var_646_25 + var_646_26 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_643_1:InitPlayNodeList()
	end,
	Play1104906158 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 1104906158
		arg_649_1.duration_ = 5

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play1104906159(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = 0.825

			if 0 < arg_649_1.time_ and arg_649_1.time_ <= 0 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, false)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_1 = arg_649_1:FormatText(arg_649_1:GetWordFromCfg(1104906158).content)

				arg_649_1.text_.text = var_652_1

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_3 = 33 <= 0 and var_652_0 or var_652_0 * (utf8.len(var_652_1) / 33)

				if (33 <= 0 and var_652_0 or var_652_0 * (utf8.len(var_652_1) / 33)) > 0 and var_652_0 < var_652_3 then
					arg_649_1.talkMaxDuration = var_652_3

					if var_652_3 + 0 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_3 + 0
					end
				end

				arg_649_1.text_.text = var_652_1
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)
				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_4 = math.max(var_652_0, arg_649_1.talkMaxDuration)

			if 0 <= arg_649_1.time_ and arg_649_1.time_ < 0 + var_652_4 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - 0) / var_652_4

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= 0 + var_652_4 and arg_649_1.time_ < 0 + var_652_4 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play1104906159 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 1104906159
		arg_653_1.duration_ = 2.77

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play1104906160(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 and not isNil(arg_653_1.actors_["1049ui_story"]) and arg_653_1.var_.characterEffect1049ui_story == nil then
				arg_653_1.var_.characterEffect1049ui_story = arg_653_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_656_0 = 0.200000002980232

			if 0 <= arg_653_1.time_ and arg_653_1.time_ < 0 + var_656_0 and not isNil(arg_653_1.actors_["1049ui_story"]) then
				if arg_653_1.var_.characterEffect1049ui_story and not isNil(arg_653_1.actors_["1049ui_story"]) then
					arg_653_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_653_1.time_ >= 0 + var_656_0 and arg_653_1.time_ < 0 + var_656_0 + arg_656_0 and not isNil(arg_653_1.actors_["1049ui_story"]) and arg_653_1.var_.characterEffect1049ui_story then
				arg_653_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 then
				arg_653_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 then
				arg_653_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_656_2 = arg_653_1.actors_["1049ui_story"].transform

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 then
				arg_653_1.var_.moveOldPos1049ui_story = var_656_2.localPosition
			end

			local var_656_3 = 0.001

			if 0 <= arg_653_1.time_ and arg_653_1.time_ < 0 + var_656_3 then
				var_656_2.localPosition = Vector3.Lerp(arg_653_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_653_1.time_ - 0) / var_656_3)
				var_656_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_656_2.position).x, (manager.ui.mainCamera.transform.position - var_656_2.position).y, (manager.ui.mainCamera.transform.position - var_656_2.position).z)
				var_656_2.localEulerAngles.z = 0
				var_656_2.localEulerAngles.x = 0
				var_656_2.localEulerAngles = var_656_2.localEulerAngles
			end

			if arg_653_1.time_ >= 0 + var_656_3 and arg_653_1.time_ < 0 + var_656_3 + arg_656_0 then
				var_656_2.localPosition = Vector3.New(0, -1.2, -6)
				var_656_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_656_2.position).x, (manager.ui.mainCamera.transform.position - var_656_2.position).y, (manager.ui.mainCamera.transform.position - var_656_2.position).z)
				var_656_2.localEulerAngles.z = 0
				var_656_2.localEulerAngles.x = 0
				var_656_2.localEulerAngles = var_656_2.localEulerAngles
			end

			local var_656_4 = 0
			local var_656_5 = 0.275

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= var_656_4 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, true)

				arg_653_1.leftNameTxt_.text = arg_653_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_653_1.leftNameTxt_.transform)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1.leftNameTxt_.text)
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_6 = arg_653_1:GetWordFromCfg(1104906159)
				local var_656_7 = arg_653_1:FormatText(var_656_6.content)

				arg_653_1.text_.text = var_656_7

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_9 = 11 <= 0 and var_656_5 or var_656_5 * (utf8.len(var_656_7) / 11)

				if (11 <= 0 and var_656_5 or var_656_5 * (utf8.len(var_656_7) / 11)) > 0 and var_656_5 < var_656_9 then
					arg_653_1.talkMaxDuration = var_656_9

					if var_656_9 + var_656_4 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_9 + var_656_4
					end
				end

				arg_653_1.text_.text = var_656_7
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906159", "story_v_side_new_1104906.awb") ~= 0 then
					local var_656_10 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906159", "story_v_side_new_1104906.awb") / 1000

					if var_656_10 + var_656_4 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_10 + var_656_4
					end

					if var_656_6.prefab_name ~= "" and arg_653_1.actors_[var_656_6.prefab_name] ~= nil then
						local var_656_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_653_1.actors_[var_656_6.prefab_name].transform, "story_v_side_new_1104906", "1104906159", "story_v_side_new_1104906.awb")

						arg_653_1:RecordAudio("1104906159", var_656_11)
						arg_653_1:RecordAudio("1104906159", var_656_11)
					else
						arg_653_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906159", "story_v_side_new_1104906.awb")
					end

					arg_653_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906159", "story_v_side_new_1104906.awb")
				end

				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_12 = math.max(var_656_5, arg_653_1.talkMaxDuration)

			if var_656_4 <= arg_653_1.time_ and arg_653_1.time_ < var_656_4 + var_656_12 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_4) / var_656_12

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_4 + var_656_12 and arg_653_1.time_ < var_656_4 + var_656_12 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_653_1:InitPlayNodeList()
	end,
	Play1104906160 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 1104906160
		arg_657_1.duration_ = 5

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play1104906161(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 and not isNil(arg_657_1.actors_["1049ui_story"]) and arg_657_1.var_.characterEffect1049ui_story == nil then
				arg_657_1.var_.characterEffect1049ui_story = arg_657_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_660_0 = 0.200000002980232

			if 0 <= arg_657_1.time_ and arg_657_1.time_ < 0 + var_660_0 and not isNil(arg_657_1.actors_["1049ui_story"]) then
				if arg_657_1.var_.characterEffect1049ui_story and not isNil(arg_657_1.actors_["1049ui_story"]) then
					arg_657_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_657_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_657_1.time_ - 0) / var_660_0)
				end
			end

			if arg_657_1.time_ >= 0 + var_660_0 and arg_657_1.time_ < 0 + var_660_0 + arg_660_0 and not isNil(arg_657_1.actors_["1049ui_story"]) and arg_657_1.var_.characterEffect1049ui_story then
				arg_657_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_657_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_660_1 = 0
			local var_660_2 = 1.6

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= var_660_1 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, false)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_3 = arg_657_1:FormatText(arg_657_1:GetWordFromCfg(1104906160).content)

				arg_657_1.text_.text = var_660_3

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_5 = 64 <= 0 and var_660_2 or var_660_2 * (utf8.len(var_660_3) / 64)

				if (64 <= 0 and var_660_2 or var_660_2 * (utf8.len(var_660_3) / 64)) > 0 and var_660_2 < var_660_5 then
					arg_657_1.talkMaxDuration = var_660_5

					if var_660_5 + var_660_1 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_5 + var_660_1
					end
				end

				arg_657_1.text_.text = var_660_3
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)
				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_6 = math.max(var_660_2, arg_657_1.talkMaxDuration)

			if var_660_1 <= arg_657_1.time_ and arg_657_1.time_ < var_660_1 + var_660_6 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_1) / var_660_6

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_1 + var_660_6 and arg_657_1.time_ < var_660_1 + var_660_6 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {}

		arg_657_1:InitPlayNodeList()
	end,
	Play1104906161 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 1104906161
		arg_661_1.duration_ = 6.67

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play1104906162(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			if 0 < arg_661_1.time_ and arg_661_1.time_ <= 0 + arg_664_0 and not isNil(arg_661_1.actors_["1049ui_story"]) and arg_661_1.var_.characterEffect1049ui_story == nil then
				arg_661_1.var_.characterEffect1049ui_story = arg_661_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_664_0 = 0.200000002980232

			if 0 <= arg_661_1.time_ and arg_661_1.time_ < 0 + var_664_0 and not isNil(arg_661_1.actors_["1049ui_story"]) then
				if arg_661_1.var_.characterEffect1049ui_story and not isNil(arg_661_1.actors_["1049ui_story"]) then
					arg_661_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_661_1.time_ >= 0 + var_664_0 and arg_661_1.time_ < 0 + var_664_0 + arg_664_0 and not isNil(arg_661_1.actors_["1049ui_story"]) and arg_661_1.var_.characterEffect1049ui_story then
				arg_661_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_661_1.time_ and arg_661_1.time_ <= 0 + arg_664_0 then
				arg_661_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			if 0 < arg_661_1.time_ and arg_661_1.time_ <= 0 + arg_664_0 then
				arg_661_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_664_2 = 0
			local var_664_3 = 0.525

			if 0 < arg_661_1.time_ and arg_661_1.time_ <= var_664_2 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0
				arg_661_1.dialogCg_.alpha = 1

				arg_661_1.dialog_:SetActive(true)
				SetActive(arg_661_1.leftNameGo_, true)

				arg_661_1.leftNameTxt_.text = arg_661_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_661_1.leftNameTxt_.transform)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1.leftNameTxt_.text)
				SetActive(arg_661_1.iconTrs_.gameObject, false)
				arg_661_1.callingController_:SetSelectedState("normal")

				local var_664_4 = arg_661_1:GetWordFromCfg(1104906161)
				local var_664_5 = arg_661_1:FormatText(var_664_4.content)

				arg_661_1.text_.text = var_664_5

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_7 = 21 <= 0 and var_664_3 or var_664_3 * (utf8.len(var_664_5) / 21)

				if (21 <= 0 and var_664_3 or var_664_3 * (utf8.len(var_664_5) / 21)) > 0 and var_664_3 < var_664_7 then
					arg_661_1.talkMaxDuration = var_664_7

					if var_664_7 + var_664_2 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_7 + var_664_2
					end
				end

				arg_661_1.text_.text = var_664_5
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906161", "story_v_side_new_1104906.awb") ~= 0 then
					local var_664_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906161", "story_v_side_new_1104906.awb") / 1000

					if var_664_8 + var_664_2 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_8 + var_664_2
					end

					if var_664_4.prefab_name ~= "" and arg_661_1.actors_[var_664_4.prefab_name] ~= nil then
						local var_664_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_661_1.actors_[var_664_4.prefab_name].transform, "story_v_side_new_1104906", "1104906161", "story_v_side_new_1104906.awb")

						arg_661_1:RecordAudio("1104906161", var_664_9)
						arg_661_1:RecordAudio("1104906161", var_664_9)
					else
						arg_661_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906161", "story_v_side_new_1104906.awb")
					end

					arg_661_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906161", "story_v_side_new_1104906.awb")
				end

				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_10 = math.max(var_664_3, arg_661_1.talkMaxDuration)

			if var_664_2 <= arg_661_1.time_ and arg_661_1.time_ < var_664_2 + var_664_10 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_2) / var_664_10

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_2 + var_664_10 and arg_661_1.time_ < var_664_2 + var_664_10 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {}

		arg_661_1:InitPlayNodeList()
	end,
	Play1104906162 = function(arg_665_0, arg_665_1)
		arg_665_1.time_ = 0
		arg_665_1.frameCnt_ = 0
		arg_665_1.state_ = "playing"
		arg_665_1.curTalkId_ = 1104906162
		arg_665_1.duration_ = 5

		SetActive(arg_665_1.tipsGo_, false)

		function arg_665_1.onSingleLineFinish_()
			arg_665_1.onSingleLineUpdate_ = nil
			arg_665_1.onSingleLineFinish_ = nil
			arg_665_1.state_ = "waiting"
		end

		function arg_665_1.playNext_(arg_667_0)
			if arg_667_0 == 1 then
				arg_665_0:Play1104906163(arg_665_1)
			end
		end

		function arg_665_1.onSingleLineUpdate_(arg_668_0)
			if 0 < arg_665_1.time_ and arg_665_1.time_ <= 0 + arg_668_0 and not isNil(arg_665_1.actors_["1049ui_story"]) and arg_665_1.var_.characterEffect1049ui_story == nil then
				arg_665_1.var_.characterEffect1049ui_story = arg_665_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_668_0 = 0.200000002980232

			if 0 <= arg_665_1.time_ and arg_665_1.time_ < 0 + var_668_0 and not isNil(arg_665_1.actors_["1049ui_story"]) then
				if arg_665_1.var_.characterEffect1049ui_story and not isNil(arg_665_1.actors_["1049ui_story"]) then
					arg_665_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_665_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_665_1.time_ - 0) / var_668_0)
				end
			end

			if arg_665_1.time_ >= 0 + var_668_0 and arg_665_1.time_ < 0 + var_668_0 + arg_668_0 and not isNil(arg_665_1.actors_["1049ui_story"]) and arg_665_1.var_.characterEffect1049ui_story then
				arg_665_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_665_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_668_1 = 0
			local var_668_2 = 0.8

			if 0 < arg_665_1.time_ and arg_665_1.time_ <= var_668_1 + arg_668_0 then
				arg_665_1.talkMaxDuration = 0
				arg_665_1.dialogCg_.alpha = 1

				arg_665_1.dialog_:SetActive(true)
				SetActive(arg_665_1.leftNameGo_, false)

				arg_665_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_665_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_665_1:RecordName(arg_665_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_665_1.iconTrs_.gameObject, false)
				arg_665_1.callingController_:SetSelectedState("normal")

				local var_668_3 = arg_665_1:FormatText(arg_665_1:GetWordFromCfg(1104906162).content)

				arg_665_1.text_.text = var_668_3

				LuaForUtil.ClearLinePrefixSymbol(arg_665_1.text_)

				local var_668_5 = 32 <= 0 and var_668_2 or var_668_2 * (utf8.len(var_668_3) / 32)

				if (32 <= 0 and var_668_2 or var_668_2 * (utf8.len(var_668_3) / 32)) > 0 and var_668_2 < var_668_5 then
					arg_665_1.talkMaxDuration = var_668_5

					if var_668_5 + var_668_1 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_5 + var_668_1
					end
				end

				arg_665_1.text_.text = var_668_3
				arg_665_1.typewritter.percent = 0

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(false)
				arg_665_1:RecordContent(arg_665_1.text_.text)
			end

			local var_668_6 = math.max(var_668_2, arg_665_1.talkMaxDuration)

			if var_668_1 <= arg_665_1.time_ and arg_665_1.time_ < var_668_1 + var_668_6 then
				arg_665_1.typewritter.percent = (arg_665_1.time_ - var_668_1) / var_668_6

				arg_665_1.typewritter:SetDirty()
			end

			if arg_665_1.time_ >= var_668_1 + var_668_6 and arg_665_1.time_ < var_668_1 + var_668_6 + arg_668_0 then
				arg_665_1.typewritter.percent = 1

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(true)
			end
		end

		arg_665_1.nodeConfigList_ = {}

		arg_665_1:InitPlayNodeList()
	end,
	Play1104906163 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 1104906163
		arg_669_1.duration_ = 9.67

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play1104906164(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			if 0 < arg_669_1.time_ and arg_669_1.time_ <= 0 + arg_672_0 and not isNil(arg_669_1.actors_["1049ui_story"]) and arg_669_1.var_.characterEffect1049ui_story == nil then
				arg_669_1.var_.characterEffect1049ui_story = arg_669_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_672_0 = 0.200000002980232

			if 0 <= arg_669_1.time_ and arg_669_1.time_ < 0 + var_672_0 and not isNil(arg_669_1.actors_["1049ui_story"]) then
				if arg_669_1.var_.characterEffect1049ui_story and not isNil(arg_669_1.actors_["1049ui_story"]) then
					arg_669_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_669_1.time_ >= 0 + var_672_0 and arg_669_1.time_ < 0 + var_672_0 + arg_672_0 and not isNil(arg_669_1.actors_["1049ui_story"]) and arg_669_1.var_.characterEffect1049ui_story then
				arg_669_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_669_1.time_ and arg_669_1.time_ <= 0 + arg_672_0 then
				arg_669_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_2")
			end

			if 0 < arg_669_1.time_ and arg_669_1.time_ <= 0 + arg_672_0 then
				arg_669_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_672_2 = 0
			local var_672_3 = 0.7

			if 0 < arg_669_1.time_ and arg_669_1.time_ <= var_672_2 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, true)

				arg_669_1.leftNameTxt_.text = arg_669_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_669_1.leftNameTxt_.transform)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1.leftNameTxt_.text)
				SetActive(arg_669_1.iconTrs_.gameObject, false)
				arg_669_1.callingController_:SetSelectedState("normal")

				local var_672_4 = arg_669_1:GetWordFromCfg(1104906163)
				local var_672_5 = arg_669_1:FormatText(var_672_4.content)

				arg_669_1.text_.text = var_672_5

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_7 = 28 <= 0 and var_672_3 or var_672_3 * (utf8.len(var_672_5) / 28)

				if (28 <= 0 and var_672_3 or var_672_3 * (utf8.len(var_672_5) / 28)) > 0 and var_672_3 < var_672_7 then
					arg_669_1.talkMaxDuration = var_672_7

					if var_672_7 + var_672_2 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_7 + var_672_2
					end
				end

				arg_669_1.text_.text = var_672_5
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906163", "story_v_side_new_1104906.awb") ~= 0 then
					local var_672_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906163", "story_v_side_new_1104906.awb") / 1000

					if var_672_8 + var_672_2 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_8 + var_672_2
					end

					if var_672_4.prefab_name ~= "" and arg_669_1.actors_[var_672_4.prefab_name] ~= nil then
						local var_672_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_669_1.actors_[var_672_4.prefab_name].transform, "story_v_side_new_1104906", "1104906163", "story_v_side_new_1104906.awb")

						arg_669_1:RecordAudio("1104906163", var_672_9)
						arg_669_1:RecordAudio("1104906163", var_672_9)
					else
						arg_669_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906163", "story_v_side_new_1104906.awb")
					end

					arg_669_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906163", "story_v_side_new_1104906.awb")
				end

				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_10 = math.max(var_672_3, arg_669_1.talkMaxDuration)

			if var_672_2 <= arg_669_1.time_ and arg_669_1.time_ < var_672_2 + var_672_10 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - var_672_2) / var_672_10

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= var_672_2 + var_672_10 and arg_669_1.time_ < var_672_2 + var_672_10 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {}

		arg_669_1:InitPlayNodeList()
	end,
	Play1104906164 = function(arg_673_0, arg_673_1)
		arg_673_1.time_ = 0
		arg_673_1.frameCnt_ = 0
		arg_673_1.state_ = "playing"
		arg_673_1.curTalkId_ = 1104906164
		arg_673_1.duration_ = 8.13

		SetActive(arg_673_1.tipsGo_, false)

		function arg_673_1.onSingleLineFinish_()
			arg_673_1.onSingleLineUpdate_ = nil
			arg_673_1.onSingleLineFinish_ = nil
			arg_673_1.state_ = "waiting"
		end

		function arg_673_1.playNext_(arg_675_0)
			if arg_675_0 == 1 then
				arg_673_0:Play1104906165(arg_673_1)
			end
		end

		function arg_673_1.onSingleLineUpdate_(arg_676_0)
			if 0 < arg_673_1.time_ and arg_673_1.time_ <= 0 + arg_676_0 then
				arg_673_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_673_1.time_ and arg_673_1.time_ <= 0 + arg_676_0 then
				arg_673_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_676_0 = 0
			local var_676_1 = 0.8

			if 0 < arg_673_1.time_ and arg_673_1.time_ <= var_676_0 + arg_676_0 then
				arg_673_1.talkMaxDuration = 0
				arg_673_1.dialogCg_.alpha = 1

				arg_673_1.dialog_:SetActive(true)
				SetActive(arg_673_1.leftNameGo_, true)

				arg_673_1.leftNameTxt_.text = arg_673_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_673_1.leftNameTxt_.transform)

				arg_673_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_673_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_673_1:RecordName(arg_673_1.leftNameTxt_.text)
				SetActive(arg_673_1.iconTrs_.gameObject, false)
				arg_673_1.callingController_:SetSelectedState("normal")

				local var_676_2 = arg_673_1:GetWordFromCfg(1104906164)
				local var_676_3 = arg_673_1:FormatText(var_676_2.content)

				arg_673_1.text_.text = var_676_3

				LuaForUtil.ClearLinePrefixSymbol(arg_673_1.text_)

				local var_676_5 = 32 <= 0 and var_676_1 or var_676_1 * (utf8.len(var_676_3) / 32)

				if (32 <= 0 and var_676_1 or var_676_1 * (utf8.len(var_676_3) / 32)) > 0 and var_676_1 < var_676_5 then
					arg_673_1.talkMaxDuration = var_676_5

					if var_676_5 + var_676_0 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_5 + var_676_0
					end
				end

				arg_673_1.text_.text = var_676_3
				arg_673_1.typewritter.percent = 0

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906164", "story_v_side_new_1104906.awb") ~= 0 then
					local var_676_6 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906164", "story_v_side_new_1104906.awb") / 1000

					if var_676_6 + var_676_0 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_6 + var_676_0
					end

					if var_676_2.prefab_name ~= "" and arg_673_1.actors_[var_676_2.prefab_name] ~= nil then
						local var_676_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_673_1.actors_[var_676_2.prefab_name].transform, "story_v_side_new_1104906", "1104906164", "story_v_side_new_1104906.awb")

						arg_673_1:RecordAudio("1104906164", var_676_7)
						arg_673_1:RecordAudio("1104906164", var_676_7)
					else
						arg_673_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906164", "story_v_side_new_1104906.awb")
					end

					arg_673_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906164", "story_v_side_new_1104906.awb")
				end

				arg_673_1:RecordContent(arg_673_1.text_.text)
			end

			local var_676_8 = math.max(var_676_1, arg_673_1.talkMaxDuration)

			if var_676_0 <= arg_673_1.time_ and arg_673_1.time_ < var_676_0 + var_676_8 then
				arg_673_1.typewritter.percent = (arg_673_1.time_ - var_676_0) / var_676_8

				arg_673_1.typewritter:SetDirty()
			end

			if arg_673_1.time_ >= var_676_0 + var_676_8 and arg_673_1.time_ < var_676_0 + var_676_8 + arg_676_0 then
				arg_673_1.typewritter.percent = 1

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(true)
			end
		end

		arg_673_1.nodeConfigList_ = {}

		arg_673_1:InitPlayNodeList()
	end,
	Play1104906165 = function(arg_677_0, arg_677_1)
		arg_677_1.time_ = 0
		arg_677_1.frameCnt_ = 0
		arg_677_1.state_ = "playing"
		arg_677_1.curTalkId_ = 1104906165
		arg_677_1.duration_ = 9

		SetActive(arg_677_1.tipsGo_, false)

		function arg_677_1.onSingleLineFinish_()
			arg_677_1.onSingleLineUpdate_ = nil
			arg_677_1.onSingleLineFinish_ = nil
			arg_677_1.state_ = "waiting"
		end

		function arg_677_1.playNext_(arg_679_0)
			if arg_679_0 == 1 then
				arg_677_0:Play1104906166(arg_677_1)
			end
		end

		function arg_677_1.onSingleLineUpdate_(arg_680_0)
			if arg_677_1.bgs_.K10g == nil then
				local var_680_0 = Object.Instantiate(arg_677_1.paintGo_)

				var_680_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K10g")
				var_680_0.name = "K10g"
				var_680_0.transform.parent = arg_677_1.stage_.transform
				var_680_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_677_1.bgs_.K10g = var_680_0
			end

			if 2 < arg_677_1.time_ and arg_677_1.time_ <= 2 + arg_680_0 then
				local var_680_1 = arg_677_1.bgs_.K10g

				arg_677_1.bgs_.K10g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_680_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_680_2 = var_680_1:GetComponent("SpriteRenderer")

				if var_680_2 and var_680_2.sprite then
					local var_680_3 = 2 * (var_680_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_680_1.transform.localScale = Vector3.New(var_680_3 / var_680_2.sprite.bounds.size.y < var_680_3 * manager.ui.mainCameraCom_.aspect / var_680_2.sprite.bounds.size.x and var_680_3 * manager.ui.mainCameraCom_.aspect / var_680_2.sprite.bounds.size.x or var_680_3 / var_680_2.sprite.bounds.size.y, var_680_3 / var_680_2.sprite.bounds.size.y < var_680_3 * manager.ui.mainCameraCom_.aspect / var_680_2.sprite.bounds.size.x and var_680_3 * manager.ui.mainCameraCom_.aspect / var_680_2.sprite.bounds.size.x or var_680_3 / var_680_2.sprite.bounds.size.y, 0)
				end

				for iter_680_0, iter_680_1 in pairs(arg_677_1.bgs_) do
					if iter_680_0 ~= "K10g" then
						iter_680_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_680_4 = 3.999999999999

			if 3.999999999999 < arg_677_1.time_ and arg_677_1.time_ <= var_680_4 + arg_680_0 then
				arg_677_1.allBtn_.enabled = false
			end

			if arg_677_1.time_ >= var_680_4 + 0.3 and arg_677_1.time_ < var_680_4 + 0.3 + arg_680_0 then
				arg_677_1.allBtn_.enabled = true
			end

			local var_680_5 = 0

			if 0 < arg_677_1.time_ and arg_677_1.time_ <= var_680_5 + arg_680_0 then
				arg_677_1.mask_.enabled = true
				arg_677_1.mask_.raycastTarget = true

				arg_677_1:SetGaussion(false)
			end

			local var_680_6 = 2

			if var_680_5 <= arg_677_1.time_ and arg_677_1.time_ < var_680_5 + var_680_6 then
				local var_680_7 = Color.New(0, 0, 0)

				var_680_7.a = Mathf.Lerp(0, 1, (arg_677_1.time_ - var_680_5) / var_680_6)
				arg_677_1.mask_.color = var_680_7
			end

			if arg_677_1.time_ >= var_680_5 + var_680_6 and arg_677_1.time_ < var_680_5 + var_680_6 + arg_680_0 then
				local var_680_8 = Color.New(0, 0, 0)

				var_680_8.a = 1
				arg_677_1.mask_.color = var_680_8
			end

			local var_680_9 = 2

			if 2 < arg_677_1.time_ and arg_677_1.time_ <= var_680_9 + arg_680_0 then
				arg_677_1.mask_.enabled = true
				arg_677_1.mask_.raycastTarget = true

				arg_677_1:SetGaussion(false)
			end

			local var_680_10 = 2

			if var_680_9 <= arg_677_1.time_ and arg_677_1.time_ < var_680_9 + var_680_10 then
				local var_680_11 = Color.New(0, 0, 0)

				var_680_11.a = Mathf.Lerp(1, 0, (arg_677_1.time_ - var_680_9) / var_680_10)
				arg_677_1.mask_.color = var_680_11
			end

			if arg_677_1.time_ >= var_680_9 + var_680_10 and arg_677_1.time_ < var_680_9 + var_680_10 + arg_680_0 then
				local var_680_12 = Color.New(0, 0, 0)

				arg_677_1.mask_.enabled = false
				var_680_12.a = 0
				arg_677_1.mask_.color = var_680_12
			end

			local var_680_13 = arg_677_1.actors_["1049ui_story"].transform

			if 1.96599999815226 < arg_677_1.time_ and arg_677_1.time_ <= 1.96599999815226 + arg_680_0 then
				arg_677_1.var_.moveOldPos1049ui_story = var_680_13.localPosition
			end

			local var_680_14 = 0.001

			if 1.96599999815226 <= arg_677_1.time_ and arg_677_1.time_ < 1.96599999815226 + var_680_14 then
				var_680_13.localPosition = Vector3.Lerp(arg_677_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_677_1.time_ - 1.96599999815226) / var_680_14)
				var_680_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_680_13.position).x, (manager.ui.mainCamera.transform.position - var_680_13.position).y, (manager.ui.mainCamera.transform.position - var_680_13.position).z)
				var_680_13.localEulerAngles.z = 0
				var_680_13.localEulerAngles.x = 0
				var_680_13.localEulerAngles = var_680_13.localEulerAngles
			end

			if arg_677_1.time_ >= 1.96599999815226 + var_680_14 and arg_677_1.time_ < 1.96599999815226 + var_680_14 + arg_680_0 then
				var_680_13.localPosition = Vector3.New(0, 100, 0)
				var_680_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_680_13.position).x, (manager.ui.mainCamera.transform.position - var_680_13.position).y, (manager.ui.mainCamera.transform.position - var_680_13.position).z)
				var_680_13.localEulerAngles.z = 0
				var_680_13.localEulerAngles.x = 0
				var_680_13.localEulerAngles = var_680_13.localEulerAngles
			end

			local var_680_15 = arg_677_1.actors_["1049ui_story"]

			if 1.96599999815226 < arg_677_1.time_ and arg_677_1.time_ <= 1.96599999815226 + arg_680_0 and not isNil(var_680_15) and arg_677_1.var_.characterEffect1049ui_story == nil then
				arg_677_1.var_.characterEffect1049ui_story = var_680_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_680_16 = 0.034000001847744

			if 1.96599999815226 <= arg_677_1.time_ and arg_677_1.time_ < 1.96599999815226 + var_680_16 and not isNil(var_680_15) then
				if arg_677_1.var_.characterEffect1049ui_story and not isNil(var_680_15) then
					arg_677_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_677_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_677_1.time_ - 1.96599999815226) / var_680_16)
				end
			end

			if arg_677_1.time_ >= 1.96599999815226 + var_680_16 and arg_677_1.time_ < 1.96599999815226 + var_680_16 + arg_680_0 and not isNil(var_680_15) and arg_677_1.var_.characterEffect1049ui_story then
				arg_677_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_677_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			if 0.366666666666667 < arg_677_1.time_ and arg_677_1.time_ <= 0.366666666666667 + arg_680_0 then
				arg_677_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_valley", "")
			end

			if 1.53333333333333 < arg_677_1.time_ and arg_677_1.time_ <= 1.53333333333333 + arg_680_0 then
				arg_677_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_amb_wind_leaves", "")
			end

			if arg_677_1.frameCnt_ <= 1 then
				arg_677_1.dialog_:SetActive(false)
			end

			local var_680_19 = 3.999999999999
			local var_680_20 = 0.5

			if 3.999999999999 < arg_677_1.time_ and arg_677_1.time_ <= var_680_19 + arg_680_0 then
				arg_677_1.talkMaxDuration = 0

				arg_677_1.dialog_:SetActive(true)

				arg_677_1.dialogCg_.alpha = 0

				local var_680_21 = LeanTween.value(arg_677_1.dialog_, 0, 1, 0.3)

				var_680_21:setOnUpdate(LuaHelper.FloatAction(function(arg_681_0)
					arg_677_1.dialogCg_.alpha = arg_681_0
				end))
				var_680_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_677_1.dialog_)
					var_680_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_677_1.duration_ = arg_677_1.duration_ + 0.3

				SetActive(arg_677_1.leftNameGo_, false)

				arg_677_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_677_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_677_1:RecordName(arg_677_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_677_1.iconTrs_.gameObject, false)
				arg_677_1.callingController_:SetSelectedState("normal")

				local var_680_22 = arg_677_1:FormatText(arg_677_1:GetWordFromCfg(1104906165).content)

				arg_677_1.text_.text = var_680_22

				LuaForUtil.ClearLinePrefixSymbol(arg_677_1.text_)

				local var_680_24 = 20 <= 0 and var_680_20 or var_680_20 * (utf8.len(var_680_22) / 20)

				if (20 <= 0 and var_680_20 or var_680_20 * (utf8.len(var_680_22) / 20)) > 0 and var_680_20 < var_680_24 then
					arg_677_1.talkMaxDuration = var_680_24
					var_680_19 = var_680_19 + 0.3

					if var_680_24 + var_680_19 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_24 + var_680_19
					end
				end

				arg_677_1.text_.text = var_680_22
				arg_677_1.typewritter.percent = 0

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(false)
				arg_677_1:RecordContent(arg_677_1.text_.text)
			end

			local var_680_25 = var_680_19 + 0.3
			local var_680_26 = math.max(var_680_20, arg_677_1.talkMaxDuration)

			if var_680_19 + 0.3 <= arg_677_1.time_ and arg_677_1.time_ < var_680_25 + var_680_26 then
				arg_677_1.typewritter.percent = (arg_677_1.time_ - var_680_25) / var_680_26

				arg_677_1.typewritter:SetDirty()
			end

			if arg_677_1.time_ >= var_680_25 + var_680_26 and arg_677_1.time_ < var_680_25 + var_680_26 + arg_680_0 then
				arg_677_1.typewritter.percent = 1

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(true)
			end
		end

		arg_677_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_677_1:InitPlayNodeList()
	end,
	Play1104906166 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 1104906166
		arg_683_1.duration_ = 5

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play1104906167(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			local var_686_0 = 0.775

			if 0 < arg_683_1.time_ and arg_683_1.time_ <= 0 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, false)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_683_1.iconTrs_.gameObject, false)
				arg_683_1.callingController_:SetSelectedState("normal")

				local var_686_1 = arg_683_1:FormatText(arg_683_1:GetWordFromCfg(1104906166).content)

				arg_683_1.text_.text = var_686_1

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_3 = 31 <= 0 and var_686_0 or var_686_0 * (utf8.len(var_686_1) / 31)

				if (31 <= 0 and var_686_0 or var_686_0 * (utf8.len(var_686_1) / 31)) > 0 and var_686_0 < var_686_3 then
					arg_683_1.talkMaxDuration = var_686_3

					if var_686_3 + 0 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_3 + 0
					end
				end

				arg_683_1.text_.text = var_686_1
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)
				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_4 = math.max(var_686_0, arg_683_1.talkMaxDuration)

			if 0 <= arg_683_1.time_ and arg_683_1.time_ < 0 + var_686_4 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - 0) / var_686_4

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= 0 + var_686_4 and arg_683_1.time_ < 0 + var_686_4 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {}

		arg_683_1:InitPlayNodeList()
	end,
	Play1104906167 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 1104906167
		arg_687_1.duration_ = 5

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play1104906168(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			local var_690_0 = 0.525

			if 0 < arg_687_1.time_ and arg_687_1.time_ <= 0 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, true)

				arg_687_1.leftNameTxt_.text = arg_687_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_687_1.leftNameTxt_.transform)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1.leftNameTxt_.text)
				SetActive(arg_687_1.iconTrs_.gameObject, true)
				arg_687_1.iconController_:SetSelectedState("hero")

				arg_687_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_687_1.callingController_:SetSelectedState("normal")

				arg_687_1.keyicon_.color = Color.New(1, 1, 1)
				arg_687_1.icon_.color = Color.New(1, 1, 1)

				local var_690_1 = arg_687_1:FormatText(arg_687_1:GetWordFromCfg(1104906167).content)

				arg_687_1.text_.text = var_690_1

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_3 = 21 <= 0 and var_690_0 or var_690_0 * (utf8.len(var_690_1) / 21)

				if (21 <= 0 and var_690_0 or var_690_0 * (utf8.len(var_690_1) / 21)) > 0 and var_690_0 < var_690_3 then
					arg_687_1.talkMaxDuration = var_690_3

					if var_690_3 + 0 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_3 + 0
					end
				end

				arg_687_1.text_.text = var_690_1
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)
				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_4 = math.max(var_690_0, arg_687_1.talkMaxDuration)

			if 0 <= arg_687_1.time_ and arg_687_1.time_ < 0 + var_690_4 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - 0) / var_690_4

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= 0 + var_690_4 and arg_687_1.time_ < 0 + var_690_4 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {}

		arg_687_1:InitPlayNodeList()
	end,
	Play1104906168 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 1104906168
		arg_691_1.duration_ = 2

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play1104906169(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 then
				arg_691_1.var_.moveOldPos1049ui_story = arg_691_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_694_0 = 0.001

			if 0 <= arg_691_1.time_ and arg_691_1.time_ < 0 + var_694_0 then
				arg_691_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_691_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_691_1.time_ - 0) / var_694_0)
				arg_691_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_691_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_691_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_691_1.actors_["1049ui_story"].transform.position).z)
				arg_691_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_691_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_691_1.actors_["1049ui_story"].transform.localEulerAngles = arg_691_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_691_1.time_ >= 0 + var_694_0 and arg_691_1.time_ < 0 + var_694_0 + arg_694_0 then
				arg_691_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_691_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_691_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_691_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_691_1.actors_["1049ui_story"].transform.position).z)
				arg_691_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_691_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_691_1.actors_["1049ui_story"].transform.localEulerAngles = arg_691_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_694_1 = arg_691_1.actors_["1049ui_story"]

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 and not isNil(var_694_1) and arg_691_1.var_.characterEffect1049ui_story == nil then
				arg_691_1.var_.characterEffect1049ui_story = var_694_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_694_2 = 0.200000002980232

			if 0 <= arg_691_1.time_ and arg_691_1.time_ < 0 + var_694_2 and not isNil(var_694_1) then
				if arg_691_1.var_.characterEffect1049ui_story and not isNil(var_694_1) then
					arg_691_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_691_1.time_ >= 0 + var_694_2 and arg_691_1.time_ < 0 + var_694_2 + arg_694_0 and not isNil(var_694_1) and arg_691_1.var_.characterEffect1049ui_story then
				arg_691_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 then
				arg_691_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 then
				arg_691_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_694_4 = 0
			local var_694_5 = 0.2

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= var_694_4 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, true)

				arg_691_1.leftNameTxt_.text = arg_691_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_691_1.leftNameTxt_.transform)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1.leftNameTxt_.text)
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_6 = arg_691_1:GetWordFromCfg(1104906168)
				local var_694_7 = arg_691_1:FormatText(var_694_6.content)

				arg_691_1.text_.text = var_694_7

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_9 = 8 <= 0 and var_694_5 or var_694_5 * (utf8.len(var_694_7) / 8)

				if (8 <= 0 and var_694_5 or var_694_5 * (utf8.len(var_694_7) / 8)) > 0 and var_694_5 < var_694_9 then
					arg_691_1.talkMaxDuration = var_694_9

					if var_694_9 + var_694_4 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_9 + var_694_4
					end
				end

				arg_691_1.text_.text = var_694_7
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906168", "story_v_side_new_1104906.awb") ~= 0 then
					local var_694_10 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906168", "story_v_side_new_1104906.awb") / 1000

					if var_694_10 + var_694_4 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_10 + var_694_4
					end

					if var_694_6.prefab_name ~= "" and arg_691_1.actors_[var_694_6.prefab_name] ~= nil then
						local var_694_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_691_1.actors_[var_694_6.prefab_name].transform, "story_v_side_new_1104906", "1104906168", "story_v_side_new_1104906.awb")

						arg_691_1:RecordAudio("1104906168", var_694_11)
						arg_691_1:RecordAudio("1104906168", var_694_11)
					else
						arg_691_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906168", "story_v_side_new_1104906.awb")
					end

					arg_691_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906168", "story_v_side_new_1104906.awb")
				end

				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_12 = math.max(var_694_5, arg_691_1.talkMaxDuration)

			if var_694_4 <= arg_691_1.time_ and arg_691_1.time_ < var_694_4 + var_694_12 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_4) / var_694_12

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_4 + var_694_12 and arg_691_1.time_ < var_694_4 + var_694_12 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_691_1:InitPlayNodeList()
	end,
	Play1104906169 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 1104906169
		arg_695_1.duration_ = 5

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play1104906170(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			if 0 < arg_695_1.time_ and arg_695_1.time_ <= 0 + arg_698_0 and not isNil(arg_695_1.actors_["1049ui_story"]) and arg_695_1.var_.characterEffect1049ui_story == nil then
				arg_695_1.var_.characterEffect1049ui_story = arg_695_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_698_0 = 0.200000002980232

			if 0 <= arg_695_1.time_ and arg_695_1.time_ < 0 + var_698_0 and not isNil(arg_695_1.actors_["1049ui_story"]) then
				if arg_695_1.var_.characterEffect1049ui_story and not isNil(arg_695_1.actors_["1049ui_story"]) then
					arg_695_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_695_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_695_1.time_ - 0) / var_698_0)
				end
			end

			if arg_695_1.time_ >= 0 + var_698_0 and arg_695_1.time_ < 0 + var_698_0 + arg_698_0 and not isNil(arg_695_1.actors_["1049ui_story"]) and arg_695_1.var_.characterEffect1049ui_story then
				arg_695_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_695_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_698_1 = 0
			local var_698_2 = 0.35

			if 0 < arg_695_1.time_ and arg_695_1.time_ <= var_698_1 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, true)

				arg_695_1.leftNameTxt_.text = arg_695_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_695_1.leftNameTxt_.transform)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1.leftNameTxt_.text)
				SetActive(arg_695_1.iconTrs_.gameObject, true)
				arg_695_1.iconController_:SetSelectedState("hero")

				arg_695_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_695_1.callingController_:SetSelectedState("normal")

				arg_695_1.keyicon_.color = Color.New(1, 1, 1)
				arg_695_1.icon_.color = Color.New(1, 1, 1)

				local var_698_3 = arg_695_1:FormatText(arg_695_1:GetWordFromCfg(1104906169).content)

				arg_695_1.text_.text = var_698_3

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_5 = 14 <= 0 and var_698_2 or var_698_2 * (utf8.len(var_698_3) / 14)

				if (14 <= 0 and var_698_2 or var_698_2 * (utf8.len(var_698_3) / 14)) > 0 and var_698_2 < var_698_5 then
					arg_695_1.talkMaxDuration = var_698_5

					if var_698_5 + var_698_1 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_5 + var_698_1
					end
				end

				arg_695_1.text_.text = var_698_3
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)
				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_6 = math.max(var_698_2, arg_695_1.talkMaxDuration)

			if var_698_1 <= arg_695_1.time_ and arg_695_1.time_ < var_698_1 + var_698_6 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - var_698_1) / var_698_6

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= var_698_1 + var_698_6 and arg_695_1.time_ < var_698_1 + var_698_6 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {}

		arg_695_1:InitPlayNodeList()
	end,
	Play1104906170 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 1104906170
		arg_699_1.duration_ = 4.93

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play1104906171(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 and not isNil(arg_699_1.actors_["1049ui_story"]) and arg_699_1.var_.characterEffect1049ui_story == nil then
				arg_699_1.var_.characterEffect1049ui_story = arg_699_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_702_0 = 0.200000002980232

			if 0 <= arg_699_1.time_ and arg_699_1.time_ < 0 + var_702_0 and not isNil(arg_699_1.actors_["1049ui_story"]) then
				if arg_699_1.var_.characterEffect1049ui_story and not isNil(arg_699_1.actors_["1049ui_story"]) then
					arg_699_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_699_1.time_ >= 0 + var_702_0 and arg_699_1.time_ < 0 + var_702_0 + arg_702_0 and not isNil(arg_699_1.actors_["1049ui_story"]) and arg_699_1.var_.characterEffect1049ui_story then
				arg_699_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 then
				arg_699_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action4_1")
			end

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 then
				arg_699_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_702_2 = 0
			local var_702_3 = 0.375

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= var_702_2 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, true)

				arg_699_1.leftNameTxt_.text = arg_699_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_699_1.leftNameTxt_.transform)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1.leftNameTxt_.text)
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_4 = arg_699_1:GetWordFromCfg(1104906170)
				local var_702_5 = arg_699_1:FormatText(var_702_4.content)

				arg_699_1.text_.text = var_702_5

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_7 = 15 <= 0 and var_702_3 or var_702_3 * (utf8.len(var_702_5) / 15)

				if (15 <= 0 and var_702_3 or var_702_3 * (utf8.len(var_702_5) / 15)) > 0 and var_702_3 < var_702_7 then
					arg_699_1.talkMaxDuration = var_702_7

					if var_702_7 + var_702_2 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_7 + var_702_2
					end
				end

				arg_699_1.text_.text = var_702_5
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906170", "story_v_side_new_1104906.awb") ~= 0 then
					local var_702_8 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906170", "story_v_side_new_1104906.awb") / 1000

					if var_702_8 + var_702_2 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_8 + var_702_2
					end

					if var_702_4.prefab_name ~= "" and arg_699_1.actors_[var_702_4.prefab_name] ~= nil then
						local var_702_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_699_1.actors_[var_702_4.prefab_name].transform, "story_v_side_new_1104906", "1104906170", "story_v_side_new_1104906.awb")

						arg_699_1:RecordAudio("1104906170", var_702_9)
						arg_699_1:RecordAudio("1104906170", var_702_9)
					else
						arg_699_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906170", "story_v_side_new_1104906.awb")
					end

					arg_699_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906170", "story_v_side_new_1104906.awb")
				end

				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_10 = math.max(var_702_3, arg_699_1.talkMaxDuration)

			if var_702_2 <= arg_699_1.time_ and arg_699_1.time_ < var_702_2 + var_702_10 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_2) / var_702_10

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_2 + var_702_10 and arg_699_1.time_ < var_702_2 + var_702_10 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {}

		arg_699_1:InitPlayNodeList()
	end,
	Play1104906171 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 1104906171
		arg_703_1.duration_ = 5

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play1104906172(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 then
				arg_703_1.var_.moveOldPos1049ui_story = arg_703_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_706_0 = 0.001

			if 0 <= arg_703_1.time_ and arg_703_1.time_ < 0 + var_706_0 then
				arg_703_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_703_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_703_1.time_ - 0) / var_706_0)
				arg_703_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_703_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_703_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_703_1.actors_["1049ui_story"].transform.position).z)
				arg_703_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_703_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_703_1.actors_["1049ui_story"].transform.localEulerAngles = arg_703_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_703_1.time_ >= 0 + var_706_0 and arg_703_1.time_ < 0 + var_706_0 + arg_706_0 then
				arg_703_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_703_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_703_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_703_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_703_1.actors_["1049ui_story"].transform.position).z)
				arg_703_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_703_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_703_1.actors_["1049ui_story"].transform.localEulerAngles = arg_703_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_706_1 = arg_703_1.actors_["1049ui_story"]

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 and not isNil(var_706_1) and arg_703_1.var_.characterEffect1049ui_story == nil then
				arg_703_1.var_.characterEffect1049ui_story = var_706_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_706_2 = 0.200000002980232

			if 0 <= arg_703_1.time_ and arg_703_1.time_ < 0 + var_706_2 and not isNil(var_706_1) then
				if arg_703_1.var_.characterEffect1049ui_story and not isNil(var_706_1) then
					arg_703_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_703_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_703_1.time_ - 0) / var_706_2)
				end
			end

			if arg_703_1.time_ >= 0 + var_706_2 and arg_703_1.time_ < 0 + var_706_2 + arg_706_0 and not isNil(var_706_1) and arg_703_1.var_.characterEffect1049ui_story then
				arg_703_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_703_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_706_3 = 0
			local var_706_4 = 1.025

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= var_706_3 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, false)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_703_1.iconTrs_.gameObject, false)
				arg_703_1.callingController_:SetSelectedState("normal")

				local var_706_5 = arg_703_1:FormatText(arg_703_1:GetWordFromCfg(1104906171).content)

				arg_703_1.text_.text = var_706_5

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_7 = 41 <= 0 and var_706_4 or var_706_4 * (utf8.len(var_706_5) / 41)

				if (41 <= 0 and var_706_4 or var_706_4 * (utf8.len(var_706_5) / 41)) > 0 and var_706_4 < var_706_7 then
					arg_703_1.talkMaxDuration = var_706_7

					if var_706_7 + var_706_3 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_7 + var_706_3
					end
				end

				arg_703_1.text_.text = var_706_5
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)
				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_8 = math.max(var_706_4, arg_703_1.talkMaxDuration)

			if var_706_3 <= arg_703_1.time_ and arg_703_1.time_ < var_706_3 + var_706_8 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_3) / var_706_8

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_3 + var_706_8 and arg_703_1.time_ < var_706_3 + var_706_8 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_703_1:InitPlayNodeList()
	end,
	Play1104906172 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 1104906172
		arg_707_1.duration_ = 5

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play1104906173(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			local var_710_0 = 0.15

			if 0 < arg_707_1.time_ and arg_707_1.time_ <= 0 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, true)

				arg_707_1.leftNameTxt_.text = arg_707_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_707_1.leftNameTxt_.transform)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1.leftNameTxt_.text)
				SetActive(arg_707_1.iconTrs_.gameObject, true)
				arg_707_1.iconController_:SetSelectedState("hero")

				arg_707_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_707_1.callingController_:SetSelectedState("normal")

				arg_707_1.keyicon_.color = Color.New(1, 1, 1)
				arg_707_1.icon_.color = Color.New(1, 1, 1)

				local var_710_1 = arg_707_1:FormatText(arg_707_1:GetWordFromCfg(1104906172).content)

				arg_707_1.text_.text = var_710_1

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_3 = 6 <= 0 and var_710_0 or var_710_0 * (utf8.len(var_710_1) / 6)

				if (6 <= 0 and var_710_0 or var_710_0 * (utf8.len(var_710_1) / 6)) > 0 and var_710_0 < var_710_3 then
					arg_707_1.talkMaxDuration = var_710_3

					if var_710_3 + 0 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_3 + 0
					end
				end

				arg_707_1.text_.text = var_710_1
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)
				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_4 = math.max(var_710_0, arg_707_1.talkMaxDuration)

			if 0 <= arg_707_1.time_ and arg_707_1.time_ < 0 + var_710_4 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - 0) / var_710_4

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= 0 + var_710_4 and arg_707_1.time_ < 0 + var_710_4 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {}

		arg_707_1:InitPlayNodeList()
	end,
	Play1104906173 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 1104906173
		arg_711_1.duration_ = 2

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
		end

		function arg_711_1.playNext_(arg_713_0)
			if arg_713_0 == 1 then
				arg_711_0:Play1104906174(arg_711_1)
			end
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			if 0 < arg_711_1.time_ and arg_711_1.time_ <= 0 + arg_714_0 then
				arg_711_1.var_.moveOldPos1049ui_story = arg_711_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_714_0 = 0.001

			if 0 <= arg_711_1.time_ and arg_711_1.time_ < 0 + var_714_0 then
				arg_711_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_711_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_711_1.time_ - 0) / var_714_0)
				arg_711_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_711_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_711_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_711_1.actors_["1049ui_story"].transform.position).z)
				arg_711_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_711_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_711_1.actors_["1049ui_story"].transform.localEulerAngles = arg_711_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_711_1.time_ >= 0 + var_714_0 and arg_711_1.time_ < 0 + var_714_0 + arg_714_0 then
				arg_711_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_711_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_711_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_711_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_711_1.actors_["1049ui_story"].transform.position).z)
				arg_711_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_711_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_711_1.actors_["1049ui_story"].transform.localEulerAngles = arg_711_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_714_1 = arg_711_1.actors_["1049ui_story"]

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= 0 + arg_714_0 and not isNil(var_714_1) and arg_711_1.var_.characterEffect1049ui_story == nil then
				arg_711_1.var_.characterEffect1049ui_story = var_714_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_714_2 = 0.200000002980232

			if 0 <= arg_711_1.time_ and arg_711_1.time_ < 0 + var_714_2 and not isNil(var_714_1) then
				if arg_711_1.var_.characterEffect1049ui_story and not isNil(var_714_1) then
					arg_711_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_711_1.time_ >= 0 + var_714_2 and arg_711_1.time_ < 0 + var_714_2 + arg_714_0 and not isNil(var_714_1) and arg_711_1.var_.characterEffect1049ui_story then
				arg_711_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= 0 + arg_714_0 then
				arg_711_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= 0 + arg_714_0 then
				arg_711_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_714_4 = 0
			local var_714_5 = 0.225

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= var_714_4 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0
				arg_711_1.dialogCg_.alpha = 1

				arg_711_1.dialog_:SetActive(true)
				SetActive(arg_711_1.leftNameGo_, true)

				arg_711_1.leftNameTxt_.text = arg_711_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_711_1.leftNameTxt_.transform)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1.leftNameTxt_.text)
				SetActive(arg_711_1.iconTrs_.gameObject, false)
				arg_711_1.callingController_:SetSelectedState("normal")

				local var_714_6 = arg_711_1:GetWordFromCfg(1104906173)
				local var_714_7 = arg_711_1:FormatText(var_714_6.content)

				arg_711_1.text_.text = var_714_7

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_9 = 9 <= 0 and var_714_5 or var_714_5 * (utf8.len(var_714_7) / 9)

				if (9 <= 0 and var_714_5 or var_714_5 * (utf8.len(var_714_7) / 9)) > 0 and var_714_5 < var_714_9 then
					arg_711_1.talkMaxDuration = var_714_9

					if var_714_9 + var_714_4 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_9 + var_714_4
					end
				end

				arg_711_1.text_.text = var_714_7
				arg_711_1.typewritter.percent = 0

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906173", "story_v_side_new_1104906.awb") ~= 0 then
					local var_714_10 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906173", "story_v_side_new_1104906.awb") / 1000

					if var_714_10 + var_714_4 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_10 + var_714_4
					end

					if var_714_6.prefab_name ~= "" and arg_711_1.actors_[var_714_6.prefab_name] ~= nil then
						local var_714_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_711_1.actors_[var_714_6.prefab_name].transform, "story_v_side_new_1104906", "1104906173", "story_v_side_new_1104906.awb")

						arg_711_1:RecordAudio("1104906173", var_714_11)
						arg_711_1:RecordAudio("1104906173", var_714_11)
					else
						arg_711_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906173", "story_v_side_new_1104906.awb")
					end

					arg_711_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906173", "story_v_side_new_1104906.awb")
				end

				arg_711_1:RecordContent(arg_711_1.text_.text)
			end

			local var_714_12 = math.max(var_714_5, arg_711_1.talkMaxDuration)

			if var_714_4 <= arg_711_1.time_ and arg_711_1.time_ < var_714_4 + var_714_12 then
				arg_711_1.typewritter.percent = (arg_711_1.time_ - var_714_4) / var_714_12

				arg_711_1.typewritter:SetDirty()
			end

			if arg_711_1.time_ >= var_714_4 + var_714_12 and arg_711_1.time_ < var_714_4 + var_714_12 + arg_714_0 then
				arg_711_1.typewritter.percent = 1

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(true)
			end
		end

		arg_711_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_711_1:InitPlayNodeList()
	end,
	Play1104906174 = function(arg_715_0, arg_715_1)
		arg_715_1.time_ = 0
		arg_715_1.frameCnt_ = 0
		arg_715_1.state_ = "playing"
		arg_715_1.curTalkId_ = 1104906174
		arg_715_1.duration_ = 5

		SetActive(arg_715_1.tipsGo_, false)

		function arg_715_1.onSingleLineFinish_()
			arg_715_1.onSingleLineUpdate_ = nil
			arg_715_1.onSingleLineFinish_ = nil
			arg_715_1.state_ = "waiting"
		end

		function arg_715_1.playNext_(arg_717_0)
			if arg_717_0 == 1 then
				arg_715_0:Play1104906175(arg_715_1)
			end
		end

		function arg_715_1.onSingleLineUpdate_(arg_718_0)
			if 0 < arg_715_1.time_ and arg_715_1.time_ <= 0 + arg_718_0 and not isNil(arg_715_1.actors_["1049ui_story"]) and arg_715_1.var_.characterEffect1049ui_story == nil then
				arg_715_1.var_.characterEffect1049ui_story = arg_715_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_718_0 = 0.200000002980232

			if 0 <= arg_715_1.time_ and arg_715_1.time_ < 0 + var_718_0 and not isNil(arg_715_1.actors_["1049ui_story"]) then
				if arg_715_1.var_.characterEffect1049ui_story and not isNil(arg_715_1.actors_["1049ui_story"]) then
					arg_715_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_715_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_715_1.time_ - 0) / var_718_0)
				end
			end

			if arg_715_1.time_ >= 0 + var_718_0 and arg_715_1.time_ < 0 + var_718_0 + arg_718_0 and not isNil(arg_715_1.actors_["1049ui_story"]) and arg_715_1.var_.characterEffect1049ui_story then
				arg_715_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_715_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_718_1 = 0
			local var_718_2 = 0.7

			if 0 < arg_715_1.time_ and arg_715_1.time_ <= var_718_1 + arg_718_0 then
				arg_715_1.talkMaxDuration = 0
				arg_715_1.dialogCg_.alpha = 1

				arg_715_1.dialog_:SetActive(true)
				SetActive(arg_715_1.leftNameGo_, false)

				arg_715_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_715_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_715_1:RecordName(arg_715_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_715_1.iconTrs_.gameObject, false)
				arg_715_1.callingController_:SetSelectedState("normal")

				local var_718_3 = arg_715_1:FormatText(arg_715_1:GetWordFromCfg(1104906174).content)

				arg_715_1.text_.text = var_718_3

				LuaForUtil.ClearLinePrefixSymbol(arg_715_1.text_)

				local var_718_5 = 28 <= 0 and var_718_2 or var_718_2 * (utf8.len(var_718_3) / 28)

				if (28 <= 0 and var_718_2 or var_718_2 * (utf8.len(var_718_3) / 28)) > 0 and var_718_2 < var_718_5 then
					arg_715_1.talkMaxDuration = var_718_5

					if var_718_5 + var_718_1 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_5 + var_718_1
					end
				end

				arg_715_1.text_.text = var_718_3
				arg_715_1.typewritter.percent = 0

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(false)
				arg_715_1:RecordContent(arg_715_1.text_.text)
			end

			local var_718_6 = math.max(var_718_2, arg_715_1.talkMaxDuration)

			if var_718_1 <= arg_715_1.time_ and arg_715_1.time_ < var_718_1 + var_718_6 then
				arg_715_1.typewritter.percent = (arg_715_1.time_ - var_718_1) / var_718_6

				arg_715_1.typewritter:SetDirty()
			end

			if arg_715_1.time_ >= var_718_1 + var_718_6 and arg_715_1.time_ < var_718_1 + var_718_6 + arg_718_0 then
				arg_715_1.typewritter.percent = 1

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(true)
			end
		end

		arg_715_1.nodeConfigList_ = {}

		arg_715_1:InitPlayNodeList()
	end,
	Play1104906175 = function(arg_719_0, arg_719_1)
		arg_719_1.time_ = 0
		arg_719_1.frameCnt_ = 0
		arg_719_1.state_ = "playing"
		arg_719_1.curTalkId_ = 1104906175
		arg_719_1.duration_ = 5

		SetActive(arg_719_1.tipsGo_, false)

		function arg_719_1.onSingleLineFinish_()
			arg_719_1.onSingleLineUpdate_ = nil
			arg_719_1.onSingleLineFinish_ = nil
			arg_719_1.state_ = "waiting"
		end

		function arg_719_1.playNext_(arg_721_0)
			if arg_721_0 == 1 then
				arg_719_0:Play1104906176(arg_719_1)
			end
		end

		function arg_719_1.onSingleLineUpdate_(arg_722_0)
			local var_722_0 = 0.175

			if 0 < arg_719_1.time_ and arg_719_1.time_ <= 0 + arg_722_0 then
				arg_719_1.talkMaxDuration = 0
				arg_719_1.dialogCg_.alpha = 1

				arg_719_1.dialog_:SetActive(true)
				SetActive(arg_719_1.leftNameGo_, true)

				arg_719_1.leftNameTxt_.text = arg_719_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_719_1.leftNameTxt_.transform)

				arg_719_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_719_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_719_1:RecordName(arg_719_1.leftNameTxt_.text)
				SetActive(arg_719_1.iconTrs_.gameObject, true)
				arg_719_1.iconController_:SetSelectedState("hero")

				arg_719_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_719_1.callingController_:SetSelectedState("normal")

				arg_719_1.keyicon_.color = Color.New(1, 1, 1)
				arg_719_1.icon_.color = Color.New(1, 1, 1)

				local var_722_1 = arg_719_1:FormatText(arg_719_1:GetWordFromCfg(1104906175).content)

				arg_719_1.text_.text = var_722_1

				LuaForUtil.ClearLinePrefixSymbol(arg_719_1.text_)

				local var_722_3 = 7 <= 0 and var_722_0 or var_722_0 * (utf8.len(var_722_1) / 7)

				if (7 <= 0 and var_722_0 or var_722_0 * (utf8.len(var_722_1) / 7)) > 0 and var_722_0 < var_722_3 then
					arg_719_1.talkMaxDuration = var_722_3

					if var_722_3 + 0 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_3 + 0
					end
				end

				arg_719_1.text_.text = var_722_1
				arg_719_1.typewritter.percent = 0

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(false)
				arg_719_1:RecordContent(arg_719_1.text_.text)
			end

			local var_722_4 = math.max(var_722_0, arg_719_1.talkMaxDuration)

			if 0 <= arg_719_1.time_ and arg_719_1.time_ < 0 + var_722_4 then
				arg_719_1.typewritter.percent = (arg_719_1.time_ - 0) / var_722_4

				arg_719_1.typewritter:SetDirty()
			end

			if arg_719_1.time_ >= 0 + var_722_4 and arg_719_1.time_ < 0 + var_722_4 + arg_722_0 then
				arg_719_1.typewritter.percent = 1

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(true)
			end
		end

		arg_719_1.nodeConfigList_ = {}

		arg_719_1:InitPlayNodeList()
	end,
	Play1104906176 = function(arg_723_0, arg_723_1)
		arg_723_1.time_ = 0
		arg_723_1.frameCnt_ = 0
		arg_723_1.state_ = "playing"
		arg_723_1.curTalkId_ = 1104906176
		arg_723_1.duration_ = 11.9

		SetActive(arg_723_1.tipsGo_, false)

		function arg_723_1.onSingleLineFinish_()
			arg_723_1.onSingleLineUpdate_ = nil
			arg_723_1.onSingleLineFinish_ = nil
			arg_723_1.state_ = "waiting"
		end

		function arg_723_1.playNext_(arg_725_0)
			if arg_725_0 == 1 then
				arg_723_0:Play1104906177(arg_723_1)
			end
		end

		function arg_723_1.onSingleLineUpdate_(arg_726_0)
			if arg_723_1.bgs_.K12h == nil then
				local var_726_0 = Object.Instantiate(arg_723_1.paintGo_)

				var_726_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K12h")
				var_726_0.name = "K12h"
				var_726_0.transform.parent = arg_723_1.stage_.transform
				var_726_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_723_1.bgs_.K12h = var_726_0
			end

			if 2.00000000298023 < arg_723_1.time_ and arg_723_1.time_ <= 2.00000000298023 + arg_726_0 then
				local var_726_1 = arg_723_1.bgs_.K12h

				arg_723_1.bgs_.K12h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_726_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_726_2 = var_726_1:GetComponent("SpriteRenderer")

				if var_726_2 and var_726_2.sprite then
					local var_726_3 = 2 * (var_726_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_726_1.transform.localScale = Vector3.New(var_726_3 / var_726_2.sprite.bounds.size.y < var_726_3 * manager.ui.mainCameraCom_.aspect / var_726_2.sprite.bounds.size.x and var_726_3 * manager.ui.mainCameraCom_.aspect / var_726_2.sprite.bounds.size.x or var_726_3 / var_726_2.sprite.bounds.size.y, var_726_3 / var_726_2.sprite.bounds.size.y < var_726_3 * manager.ui.mainCameraCom_.aspect / var_726_2.sprite.bounds.size.x and var_726_3 * manager.ui.mainCameraCom_.aspect / var_726_2.sprite.bounds.size.x or var_726_3 / var_726_2.sprite.bounds.size.y, 0)
				end

				for iter_726_0, iter_726_1 in pairs(arg_723_1.bgs_) do
					if iter_726_0 ~= "K12h" then
						iter_726_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_726_4 = 4

			if 4 < arg_723_1.time_ and arg_723_1.time_ <= var_726_4 + arg_726_0 then
				arg_723_1.allBtn_.enabled = false
			end

			if arg_723_1.time_ >= var_726_4 + 0.3 and arg_723_1.time_ < var_726_4 + 0.3 + arg_726_0 then
				arg_723_1.allBtn_.enabled = true
			end

			local var_726_5 = 0

			if 0 < arg_723_1.time_ and arg_723_1.time_ <= var_726_5 + arg_726_0 then
				arg_723_1.mask_.enabled = true
				arg_723_1.mask_.raycastTarget = true

				arg_723_1:SetGaussion(false)
			end

			local var_726_6 = 2

			if var_726_5 <= arg_723_1.time_ and arg_723_1.time_ < var_726_5 + var_726_6 then
				local var_726_7 = Color.New(0, 0, 0)

				var_726_7.a = Mathf.Lerp(0, 1, (arg_723_1.time_ - var_726_5) / var_726_6)
				arg_723_1.mask_.color = var_726_7
			end

			if arg_723_1.time_ >= var_726_5 + var_726_6 and arg_723_1.time_ < var_726_5 + var_726_6 + arg_726_0 then
				local var_726_8 = Color.New(0, 0, 0)

				var_726_8.a = 1
				arg_723_1.mask_.color = var_726_8
			end

			local var_726_9 = 2

			if 2 < arg_723_1.time_ and arg_723_1.time_ <= var_726_9 + arg_726_0 then
				arg_723_1.mask_.enabled = true
				arg_723_1.mask_.raycastTarget = true

				arg_723_1:SetGaussion(false)
			end

			local var_726_10 = 2

			if var_726_9 <= arg_723_1.time_ and arg_723_1.time_ < var_726_9 + var_726_10 then
				local var_726_11 = Color.New(0, 0, 0)

				var_726_11.a = Mathf.Lerp(1, 0, (arg_723_1.time_ - var_726_9) / var_726_10)
				arg_723_1.mask_.color = var_726_11
			end

			if arg_723_1.time_ >= var_726_9 + var_726_10 and arg_723_1.time_ < var_726_9 + var_726_10 + arg_726_0 then
				local var_726_12 = Color.New(0, 0, 0)

				arg_723_1.mask_.enabled = false
				var_726_12.a = 0
				arg_723_1.mask_.color = var_726_12
			end

			local var_726_13 = arg_723_1.actors_["1049ui_story"]

			if 3.8 < arg_723_1.time_ and arg_723_1.time_ <= 3.8 + arg_726_0 and not isNil(var_726_13) and arg_723_1.var_.characterEffect1049ui_story == nil then
				arg_723_1.var_.characterEffect1049ui_story = var_726_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_726_14 = 0.200000002980232

			if 3.8 <= arg_723_1.time_ and arg_723_1.time_ < 3.8 + var_726_14 and not isNil(var_726_13) then
				if arg_723_1.var_.characterEffect1049ui_story and not isNil(var_726_13) then
					arg_723_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_723_1.time_ >= 3.8 + var_726_14 and arg_723_1.time_ < 3.8 + var_726_14 + arg_726_0 and not isNil(var_726_13) and arg_723_1.var_.characterEffect1049ui_story then
				arg_723_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 3.8 < arg_723_1.time_ and arg_723_1.time_ <= 3.8 + arg_726_0 then
				arg_723_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 3.8 < arg_723_1.time_ and arg_723_1.time_ <= 3.8 + arg_726_0 then
				arg_723_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_726_16 = arg_723_1.actors_["1049ui_story"].transform

			if 1.98333333333333 < arg_723_1.time_ and arg_723_1.time_ <= 1.98333333333333 + arg_726_0 then
				arg_723_1.var_.moveOldPos1049ui_story = var_726_16.localPosition
			end

			local var_726_17 = 0.001

			if 1.98333333333333 <= arg_723_1.time_ and arg_723_1.time_ < 1.98333333333333 + var_726_17 then
				var_726_16.localPosition = Vector3.Lerp(arg_723_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_723_1.time_ - 1.98333333333333) / var_726_17)
				var_726_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_726_16.position).x, (manager.ui.mainCamera.transform.position - var_726_16.position).y, (manager.ui.mainCamera.transform.position - var_726_16.position).z)
				var_726_16.localEulerAngles.z = 0
				var_726_16.localEulerAngles.x = 0
				var_726_16.localEulerAngles = var_726_16.localEulerAngles
			end

			if arg_723_1.time_ >= 1.98333333333333 + var_726_17 and arg_723_1.time_ < 1.98333333333333 + var_726_17 + arg_726_0 then
				var_726_16.localPosition = Vector3.New(0, 100, 0)
				var_726_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_726_16.position).x, (manager.ui.mainCamera.transform.position - var_726_16.position).y, (manager.ui.mainCamera.transform.position - var_726_16.position).z)
				var_726_16.localEulerAngles.z = 0
				var_726_16.localEulerAngles.x = 0
				var_726_16.localEulerAngles = var_726_16.localEulerAngles
			end

			local var_726_18 = arg_723_1.actors_["1049ui_story"].transform

			if 3.8 < arg_723_1.time_ and arg_723_1.time_ <= 3.8 + arg_726_0 then
				arg_723_1.var_.moveOldPos1049ui_story = var_726_18.localPosition
			end

			local var_726_19 = 0.001

			if 3.8 <= arg_723_1.time_ and arg_723_1.time_ < 3.8 + var_726_19 then
				var_726_18.localPosition = Vector3.Lerp(arg_723_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_723_1.time_ - 3.8) / var_726_19)
				var_726_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_726_18.position).x, (manager.ui.mainCamera.transform.position - var_726_18.position).y, (manager.ui.mainCamera.transform.position - var_726_18.position).z)
				var_726_18.localEulerAngles.z = 0
				var_726_18.localEulerAngles.x = 0
				var_726_18.localEulerAngles = var_726_18.localEulerAngles
			end

			if arg_723_1.time_ >= 3.8 + var_726_19 and arg_723_1.time_ < 3.8 + var_726_19 + arg_726_0 then
				var_726_18.localPosition = Vector3.New(0, -1.2, -6)
				var_726_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_726_18.position).x, (manager.ui.mainCamera.transform.position - var_726_18.position).y, (manager.ui.mainCamera.transform.position - var_726_18.position).z)
				var_726_18.localEulerAngles.z = 0
				var_726_18.localEulerAngles.x = 0
				var_726_18.localEulerAngles = var_726_18.localEulerAngles
			end

			local var_726_20 = 1.98333333333333

			arg_723_1.isInRecall_ = false

			if var_726_20 < arg_723_1.time_ and arg_723_1.time_ <= var_726_20 + arg_726_0 then
				arg_723_1.screenFilterGo_:SetActive(true)

				arg_723_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_726_2, iter_726_3 in pairs(arg_723_1.actors_) do
					for iter_726_4, iter_726_5 in ipairs((iter_726_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_726_5.color = iter_726_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_726_21 = 0.2

			if var_726_20 <= arg_723_1.time_ and arg_723_1.time_ < var_726_20 + var_726_21 then
				arg_723_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_723_1.time_ - var_726_20) / var_726_21)
			end

			if arg_723_1.time_ >= var_726_20 + var_726_21 and arg_723_1.time_ < var_726_20 + var_726_21 + arg_726_0 then
				arg_723_1.screenFilterEffect_.weight = 1
			end

			if 0.6 < arg_723_1.time_ and arg_723_1.time_ <= 0.6 + arg_726_0 then
				arg_723_1:AudioAction("stop", "effect", "se_story_side_1049", "se_story_side_1049_amb_wind_leaves", "")
			end

			if 2.36666666666667 < arg_723_1.time_ and arg_723_1.time_ <= 2.36666666666667 + arg_726_0 then
				arg_723_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if arg_723_1.frameCnt_ <= 1 then
				arg_723_1.dialog_:SetActive(false)
			end

			local var_726_24 = 4.00000000298023
			local var_726_25 = 0.85

			if 4.00000000298023 < arg_723_1.time_ and arg_723_1.time_ <= var_726_24 + arg_726_0 then
				arg_723_1.talkMaxDuration = 0

				arg_723_1.dialog_:SetActive(true)

				arg_723_1.dialogCg_.alpha = 0

				local var_726_26 = LeanTween.value(arg_723_1.dialog_, 0, 1, 0.3)

				var_726_26:setOnUpdate(LuaHelper.FloatAction(function(arg_727_0)
					arg_723_1.dialogCg_.alpha = arg_727_0
				end))
				var_726_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_723_1.dialog_)
					var_726_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_723_1.duration_ = arg_723_1.duration_ + 0.3

				SetActive(arg_723_1.leftNameGo_, true)

				arg_723_1.leftNameTxt_.text = arg_723_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_723_1.leftNameTxt_.transform)

				arg_723_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_723_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_723_1:RecordName(arg_723_1.leftNameTxt_.text)
				SetActive(arg_723_1.iconTrs_.gameObject, false)
				arg_723_1.callingController_:SetSelectedState("normal")

				local var_726_27 = arg_723_1:GetWordFromCfg(1104906176)
				local var_726_28 = arg_723_1:FormatText(var_726_27.content)

				arg_723_1.text_.text = var_726_28

				LuaForUtil.ClearLinePrefixSymbol(arg_723_1.text_)

				local var_726_30 = 34 <= 0 and var_726_25 or var_726_25 * (utf8.len(var_726_28) / 34)

				if (34 <= 0 and var_726_25 or var_726_25 * (utf8.len(var_726_28) / 34)) > 0 and var_726_25 < var_726_30 then
					arg_723_1.talkMaxDuration = var_726_30
					var_726_24 = var_726_24 + 0.3

					if var_726_30 + var_726_24 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_30 + var_726_24
					end
				end

				arg_723_1.text_.text = var_726_28
				arg_723_1.typewritter.percent = 0

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906176", "story_v_side_new_1104906.awb") ~= 0 then
					local var_726_31 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906176", "story_v_side_new_1104906.awb") / 1000

					if var_726_31 + var_726_24 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_31 + var_726_24
					end

					if var_726_27.prefab_name ~= "" and arg_723_1.actors_[var_726_27.prefab_name] ~= nil then
						local var_726_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_723_1.actors_[var_726_27.prefab_name].transform, "story_v_side_new_1104906", "1104906176", "story_v_side_new_1104906.awb")

						arg_723_1:RecordAudio("1104906176", var_726_32)
						arg_723_1:RecordAudio("1104906176", var_726_32)
					else
						arg_723_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906176", "story_v_side_new_1104906.awb")
					end

					arg_723_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906176", "story_v_side_new_1104906.awb")
				end

				arg_723_1:RecordContent(arg_723_1.text_.text)
			end

			local var_726_33 = var_726_24 + 0.3
			local var_726_34 = math.max(var_726_25, arg_723_1.talkMaxDuration)

			if var_726_24 + 0.3 <= arg_723_1.time_ and arg_723_1.time_ < var_726_33 + var_726_34 then
				arg_723_1.typewritter.percent = (arg_723_1.time_ - var_726_33) / var_726_34

				arg_723_1.typewritter:SetDirty()
			end

			if arg_723_1.time_ >= var_726_33 + var_726_34 and arg_723_1.time_ < var_726_33 + var_726_34 + arg_726_0 then
				arg_723_1.typewritter.percent = 1

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(true)
			end
		end

		arg_723_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_723_1:InitPlayNodeList()
	end,
	Play1104906177 = function(arg_729_0, arg_729_1)
		arg_729_1.time_ = 0
		arg_729_1.frameCnt_ = 0
		arg_729_1.state_ = "playing"
		arg_729_1.curTalkId_ = 1104906177
		arg_729_1.duration_ = 17.47

		SetActive(arg_729_1.tipsGo_, false)

		function arg_729_1.onSingleLineFinish_()
			arg_729_1.onSingleLineUpdate_ = nil
			arg_729_1.onSingleLineFinish_ = nil
			arg_729_1.state_ = "waiting"
		end

		function arg_729_1.playNext_(arg_731_0)
			if arg_731_0 == 1 then
				arg_729_0:Play1104906178(arg_729_1)
			end
		end

		function arg_729_1.onSingleLineUpdate_(arg_732_0)
			if 0 < arg_729_1.time_ and arg_729_1.time_ <= 0 + arg_732_0 then
				arg_729_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_729_1.time_ and arg_729_1.time_ <= 0 + arg_732_0 then
				arg_729_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_732_0 = 0
			local var_732_1 = 1.525

			if 0 < arg_729_1.time_ and arg_729_1.time_ <= var_732_0 + arg_732_0 then
				arg_729_1.talkMaxDuration = 0
				arg_729_1.dialogCg_.alpha = 1

				arg_729_1.dialog_:SetActive(true)
				SetActive(arg_729_1.leftNameGo_, true)

				arg_729_1.leftNameTxt_.text = arg_729_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_729_1.leftNameTxt_.transform)

				arg_729_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_729_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_729_1:RecordName(arg_729_1.leftNameTxt_.text)
				SetActive(arg_729_1.iconTrs_.gameObject, false)
				arg_729_1.callingController_:SetSelectedState("normal")

				local var_732_2 = arg_729_1:GetWordFromCfg(1104906177)
				local var_732_3 = arg_729_1:FormatText(var_732_2.content)

				arg_729_1.text_.text = var_732_3

				LuaForUtil.ClearLinePrefixSymbol(arg_729_1.text_)

				local var_732_5 = 61 <= 0 and var_732_1 or var_732_1 * (utf8.len(var_732_3) / 61)

				if (61 <= 0 and var_732_1 or var_732_1 * (utf8.len(var_732_3) / 61)) > 0 and var_732_1 < var_732_5 then
					arg_729_1.talkMaxDuration = var_732_5

					if var_732_5 + var_732_0 > arg_729_1.duration_ then
						arg_729_1.duration_ = var_732_5 + var_732_0
					end
				end

				arg_729_1.text_.text = var_732_3
				arg_729_1.typewritter.percent = 0

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906177", "story_v_side_new_1104906.awb") ~= 0 then
					local var_732_6 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906177", "story_v_side_new_1104906.awb") / 1000

					if var_732_6 + var_732_0 > arg_729_1.duration_ then
						arg_729_1.duration_ = var_732_6 + var_732_0
					end

					if var_732_2.prefab_name ~= "" and arg_729_1.actors_[var_732_2.prefab_name] ~= nil then
						local var_732_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_729_1.actors_[var_732_2.prefab_name].transform, "story_v_side_new_1104906", "1104906177", "story_v_side_new_1104906.awb")

						arg_729_1:RecordAudio("1104906177", var_732_7)
						arg_729_1:RecordAudio("1104906177", var_732_7)
					else
						arg_729_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906177", "story_v_side_new_1104906.awb")
					end

					arg_729_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906177", "story_v_side_new_1104906.awb")
				end

				arg_729_1:RecordContent(arg_729_1.text_.text)
			end

			local var_732_8 = math.max(var_732_1, arg_729_1.talkMaxDuration)

			if var_732_0 <= arg_729_1.time_ and arg_729_1.time_ < var_732_0 + var_732_8 then
				arg_729_1.typewritter.percent = (arg_729_1.time_ - var_732_0) / var_732_8

				arg_729_1.typewritter:SetDirty()
			end

			if arg_729_1.time_ >= var_732_0 + var_732_8 and arg_729_1.time_ < var_732_0 + var_732_8 + arg_732_0 then
				arg_729_1.typewritter.percent = 1

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(true)
			end
		end

		arg_729_1.nodeConfigList_ = {}

		arg_729_1:InitPlayNodeList()
	end,
	Play1104906178 = function(arg_733_0, arg_733_1)
		arg_733_1.time_ = 0
		arg_733_1.frameCnt_ = 0
		arg_733_1.state_ = "playing"
		arg_733_1.curTalkId_ = 1104906178
		arg_733_1.duration_ = 9

		SetActive(arg_733_1.tipsGo_, false)

		function arg_733_1.onSingleLineFinish_()
			arg_733_1.onSingleLineUpdate_ = nil
			arg_733_1.onSingleLineFinish_ = nil
			arg_733_1.state_ = "waiting"
		end

		function arg_733_1.playNext_(arg_735_0)
			if arg_735_0 == 1 then
				arg_733_0:Play1104906179(arg_733_1)
			end
		end

		function arg_733_1.onSingleLineUpdate_(arg_736_0)
			if 2 < arg_733_1.time_ and arg_733_1.time_ <= 2 + arg_736_0 then
				local var_736_0 = arg_733_1.bgs_.K10g

				arg_733_1.bgs_.K10g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_736_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_736_1 = var_736_0:GetComponent("SpriteRenderer")

				if var_736_1 and var_736_1.sprite then
					local var_736_2 = 2 * (var_736_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_736_0.transform.localScale = Vector3.New(var_736_2 / var_736_1.sprite.bounds.size.y < var_736_2 * manager.ui.mainCameraCom_.aspect / var_736_1.sprite.bounds.size.x and var_736_2 * manager.ui.mainCameraCom_.aspect / var_736_1.sprite.bounds.size.x or var_736_2 / var_736_1.sprite.bounds.size.y, var_736_2 / var_736_1.sprite.bounds.size.y < var_736_2 * manager.ui.mainCameraCom_.aspect / var_736_1.sprite.bounds.size.x and var_736_2 * manager.ui.mainCameraCom_.aspect / var_736_1.sprite.bounds.size.x or var_736_2 / var_736_1.sprite.bounds.size.y, 0)
				end

				for iter_736_0, iter_736_1 in pairs(arg_733_1.bgs_) do
					if iter_736_0 ~= "K10g" then
						iter_736_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_736_3 = 4

			if 4 < arg_733_1.time_ and arg_733_1.time_ <= var_736_3 + arg_736_0 then
				arg_733_1.allBtn_.enabled = false
			end

			if arg_733_1.time_ >= var_736_3 + 0.3 and arg_733_1.time_ < var_736_3 + 0.3 + arg_736_0 then
				arg_733_1.allBtn_.enabled = true
			end

			local var_736_4 = 0

			if 0 < arg_733_1.time_ and arg_733_1.time_ <= var_736_4 + arg_736_0 then
				arg_733_1.mask_.enabled = true
				arg_733_1.mask_.raycastTarget = true

				arg_733_1:SetGaussion(false)
			end

			local var_736_5 = 2

			if var_736_4 <= arg_733_1.time_ and arg_733_1.time_ < var_736_4 + var_736_5 then
				local var_736_6 = Color.New(0, 0, 0)

				var_736_6.a = Mathf.Lerp(0, 1, (arg_733_1.time_ - var_736_4) / var_736_5)
				arg_733_1.mask_.color = var_736_6
			end

			if arg_733_1.time_ >= var_736_4 + var_736_5 and arg_733_1.time_ < var_736_4 + var_736_5 + arg_736_0 then
				local var_736_7 = Color.New(0, 0, 0)

				var_736_7.a = 1
				arg_733_1.mask_.color = var_736_7
			end

			local var_736_8 = 2

			if 2 < arg_733_1.time_ and arg_733_1.time_ <= var_736_8 + arg_736_0 then
				arg_733_1.mask_.enabled = true
				arg_733_1.mask_.raycastTarget = true

				arg_733_1:SetGaussion(false)
			end

			local var_736_9 = 2

			if var_736_8 <= arg_733_1.time_ and arg_733_1.time_ < var_736_8 + var_736_9 then
				local var_736_10 = Color.New(0, 0, 0)

				var_736_10.a = Mathf.Lerp(1, 0, (arg_733_1.time_ - var_736_8) / var_736_9)
				arg_733_1.mask_.color = var_736_10
			end

			if arg_733_1.time_ >= var_736_8 + var_736_9 and arg_733_1.time_ < var_736_8 + var_736_9 + arg_736_0 then
				local var_736_11 = Color.New(0, 0, 0)

				arg_733_1.mask_.enabled = false
				var_736_11.a = 0
				arg_733_1.mask_.color = var_736_11
			end

			local var_736_12 = arg_733_1.actors_["1049ui_story"]

			if 2 < arg_733_1.time_ and arg_733_1.time_ <= 2 + arg_736_0 and not isNil(var_736_12) and arg_733_1.var_.characterEffect1049ui_story == nil then
				arg_733_1.var_.characterEffect1049ui_story = var_736_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_736_13 = 0.0166666666666666

			if 2 <= arg_733_1.time_ and arg_733_1.time_ < 2 + var_736_13 and not isNil(var_736_12) then
				if arg_733_1.var_.characterEffect1049ui_story and not isNil(var_736_12) then
					arg_733_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_733_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_733_1.time_ - 2) / var_736_13)
				end
			end

			if arg_733_1.time_ >= 2 + var_736_13 and arg_733_1.time_ < 2 + var_736_13 + arg_736_0 and not isNil(var_736_12) and arg_733_1.var_.characterEffect1049ui_story then
				arg_733_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_733_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_736_14 = 2

			arg_733_1.isInRecall_ = false

			if var_736_14 < arg_733_1.time_ and arg_733_1.time_ <= var_736_14 + arg_736_0 then
				arg_733_1.screenFilterGo_:SetActive(false)

				for iter_736_2, iter_736_3 in pairs(arg_733_1.actors_) do
					for iter_736_4, iter_736_5 in ipairs((iter_736_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_736_5.color = iter_736_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_736_15 = 0.0166666666666667

			if var_736_14 <= arg_733_1.time_ and arg_733_1.time_ < var_736_14 + var_736_15 then
				arg_733_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_733_1.time_ - var_736_14) / var_736_15)
			end

			if arg_733_1.time_ >= var_736_14 + var_736_15 and arg_733_1.time_ < var_736_14 + var_736_15 + arg_736_0 then
				arg_733_1.screenFilterEffect_.weight = 0
			end

			local var_736_16 = arg_733_1.actors_["1049ui_story"].transform

			if 2 < arg_733_1.time_ and arg_733_1.time_ <= 2 + arg_736_0 then
				arg_733_1.var_.moveOldPos1049ui_story = var_736_16.localPosition
			end

			local var_736_17 = 0.0666666666666669

			if 2 <= arg_733_1.time_ and arg_733_1.time_ < 2 + var_736_17 then
				var_736_16.localPosition = Vector3.Lerp(arg_733_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_733_1.time_ - 2) / var_736_17)
				var_736_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_736_16.position).x, (manager.ui.mainCamera.transform.position - var_736_16.position).y, (manager.ui.mainCamera.transform.position - var_736_16.position).z)
				var_736_16.localEulerAngles.z = 0
				var_736_16.localEulerAngles.x = 0
				var_736_16.localEulerAngles = var_736_16.localEulerAngles
			end

			if arg_733_1.time_ >= 2 + var_736_17 and arg_733_1.time_ < 2 + var_736_17 + arg_736_0 then
				var_736_16.localPosition = Vector3.New(0, 100, 0)
				var_736_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_736_16.position).x, (manager.ui.mainCamera.transform.position - var_736_16.position).y, (manager.ui.mainCamera.transform.position - var_736_16.position).z)
				var_736_16.localEulerAngles.z = 0
				var_736_16.localEulerAngles.x = 0
				var_736_16.localEulerAngles = var_736_16.localEulerAngles
			end

			if 0.4 < arg_733_1.time_ and arg_733_1.time_ <= 0.4 + arg_736_0 then
				arg_733_1:AudioAction("stop", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if 1.63333333333333 < arg_733_1.time_ and arg_733_1.time_ <= 1.63333333333333 + arg_736_0 then
				arg_733_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_amb_wind_leaves", "")
			end

			if arg_733_1.frameCnt_ <= 1 then
				arg_733_1.dialog_:SetActive(false)
			end

			local var_736_20 = 4
			local var_736_21 = 0.975

			if 4 < arg_733_1.time_ and arg_733_1.time_ <= var_736_20 + arg_736_0 then
				arg_733_1.talkMaxDuration = 0

				arg_733_1.dialog_:SetActive(true)

				arg_733_1.dialogCg_.alpha = 0

				local var_736_22 = LeanTween.value(arg_733_1.dialog_, 0, 1, 0.3)

				var_736_22:setOnUpdate(LuaHelper.FloatAction(function(arg_737_0)
					arg_733_1.dialogCg_.alpha = arg_737_0
				end))
				var_736_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_733_1.dialog_)
					var_736_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_733_1.duration_ = arg_733_1.duration_ + 0.3

				SetActive(arg_733_1.leftNameGo_, false)

				arg_733_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_733_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_733_1:RecordName(arg_733_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_733_1.iconTrs_.gameObject, false)
				arg_733_1.callingController_:SetSelectedState("normal")

				local var_736_23 = arg_733_1:FormatText(arg_733_1:GetWordFromCfg(1104906178).content)

				arg_733_1.text_.text = var_736_23

				LuaForUtil.ClearLinePrefixSymbol(arg_733_1.text_)

				local var_736_25 = 39 <= 0 and var_736_21 or var_736_21 * (utf8.len(var_736_23) / 39)

				if (39 <= 0 and var_736_21 or var_736_21 * (utf8.len(var_736_23) / 39)) > 0 and var_736_21 < var_736_25 then
					arg_733_1.talkMaxDuration = var_736_25
					var_736_20 = var_736_20 + 0.3

					if var_736_25 + var_736_20 > arg_733_1.duration_ then
						arg_733_1.duration_ = var_736_25 + var_736_20
					end
				end

				arg_733_1.text_.text = var_736_23
				arg_733_1.typewritter.percent = 0

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(false)
				arg_733_1:RecordContent(arg_733_1.text_.text)
			end

			local var_736_26 = var_736_20 + 0.3
			local var_736_27 = math.max(var_736_21, arg_733_1.talkMaxDuration)

			if var_736_20 + 0.3 <= arg_733_1.time_ and arg_733_1.time_ < var_736_26 + var_736_27 then
				arg_733_1.typewritter.percent = (arg_733_1.time_ - var_736_26) / var_736_27

				arg_733_1.typewritter:SetDirty()
			end

			if arg_733_1.time_ >= var_736_26 + var_736_27 and arg_733_1.time_ < var_736_26 + var_736_27 + arg_736_0 then
				arg_733_1.typewritter.percent = 1

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(true)
			end
		end

		arg_733_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0666666666666669,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_733_1:InitPlayNodeList()
	end,
	Play1104906179 = function(arg_739_0, arg_739_1)
		arg_739_1.time_ = 0
		arg_739_1.frameCnt_ = 0
		arg_739_1.state_ = "playing"
		arg_739_1.curTalkId_ = 1104906179
		arg_739_1.duration_ = 6.73

		SetActive(arg_739_1.tipsGo_, false)

		function arg_739_1.onSingleLineFinish_()
			arg_739_1.onSingleLineUpdate_ = nil
			arg_739_1.onSingleLineFinish_ = nil
			arg_739_1.state_ = "waiting"
			arg_739_1.auto_ = false
		end

		function arg_739_1.playNext_(arg_741_0)
			arg_739_1.onStoryFinished_()
		end

		function arg_739_1.onSingleLineUpdate_(arg_742_0)
			if 0 < arg_739_1.time_ and arg_739_1.time_ <= 0 + arg_742_0 and not isNil(arg_739_1.actors_["1049ui_story"]) and arg_739_1.var_.characterEffect1049ui_story == nil then
				arg_739_1.var_.characterEffect1049ui_story = arg_739_1.actors_["1049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_742_0 = 0.200000002980232

			if 0 <= arg_739_1.time_ and arg_739_1.time_ < 0 + var_742_0 and not isNil(arg_739_1.actors_["1049ui_story"]) then
				if arg_739_1.var_.characterEffect1049ui_story and not isNil(arg_739_1.actors_["1049ui_story"]) then
					arg_739_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_739_1.time_ >= 0 + var_742_0 and arg_739_1.time_ < 0 + var_742_0 + arg_742_0 and not isNil(arg_739_1.actors_["1049ui_story"]) and arg_739_1.var_.characterEffect1049ui_story then
				arg_739_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_739_1.time_ and arg_739_1.time_ <= 0 + arg_742_0 then
				arg_739_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			if 0 < arg_739_1.time_ and arg_739_1.time_ <= 0 + arg_742_0 then
				arg_739_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_742_2 = arg_739_1.actors_["1049ui_story"].transform

			if 0 < arg_739_1.time_ and arg_739_1.time_ <= 0 + arg_742_0 then
				arg_739_1.var_.moveOldPos1049ui_story = var_742_2.localPosition
			end

			local var_742_3 = 0.001

			if 0 <= arg_739_1.time_ and arg_739_1.time_ < 0 + var_742_3 then
				var_742_2.localPosition = Vector3.Lerp(arg_739_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_739_1.time_ - 0) / var_742_3)
				var_742_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_742_2.position).x, (manager.ui.mainCamera.transform.position - var_742_2.position).y, (manager.ui.mainCamera.transform.position - var_742_2.position).z)
				var_742_2.localEulerAngles.z = 0
				var_742_2.localEulerAngles.x = 0
				var_742_2.localEulerAngles = var_742_2.localEulerAngles
			end

			if arg_739_1.time_ >= 0 + var_742_3 and arg_739_1.time_ < 0 + var_742_3 + arg_742_0 then
				var_742_2.localPosition = Vector3.New(0, -1.2, -6)
				var_742_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_742_2.position).x, (manager.ui.mainCamera.transform.position - var_742_2.position).y, (manager.ui.mainCamera.transform.position - var_742_2.position).z)
				var_742_2.localEulerAngles.z = 0
				var_742_2.localEulerAngles.x = 0
				var_742_2.localEulerAngles = var_742_2.localEulerAngles
			end

			local var_742_4 = 0
			local var_742_5 = 0.475

			if 0 < arg_739_1.time_ and arg_739_1.time_ <= var_742_4 + arg_742_0 then
				arg_739_1.talkMaxDuration = 0
				arg_739_1.dialogCg_.alpha = 1

				arg_739_1.dialog_:SetActive(true)
				SetActive(arg_739_1.leftNameGo_, true)

				arg_739_1.leftNameTxt_.text = arg_739_1:FormatText(StoryNameCfg[551].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_739_1.leftNameTxt_.transform)

				arg_739_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_739_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_739_1:RecordName(arg_739_1.leftNameTxt_.text)
				SetActive(arg_739_1.iconTrs_.gameObject, false)
				arg_739_1.callingController_:SetSelectedState("normal")

				local var_742_6 = arg_739_1:GetWordFromCfg(1104906179)
				local var_742_7 = arg_739_1:FormatText(var_742_6.content)

				arg_739_1.text_.text = var_742_7

				LuaForUtil.ClearLinePrefixSymbol(arg_739_1.text_)

				local var_742_9 = 20 <= 0 and var_742_5 or var_742_5 * (utf8.len(var_742_7) / 20)

				if (20 <= 0 and var_742_5 or var_742_5 * (utf8.len(var_742_7) / 20)) > 0 and var_742_5 < var_742_9 then
					arg_739_1.talkMaxDuration = var_742_9

					if var_742_9 + var_742_4 > arg_739_1.duration_ then
						arg_739_1.duration_ = var_742_9 + var_742_4
					end
				end

				arg_739_1.text_.text = var_742_7
				arg_739_1.typewritter.percent = 0

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906179", "story_v_side_new_1104906.awb") ~= 0 then
					local var_742_10 = manager.audio:GetVoiceLength("story_v_side_new_1104906", "1104906179", "story_v_side_new_1104906.awb") / 1000

					if var_742_10 + var_742_4 > arg_739_1.duration_ then
						arg_739_1.duration_ = var_742_10 + var_742_4
					end

					if var_742_6.prefab_name ~= "" and arg_739_1.actors_[var_742_6.prefab_name] ~= nil then
						local var_742_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_739_1.actors_[var_742_6.prefab_name].transform, "story_v_side_new_1104906", "1104906179", "story_v_side_new_1104906.awb")

						arg_739_1:RecordAudio("1104906179", var_742_11)
						arg_739_1:RecordAudio("1104906179", var_742_11)
					else
						arg_739_1:AudioAction("play", "voice", "story_v_side_new_1104906", "1104906179", "story_v_side_new_1104906.awb")
					end

					arg_739_1:RecordHistoryTalkVoice("story_v_side_new_1104906", "1104906179", "story_v_side_new_1104906.awb")
				end

				arg_739_1:RecordContent(arg_739_1.text_.text)
			end

			local var_742_12 = math.max(var_742_5, arg_739_1.talkMaxDuration)

			if var_742_4 <= arg_739_1.time_ and arg_739_1.time_ < var_742_4 + var_742_12 then
				arg_739_1.typewritter.percent = (arg_739_1.time_ - var_742_4) / var_742_12

				arg_739_1.typewritter:SetDirty()
			end

			if arg_739_1.time_ >= var_742_4 + var_742_12 and arg_739_1.time_ < var_742_4 + var_742_12 + arg_742_0 then
				arg_739_1.typewritter.percent = 1

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(true)
			end
		end

		arg_739_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_739_1:InitPlayNodeList()
	end,
	Play1104906069 = function(arg_743_0, arg_743_1)
		arg_743_1.time_ = 0
		arg_743_1.frameCnt_ = 0
		arg_743_1.state_ = "playing"
		arg_743_1.curTalkId_ = 1104906069
		arg_743_1.duration_ = 5

		SetActive(arg_743_1.tipsGo_, false)

		function arg_743_1.onSingleLineFinish_()
			arg_743_1.onSingleLineUpdate_ = nil
			arg_743_1.onSingleLineFinish_ = nil
			arg_743_1.state_ = "waiting"
		end

		function arg_743_1.playNext_(arg_745_0)
			if arg_745_0 == 1 then
				arg_743_0:Play1104906070(arg_743_1)
			end
		end

		function arg_743_1.onSingleLineUpdate_(arg_746_0)
			local var_746_0 = 0.65

			if 0 < arg_743_1.time_ and arg_743_1.time_ <= 0 + arg_746_0 then
				arg_743_1.talkMaxDuration = 0
				arg_743_1.dialogCg_.alpha = 1

				arg_743_1.dialog_:SetActive(true)
				SetActive(arg_743_1.leftNameGo_, true)

				arg_743_1.leftNameTxt_.text = arg_743_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_743_1.leftNameTxt_.transform)

				arg_743_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_743_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_743_1:RecordName(arg_743_1.leftNameTxt_.text)
				SetActive(arg_743_1.iconTrs_.gameObject, true)
				arg_743_1.iconController_:SetSelectedState("hero")

				arg_743_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_743_1.callingController_:SetSelectedState("normal")

				arg_743_1.keyicon_.color = Color.New(1, 1, 1)
				arg_743_1.icon_.color = Color.New(1, 1, 1)

				local var_746_1 = arg_743_1:FormatText(arg_743_1:GetWordFromCfg(1104906069).content)

				arg_743_1.text_.text = var_746_1

				LuaForUtil.ClearLinePrefixSymbol(arg_743_1.text_)

				local var_746_3 = 26 <= 0 and var_746_0 or var_746_0 * (utf8.len(var_746_1) / 26)

				if (26 <= 0 and var_746_0 or var_746_0 * (utf8.len(var_746_1) / 26)) > 0 and var_746_0 < var_746_3 then
					arg_743_1.talkMaxDuration = var_746_3

					if var_746_3 + 0 > arg_743_1.duration_ then
						arg_743_1.duration_ = var_746_3 + 0
					end
				end

				arg_743_1.text_.text = var_746_1
				arg_743_1.typewritter.percent = 0

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(false)
				arg_743_1:RecordContent(arg_743_1.text_.text)
			end

			local var_746_4 = math.max(var_746_0, arg_743_1.talkMaxDuration)

			if 0 <= arg_743_1.time_ and arg_743_1.time_ < 0 + var_746_4 then
				arg_743_1.typewritter.percent = (arg_743_1.time_ - 0) / var_746_4

				arg_743_1.typewritter:SetDirty()
			end

			if arg_743_1.time_ >= 0 + var_746_4 and arg_743_1.time_ < 0 + var_746_4 + arg_746_0 then
				arg_743_1.typewritter.percent = 1

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(true)
			end
		end

		arg_743_1.nodeConfigList_ = {}

		arg_743_1:InitPlayNodeList()
	end,
	Play1104906053 = function(arg_747_0, arg_747_1)
		arg_747_1.time_ = 0
		arg_747_1.frameCnt_ = 0
		arg_747_1.state_ = "playing"
		arg_747_1.curTalkId_ = 1104906053
		arg_747_1.duration_ = 5

		SetActive(arg_747_1.tipsGo_, false)

		function arg_747_1.onSingleLineFinish_()
			arg_747_1.onSingleLineUpdate_ = nil
			arg_747_1.onSingleLineFinish_ = nil
			arg_747_1.state_ = "waiting"
		end

		function arg_747_1.playNext_(arg_749_0)
			if arg_749_0 == 1 then
				arg_747_0:Play1104906054(arg_747_1)
			end
		end

		function arg_747_1.onSingleLineUpdate_(arg_750_0)
			local var_750_0 = 0.975

			if 0 < arg_747_1.time_ and arg_747_1.time_ <= 0 + arg_750_0 then
				arg_747_1.talkMaxDuration = 0
				arg_747_1.dialogCg_.alpha = 1

				arg_747_1.dialog_:SetActive(true)
				SetActive(arg_747_1.leftNameGo_, true)

				arg_747_1.leftNameTxt_.text = arg_747_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_747_1.leftNameTxt_.transform)

				arg_747_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_747_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_747_1:RecordName(arg_747_1.leftNameTxt_.text)
				SetActive(arg_747_1.iconTrs_.gameObject, true)
				arg_747_1.iconController_:SetSelectedState("hero")

				arg_747_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_747_1.callingController_:SetSelectedState("normal")

				arg_747_1.keyicon_.color = Color.New(1, 1, 1)
				arg_747_1.icon_.color = Color.New(1, 1, 1)

				local var_750_1 = arg_747_1:FormatText(arg_747_1:GetWordFromCfg(1104906053).content)

				arg_747_1.text_.text = var_750_1

				LuaForUtil.ClearLinePrefixSymbol(arg_747_1.text_)

				local var_750_3 = 39 <= 0 and var_750_0 or var_750_0 * (utf8.len(var_750_1) / 39)

				if (39 <= 0 and var_750_0 or var_750_0 * (utf8.len(var_750_1) / 39)) > 0 and var_750_0 < var_750_3 then
					arg_747_1.talkMaxDuration = var_750_3

					if var_750_3 + 0 > arg_747_1.duration_ then
						arg_747_1.duration_ = var_750_3 + 0
					end
				end

				arg_747_1.text_.text = var_750_1
				arg_747_1.typewritter.percent = 0

				arg_747_1.typewritter:SetDirty()
				arg_747_1:ShowNextGo(false)
				arg_747_1:RecordContent(arg_747_1.text_.text)
			end

			local var_750_4 = math.max(var_750_0, arg_747_1.talkMaxDuration)

			if 0 <= arg_747_1.time_ and arg_747_1.time_ < 0 + var_750_4 then
				arg_747_1.typewritter.percent = (arg_747_1.time_ - 0) / var_750_4

				arg_747_1.typewritter:SetDirty()
			end

			if arg_747_1.time_ >= 0 + var_750_4 and arg_747_1.time_ < 0 + var_750_4 + arg_750_0 then
				arg_747_1.typewritter.percent = 1

				arg_747_1.typewritter:SetDirty()
				arg_747_1:ShowNextGo(true)
			end
		end

		arg_747_1.nodeConfigList_ = {}

		arg_747_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST06",
		"TextureConfig/Background/ST58",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/K11f",
		"TextureConfig/Background/R4902",
		"TextureConfig/Background/R4902a",
		"TextureConfig/Background/K11g",
		"TextureConfig/Background/K01h",
		"TextureConfig/Background/K10g",
		"TextureConfig/Background/K12h"
	},
	voices = {
		"story_v_side_new_1104906.awb"
	}
}
