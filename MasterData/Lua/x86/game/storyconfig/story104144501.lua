return {
	Play414451001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 414451001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play414451002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.H08f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H08f")
				var_4_0.name = "H08f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.H08f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.H08f

				arg_1_1.bgs_.H08f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "H08f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 2
			local var_4_16 = 0.125

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

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(414451001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 5 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 5)

				if (5 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 5)) > 0 and var_4_16 < var_4_20 then
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
	Play414451002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 414451002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play414451003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.275

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(414451002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 11 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 11)

				if (11 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 11)) > 0 and var_12_0 < var_12_3 then
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
	Play414451003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 414451003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play414451004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.7

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(414451003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 68 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 68)

				if (68 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 68)) > 0 and var_16_0 < var_16_3 then
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
	Play414451004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 414451004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play414451005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["104902ui_story"] == nil and not isNil((Asset.Load("Char/" .. "104902ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "104902ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "104902ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["104902ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["104902ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["104902ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["104902ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["104902ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos104902ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_17_1.time_ - 0) / var_20_4)
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

			local var_20_5 = arg_17_1.actors_["104902ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect104902ui_story == nil then
				arg_17_1.var_.characterEffect104902ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect104902ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect104902ui_story then
				arg_17_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action5_1")
			end

			local var_20_8 = 0
			local var_20_9 = 0.525

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(414451004).content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_12 = 21 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_10) / 21)

				if (21 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_10) / 21)) > 0 and var_20_9 < var_20_12 then
					arg_17_1.talkMaxDuration = var_20_12

					if var_20_12 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_12 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_10
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_13 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_13 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_13

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_13 and arg_17_1.time_ < var_20_8 + var_20_13 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
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
	Play414451005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 414451005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play414451006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["104902ui_story"]) and arg_21_1.var_.characterEffect104902ui_story == nil then
				arg_21_1.var_.characterEffect104902ui_story = arg_21_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["104902ui_story"]) then
				if arg_21_1.var_.characterEffect104902ui_story and not isNil(arg_21_1.actors_["104902ui_story"]) then
					arg_21_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_21_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["104902ui_story"]) and arg_21_1.var_.characterEffect104902ui_story then
				arg_21_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_21_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 0.5

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

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(414451005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 20 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 20)

				if (20 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 20)) > 0 and var_24_2 < var_24_5 then
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
	Play414451006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 414451006
		arg_25_1.duration_ = 9

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play414451007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 2 < arg_25_1.time_ and arg_25_1.time_ <= 2 + arg_28_0 then
				local var_28_0 = arg_25_1.bgs_.H08f

				arg_25_1.bgs_.H08f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_28_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_1 = var_28_0:GetComponent("SpriteRenderer")

				if var_28_1 and var_28_1.sprite then
					local var_28_2 = 2 * (var_28_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_28_0.transform.localScale = Vector3.New(var_28_2 / var_28_1.sprite.bounds.size.y < var_28_2 * manager.ui.mainCameraCom_.aspect / var_28_1.sprite.bounds.size.x and var_28_2 * manager.ui.mainCameraCom_.aspect / var_28_1.sprite.bounds.size.x or var_28_2 / var_28_1.sprite.bounds.size.y, var_28_2 / var_28_1.sprite.bounds.size.y < var_28_2 * manager.ui.mainCameraCom_.aspect / var_28_1.sprite.bounds.size.x and var_28_2 * manager.ui.mainCameraCom_.aspect / var_28_1.sprite.bounds.size.x or var_28_2 / var_28_1.sprite.bounds.size.y, 0)
				end

				for iter_28_0, iter_28_1 in pairs(arg_25_1.bgs_) do
					if iter_28_0 ~= "H08f" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_28_3 = 0

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_3 + arg_28_0 then
				arg_25_1.allBtn_.enabled = false
			end

			if arg_25_1.time_ >= var_28_3 + 0.3 and arg_25_1.time_ < var_28_3 + 0.3 + arg_28_0 then
				arg_25_1.allBtn_.enabled = true
			end

			local var_28_4 = 0

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_5 = 2

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_5 then
				local var_28_6 = Color.New(0, 0, 0)

				var_28_6.a = Mathf.Lerp(0, 1, (arg_25_1.time_ - var_28_4) / var_28_5)
				arg_25_1.mask_.color = var_28_6
			end

			if arg_25_1.time_ >= var_28_4 + var_28_5 and arg_25_1.time_ < var_28_4 + var_28_5 + arg_28_0 then
				local var_28_7 = Color.New(0, 0, 0)

				var_28_7.a = 1
				arg_25_1.mask_.color = var_28_7
			end

			local var_28_8 = 2

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_9 = 2

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_9 then
				local var_28_10 = Color.New(0, 0, 0)

				var_28_10.a = Mathf.Lerp(1, 0, (arg_25_1.time_ - var_28_8) / var_28_9)
				arg_25_1.mask_.color = var_28_10
			end

			if arg_25_1.time_ >= var_28_8 + var_28_9 and arg_25_1.time_ < var_28_8 + var_28_9 + arg_28_0 then
				local var_28_11 = Color.New(0, 0, 0)

				arg_25_1.mask_.enabled = false
				var_28_11.a = 0
				arg_25_1.mask_.color = var_28_11
			end

			local var_28_12 = "102101ui_story"

			if arg_25_1.actors_["102101ui_story"] == nil and not isNil((Asset.Load("Char/" .. "102101ui_story"))) then
				local var_28_13 = Object.Instantiate(Asset.Load("Char/" .. "102101ui_story"), arg_25_1.stage_.transform)

				var_28_13.name = var_28_12
				var_28_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_[var_28_12] = var_28_13

				local var_28_14 = var_28_13:GetComponentInChildren(typeof(CharacterEffect))

				var_28_14.enabled = true

				local var_28_15 = GameObjectTools.GetOrAddComponent(var_28_13, typeof(DynamicBoneHelper))

				if var_28_15 then
					var_28_15:EnableDynamicBone(false)
				end

				arg_25_1:ShowWeapon(var_28_14.transform, false)

				arg_25_1.var_[var_28_12 .. "Animator"] = var_28_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_25_1.var_[var_28_12 .. "Animator"].applyRootMotion = true
				arg_25_1.var_[var_28_12 .. "LipSync"] = var_28_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_28_16 = arg_25_1.actors_["102101ui_story"].transform

			if 3.8 < arg_25_1.time_ and arg_25_1.time_ <= 3.8 + arg_28_0 then
				arg_25_1.var_.moveOldPos102101ui_story = var_28_16.localPosition

				arg_25_1:ShowWeapon(arg_25_1.var_["102101ui_story" .. "Animator"].transform, false)
			end

			local var_28_17 = 0.001

			if 3.8 <= arg_25_1.time_ and arg_25_1.time_ < 3.8 + var_28_17 then
				var_28_16.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos102101ui_story, Vector3.New(0, -0.98, -6.05), (arg_25_1.time_ - 3.8) / var_28_17)
				var_28_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_16.position).x, (manager.ui.mainCamera.transform.position - var_28_16.position).y, (manager.ui.mainCamera.transform.position - var_28_16.position).z)
				var_28_16.localEulerAngles.z = 0
				var_28_16.localEulerAngles.x = 0
				var_28_16.localEulerAngles = var_28_16.localEulerAngles
			end

			if arg_25_1.time_ >= 3.8 + var_28_17 and arg_25_1.time_ < 3.8 + var_28_17 + arg_28_0 then
				var_28_16.localPosition = Vector3.New(0, -0.98, -6.05)
				var_28_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_16.position).x, (manager.ui.mainCamera.transform.position - var_28_16.position).y, (manager.ui.mainCamera.transform.position - var_28_16.position).z)
				var_28_16.localEulerAngles.z = 0
				var_28_16.localEulerAngles.x = 0
				var_28_16.localEulerAngles = var_28_16.localEulerAngles
			end

			local var_28_18 = arg_25_1.actors_["102101ui_story"]

			if 3.8 < arg_25_1.time_ and arg_25_1.time_ <= 3.8 + arg_28_0 and not isNil(var_28_18) and arg_25_1.var_.characterEffect102101ui_story == nil then
				arg_25_1.var_.characterEffect102101ui_story = var_28_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_19 = 0.200000002980232

			if 3.8 <= arg_25_1.time_ and arg_25_1.time_ < 3.8 + var_28_19 and not isNil(var_28_18) then
				if arg_25_1.var_.characterEffect102101ui_story and not isNil(var_28_18) then
					arg_25_1.var_.characterEffect102101ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 3.8 + var_28_19 and arg_25_1.time_ < 3.8 + var_28_19 + arg_28_0 and not isNil(var_28_18) and arg_25_1.var_.characterEffect102101ui_story then
				arg_25_1.var_.characterEffect102101ui_story.fillFlat = false
			end

			if 3.8 < arg_25_1.time_ and arg_25_1.time_ <= 3.8 + arg_28_0 then
				arg_25_1:PlayTimeline("102101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_28_21 = arg_25_1.actors_["104902ui_story"].transform

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= 2 + arg_28_0 then
				arg_25_1.var_.moveOldPos104902ui_story = var_28_21.localPosition
			end

			local var_28_22 = 0.001

			if 2 <= arg_25_1.time_ and arg_25_1.time_ < 2 + var_28_22 then
				var_28_21.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos104902ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 2) / var_28_22)
				var_28_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_21.position).x, (manager.ui.mainCamera.transform.position - var_28_21.position).y, (manager.ui.mainCamera.transform.position - var_28_21.position).z)
				var_28_21.localEulerAngles.z = 0
				var_28_21.localEulerAngles.x = 0
				var_28_21.localEulerAngles = var_28_21.localEulerAngles
			end

			if arg_25_1.time_ >= 2 + var_28_22 and arg_25_1.time_ < 2 + var_28_22 + arg_28_0 then
				var_28_21.localPosition = Vector3.New(0, 100, 0)
				var_28_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_21.position).x, (manager.ui.mainCamera.transform.position - var_28_21.position).y, (manager.ui.mainCamera.transform.position - var_28_21.position).z)
				var_28_21.localEulerAngles.z = 0
				var_28_21.localEulerAngles.x = 0
				var_28_21.localEulerAngles = var_28_21.localEulerAngles
			end

			if 3.8 < arg_25_1.time_ and arg_25_1.time_ <= 3.8 + arg_28_0 then
				arg_25_1:PlayTimeline("102101ui_story", "StoryTimeline/CharAction/story1021/story1021action/1021action1_1")
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_23 = 4.00000000298023
			local var_28_24 = 0.15

			if 4.00000000298023 < arg_25_1.time_ and arg_25_1.time_ <= var_28_23 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_25 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_25:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_26 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(414451006).content)

				arg_25_1.text_.text = var_28_26

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_28 = 6 <= 0 and var_28_24 or var_28_24 * (utf8.len(var_28_26) / 6)

				if (6 <= 0 and var_28_24 or var_28_24 * (utf8.len(var_28_26) / 6)) > 0 and var_28_24 < var_28_28 then
					arg_25_1.talkMaxDuration = var_28_28
					var_28_23 = var_28_23 + 0.3

					if var_28_28 + var_28_23 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_28 + var_28_23
					end
				end

				arg_25_1.text_.text = var_28_26
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_29 = var_28_23 + 0.3
			local var_28_30 = math.max(var_28_24, arg_25_1.talkMaxDuration)

			if var_28_23 + 0.3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_29 + var_28_30 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_29) / var_28_30

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_29 + var_28_30 and arg_25_1.time_ < var_28_29 + var_28_30 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play414451007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 414451007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play414451008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["102101ui_story"]) and arg_31_1.var_.characterEffect102101ui_story == nil then
				arg_31_1.var_.characterEffect102101ui_story = arg_31_1.actors_["102101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_0 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 and not isNil(arg_31_1.actors_["102101ui_story"]) then
				if arg_31_1.var_.characterEffect102101ui_story and not isNil(arg_31_1.actors_["102101ui_story"]) then
					arg_31_1.var_.characterEffect102101ui_story.fillFlat = true
					arg_31_1.var_.characterEffect102101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_0)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 and not isNil(arg_31_1.actors_["102101ui_story"]) and arg_31_1.var_.characterEffect102101ui_story then
				arg_31_1.var_.characterEffect102101ui_story.fillFlat = true
				arg_31_1.var_.characterEffect102101ui_story.fillRatio = 0.5
			end

			local var_34_1 = 0
			local var_34_2 = 0.275

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_3 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(414451007).content)

				arg_31_1.text_.text = var_34_3

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 22 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 22)

				if (22 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 22)) > 0 and var_34_2 < var_34_5 then
					arg_31_1.talkMaxDuration = var_34_5

					if var_34_5 + var_34_1 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + var_34_1
					end
				end

				arg_31_1.text_.text = var_34_3
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_6 = math.max(var_34_2, arg_31_1.talkMaxDuration)

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_6 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_1) / var_34_6

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_1 + var_34_6 and arg_31_1.time_ < var_34_1 + var_34_6 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play414451008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 414451008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play414451009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos102101ui_story = arg_35_1.actors_["102101ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["102101ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos102101ui_story, Vector3.New(0, -0.98, -6.05), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["102101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["102101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["102101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["102101ui_story"].transform.position).z)
				arg_35_1.actors_["102101ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["102101ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["102101ui_story"].transform.localEulerAngles = arg_35_1.actors_["102101ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["102101ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.05)
				arg_35_1.actors_["102101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["102101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["102101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["102101ui_story"].transform.position).z)
				arg_35_1.actors_["102101ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["102101ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["102101ui_story"].transform.localEulerAngles = arg_35_1.actors_["102101ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["102101ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect102101ui_story == nil then
				arg_35_1.var_.characterEffect102101ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect102101ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect102101ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect102101ui_story then
				arg_35_1.var_.characterEffect102101ui_story.fillFlat = false
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("102101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1302cva")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("102101ui_story", "StoryTimeline/CharAction/story1021/story1021action/1021action7_1")
			end

			local var_38_4 = 0
			local var_38_5 = 0.4

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_4 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_6 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(414451008).content)

				arg_35_1.text_.text = var_38_6

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_8 = 25 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_6) / 25)

				if (25 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_6) / 25)) > 0 and var_38_5 < var_38_8 then
					arg_35_1.talkMaxDuration = var_38_8

					if var_38_8 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_8 + var_38_4
					end
				end

				arg_35_1.text_.text = var_38_6
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_9 = math.max(var_38_5, arg_35_1.talkMaxDuration)

			if var_38_4 <= arg_35_1.time_ and arg_35_1.time_ < var_38_4 + var_38_9 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_4) / var_38_9

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_4 + var_38_9 and arg_35_1.time_ < var_38_4 + var_38_9 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play414451009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 414451009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play414451010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["102101ui_story"]) and arg_39_1.var_.characterEffect102101ui_story == nil then
				arg_39_1.var_.characterEffect102101ui_story = arg_39_1.actors_["102101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["102101ui_story"]) then
				if arg_39_1.var_.characterEffect102101ui_story and not isNil(arg_39_1.actors_["102101ui_story"]) then
					arg_39_1.var_.characterEffect102101ui_story.fillFlat = true
					arg_39_1.var_.characterEffect102101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_0)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["102101ui_story"]) and arg_39_1.var_.characterEffect102101ui_story then
				arg_39_1.var_.characterEffect102101ui_story.fillFlat = true
				arg_39_1.var_.characterEffect102101ui_story.fillRatio = 0.5
			end

			local var_42_1 = 0
			local var_42_2 = 0.8

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_3 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(414451009).content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 17 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 17)

				if (17 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 17)) > 0 and var_42_2 < var_42_5 then
					arg_39_1.talkMaxDuration = var_42_5

					if var_42_5 + var_42_1 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + var_42_1
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_6 = math.max(var_42_2, arg_39_1.talkMaxDuration)

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_6 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_1) / var_42_6

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_1 + var_42_6 and arg_39_1.time_ < var_42_1 + var_42_6 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play414451010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 414451010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play414451011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos102101ui_story = arg_43_1.actors_["102101ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["102101ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos102101ui_story, Vector3.New(0, -0.98, -6.05), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["102101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["102101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["102101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["102101ui_story"].transform.position).z)
				arg_43_1.actors_["102101ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["102101ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["102101ui_story"].transform.localEulerAngles = arg_43_1.actors_["102101ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["102101ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.05)
				arg_43_1.actors_["102101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["102101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["102101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["102101ui_story"].transform.position).z)
				arg_43_1.actors_["102101ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["102101ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["102101ui_story"].transform.localEulerAngles = arg_43_1.actors_["102101ui_story"].transform.localEulerAngles
			end

			local var_46_1 = arg_43_1.actors_["102101ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect102101ui_story == nil then
				arg_43_1.var_.characterEffect102101ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect102101ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect102101ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect102101ui_story then
				arg_43_1.var_.characterEffect102101ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("102101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("102101ui_story", "StoryTimeline/CharAction/story1021/story1021action/1021action7_2")
			end

			local var_46_4 = 0
			local var_46_5 = 1.075

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_6 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(414451010).content)

				arg_43_1.text_.text = var_46_6

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_8 = 43 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_6) / 43)

				if (43 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_6) / 43)) > 0 and var_46_5 < var_46_8 then
					arg_43_1.talkMaxDuration = var_46_8

					if var_46_8 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_8 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_6
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_9 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_9 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_9

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_9 and arg_43_1.time_ < var_46_4 + var_46_9 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play414451011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 414451011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play414451012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["102101ui_story"]) and arg_47_1.var_.characterEffect102101ui_story == nil then
				arg_47_1.var_.characterEffect102101ui_story = arg_47_1.actors_["102101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["102101ui_story"]) then
				if arg_47_1.var_.characterEffect102101ui_story and not isNil(arg_47_1.actors_["102101ui_story"]) then
					arg_47_1.var_.characterEffect102101ui_story.fillFlat = true
					arg_47_1.var_.characterEffect102101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_0)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["102101ui_story"]) and arg_47_1.var_.characterEffect102101ui_story then
				arg_47_1.var_.characterEffect102101ui_story.fillFlat = true
				arg_47_1.var_.characterEffect102101ui_story.fillRatio = 0.5
			end

			local var_50_1 = 0
			local var_50_2 = 0.6

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_3 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(414451011).content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 24 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 24)

				if (24 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 24)) > 0 and var_50_2 < var_50_5 then
					arg_47_1.talkMaxDuration = var_50_5

					if var_50_5 + var_50_1 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + var_50_1
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_6 = math.max(var_50_2, arg_47_1.talkMaxDuration)

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_6 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_1) / var_50_6

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_1 + var_50_6 and arg_47_1.time_ < var_50_1 + var_50_6 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play414451012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 414451012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play414451013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos102101ui_story = arg_51_1.actors_["102101ui_story"].transform.localPosition
			end

			local var_54_0 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 then
				arg_51_1.actors_["102101ui_story"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos102101ui_story, Vector3.New(0, -0.98, -6.05), (arg_51_1.time_ - 0) / var_54_0)
				arg_51_1.actors_["102101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["102101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["102101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["102101ui_story"].transform.position).z)
				arg_51_1.actors_["102101ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["102101ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["102101ui_story"].transform.localEulerAngles = arg_51_1.actors_["102101ui_story"].transform.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 then
				arg_51_1.actors_["102101ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.05)
				arg_51_1.actors_["102101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["102101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["102101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["102101ui_story"].transform.position).z)
				arg_51_1.actors_["102101ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["102101ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["102101ui_story"].transform.localEulerAngles = arg_51_1.actors_["102101ui_story"].transform.localEulerAngles
			end

			local var_54_1 = arg_51_1.actors_["102101ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect102101ui_story == nil then
				arg_51_1.var_.characterEffect102101ui_story = var_54_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_2 and not isNil(var_54_1) then
				if arg_51_1.var_.characterEffect102101ui_story and not isNil(var_54_1) then
					arg_51_1.var_.characterEffect102101ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_2 and arg_51_1.time_ < 0 + var_54_2 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect102101ui_story then
				arg_51_1.var_.characterEffect102101ui_story.fillFlat = false
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("102101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("102101ui_story", "StoryTimeline/CharAction/story1021/story1021action/1021action8_1")
			end

			local var_54_4 = 0
			local var_54_5 = 0.375

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_4 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_6 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(414451012).content)

				arg_51_1.text_.text = var_54_6

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_8 = 15 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_6) / 15)

				if (15 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_6) / 15)) > 0 and var_54_5 < var_54_8 then
					arg_51_1.talkMaxDuration = var_54_8

					if var_54_8 + var_54_4 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_4
					end
				end

				arg_51_1.text_.text = var_54_6
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_9 = math.max(var_54_5, arg_51_1.talkMaxDuration)

			if var_54_4 <= arg_51_1.time_ and arg_51_1.time_ < var_54_4 + var_54_9 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_4) / var_54_9

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_4 + var_54_9 and arg_51_1.time_ < var_54_4 + var_54_9 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play414451013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 414451013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play414451014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["102101ui_story"]) and arg_55_1.var_.characterEffect102101ui_story == nil then
				arg_55_1.var_.characterEffect102101ui_story = arg_55_1.actors_["102101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_0 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["102101ui_story"]) then
				if arg_55_1.var_.characterEffect102101ui_story and not isNil(arg_55_1.actors_["102101ui_story"]) then
					arg_55_1.var_.characterEffect102101ui_story.fillFlat = true
					arg_55_1.var_.characterEffect102101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_0)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["102101ui_story"]) and arg_55_1.var_.characterEffect102101ui_story then
				arg_55_1.var_.characterEffect102101ui_story.fillFlat = true
				arg_55_1.var_.characterEffect102101ui_story.fillRatio = 0.5
			end

			local var_58_1 = 0
			local var_58_2 = 1.275

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_3 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(414451013).content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 51 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_3) / 51)

				if (51 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_3) / 51)) > 0 and var_58_2 < var_58_5 then
					arg_55_1.talkMaxDuration = var_58_5

					if var_58_5 + var_58_1 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + var_58_1
					end
				end

				arg_55_1.text_.text = var_58_3
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_6 = math.max(var_58_2, arg_55_1.talkMaxDuration)

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_6 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_1) / var_58_6

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_1 + var_58_6 and arg_55_1.time_ < var_58_1 + var_58_6 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play414451014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 414451014
		arg_59_1.duration_ = 1

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"

			SetActive(arg_59_1.choicesGo_, true)

			for iter_60_0, iter_60_1 in ipairs(arg_59_1.choices_) do
				SetActive(iter_60_1.go, iter_60_0 <= 2)
			end

			arg_59_1.choices_[1].txt.text = arg_59_1:FormatText(StoryChoiceCfg[929].name)
			arg_59_1.choices_[2].txt.text = arg_59_1:FormatText(StoryChoiceCfg[930].name)
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play414451015(arg_59_1)
			end

			if arg_61_0 == 2 then
				arg_59_0:Play414451016(arg_59_1)
			end

			arg_59_1:RecordChoiceLog(414451014, 929, 930)
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			return
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play414451015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 414451015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play414451017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos102101ui_story = arg_63_1.actors_["102101ui_story"].transform.localPosition
			end

			local var_66_0 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 then
				arg_63_1.actors_["102101ui_story"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos102101ui_story, Vector3.New(0, -0.98, -6.05), (arg_63_1.time_ - 0) / var_66_0)
				arg_63_1.actors_["102101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["102101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["102101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["102101ui_story"].transform.position).z)
				arg_63_1.actors_["102101ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["102101ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["102101ui_story"].transform.localEulerAngles = arg_63_1.actors_["102101ui_story"].transform.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 then
				arg_63_1.actors_["102101ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.05)
				arg_63_1.actors_["102101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["102101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["102101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["102101ui_story"].transform.position).z)
				arg_63_1.actors_["102101ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["102101ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["102101ui_story"].transform.localEulerAngles = arg_63_1.actors_["102101ui_story"].transform.localEulerAngles
			end

			local var_66_1 = arg_63_1.actors_["102101ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect102101ui_story == nil then
				arg_63_1.var_.characterEffect102101ui_story = var_66_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_2 and not isNil(var_66_1) then
				if arg_63_1.var_.characterEffect102101ui_story and not isNil(var_66_1) then
					arg_63_1.var_.characterEffect102101ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_2 and arg_63_1.time_ < 0 + var_66_2 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect102101ui_story then
				arg_63_1.var_.characterEffect102101ui_story.fillFlat = false
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("102101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("102101ui_story", "StoryTimeline/CharAction/story1021/story1021actionlink/1021action486")
			end

			local var_66_4 = 0
			local var_66_5 = 0.475

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_6 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(414451015).content)

				arg_63_1.text_.text = var_66_6

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_8 = 19 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_6) / 19)

				if (19 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_6) / 19)) > 0 and var_66_5 < var_66_8 then
					arg_63_1.talkMaxDuration = var_66_8

					if var_66_8 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_4
					end
				end

				arg_63_1.text_.text = var_66_6
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_9 = math.max(var_66_5, arg_63_1.talkMaxDuration)

			if var_66_4 <= arg_63_1.time_ and arg_63_1.time_ < var_66_4 + var_66_9 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_4) / var_66_9

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_4 + var_66_9 and arg_63_1.time_ < var_66_4 + var_66_9 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play414451017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 414451017
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play414451018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["102101ui_story"]) and arg_67_1.var_.characterEffect102101ui_story == nil then
				arg_67_1.var_.characterEffect102101ui_story = arg_67_1.actors_["102101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["102101ui_story"]) then
				if arg_67_1.var_.characterEffect102101ui_story and not isNil(arg_67_1.actors_["102101ui_story"]) then
					arg_67_1.var_.characterEffect102101ui_story.fillFlat = true
					arg_67_1.var_.characterEffect102101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_0)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["102101ui_story"]) and arg_67_1.var_.characterEffect102101ui_story then
				arg_67_1.var_.characterEffect102101ui_story.fillFlat = true
				arg_67_1.var_.characterEffect102101ui_story.fillRatio = 0.5
			end

			local var_70_1 = 0
			local var_70_2 = 0.9

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_3 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(414451017).content)

				arg_67_1.text_.text = var_70_3

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 36 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 36)

				if (36 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 36)) > 0 and var_70_2 < var_70_5 then
					arg_67_1.talkMaxDuration = var_70_5

					if var_70_5 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + var_70_1
					end
				end

				arg_67_1.text_.text = var_70_3
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_6 = math.max(var_70_2, arg_67_1.talkMaxDuration)

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_6 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_1) / var_70_6

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_1 + var_70_6 and arg_67_1.time_ < var_70_1 + var_70_6 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play414451018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 414451018
		arg_71_1.duration_ = 5.5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play414451019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if arg_71_1.actors_["102201ui_story"] == nil and not isNil((Asset.Load("Char/" .. "102201ui_story"))) then
				local var_74_0 = Object.Instantiate(Asset.Load("Char/" .. "102201ui_story"), arg_71_1.stage_.transform)

				var_74_0.name = "102201ui_story"
				var_74_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.actors_["102201ui_story"] = var_74_0

				local var_74_1 = var_74_0:GetComponentInChildren(typeof(CharacterEffect))

				var_74_1.enabled = true

				local var_74_2 = GameObjectTools.GetOrAddComponent(var_74_0, typeof(DynamicBoneHelper))

				if var_74_2 then
					var_74_2:EnableDynamicBone(false)
				end

				arg_71_1:ShowWeapon(var_74_1.transform, false)

				arg_71_1.var_["102201ui_story" .. "Animator"] = var_74_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_71_1.var_["102201ui_story" .. "Animator"].applyRootMotion = true
				arg_71_1.var_["102201ui_story" .. "LipSync"] = var_74_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action4_1")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_74_3 = arg_71_1.actors_["102101ui_story"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos102101ui_story = var_74_3.localPosition
			end

			local var_74_4 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 then
				var_74_3.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos102101ui_story, Vector3.New(0, 100, 0), (arg_71_1.time_ - 0) / var_74_4)
				var_74_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_3.position).x, (manager.ui.mainCamera.transform.position - var_74_3.position).y, (manager.ui.mainCamera.transform.position - var_74_3.position).z)
				var_74_3.localEulerAngles.z = 0
				var_74_3.localEulerAngles.x = 0
				var_74_3.localEulerAngles = var_74_3.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 then
				var_74_3.localPosition = Vector3.New(0, 100, 0)
				var_74_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_3.position).x, (manager.ui.mainCamera.transform.position - var_74_3.position).y, (manager.ui.mainCamera.transform.position - var_74_3.position).z)
				var_74_3.localEulerAngles.z = 0
				var_74_3.localEulerAngles.x = 0
				var_74_3.localEulerAngles = var_74_3.localEulerAngles
			end

			local var_74_5 = arg_71_1.actors_["102201ui_story"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos102201ui_story = var_74_5.localPosition

				arg_71_1:ShowWeapon(arg_71_1.var_["102201ui_story" .. "Animator"].transform, false)
			end

			local var_74_6 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_6 then
				var_74_5.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos102201ui_story, Vector3.New(0, -1.08, -6), (arg_71_1.time_ - 0) / var_74_6)
				var_74_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_5.position).x, (manager.ui.mainCamera.transform.position - var_74_5.position).y, (manager.ui.mainCamera.transform.position - var_74_5.position).z)
				var_74_5.localEulerAngles.z = 0
				var_74_5.localEulerAngles.x = 0
				var_74_5.localEulerAngles = var_74_5.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_6 and arg_71_1.time_ < 0 + var_74_6 + arg_74_0 then
				var_74_5.localPosition = Vector3.New(0, -1.08, -6)
				var_74_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_5.position).x, (manager.ui.mainCamera.transform.position - var_74_5.position).y, (manager.ui.mainCamera.transform.position - var_74_5.position).z)
				var_74_5.localEulerAngles.z = 0
				var_74_5.localEulerAngles.x = 0
				var_74_5.localEulerAngles = var_74_5.localEulerAngles
			end

			if arg_71_1.frameCnt_ <= 1 then
				arg_71_1.dialog_:SetActive(false)
			end

			local var_74_7 = 0.5
			local var_74_8 = 0.175

			if 0.5 < arg_71_1.time_ and arg_71_1.time_ <= var_74_7 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				arg_71_1.dialog_:SetActive(true)

				arg_71_1.dialogCg_.alpha = 0

				local var_74_9 = LeanTween.value(arg_71_1.dialog_, 0, 1, 0.3)

				var_74_9:setOnUpdate(LuaHelper.FloatAction(function(arg_75_0)
					arg_71_1.dialogCg_.alpha = arg_75_0
				end))
				var_74_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_71_1.dialog_)
					var_74_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_71_1.duration_ = arg_71_1.duration_ + 0.3

				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_10 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(414451018).content)

				arg_71_1.text_.text = var_74_10

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_12 = 7 <= 0 and var_74_8 or var_74_8 * (utf8.len(var_74_10) / 7)

				if (7 <= 0 and var_74_8 or var_74_8 * (utf8.len(var_74_10) / 7)) > 0 and var_74_8 < var_74_12 then
					arg_71_1.talkMaxDuration = var_74_12
					var_74_7 = var_74_7 + 0.3

					if var_74_12 + var_74_7 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_12 + var_74_7
					end
				end

				arg_71_1.text_.text = var_74_10
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_13 = var_74_7 + 0.3
			local var_74_14 = math.max(var_74_8, arg_71_1.talkMaxDuration)

			if var_74_7 + 0.3 <= arg_71_1.time_ and arg_71_1.time_ < var_74_13 + var_74_14 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_13) / var_74_14

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_13 + var_74_14 and arg_71_1.time_ < var_74_13 + var_74_14 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "102201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play414451019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 414451019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play414451020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.45

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(414451019).content)

				arg_77_1.text_.text = var_80_1

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_3 = 18 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 18)

				if (18 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 18)) > 0 and var_80_0 < var_80_3 then
					arg_77_1.talkMaxDuration = var_80_3

					if var_80_3 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_3 + 0
					end
				end

				arg_77_1.text_.text = var_80_1
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_4 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_4

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play414451020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 414451020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play414451021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos102201ui_story = arg_81_1.actors_["102201ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["102201ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos102201ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["102201ui_story"].transform.position).z)
				arg_81_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["102201ui_story"].transform.localEulerAngles = arg_81_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["102201ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["102201ui_story"].transform.position).z)
				arg_81_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["102201ui_story"].transform.localEulerAngles = arg_81_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			local var_84_1 = 0
			local var_84_2 = 0.725

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[104].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(414451020).content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 29 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 29)

				if (29 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 29)) > 0 and var_84_2 < var_84_5 then
					arg_81_1.talkMaxDuration = var_84_5

					if var_84_5 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_6 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_6 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_6

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_6 and arg_81_1.time_ < var_84_1 + var_84_6 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play414451021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 414451021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play414451022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.825

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[105].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(414451021).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 33 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 33)

				if (33 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 33)) > 0 and var_88_0 < var_88_3 then
					arg_85_1.talkMaxDuration = var_88_3

					if var_88_3 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_3 + 0
					end
				end

				arg_85_1.text_.text = var_88_1
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_4 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_4

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play414451022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 414451022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play414451023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos102201ui_story = arg_89_1.actors_["102201ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["102201ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos102201ui_story, Vector3.New(0, -1.08, -6), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["102201ui_story"].transform.position).z)
				arg_89_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["102201ui_story"].transform.localEulerAngles = arg_89_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["102201ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_89_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["102201ui_story"].transform.position).z)
				arg_89_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["102201ui_story"].transform.localEulerAngles = arg_89_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["102201ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect102201ui_story == nil then
				arg_89_1.var_.characterEffect102201ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect102201ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect102201ui_story then
				arg_89_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022actionlink/1022action445")
			end

			local var_92_4 = 0
			local var_92_5 = 0.425

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(414451022).content)

				arg_89_1.text_.text = var_92_6

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_8 = 17 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_6) / 17)

				if (17 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_6) / 17)) > 0 and var_92_5 < var_92_8 then
					arg_89_1.talkMaxDuration = var_92_8

					if var_92_8 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_6
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_9 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_9 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_9

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_9 and arg_89_1.time_ < var_92_4 + var_92_9 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
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
	Play414451023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 414451023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play414451024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos102201ui_story = arg_93_1.actors_["102201ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["102201ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos102201ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["102201ui_story"].transform.position).z)
				arg_93_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["102201ui_story"].transform.localEulerAngles = arg_93_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["102201ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["102201ui_story"].transform.position).z)
				arg_93_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["102201ui_story"].transform.localEulerAngles = arg_93_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["102101ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos102101ui_story = var_96_1.localPosition

				arg_93_1:ShowWeapon(arg_93_1.var_["102101ui_story" .. "Animator"].transform, false)
			end

			local var_96_2 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 then
				var_96_1.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos102101ui_story, Vector3.New(0, -0.98, -6.05), (arg_93_1.time_ - 0) / var_96_2)
				var_96_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_1.position).x, (manager.ui.mainCamera.transform.position - var_96_1.position).y, (manager.ui.mainCamera.transform.position - var_96_1.position).z)
				var_96_1.localEulerAngles.z = 0
				var_96_1.localEulerAngles.x = 0
				var_96_1.localEulerAngles = var_96_1.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 then
				var_96_1.localPosition = Vector3.New(0, -0.98, -6.05)
				var_96_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_1.position).x, (manager.ui.mainCamera.transform.position - var_96_1.position).y, (manager.ui.mainCamera.transform.position - var_96_1.position).z)
				var_96_1.localEulerAngles.z = 0
				var_96_1.localEulerAngles.x = 0
				var_96_1.localEulerAngles = var_96_1.localEulerAngles
			end

			local var_96_3 = arg_93_1.actors_["102101ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_3) and arg_93_1.var_.characterEffect102101ui_story == nil then
				arg_93_1.var_.characterEffect102101ui_story = var_96_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_4 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 and not isNil(var_96_3) then
				if arg_93_1.var_.characterEffect102101ui_story and not isNil(var_96_3) then
					arg_93_1.var_.characterEffect102101ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 and not isNil(var_96_3) and arg_93_1.var_.characterEffect102101ui_story then
				arg_93_1.var_.characterEffect102101ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("102101ui_story", "StoryTimeline/CharAction/story1021/story1021action/1021action6_2")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("102101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_96_6 = 0
			local var_96_7 = 0.325

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_8 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(414451023).content)

				arg_93_1.text_.text = var_96_8

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_10 = 13 <= 0 and var_96_7 or var_96_7 * (utf8.len(var_96_8) / 13)

				if (13 <= 0 and var_96_7 or var_96_7 * (utf8.len(var_96_8) / 13)) > 0 and var_96_7 < var_96_10 then
					arg_93_1.talkMaxDuration = var_96_10

					if var_96_10 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_8
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_11 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_11 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_11

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_11 and arg_93_1.time_ < var_96_6 + var_96_11 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "102101ui_story",
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
	Play414451024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 414451024
		arg_97_1.duration_ = 1

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"

			SetActive(arg_97_1.choicesGo_, true)

			for iter_98_0, iter_98_1 in ipairs(arg_97_1.choices_) do
				SetActive(iter_98_1.go, iter_98_0 <= 2)
			end

			arg_97_1.choices_[1].txt.text = arg_97_1:FormatText(StoryChoiceCfg[931].name)
			arg_97_1.choices_[2].txt.text = arg_97_1:FormatText(StoryChoiceCfg[932].name)
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play414451025(arg_97_1)
			end

			if arg_99_0 == 2 then
				arg_97_0:Play414451027(arg_97_1)
			end

			arg_97_1:RecordChoiceLog(414451024, 931, 932)
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["102101ui_story"]) and arg_97_1.var_.characterEffect102101ui_story == nil then
				arg_97_1.var_.characterEffect102101ui_story = arg_97_1.actors_["102101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["102101ui_story"]) then
				if arg_97_1.var_.characterEffect102101ui_story and not isNil(arg_97_1.actors_["102101ui_story"]) then
					arg_97_1.var_.characterEffect102101ui_story.fillFlat = true
					arg_97_1.var_.characterEffect102101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["102101ui_story"]) and arg_97_1.var_.characterEffect102101ui_story then
				arg_97_1.var_.characterEffect102101ui_story.fillFlat = true
				arg_97_1.var_.characterEffect102101ui_story.fillRatio = 0.5
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play414451025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 414451025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play414451026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.7

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(414451025).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 28 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 28)

				if (28 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 28)) > 0 and var_104_0 < var_104_3 then
					arg_101_1.talkMaxDuration = var_104_3

					if var_104_3 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_3 + 0
					end
				end

				arg_101_1.text_.text = var_104_1
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_4 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_4

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play414451026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 414451026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play414451029(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("102101ui_story", "StoryTimeline/CharAction/story1021/story1021action/1021action3_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("102101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_108_0 = arg_105_1.actors_["102101ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect102101ui_story == nil then
				arg_105_1.var_.characterEffect102101ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_1 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 and not isNil(var_108_0) then
				if arg_105_1.var_.characterEffect102101ui_story and not isNil(var_108_0) then
					arg_105_1.var_.characterEffect102101ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect102101ui_story then
				arg_105_1.var_.characterEffect102101ui_story.fillFlat = false
			end

			local var_108_3 = 0
			local var_108_4 = 0.375

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_3 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_5 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(414451026).content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 15 <= 0 and var_108_4 or var_108_4 * (utf8.len(var_108_5) / 15)

				if (15 <= 0 and var_108_4 or var_108_4 * (utf8.len(var_108_5) / 15)) > 0 and var_108_4 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_3 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_3
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_8 = math.max(var_108_4, arg_105_1.talkMaxDuration)

			if var_108_3 <= arg_105_1.time_ and arg_105_1.time_ < var_108_3 + var_108_8 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_3) / var_108_8

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_3 + var_108_8 and arg_105_1.time_ < var_108_3 + var_108_8 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play414451029 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 414451029
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play414451030(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.525

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(414451029).content)

				arg_109_1.text_.text = var_112_1

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_3 = 21 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 21)

				if (21 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 21)) > 0 and var_112_0 < var_112_3 then
					arg_109_1.talkMaxDuration = var_112_3

					if var_112_3 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_3 + 0
					end
				end

				arg_109_1.text_.text = var_112_1
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_4 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_4

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play414451030 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 414451030
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play414451031(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos102101ui_story = arg_113_1.actors_["102101ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["102101ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos102101ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["102101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["102101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["102101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["102101ui_story"].transform.position).z)
				arg_113_1.actors_["102101ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["102101ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["102101ui_story"].transform.localEulerAngles = arg_113_1.actors_["102101ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["102101ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.actors_["102101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["102101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["102101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["102101ui_story"].transform.position).z)
				arg_113_1.actors_["102101ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["102101ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["102101ui_story"].transform.localEulerAngles = arg_113_1.actors_["102101ui_story"].transform.localEulerAngles
			end

			local var_116_1 = 0
			local var_116_2 = 1.175

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(414451030).content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 47 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 47)

				if (47 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 47)) > 0 and var_116_2 < var_116_5 then
					arg_113_1.talkMaxDuration = var_116_5

					if var_116_5 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_3
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_6 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_6 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_6

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_6 and arg_113_1.time_ < var_116_1 + var_116_6 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102101ui_story",
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
	Play414451031 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 414451031
		arg_117_1.duration_ = 6.87

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play414451032(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				local var_120_0 = arg_117_1.bgs_.H08f

				arg_117_1.bgs_.H08f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_120_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_120_1 = var_120_0:GetComponent("SpriteRenderer")

				if var_120_1 and var_120_1.sprite then
					local var_120_2 = 2 * (var_120_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_120_0.transform.localScale = Vector3.New(var_120_2 / var_120_1.sprite.bounds.size.y < var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x and var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x or var_120_2 / var_120_1.sprite.bounds.size.y, var_120_2 / var_120_1.sprite.bounds.size.y < var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x and var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x or var_120_2 / var_120_1.sprite.bounds.size.y, 0)
				end

				for iter_120_0, iter_120_1 in pairs(arg_117_1.bgs_) do
					if iter_120_0 ~= "H08f" then
						iter_120_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_120_3 = 0

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_3 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_4 = 1

			if var_120_3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_3 + var_120_4 then
				local var_120_5 = Color.New(0, 0, 0)

				var_120_5.a = Mathf.Lerp(0, 1, (arg_117_1.time_ - var_120_3) / var_120_4)
				arg_117_1.mask_.color = var_120_5
			end

			if arg_117_1.time_ >= var_120_3 + var_120_4 and arg_117_1.time_ < var_120_3 + var_120_4 + arg_120_0 then
				local var_120_6 = Color.New(0, 0, 0)

				var_120_6.a = 1
				arg_117_1.mask_.color = var_120_6
			end

			local var_120_7 = 1

			if 1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_7 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_8 = 1

			if var_120_7 <= arg_117_1.time_ and arg_117_1.time_ < var_120_7 + var_120_8 then
				local var_120_9 = Color.New(0, 0, 0)

				var_120_9.a = Mathf.Lerp(1, 0, (arg_117_1.time_ - var_120_7) / var_120_8)
				arg_117_1.mask_.color = var_120_9
			end

			if arg_117_1.time_ >= var_120_7 + var_120_8 and arg_117_1.time_ < var_120_7 + var_120_8 + arg_120_0 then
				local var_120_10 = Color.New(0, 0, 0)

				arg_117_1.mask_.enabled = false
				var_120_10.a = 0
				arg_117_1.mask_.color = var_120_10
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_11 = 1.86666666666667
			local var_120_12 = 1.175

			if 1.86666666666667 < arg_117_1.time_ and arg_117_1.time_ <= var_120_11 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_13 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_13:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_14 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(414451031).content)

				arg_117_1.text_.text = var_120_14

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_16 = 47 <= 0 and var_120_12 or var_120_12 * (utf8.len(var_120_14) / 47)

				if (47 <= 0 and var_120_12 or var_120_12 * (utf8.len(var_120_14) / 47)) > 0 and var_120_12 < var_120_16 then
					arg_117_1.talkMaxDuration = var_120_16
					var_120_11 = var_120_11 + 0.3

					if var_120_16 + var_120_11 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_16 + var_120_11
					end
				end

				arg_117_1.text_.text = var_120_14
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_17 = var_120_11 + 0.3
			local var_120_18 = math.max(var_120_12, arg_117_1.talkMaxDuration)

			if var_120_11 + 0.3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_17 + var_120_18 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_17) / var_120_18

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_17 + var_120_18 and arg_117_1.time_ < var_120_17 + var_120_18 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play414451032 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 414451032
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play414451033(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos104902ui_story = arg_123_1.actors_["104902ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["104902ui_story"].transform.position).z)
				arg_123_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["104902ui_story"].transform.localEulerAngles = arg_123_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_123_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["104902ui_story"].transform.position).z)
				arg_123_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["104902ui_story"].transform.localEulerAngles = arg_123_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_126_1 = arg_123_1.actors_["104902ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect104902ui_story == nil then
				arg_123_1.var_.characterEffect104902ui_story = var_126_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_2 and not isNil(var_126_1) then
				if arg_123_1.var_.characterEffect104902ui_story and not isNil(var_126_1) then
					arg_123_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_2 and arg_123_1.time_ < 0 + var_126_2 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect104902ui_story then
				arg_123_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action5_2")
			end

			local var_126_4 = 0
			local var_126_5 = 0.65

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_6 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(414451032).content)

				arg_123_1.text_.text = var_126_6

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_8 = 26 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_6) / 26)

				if (26 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_6) / 26)) > 0 and var_126_5 < var_126_8 then
					arg_123_1.talkMaxDuration = var_126_8

					if var_126_8 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_4
					end
				end

				arg_123_1.text_.text = var_126_6
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_9 = math.max(var_126_5, arg_123_1.talkMaxDuration)

			if var_126_4 <= arg_123_1.time_ and arg_123_1.time_ < var_126_4 + var_126_9 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_4) / var_126_9

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_4 + var_126_9 and arg_123_1.time_ < var_126_4 + var_126_9 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play414451033 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 414451033
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play414451034(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["104902ui_story"]) and arg_127_1.var_.characterEffect104902ui_story == nil then
				arg_127_1.var_.characterEffect104902ui_story = arg_127_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["104902ui_story"]) then
				if arg_127_1.var_.characterEffect104902ui_story and not isNil(arg_127_1.actors_["104902ui_story"]) then
					arg_127_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_127_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_0)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["104902ui_story"]) and arg_127_1.var_.characterEffect104902ui_story then
				arg_127_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_127_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_130_1 = 0
			local var_130_2 = 0.475

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(414451033).content)

				arg_127_1.text_.text = var_130_3

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 19 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_3) / 19)

				if (19 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_3) / 19)) > 0 and var_130_2 < var_130_5 then
					arg_127_1.talkMaxDuration = var_130_5

					if var_130_5 + var_130_1 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + var_130_1
					end
				end

				arg_127_1.text_.text = var_130_3
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_6 = math.max(var_130_2, arg_127_1.talkMaxDuration)

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_6 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_1) / var_130_6

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_1 + var_130_6 and arg_127_1.time_ < var_130_1 + var_130_6 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play414451034 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 414451034
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play414451035(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["104902ui_story"]) and arg_131_1.var_.characterEffect104902ui_story == nil then
				arg_131_1.var_.characterEffect104902ui_story = arg_131_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["104902ui_story"]) then
				if arg_131_1.var_.characterEffect104902ui_story and not isNil(arg_131_1.actors_["104902ui_story"]) then
					arg_131_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["104902ui_story"]) and arg_131_1.var_.characterEffect104902ui_story then
				arg_131_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			local var_134_2 = 0
			local var_134_3 = 0.675

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_2 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_4 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(414451034).content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_6 = 27 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_4) / 27)

				if (27 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_4) / 27)) > 0 and var_134_3 < var_134_6 then
					arg_131_1.talkMaxDuration = var_134_6

					if var_134_6 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_6 + var_134_2
					end
				end

				arg_131_1.text_.text = var_134_4
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_3, arg_131_1.talkMaxDuration)

			if var_134_2 <= arg_131_1.time_ and arg_131_1.time_ < var_134_2 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_2) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_2 + var_134_7 and arg_131_1.time_ < var_134_2 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play414451035 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 414451035
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play414451036(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action6_1")
			end

			local var_138_0 = 0
			local var_138_1 = 0.675

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_2 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(414451035).content)

				arg_135_1.text_.text = var_138_2

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 27 <= 0 and var_138_1 or var_138_1 * (utf8.len(var_138_2) / 27)

				if (27 <= 0 and var_138_1 or var_138_1 * (utf8.len(var_138_2) / 27)) > 0 and var_138_1 < var_138_4 then
					arg_135_1.talkMaxDuration = var_138_4

					if var_138_4 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_4 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_2
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_5 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_5 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_5

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_5 and arg_135_1.time_ < var_138_0 + var_138_5 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play414451036 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 414451036
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
			arg_139_1.auto_ = false
		end

		function arg_139_1.playNext_(arg_141_0)
			arg_139_1.onStoryFinished_()
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos104902ui_story = arg_139_1.actors_["104902ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos104902ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["104902ui_story"].transform.position).z)
				arg_139_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["104902ui_story"].transform.localEulerAngles = arg_139_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_139_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["104902ui_story"].transform.position).z)
				arg_139_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["104902ui_story"].transform.localEulerAngles = arg_139_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_142_1 = 0
			local var_142_2 = 1.45

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[978].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(414451036).content)

				arg_139_1.text_.text = var_142_3

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 58 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 58)

				if (58 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 58)) > 0 and var_142_2 < var_142_5 then
					arg_139_1.talkMaxDuration = var_142_5

					if var_142_5 + var_142_1 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + var_142_1
					end
				end

				arg_139_1.text_.text = var_142_3
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_6 = math.max(var_142_2, arg_139_1.talkMaxDuration)

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_6 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_1) / var_142_6

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_1 + var_142_6 and arg_139_1.time_ < var_142_1 + var_142_6 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play414451027 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 414451027
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play414451028(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if arg_143_1.actors_["102101ui_story"] == nil and not isNil((Asset.Load("Char/" .. "102101ui_story"))) then
				local var_146_0 = Object.Instantiate(Asset.Load("Char/" .. "102101ui_story"), arg_143_1.stage_.transform)

				var_146_0.name = "102101ui_story"
				var_146_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_143_1.actors_["102101ui_story"] = var_146_0

				local var_146_1 = var_146_0:GetComponentInChildren(typeof(CharacterEffect))

				var_146_1.enabled = true

				local var_146_2 = GameObjectTools.GetOrAddComponent(var_146_0, typeof(DynamicBoneHelper))

				if var_146_2 then
					var_146_2:EnableDynamicBone(false)
				end

				arg_143_1:ShowWeapon(var_146_1.transform, false)

				arg_143_1.var_["102101ui_story" .. "Animator"] = var_146_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_143_1.var_["102101ui_story" .. "Animator"].applyRootMotion = true
				arg_143_1.var_["102101ui_story" .. "LipSync"] = var_146_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("102101ui_story", "StoryTimeline/CharAction/story1021/story1021action/1021action3_1")
			end

			local var_146_3 = "102101ui_story"

			if arg_143_1.actors_["102101ui_story"] == nil and not isNil((Asset.Load("Char/" .. "102101ui_story"))) then
				local var_146_4 = Object.Instantiate(Asset.Load("Char/" .. "102101ui_story"), arg_143_1.stage_.transform)

				var_146_4.name = var_146_3
				var_146_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_143_1.actors_[var_146_3] = var_146_4

				local var_146_5 = var_146_4:GetComponentInChildren(typeof(CharacterEffect))

				var_146_5.enabled = true

				local var_146_6 = GameObjectTools.GetOrAddComponent(var_146_4, typeof(DynamicBoneHelper))

				if var_146_6 then
					var_146_6:EnableDynamicBone(false)
				end

				arg_143_1:ShowWeapon(var_146_5.transform, false)

				arg_143_1.var_[var_146_3 .. "Animator"] = var_146_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_143_1.var_[var_146_3 .. "Animator"].applyRootMotion = true
				arg_143_1.var_[var_146_3 .. "LipSync"] = var_146_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("102101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_146_7 = arg_143_1.actors_["102101ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_7) and arg_143_1.var_.characterEffect102101ui_story == nil then
				arg_143_1.var_.characterEffect102101ui_story = var_146_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_8 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_8 and not isNil(var_146_7) then
				if arg_143_1.var_.characterEffect102101ui_story and not isNil(var_146_7) then
					arg_143_1.var_.characterEffect102101ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_8 and arg_143_1.time_ < 0 + var_146_8 + arg_146_0 and not isNil(var_146_7) and arg_143_1.var_.characterEffect102101ui_story then
				arg_143_1.var_.characterEffect102101ui_story.fillFlat = false
			end

			local var_146_10 = 0
			local var_146_11 = 0.325

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_10 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_12 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(414451027).content)

				arg_143_1.text_.text = var_146_12

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_14 = 13 <= 0 and var_146_11 or var_146_11 * (utf8.len(var_146_12) / 13)

				if (13 <= 0 and var_146_11 or var_146_11 * (utf8.len(var_146_12) / 13)) > 0 and var_146_11 < var_146_14 then
					arg_143_1.talkMaxDuration = var_146_14

					if var_146_14 + var_146_10 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_14 + var_146_10
					end
				end

				arg_143_1.text_.text = var_146_12
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_15 = math.max(var_146_11, arg_143_1.talkMaxDuration)

			if var_146_10 <= arg_143_1.time_ and arg_143_1.time_ < var_146_10 + var_146_15 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_10) / var_146_15

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_10 + var_146_15 and arg_143_1.time_ < var_146_10 + var_146_15 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play414451028 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 414451028
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play414451029(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.275

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_1 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(414451028).content)

				arg_147_1.text_.text = var_150_1

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_3 = 11 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 11)

				if (11 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 11)) > 0 and var_150_0 < var_150_3 then
					arg_147_1.talkMaxDuration = var_150_3

					if var_150_3 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_3 + 0
					end
				end

				arg_147_1.text_.text = var_150_1
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_4 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_4

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play414451016 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 414451016
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play414451017(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos102101ui_story = arg_151_1.actors_["102101ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["102101ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos102101ui_story, Vector3.New(0, -0.98, -6.05), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["102101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["102101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["102101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["102101ui_story"].transform.position).z)
				arg_151_1.actors_["102101ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["102101ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["102101ui_story"].transform.localEulerAngles = arg_151_1.actors_["102101ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["102101ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.05)
				arg_151_1.actors_["102101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["102101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["102101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["102101ui_story"].transform.position).z)
				arg_151_1.actors_["102101ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["102101ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["102101ui_story"].transform.localEulerAngles = arg_151_1.actors_["102101ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["102101ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect102101ui_story == nil then
				arg_151_1.var_.characterEffect102101ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect102101ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect102101ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect102101ui_story then
				arg_151_1.var_.characterEffect102101ui_story.fillFlat = false
			end

			local var_154_4 = "102101ui_story"

			if arg_151_1.actors_["102101ui_story"] == nil and not isNil((Asset.Load("Char/" .. "102101ui_story"))) then
				local var_154_5 = Object.Instantiate(Asset.Load("Char/" .. "102101ui_story"), arg_151_1.stage_.transform)

				var_154_5.name = var_154_4
				var_154_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_151_1.actors_[var_154_4] = var_154_5

				local var_154_6 = var_154_5:GetComponentInChildren(typeof(CharacterEffect))

				var_154_6.enabled = true

				local var_154_7 = GameObjectTools.GetOrAddComponent(var_154_5, typeof(DynamicBoneHelper))

				if var_154_7 then
					var_154_7:EnableDynamicBone(false)
				end

				arg_151_1:ShowWeapon(var_154_6.transform, false)

				arg_151_1.var_[var_154_4 .. "Animator"] = var_154_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_151_1.var_[var_154_4 .. "Animator"].applyRootMotion = true
				arg_151_1.var_[var_154_4 .. "LipSync"] = var_154_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("102101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_154_8 = "102101ui_story"

			if arg_151_1.actors_["102101ui_story"] == nil and not isNil((Asset.Load("Char/" .. "102101ui_story"))) then
				local var_154_9 = Object.Instantiate(Asset.Load("Char/" .. "102101ui_story"), arg_151_1.stage_.transform)

				var_154_9.name = var_154_8
				var_154_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_151_1.actors_[var_154_8] = var_154_9

				local var_154_10 = var_154_9:GetComponentInChildren(typeof(CharacterEffect))

				var_154_10.enabled = true

				local var_154_11 = GameObjectTools.GetOrAddComponent(var_154_9, typeof(DynamicBoneHelper))

				if var_154_11 then
					var_154_11:EnableDynamicBone(false)
				end

				arg_151_1:ShowWeapon(var_154_10.transform, false)

				arg_151_1.var_[var_154_8 .. "Animator"] = var_154_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_151_1.var_[var_154_8 .. "Animator"].applyRootMotion = true
				arg_151_1.var_[var_154_8 .. "LipSync"] = var_154_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("102101ui_story", "StoryTimeline/CharAction/story1021/story1021actionlink/1021action486")
			end

			local var_154_12 = 0
			local var_154_13 = 0.725

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_12 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_14 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(414451016).content)

				arg_151_1.text_.text = var_154_14

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_16 = 29 <= 0 and var_154_13 or var_154_13 * (utf8.len(var_154_14) / 29)

				if (29 <= 0 and var_154_13 or var_154_13 * (utf8.len(var_154_14) / 29)) > 0 and var_154_13 < var_154_16 then
					arg_151_1.talkMaxDuration = var_154_16

					if var_154_16 + var_154_12 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_16 + var_154_12
					end
				end

				arg_151_1.text_.text = var_154_14
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_17 = math.max(var_154_13, arg_151_1.talkMaxDuration)

			if var_154_12 <= arg_151_1.time_ and arg_151_1.time_ < var_154_12 + var_154_17 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_12) / var_154_17

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_12 + var_154_17 and arg_151_1.time_ < var_154_12 + var_154_17 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H08f"
	},
	voices = {}
}
